Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC1C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866AE2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZxkzZ0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866AE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8NDh-0007J2-Na
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 08:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8ND5-0006jg-Ow
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:28:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43813
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8ND0-00016X-KM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597840128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jpv1nqq5xXCuBxFE9nAZu2FxNqrqSxd1DSas67mR8P8=;
 b=RZxkzZ0i1pcdmosd1S3a7AZVFX1+Al4AY2YcUswKNg/INCujHNii1oRpLnVAjUS0AZP+hY
 FuJSkadz4deIE4vbAQfuE4TDMZtbOVmS679PwvpOvNPj6dml2K/ByJ0gygCiSJVEIao/vH
 PlCZhwt0bLp3EfYFNCCW6trUVe3BCVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-6d15sNmHONuPzZzVGgStqw-1; Wed, 19 Aug 2020 08:28:47 -0400
X-MC-Unique: 6d15sNmHONuPzZzVGgStqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD54681CAFC;
 Wed, 19 Aug 2020 12:28:45 +0000 (UTC)
Received: from gondolin (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF37F19C4F;
 Wed, 19 Aug 2020 12:28:34 +0000 (UTC)
Date: Wed, 19 Aug 2020 14:28:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/3] vhost-vsock-pci: force virtio version 1
Message-ID: <20200819142832.0abdc59f.cohuck@redhat.com>
In-Reply-To: <20200819120910.nuawi5cmh5wqbgjj@steredhat.lan>
References: <20200819105156.54163-1-sgarzare@redhat.com>
 <20200819105156.54163-2-sgarzare@redhat.com>
 <20200819135542.32288fef.cohuck@redhat.com>
 <20200819120910.nuawi5cmh5wqbgjj@steredhat.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 19 Aug 2020 14:09:10 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Wed, Aug 19, 2020 at 01:55:42PM +0200, Cornelia Huck wrote:
> > On Wed, 19 Aug 2020 12:51:54 +0200
> > Stefano Garzarella <sgarzare@redhat.com> wrote:
> >   
> > > Commit 9b3a35ec82 ("virtio: verify that legacy support is not
> > > accidentally on") added a safety checks that requires to set  
> > 
> > Nit: s/checks/check/ (also in patch 2)  
> 
> I'll fix.
> 
> >   
> > > 'disable-legacy=on' on vhost-vsock-pci device:
> > > 
> > >     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
> > >         qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
> > >         device is modern-only, use disable-legacy=on
> > > 
> > > virtio-vsock was introduced after the release of VIRTIO 1.0
> > > specifications, so it should be 'modern-only'.
> > > In addition Cornelia verified that forcing a legacy mode on
> > > vhost-vsock-pci device using x86-64 host and s390x guest, so with
> > > different endianness, produces strange behaviours.
> > > 
> > > This patch forces virtio version 1 and remove 'transitional_name'
> > > properties removing the need to specify 'disable-legacy=on' on  
> > 
> > "removes the 'transitional_name' property" ?  
> 
> It is better, I'll fix.
> 
> > 
> > (Unless you want to merge with patch 2, which might make sense.)  
> 
> I left seprated because vhost-user-vsock-pci was introduced in QEMU 5.1,
> so I wanted to make it easier to backport on others stable branches.
> (I'm not sure if we continue to support 4.2).
> 
> Does it make sense to keep them separated?

Yes, indeed, it makes sense for stable backporting purposes.


