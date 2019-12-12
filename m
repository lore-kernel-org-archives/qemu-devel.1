Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02F6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 06:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A00A21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 06:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MA51rQXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A00A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifIAN-0005FQ-Nc
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 01:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1ifI9h-0004pK-Sa
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 01:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1ifI9g-0005Yd-Nc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 01:40:57 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:40655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1ifI9g-0005WM-GI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 01:40:56 -0500
Received: by mail-qk1-x744.google.com with SMTP id c17so729962qkg.7
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 22:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AXRap6BBWQzWAyS8XpX73+bYNdrI0cAeZpXa9H/bRAc=;
 b=MA51rQXW0kUy/eH8a+CHW4cprcJcqsH2HDzbo+OKNkS1fIXDmPWFSH3Msg+CjLkt0o
 Hn/0mqSAS7p59uvMv2wKRkhzzpGh/xZo8lBVIiBJppJf7GsAmMMTWL+CZJ5TtspASJzS
 NaTGJFY7ayj0hAf+odDLpymBHQaz1OrCu/eC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AXRap6BBWQzWAyS8XpX73+bYNdrI0cAeZpXa9H/bRAc=;
 b=PvNok8LzDbaqhMbjCHj116ISwqggm/yqq7xqQy9PksW34tlevGc6qYnoy1kOdvoAEq
 6eXQ2Dj/F4aj1tGlBLeNaTsRdX6/N2J3TVLqpzjgtKW3yiKTrF3WXR4C404uwsmwTRmE
 dcDzePxmOXDUcR5t8dJ8aLq/e3XI965L5VzikjYRJJgwdhmvGC5gKUIcjnstXO/Ps/ep
 FwojpygSj/7epgUUMM5DJRM+VkobB3Q2RLOtuKMrmP02Kw74aPv6N8n8uN3UQJafdb8w
 GDLLaMEo6FEGIopscyIQT6ImtscN7A6xas0I3es0oj30/TLycYWu3DZaOl+3UGDp8HuB
 SlEw==
X-Gm-Message-State: APjAAAUUzZhWDCEzwrtRvys6H2GgL7ADFbNZVqSgygD8aJFSRyAL2WQP
 MduykmK8aKeGxvgJOxKb4Uv9yI0q9iJ9HT+WGShTow==
X-Google-Smtp-Source: APXvYqxMMjzivuQZLMAX1uEdLyogQxiS5pr/nUVktTqgng9NiXTmVutloTIAjZEQhboxEVr3pF5DU82GdhtuG5OkV90=
X-Received: by 2002:a05:620a:101b:: with SMTP id
 z27mr6394282qkj.241.1576132855363; 
 Wed, 11 Dec 2019 22:40:55 -0800 (PST)
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
From: David Stevens <stevensd@chromium.org>
Date: Thu, 12 Dec 2019 15:40:44 +0900
Message-ID: <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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

> First the addressing is non-trivial, especially with the "transport
> specific device address" in the tuple.

There is complexity here, but I think it would also be present in the
buffer sharing device case. With a buffer sharing device, the same
identifying information would need to be provided from the exporting
driver to the buffer sharing driver, so the buffer sharing device
would be able to identify the right device in the vmm. And then in
both import cases, the buffer is just identified by some opaque bytes
that need to be given to a buffer manager in the vmm to resolve the
actual buffer.

> Second I think it is a bad idea
> from the security point of view.  When explicitly exporting buffers it
> is easy to restrict access to the actual exports.

Restricting access to actual exports could perhaps help catch bugs.
However, I don't think it provides any security guarantees, since the
guest can always just export every buffer before using it. Using
implicit addresses doesn't mean that the buffer import actually has to
be allowed - it can be thought of as fusing the buffer export and
buffer import operations into a single operation. The vmm can still
perform exactly the same security checks.

> Instead of using a dedicated buffer sharing device we can also use
> virtio-gpu (or any other driver which supports dma-buf exports) to
> manage buffers.

I don't think adding generic buffer management to virtio-gpu (or any
specific device type) is a good idea, since that device would then
become a requirement for buffer sharing between unrelated devices. For
example, it's easy to imagine a device with a virtio-camera and a
virtio-encoder (although such protocols don't exist today). It
wouldn't make sense to require a virtio-gpu device to allow those two
devices to share buffers.

> With no central instance (buffer sharing device) being there managing
> the buffer identifiers I think using uuids as identifiers would be a
> good idea, to avoid clashes.  Also good for security because it's pretty
> much impossible to guess buffer identifiers then.

Using uuids to identify buffers would work. The fact that it provides
a single way to refer to both guest and host allocated buffers is
nice. And it could also directly apply to sharing resources other than
buffers (e.g. fences). Although unless we're positing that there are
different levels of trust within the guest, I don't think uuids really
provides much security.

If we're talking about uuids, they could also be used to simplify my
proposed implicit addressing scheme. Each device could be assigned a
uuid, which would simplify the shared resource identifier to
(device-uuid, shmid, offset).

In my opinion, the implicit buffer addressing scheme is fairly similar
to the uuid proposal. As I see it, the difference is that one is
referring to resources as uuids in a global namespace, whereas the
other is referring to resources with fully qualified names. Beyond
that, the implementations would be fairly similar.

-David

