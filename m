Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 02:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C471207F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 02:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQAsrran"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C471207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqp9k-0003Xy-RM
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 22:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqp95-00031F-Vu
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 22:40:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqp91-00022p-IS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 22:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593657609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tVcgnNx63zZNLfu8XJZTXFeLIqqzjGCceCZjAJHXlS8=;
 b=MQAsrrangqJS2f7Vh6dDq5435C3IUaatdz+jg3rPvVjxjqWo+HCEJ11Wkdz+Togq9320AL
 MvAlPKHNJpfaK4MRSR/F6ict+qTJuSpACo3VRFCHOCKJX/iVGdmhkNJqOFvre6p/u+2CWN
 zzpWDB9dAFSdDKayIFu2zA8lMwPRSVA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-LtSSbshKPr-iEWTFtJ6oxg-1; Wed, 01 Jul 2020 22:40:01 -0400
X-MC-Unique: LtSSbshKPr-iEWTFtJ6oxg-1
Received: by mail-pg1-f199.google.com with SMTP id p8so19475791pgj.14
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 19:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tVcgnNx63zZNLfu8XJZTXFeLIqqzjGCceCZjAJHXlS8=;
 b=NtdyPYYRPvrz027i+Gu3M5Zzd5kojxrLnYjooP+8QIPTx7BZGPErZBYU6KrDVtaN0c
 hYJmn4FEEZ5SpatJQb3We8LTKeto3iMpyCrYZ/bYwcVK7a+DyurmoJbE6xPKjkbSrEot
 UlIC2Sqm+LjaRYMRvE62kHwJav02WJJv2wbXZyKFdk2zfyFxY43KymH5er5HCpOJoraT
 UWzKZmiSiicyrl4y5T5KPgiYe0o5rfuhHqsfOMt+ZKrOAJTxjT9KNJhmbnZej2fmpgK2
 E69igiBPlHX/gswYGmrUWJdz9g0kuqxDixMRxaG7ctSngeLXgCHpCsR+CDYJl4PJt9hn
 I2xQ==
X-Gm-Message-State: AOAM533p7fgMSin5BZdXnEV/eVAFq7aX02fZEUSQVAmBarbmSjIV4KKD
 T18mWyRQJeKKX7BwDEFs8hAQvtCBMKL8bMY56wkzCsDQWdsInLObrkSe1Qrp8izWIcviy6NlzXl
 txw+khtqnC9kaFSTESIBQZQ27HSNj36M=
X-Received: by 2002:a63:e24d:: with SMTP id y13mr17349405pgj.248.1593657600042; 
 Wed, 01 Jul 2020 19:40:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCDLmcd1EqeQbqC7qoHHCc17cyI2Lol+pXD7zrZzO09QEZ+pymvcdwWEi5+53RPrb6B/EbJsr3EWRywH35e0U=
X-Received: by 2002:a63:e24d:: with SMTP id y13mr17349375pgj.248.1593657599716; 
 Wed, 01 Jul 2020 19:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200701092449.17451-1-lulu@redhat.com>
 <20200701092449.17451-14-lulu@redhat.com>
 <dc1c8668-54b7-4b9f-cf0f-a0479339fa7d@redhat.com>
 <20200701112022-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200701112022-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 2 Jul 2020 10:39:48 +0800
Message-ID: <CACLfguVBfWTPAFK5f3VP0fNO=qSAjTUHNr06t-vkxzvgujUrwQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] vhost-vdpa: introduce vhost-vdpa net client
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 22:40:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, hanand@xilinx.com, Rob Miller <rob.miller@broadcom.com>,
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 mhabets@solarflare.com, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael, Eric,
This was fix in the latest version, v4
https://patchew.org/QEMU/20200701145538.22333-1-lulu@redhat.com/20200701145538.22333-15-lulu@redhat.com/

On Wed, Jul 1, 2020 at 11:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jul 01, 2020 at 09:28:27AM -0500, Eric Blake wrote:
> > On 7/1/20 4:24 AM, Cindy Lu wrote:
> > > This patch set introduces a new net client type: vhost-vdpa.
> > > vhost-vdpa net client will set up a vDPA device which is specified
> > > by a "vhostdev" parameter.
> > >
> > > Signed-off-by: Lingshan Zhu <lingshan.zhu@intel.com>
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> >
> > > +++ b/qapi/net.json
> >
> > >   ##
> > >   # @NetClientDriver:
> > >   #
> > >   # Available netdev drivers.
> > >   #
> > > -# Since: 2.7
> > > +# Since: 5.1
> >
> > This should be:
> >
> > # Since 2.7
> > # @vhost-vdpa since 5.1
> >
> > since the enum itself is still available in older releases, it is only the
> > new member that was introduced in this series.
> >
> > >   ##
> > >   { 'enum': 'NetClientDriver',
> > >     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> > > -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> > > +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] }
> >
>
>
> Thanks! I will fix it up when applying.
> Ack with that fixed?
>
>
> > --
> > Eric Blake, Principal Software Engineer
> > Red Hat, Inc.           +1-919-301-3226
> > Virtualization:  qemu.org | libvirt.org
>


