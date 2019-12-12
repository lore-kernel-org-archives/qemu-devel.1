Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6482120663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ccGurdDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6482120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNZ8-0008In-Hg
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1ifNYL-0007sr-LB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1ifNYK-0004ry-9i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:26:45 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:36034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1ifNYK-0004rG-1n
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:26:44 -0500
Received: by mail-qt1-x844.google.com with SMTP id k11so2124131qtm.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zzuaDacu5BFhoisZaoQtnflxPHTSJ1BMzYrW5oVhp6A=;
 b=ccGurdDWOjVoQeL3FLvqQ+fVjvam+gDriu9+NtKrTWLFwG7hAdq/96uznle/g7ot87
 zkuNY4KDorEuL4NVOkq6tFOB8S4Zcs0tcbdhvvOUhJlQ6YDUyfl6Dvg5yzOwHNUeokxE
 VKkje5Uql4RRBOtKUD6+7/lHTHFe6sm2xdo2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zzuaDacu5BFhoisZaoQtnflxPHTSJ1BMzYrW5oVhp6A=;
 b=NoIsWcrHvuPwZ+BwIdFFbO8cDlD457a2d5sxczB31p3O9IBPa6n4aIRoyjXbB+ry5v
 0MEfbCm5jLYX0NkGtdQUXipDuR2GD52dfA9klILUg6YScNPeoIdyHVmzpwP9aFsg4ia9
 9iK2cJ9MfvOitPswPMrQWLkRqPiRDnPS3Va+NrGtGo4mXudYRL7cTcSHvBVvXhIcxkwi
 fViELAVJcTU+ssZEHW9kHt0dtIDQRgTLMBIJhNVrW7BlwLahWvj45oaaUPnos8NSIp+w
 ZGCb1G6JvTVNUbGzQim7yz4rLbbb+LjtZFwn3MuZrrJM63psDUTCrDGJgYCM/X0gmzkg
 Ixvw==
X-Gm-Message-State: APjAAAU3Jclid3yKSweFzpsvkoEMxCBAuZf8hJ7TV7sl8VAiOBUaIzFD
 CMBhL4PL2Hm/HGI3wpysIar/D5VHPVX8/j+PGNiUhQ==
X-Google-Smtp-Source: APXvYqyyW9xksRz10OUFM4sUWiAeVJQVc8sXvXBShkOf1bK8grmGt1MOoQHtahVrRAWGVxDTH6FRr9lamDi8qA2+Pt8=
X-Received: by 2002:aed:2344:: with SMTP id i4mr7392923qtc.136.1576153603247; 
 Thu, 12 Dec 2019 04:26:43 -0800 (PST)
MIME-Version: 1.0
References: <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
 <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
 <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
 <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
 <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org>
In-Reply-To: <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 12 Dec 2019 21:26:32 +0900
Message-ID: <CAD=HUj6YYupjdxxz2mgMmE2DcKhXP-qdhRORvUNTmzcORRrLzg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Zach Reizner <zachr@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>,
 Alex Lau <alexlau@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > Second I think it is a bad idea
> > > from the security point of view.  When explicitly exporting buffers it
> > > is easy to restrict access to the actual exports.
> >
> > Restricting access to actual exports could perhaps help catch bugs.
> > However, I don't think it provides any security guarantees, since the
> > guest can always just export every buffer before using it.
>
> Probably not on the guest/host boundary.
>
> It's important for security inside the guest though.  You don't want
> process A being able to access process B private resources via buffer
> sharing support, by guessing implicit buffer identifiers.

At least for the linux guest implementation, I wouldn't think the
uuids would be exposed from the kernel. To me, it seems like something
that should be handled internally by the virtio drivers. Especially
since the 'export' process would be very much a virtio-specific
action, so it's likely that it wouldn't fit nicely into existing
userspace software. If you use some other guest with untrusted
userspace drivers, or if you're pulling the uuids out of the kernel to
give to some non-virtio transport, then I can see it being a concern.

> > > Instead of using a dedicated buffer sharing device we can also use
> > > virtio-gpu (or any other driver which supports dma-buf exports) to
> > > manage buffers.

Ah, okay. I misunderstood the original statement. I read the sentence
as 'we can use virtio-gpu in place of the dedicated buffer sharing
device', rather than 'every device can manage its own buffers'. I can
agree with the second meaning.

> Without buffer sharing support the driver importing a virtio-gpu dma-buf
> can send the buffer scatter list to the host.  So both virtio-gpu and
> the other device would actually access the same guest pages, but they
> are not aware that the buffer is shared between devices.

With the uuid approach, how should this case be handled? Should it be
equivalent to exporting and importing the buffer which was created
first? Should the spec say it's undefined behavior that might work as
expected but might not, depending on the device implementation? Does
the spec even need to say anything about it?

> With buffer sharing virtio-gpu would attach a uuid to the dma-buf, and
> the importing driver can send the uuid (instead of the scatter list) to
> the host.  So the device can simply lookup the buffer on the host side
> and use it directly.  Another advantage is that this enables some more
> use cases like sharing buffers between devices which are not backed by
> guest ram.

Not just buffers not backed by guest ram, but things like fences. I
would suggest the uuids represent 'exported resources' rather than
'exported buffers'.

> Well, security-wise you want have buffer identifiers which can't be
> easily guessed.  And guessing uuid is pretty much impossible due to
> the namespace being huge.

I guess this depends on what you're passing around within the guest.
If you're passing around the raw uuids, sure. But I would argue it's
better to pass around unforgeable identifiers (e.g. fds), and to
restrict the uuids to when talking directly to the virtio transport.
But I guess there are likely situations where that's not possible.

-David

