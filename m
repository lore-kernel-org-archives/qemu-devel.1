Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E1CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3612070B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTy/axit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3612070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUMk-0006D4-Iz
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elohimes@gmail.com>) id 1iMULk-00051F-7n
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1iMULj-0004Vy-2T
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:51:39 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:36437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1iMULi-0004VV-Sn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:51:39 -0400
Received: by mail-qk1-x743.google.com with SMTP id y189so11975659qkc.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PxQG9y4KZMF7sEbIedxj8Q50XOkg1OWTWECD/ywOQmA=;
 b=cTy/axitg5DU5EUBW0Tx8NOW3NSBZOlCbF/4oMm642+bTBqoSsm82PB+ydRTqK/yt3
 CYsAlHOwqGag9OjDZ10aiHS/MCzwy4M1oS/WID/Go+ttPS/wsRAH0PaQNb61xWNw6zmG
 rkDKPVc6zOHnBcxFS/t58p9ebFmOw6iozU0J7gX4DHcr7uf+3CyKrvL8CYjmShgz+vDF
 +CrniUr3Aa1bk3x+K+hkRAsdJE/hEn/0C9SW4OnmXMYuFzk5TILBHcM1dPFBSBj6bCnE
 5eh3VRsiA+87LHvYv1Sm3Ks2Ith4h7A6+YqLxE0Lyzcr51W9d9OeWg49Mx3HzLXrA+w6
 JuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PxQG9y4KZMF7sEbIedxj8Q50XOkg1OWTWECD/ywOQmA=;
 b=q4fm0rOwreMO8YBJ9jHOQHUjAkhEag2X4awpILCqDsI4Yz/Nrzx+tXEn5VPp2Xq1Rj
 FkJCxtkRdAnogaaQd8p3VaBRifwBq0Rj7sdPXahjcV7aO/5hK9i6weVb0gxuLntuvWTL
 AlGa5yVE4AKAo9rSd9dSAt5x89P386J5TwTewcoFcmoXPIcn5twf5n1wQqyCJgzyIExX
 QS92DkJkUfGtPxEQdp8nwXwRVBI3RaOWN6VOS8WKecBwVaW8GNheCUKRoEBJlk4WXNqC
 jjsnPU01TKWEnA3kXO8V/yyuFcL10cIXSzF+A1/7c167CMMykfBzpYMSUbymQTfqSGjD
 bi2Q==
X-Gm-Message-State: APjAAAUASQHkYF49iShx3/sBEJ697y9q81zP1OKYcb2FJkr91bFZXGiq
 6TPg440TH72RPJimSlNIwk9ljoabQcnoz/Xv1wk=
X-Google-Smtp-Source: APXvYqxJMOLzoeuaPcNAgK7LuqVg+dglRool2mlEmtzMvmU3ZXka6cRUfL0mdmdgs9GCJ+Ke78z4VqvciIwk4qZzAcY=
X-Received: by 2002:a37:e10d:: with SMTP id c13mr20306488qkm.35.1571651497898; 
 Mon, 21 Oct 2019 02:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191017163859.23184-1-felipe@nutanix.com>
 <CAONzpcbR+OjcrfavTnFXVopG-YsTdnFCT=no0eFei4oanfmj1Q@mail.gmail.com>
 <17B5A7A6-F790-4D10-8921-06A83DA18077@nutanix.com>
 <CAONzpcYDDUde0PLVtGYuwGm79RvU-VubXqDs=4F_8yp+-pz-Zg@mail.gmail.com>
 <B53729BD-5A55-4D27-88BE-F8ED2A39D41F@nutanix.com>
In-Reply-To: <B53729BD-5A55-4D27-88BE-F8ED2A39D41F@nutanix.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 21 Oct 2019 17:51:26 +0800
Message-ID: <CAONzpcY5YSydQjdVH1yGw6+qhGZxHBY5PtcXRcQPeakLj00dbg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-scsi: implement handle_output
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 16:00, Felipe Franciosi <felipe@nutanix.com> wrote:
>
>
>
> > On Oct 21, 2019, at 5:01 AM, Yongji Xie <elohimes@gmail.com> wrote:
> >
> > On Fri, 18 Oct 2019 at 19:14, Felipe Franciosi <felipe@nutanix.com> wrote:
> >>
> >>
> >>
> >>> On Oct 18, 2019, at 3:59 AM, Yongji Xie <elohimes@gmail.com> wrote:
> >>>
> >>> On Fri, 18 Oct 2019 at 01:17, Felipe Franciosi <felipe@nutanix.com> wrote:
> >>>>
> >>>> Originally, vhost-user-scsi did not implement a handle_output callback
> >>>> as that didn't seem necessary. Turns out it is.
> >>>>
> >>>> Depending on which other devices are presented to a VM, SeaBIOS may
> >>>> decide to map vhost-user-scsi devices on the 64-bit range of the address
> >>>> space. As a result, SeaBIOS will kick VQs via the config space. Those
> >>>> land on Qemu (not the vhost backend) and are missed, causing the VM not
> >>>> to boot. This fixes the issue by getting Qemu to post the notification.
> >>>>
> >>> Should we fix this in vhost-user-blk too?
> >>
> >> I'm not sure vhost-user-blk suffers from the same problem. Certainly
> >
> > Actually I found vhost-user-blk has the same problem in a mutilple
> > GPUs passthough environment.
>
> Let's Cc Changpeng for comments. I'm not familiar with that code.
>
> In any case, I still think we should merge this and fix other
> implementations separately. That allows us to revert patches
> individually if anything else breaks.
>

It's OK for me.

Thanks,
Yongji

