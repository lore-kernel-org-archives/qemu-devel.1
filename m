Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F973C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738AC2077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTsmwQUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738AC2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if6fL-0000jo-JF
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 13:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <egranata@google.com>) id 1if4Uu-0003fR-9g
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <egranata@google.com>) id 1if4Ut-0004g5-0p
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:05:56 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:44652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <egranata@google.com>) id 1if4Us-0004e0-R1
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:05:54 -0500
Received: by mail-qk1-x741.google.com with SMTP id w127so8268109qkb.11
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rehiyiPENjIb3TkGzxdImMUheY4m13it4HkAOv4ifvA=;
 b=vTsmwQUGn0PUh4gMKS4wWcvmJG9Rls92dzR7yu3qn9LK1XT3kD28mO+CU67Z6t3Kjg
 Hdg1fiVHJmBBtpaFSWqVTc8/bEFywDYGJH/GPAe+PvySrIKunzLxecQ5DxeXrtNn04T7
 MZbJXaN6QLLDpvIJFkZoeoYorXVI56DjLDfGXfmV9VXgzcEvimD1OsJ/ObTAkyFpTK9j
 Bh4zi2aWz1IAadMIXSNWBe7WEjdVJM963QzpsU8/fprO8FZ2t6aMpI+3qrBcCClsTg7s
 fIaIr27QMj1Um5In/gi8No9JpBYd1pH9esdh8Wg/nVdRbFKofD6BOkla/vA26Wpq3lR9
 trzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rehiyiPENjIb3TkGzxdImMUheY4m13it4HkAOv4ifvA=;
 b=cIT4Zjc7tDlO+tO4NNTPpRwvwWD0453pNGW8TSkaLSXbdKOK7la/pSGjpBYqGsLXYr
 pLKY1YvjTGMcaP2WXjWLfbYEs3sELWaOu/Q6S+dh9aP+3omUU6VT4Zqqvs43yz1g58F2
 SoLNDrA+1LbwdLKGlXG8iM0UDLiRdQa1Tds/3dWpHGqxaVhwzSnxNTsZrw89O+nXMtXN
 gO0zhx6j7wQPle1WOemG5sUltJNb/v6qNkMkBrI5mflizeCWKlRA+LAjmDNrjEfiAlX6
 c+0rgBv24ir3TOXzr+0QEomdzzAr+kiyX/oTw853G4j7vUSTcGjLFWWxwfKKbSoLhVRu
 gr5A==
X-Gm-Message-State: APjAAAW5/Ydc+r8fqyVWrcgBw/nx10ywn9U6DtUSoPZOO7GsJH+Kv1dQ
 adO5sXxgg7WanNIsXm19ECxuo3Ewcw/p6nGQ06Ee4g==
X-Google-Smtp-Source: APXvYqwfhmkuQ3K22hYcRkCOlEFPEw9qgU3YRMBjW3CG9Yuk+ek1oqXWKsbNqkZQBQzVDCnoEwkSWILGRpBU8BTNRKM=
X-Received: by 2002:a37:48f:: with SMTP id 137mr3663089qke.25.1576080352362;
 Wed, 11 Dec 2019 08:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
 <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
 <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
In-Reply-To: <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
From: Enrico Granata <egranata@google.com>
Date: Wed, 11 Dec 2019 08:05:40 -0800
Message-ID: <CAPR809tr7cY_ONLgc2Gq2hzuR+FZrtJ5nsLsq-UmV0LxFu0CRA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Stevens <stevensd@chromium.org>, Dylan Reid <dgreid@chromium.org>, 
 Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, 
 Geoffrey McRae <geoff@hostfission.com>,
 Keiichi Watanabe <keiichiw@chromium.org>, 
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Alexandre Courbot <acourbot@chromium.org>, 
 Alex Lau <alexlau@chromium.org>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, 
 Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
X-Mailman-Approved-At: Wed, 11 Dec 2019 13:24:12 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 1:26 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > None of the proposals directly address the use case of sharing host
> > allocated buffers between devices, but I think they can be extended to
> > support it. Host buffers can be identified by the following tuple:
> > (transport type enum, transport specific device address, shmid,
> > offset). I think this is sufficient even for host-allocated buffers
> > that aren't visible to the guest (e.g. protected memory, vram), since
> > they can still be given address space in some shared memory region,
> > even if those addresses are actually inaccessible to the guest. At
> > this point, the host buffer identifier can simply be passed in place
> > of the guest ram scatterlist with either proposed buffer sharing
> > mechanism.
>
> > I think the main question here is whether or not the complexity of
> > generic buffers and a buffer sharing device is worth it compared to
> > the more implicit definition of buffers.
>
> Here are two issues mixed up.  First is, whenever we'll go define a
> buffer sharing device or not.  Second is how we are going to address
> buffers.
>
> I think defining (and addressing) buffers implicitly is a bad idea.
> First the addressing is non-trivial, especially with the "transport
> specific device address" in the tuple.  Second I think it is a bad idea
> from the security point of view.  When explicitly exporting buffers it
> is easy to restrict access to the actual exports.
>

Strong +1 to the above. There are definitely use cases of interest
where it makes sense to be able to attach security attributes to
buffers.
Having an explicit interface that can handle all of this, instead of
duplicating logic in several subsystems, seems a worthy endeavor to
me.

> Instead of using a dedicated buffer sharing device we can also use
> virtio-gpu (or any other driver which supports dma-buf exports) to
> manage buffers.  virtio-gpu would create an identifier when exporting a
> buffer (dma-buf exports inside the guest), attach the identifier to the
> dma-buf so other drivers importing the buffer can see and use it.  Maybe
> add an ioctl to query, so guest userspace can query the identifier too.
> Also send the identifier to the host so it can also be used on the host
> side to lookup and access the buffer.
>
> With no central instance (buffer sharing device) being there managing
> the buffer identifiers I think using uuids as identifiers would be a
> good idea, to avoid clashes.  Also good for security because it's pretty
> much impossible to guess buffer identifiers then.
>
> cheers,
>   Gerd
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

