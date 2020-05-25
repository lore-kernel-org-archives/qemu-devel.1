Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8248BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500412071C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvUdeceG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500412071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdF8L-0004xo-HN
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jdF7F-0004T9-Jf
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:34:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20782
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jdF7E-0004lI-4G
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590420848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHHe8V7KAYXRwg8h4vOFivuYKgT4EvLRxM0ceKRzb/g=;
 b=WvUdeceGM4x6yoD4E7fDjqaAfA9iwdbjd6Z4qN+0gZeyNTMtarP/xehlyXyRQQM4apcXh9
 BWxpxO8R6Cjqs1wxGsXxNMWl5DPp3X+BNJCUSnPBLUtrb/NeOwr+GjY9apiHGVGsPMPEyH
 XWCa8saybTvoIyLqImELqVP4lI0BzKM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-tP0bH8RrN1KFo6iKrFGMLg-1; Mon, 25 May 2020 11:34:06 -0400
X-MC-Unique: tP0bH8RrN1KFo6iKrFGMLg-1
Received: by mail-pj1-f70.google.com with SMTP id jx21so240375pjb.7
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AHHe8V7KAYXRwg8h4vOFivuYKgT4EvLRxM0ceKRzb/g=;
 b=Ej/QVybK7IsumthChbs+K0Vh73AB2RI8XdVbPLhVXoPi/qbsQQCm7KzyI5g4t/aggJ
 inJmXBaIRxursQEXQb6x3l7TkkuoxdgDQVeKMvP2XYM+bEpXJu3FFMS4i6nQ3LCjXLom
 IqmZc3QUgHmyAbSyIFnL7qVYmXOr5FHZsIDsdF7i6lOXq+rqcggWTXweQDfW4UFRGf7z
 hjXyZcD/YjxuBro3beazTv3qTD2mDn9VByB/EbRSTAAGlEaIE+18m8OqS5uoakp1iGUy
 QtyVmyDFXQmEJ3aYJCKLrYCvp6KHoK7/x0NZUqSreATEfXSz+g4jFmsIfxMidZ/SP/8H
 qFGg==
X-Gm-Message-State: AOAM531f4SSW30FkCE6o9ltSmNIET3IZixP4CSOYOUndK6M0CsJITzZM
 aNNFX1L1tn6cMVDy6tpGRL0LuaVmfjciH+w+c+qZIe3KdY3Cp33IGgPzQ6gHKxScDswmP6lyv0r
 T+ebklvX8rZiYlKclq2D/0nKloidxH40=
X-Received: by 2002:a63:1617:: with SMTP id w23mr5504583pgl.248.1590420845696; 
 Mon, 25 May 2020 08:34:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkUYDVkbO7r+CbXp20FY/f2rIETMYoQ6qzpntGzsS2rGKLGbp/g4mM3zIm9uoOi+ZPsITeOyGO/42AdI1RxtA=
X-Received: by 2002:a63:1617:: with SMTP id w23mr5504541pgl.248.1590420845404; 
 Mon, 25 May 2020 08:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-6-lulu@redhat.com>
 <20200521124032.GH251811@stefanha-x1.localdomain>
In-Reply-To: <20200521124032.GH251811@stefanha-x1.localdomain>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 25 May 2020 23:33:54 +0800
Message-ID: <CACLfguUVO_zhZbrZ2bW--i5KrP+Yxe0EQwOCrtihSDqRADOKfA@mail.gmail.com>
Subject: Re: [RFC v2 5/9] vhost-vdpa: implement vhost-vdpa backend
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 8:40 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Sat, May 09, 2020 at 12:32:14AM +0800, Cindy Lu wrote:
> > From: Tiwei Bie <tiwei.bie@intel.com>
> >
> > Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> > vhost-user. The above patch provides a generic device for vDPA purpose,
> > this vDPA device exposes to user space a non-vendor-specific configuration
> > interface for setting up a vhost HW accelerator, this patch set introduces
> > a third vhost backend called vhost-vdpa based on the vDPA interface.
> >
> > Vhost-vdpa usage:
> >
> >   qemu-system-x86_64 -cpu host -enable-kvm \
> >     ......
> >   -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-id,id=vhost-vdpa0 \
> >   -device virtio-net-pci,netdev=vhost-vdpa0,page-per-vq=on \
>
> I haven't looked at vDPA in depth. What is different here compared to
> the existing vhost-backend.c kernel backend?
>
> It seems to be making the same ioctls calls so I wonder if it makes
> sense to share the vhost-backend.c kernel code?
>
> Stefan
Hi Stefan,
Sorry for the late reply and Thanks for these suggestions.
I think the most difference between vhost kernel and vdpa is vdpa
depends on a real hardware.
The point is that vDPA devices work as a virtio device, but vhost-vdpa
qemu must present a vhost-like device in qemu vhost layer.
The ioctl  calls are similar  with vhost-backend.c now, but after more
and more NIC support vdpa. The difference between vhost-backend.c and
vpda will become more and more big. It will make the code complicated
to share the  code with kernel code.

Thanks
Cindy


