Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76BCC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C562173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3Y5/K4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C562173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJo1-0004sg-4R
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSJlX-0002p2-LD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSJlV-0007g6-Il
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:46:23 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34]:40476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSJlT-0007f9-PT
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:46:21 -0500
Received: by mail-qv1-xf34.google.com with SMTP id r8so1249505qvq.7
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ff4rTf71EaaA6mDalMOvcUyB0YnCYPZvyXrWDdkjzLY=;
 b=R3Y5/K4FpSGl/JBDa6luAfZN1wJEVODtQQYIXXVMud/7MFhzUyi1wNTd4CXXvspyXA
 Np1QSYFRTIpakGlS3B+TXTCXmFzGhj3QgyTrhSU19TPOsWeKjjhHhLJQlMmwWjQvg/Oa
 NlA+bQe2LTa4aSuBh+VFONS721EwkfA8b+4NJMCDozfMGD+hPkt+O6kOmiKlOio9ZrdC
 31TD57/2Qk4hA5cQxf/QaM6Csg9rP49Godm2fe+CwynOD17JK7eEigA0QrFowsgQvLgx
 DiRNcH6M7viFHn93SlGe4ireJbhRDBjy37FSiqLOoN/S8Qo40w/Puia7T+lfX/atu72z
 u1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ff4rTf71EaaA6mDalMOvcUyB0YnCYPZvyXrWDdkjzLY=;
 b=PhECZuFRoSWw+Z6rlFnd18cKM5saPSCsTFe7NJkwyW6t4OJ3FHVKdt2srDIl+it7Zw
 KSvGxRhPs5tnDDUcDc5Ywo9RtkL0AYuYjtPCwaCPdSR/YSWZ7JbX7SiKiqZebYcpB9Tv
 mDRER1fyFBt97/NXOK3uwr5exdg2KG7hk/HAyW1a1w1BeWuoQEbvr0qLjcmADZKl71pc
 3sPwKkyBwDAx93It9SYv1q6DTPMMONDqdURIplXhNbUD4VUsttRwPNhn/qwqpf9kblZe
 nqxnfLe8YhzMwdXbq6JSEm/rmKwGOGfqb5NabBMDU9QF7lloxQmxjuWWylbYjOlq46cE
 rArw==
X-Gm-Message-State: APjAAAUOYHF0ByWF0nr6jeLYgwjXP7sY07dV8pS5Fw0J5AoBkl141tSo
 PyVKI29IfK8hZ2tTr2Ley2sdHDXSTjZNGxug978=
X-Google-Smtp-Source: APXvYqxiW7m5BcPoYQedl9pTBVFzRV+opTQ9XBEb+aAhdBe/1UuZKWWxX6FmvT5qwm+9kfhdgNYpP1vfa3BNI+Y7U6I=
X-Received: by 2002:a0c:c70a:: with SMTP id w10mr1805353qvi.218.1573040779005; 
 Wed, 06 Nov 2019 03:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
In-Reply-To: <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Nov 2019 12:46:07 +0100
Message-ID: <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f34
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 qemu-devel <qemu-devel@nongnu.org>, Tomasz Figa <tfiga@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 6, 2019 at 10:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
> > > resources" is really a good answer for all the different use cases
> > > we have collected over time.  Maybe it is better to have a dedicated
> > > buffer sharing virtio device?  Here is the rough idea:
> >
> > My concern is that buffer sharing isn't a "device".  It's a primitive
> > used in building other devices.  When someone asks for just buffer
> > sharing it's often because they do not intend to upstream a
> > specification for their device.
>
> Well, "vsock" isn't a classic device (aka nic/storage/gpu/...) either.
> It is more a service to allow communication between host and guest

There are existing applications and network protocols that can be
easily run over virtio-vsock, virtio-net, and virtio-serial to do
useful things.

If a new device has no use except for writing a custom code, then it's
a clue that we're missing the actual use case.

In the graphics buffer sharing use case, how does the other side
determine how to interpret this data?  Shouldn't there be a VIRTIO
device spec for the messaging so compatible implementations can be
written by others?

Stefan

