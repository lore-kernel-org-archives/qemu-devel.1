Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62ABC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3931721D46
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFgEp1Bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3931721D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMrFN-0003VM-9B
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kMrEU-0002xa-9A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kMrER-0003Lz-Ud
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:22:13 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601292129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AljXW5p/xFN3rGodB4xP6rvNOcd8M/T9pzNJLM2JwDI=;
 b=cFgEp1BmQF00v309VDgStDN3dRlcbQfRhy354ILzMfJw6mjD4FV9U2nKbvGxNg9rx/Mp1b
 BHlLjO3Crmg0hoYr3m42cfVk8aA0RpqUc2IOu9Wo8bjydfuci6u4ss8A3Gvs4Vyr+yvd+Z
 NgpzEz5w83Iy7SMpgj2cX+CSZQdwHsk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-au7qVCNBO1Wq0q8NCqzb6Q-1; Mon, 28 Sep 2020 07:22:08 -0400
X-MC-Unique: au7qVCNBO1Wq0q8NCqzb6Q-1
Received: by mail-il1-f199.google.com with SMTP id m1so445661iln.19
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 04:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AljXW5p/xFN3rGodB4xP6rvNOcd8M/T9pzNJLM2JwDI=;
 b=aOmrFe5MgMTalykcMeo851TKIOS+JJECh3TJy4DrA4Mt36IUPjbSYvbpEAQ/WYMfOo
 7tly4Kj5RxGSoOMnd/XdX4owaCwpnNISXtu/fdEGBC8IC5sBuGjshpWuuS1kxRSwt0g1
 fxIKpIrL3CX7rdWokcYXd5gjg9eD18tuGCIx1fdCs2EOht1XLMdBnChC/q0xUXFJlq+z
 27Pb9aJjgrmBv3XuB8+6qMv0Y0WY0yJzdBTCw8xL9MkKCZaoixTIAanqbwqy3tNQD8uY
 4M2Uk/R+un9m5CkYOtjEbc3E0iBXB0sSSzyHJ9XGsbqVHD0cFDOOLqaOjuhnOV4KLGTn
 oT8Q==
X-Gm-Message-State: AOAM530LYtpNzQ8OBFMwXFYBBHgp19waGohIDrvJ46Z6DMicqmWJkmGJ
 J230pVJ3NWIO8PSPpHYlbb8im2ZwVlNwgTJtkoo+xpF+9GQVxE2BSPJ5kftPi8j40JSFCgglCJh
 uAhfQ9STD+0CXI7Hvu5aRa+lsggiRQus=
X-Received: by 2002:a92:2602:: with SMTP id n2mr752220ile.82.1601292127522;
 Mon, 28 Sep 2020 04:22:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1JYBZekCcXpIKMmDLTSeVWFefwspHEnHHew1mD7Uvp+Bz467rlU63EN+ToWcINSIJtVYRBKV16SlpYb1rMx0=
X-Received: by 2002:a92:2602:: with SMTP id n2mr752196ile.82.1601292127305;
 Mon, 28 Sep 2020 04:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200928092537.GA44353@stefanha-x1.localdomain>
In-Reply-To: <20200928092537.GA44353@stefanha-x1.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Sep 2020 15:21:56 +0400
Message-ID: <CAMxuvayJXbSVAG3yJPkb+_9OU5k623WKOksEpHjVU5eV9U=zKA@mail.gmail.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
To: Stefan Hajnoczi <stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lulu@redhat.com, tiwei.bie@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, "Coquelin,
 Maxime" <maxime.coquelin@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Nikos Dragazis <ndragazis@arrikto.com>,
 "Liu, Changpeng" <changpeng.liu@intel.com>, Daniele Buono <dbuono@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Sep 28, 2020 at 1:25 PM Stefan Hajnoczi <stefanha@redhat.com wrote:
> Where this converges with multi-process QEMU
> --------------------------------------------
> At this point QEMU can run ad-hoc vhost-user backends using existing
> VIRTIO device models. It is possible to go further by creating a
> qemu-dev launcher executable that implements the vhost-user spec's
> "Backend program conventions". This way a minimal device emulator
> executable hosts the device instead of a full system emulator.
>
> The requirements for this are similar to the multi-process QEMU effort,
> which aims to run QEMU devices as separate processes. One of the main
> open questions is how to design build system and Kconfig support for
> building minimal device emulator executables.
>
> In the case of vhost-user-net the qemu-dev-vhost-user-net executable
> would contain virtio-net-device, vhost-user-backend, any netdevs the
> user wishes to include, a QMP monitor, and a vhost-user backend
> command-line interface.
>
> Where does this leave us? QEMU's existing VIRTIO device models can be
> used as vhost-user devices and run in a separate processes from the VMM.
> It's a great way of reusing code and having the flexibility to deploy it
> in the way that makes most sense for the intended use case.
>

My understanding is that this would only be able to expose virtio
devices from external processes. But vfio-user could expose more kinds
of devices, including the virtio devices.

Shouldn't we focus on vfio-user now, as the general out-of-process
device solution?


