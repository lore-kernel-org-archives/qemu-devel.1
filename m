Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C534BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F15C2063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7QzP7Xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F15C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Muo-0002Hy-Lu
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 08:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8Mu9-0001gq-8b
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:09:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8Mu7-0006rA-IT
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597838958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pyPWG8kB0rBpQCf9h14r7naWnyvJobceE0c8deEXiF8=;
 b=W7QzP7XkgeK/TKuQYGASpAf3ZdVXqwqBO/ByCXBGAPpLqC7fxn2MUD6hj2Z64S6Wy4ZK98
 3Jqupn1QSyL5y+efDqyYxu9HAz5KVTMq18mOvEbYaGISJ1jggNbPmluYxRTk0tpZl99+so
 QrHOnQNFjC+ZTI5YCLIsIu2pgA925Ms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-FvepbXgyPm-kVKEvWujNeg-1; Wed, 19 Aug 2020 08:09:16 -0400
X-MC-Unique: FvepbXgyPm-kVKEvWujNeg-1
Received: by mail-wm1-f70.google.com with SMTP id d22so864172wmd.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 05:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pyPWG8kB0rBpQCf9h14r7naWnyvJobceE0c8deEXiF8=;
 b=lWw/82nwDboJbIihchvUio1tvQAzOkYyFOZZP5TCbvG9MUVZun0Nvk2ImV5vae9Rhy
 58X+U1lEpjfEP0AvHcFQloOYWEy+ASOnLTtxld/yqOlqJvnJOB5m3NkvWJIWToRG4gWd
 vAr0suW92QRlTlTCgdT42UG/Xzh4XsMdhLcoBuh1+rM6tqx1wdAEdPRuBphFmqyzHq/K
 M/rYWT2yVNDaXupFUmUl/OYahqrikx7JJywi3E6/dL6yoSrrR9xzI/LwlkOq2PZKCZ8C
 f+PuZgkg/gIy8ewutUbGqiRBKYrLvloATmy5vhQBoJQSaNcGY2Mq6N+Gv/uGcC7AGRhj
 0jHA==
X-Gm-Message-State: AOAM530CRJUNXC+rqLwX8f1n5AZLkRSFptg+9iUgSn6zeOy/BUOAcVPe
 lPTv8vuDfPfspbtZvvQYyYW8Wqp/3Y6mlocq5FMYKe5FzJuA1nHtYkc7N1DMXCaI6zq4L2l0iVX
 j2buchTVkfZjJlXY=
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr25235519wrv.104.1597838955289; 
 Wed, 19 Aug 2020 05:09:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf9PNa2Mn23SFdKciH09EbuhAveNDrVdcYWnIaA75SD0ukdyv0jithJKJcWJcPPX1rbTp9uA==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr25235492wrv.104.1597838954972; 
 Wed, 19 Aug 2020 05:09:14 -0700 (PDT)
Received: from steredhat.lan ([5.171.195.20])
 by smtp.gmail.com with ESMTPSA id c10sm39157617wrx.15.2020.08.19.05.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 05:09:14 -0700 (PDT)
Date: Wed, 19 Aug 2020 14:09:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/3] vhost-vsock-pci: force virtio version 1
Message-ID: <20200819120910.nuawi5cmh5wqbgjj@steredhat.lan>
References: <20200819105156.54163-1-sgarzare@redhat.com>
 <20200819105156.54163-2-sgarzare@redhat.com>
 <20200819135542.32288fef.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200819135542.32288fef.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Qian Cai <caiqian@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 01:55:42PM +0200, Cornelia Huck wrote:
> On Wed, 19 Aug 2020 12:51:54 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > Commit 9b3a35ec82 ("virtio: verify that legacy support is not
> > accidentally on") added a safety checks that requires to set
> 
> Nit: s/checks/check/ (also in patch 2)

I'll fix.

> 
> > 'disable-legacy=on' on vhost-vsock-pci device:
> > 
> >     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
> >         qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
> >         device is modern-only, use disable-legacy=on
> > 
> > virtio-vsock was introduced after the release of VIRTIO 1.0
> > specifications, so it should be 'modern-only'.
> > In addition Cornelia verified that forcing a legacy mode on
> > vhost-vsock-pci device using x86-64 host and s390x guest, so with
> > different endianness, produces strange behaviours.
> > 
> > This patch forces virtio version 1 and remove 'transitional_name'
> > properties removing the need to specify 'disable-legacy=on' on
> 
> "removes the 'transitional_name' property" ?

It is better, I'll fix.

> 
> (Unless you want to merge with patch 2, which might make sense.)

I left seprated because vhost-user-vsock-pci was introduced in QEMU 5.1,
so I wanted to make it easier to backport on others stable branches.
(I'm not sure if we continue to support 4.2).

Does it make sense to keep them separated?

> 
> > vhost-vsock-pci device.
> > 
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Qian Cai <caiqian@redhat.com>
> > Reported-by: Qinghua Cheng <qcheng@redhat.com>
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1868449
> > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  hw/virtio/vhost-vsock-pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Stefano


