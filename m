Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C2C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45750207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usNu8LKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45750207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJK8-0001jz-3g
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irJJ9-000156-5Y
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irJJ7-0006A4-VS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:20:23 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:37400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1irJJ7-00069n-R9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:20:21 -0500
Received: by mail-qk1-x743.google.com with SMTP id 21so11586427qky.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 02:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HI8Gr6zHhG3Vukw1huvIV1a1LkKhMaZLUP/apOK5HcI=;
 b=usNu8LKRxT5BAMzXggB6H2tlmSv+md92rqf6ZofBkMjI8JswsDmLyb73ca380aN0uM
 GQJ2Mnm959+7XRKy3bTZx3Hho7jbo5TZd2Bubh06+BYYfcZN2glWmCulOQYiJSqyew42
 JEU9O08NYaDQvdDhzjxGkbetadhZ+m2/rcmikks27t00hrACdIXxHNhYpV9yEmClQhXG
 IIvGxDXDROdX0DrvQNbYxhPaagdwYYIPvpB9bH0UorQ5aqz7CqtyWjvfbdTunhEVuIDh
 4QyuWJS0wVHfeg1yoWfIOA+qxvd/QTEExqEzCuwV9IMhZrS5G3PtM/x3V7r8gg12pe/c
 hp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HI8Gr6zHhG3Vukw1huvIV1a1LkKhMaZLUP/apOK5HcI=;
 b=evOjaqeQOjCOB5TMkybL9s6mYshepsYFJs2kCbVRZd04/4jYUmAf8g/zvpzi+ODcGw
 U6d2n49jKuyKQJuajSbn9V3IRAnHzLxY2regRCp67E01aVhzymDAK5aRaJaTVNBaBUBw
 fMh1qKxD24CMkpiuZVHezlUVtJCCdM8ZQYtTrtsIFSoybI3p4W4quxgDwdbEhuG/8SI+
 RSQYhgKIhKfHuj3Mc6HeOabRe5kaihVC+jjzNiL7Df4d9HtUum2mVGY1KpoJyB9OLnKR
 AZFh+BpwqNHowGhMae0Lv9X1+37/4pzynOPtia0FQpPZPEEqN/gMwVuoUhA0j5IMXRrY
 hgPg==
X-Gm-Message-State: APjAAAUuD2jKpVAP0Qc5/Ykf1KyVrZofiZy2EgOSGV4FpuSKlMZgMN/2
 keu3brj7LVcP7zXvBovP+6c/kp/BuUZwRgZGfIw=
X-Google-Smtp-Source: APXvYqwaVD/HZYWrSWjnP0IWPVxkjm0fHXzCztkPywB8RZXUoGRYdO1NpnhDGKlQsav+Qaz9BxjxuVSS33OF8y0atEk=
X-Received: by 2002:a37:a215:: with SMTP id l21mr15927039qke.87.1578997220893; 
 Tue, 14 Jan 2020 02:20:20 -0800 (PST)
MIME-Version: 1.0
References: <98d1e1f0-0e53-d207-78ce-ea9717673985@winaoe.org>
 <CAJ+F1CLzR7Q7ei550d+2GhnmcwiGpb2ixem_tr4QUPnsF_KPKg@mail.gmail.com>
In-Reply-To: <CAJ+F1CLzR7Q7ei550d+2GhnmcwiGpb2ixem_tr4QUPnsF_KPKg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Jan 2020 10:20:09 +0000
Message-ID: <CAJSP0QW6cC=rCTn--vJ84t+LzeFND_SeN76CdF1fv6-F4NVDyg@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/1] Vhost User Cross Cable: Intro
To: "V." <mail@winaoe.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 10:34 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> On Wed, Jan 8, 2020 at 5:57 AM V. <mail@winaoe.org> wrote:

Hi V.,
I think I remember you from Etherboot/gPXE days :).

> > 3.
> > Now if Cross Cable is actually a new and (after a code-rewrite of 10) a=
 viable way to connect 2 QEMU's together, could I actually
> > suggest a better way?
> > I am thinking of a '-netdev vhost-user-slave' option to connect (as cli=
ent or server) to a master QEMU running '-netdev vhost-user'.
> > This way there is no need for any external program at all, the master c=
an have it's memory unshared and everything would just work
> > and be fast.
> > Also the whole thing can fall back to normal virtio if memory is not sh=
ared and it would even work in pure usermode without any
> > context switch.
> >
> > Building a patch for this idea I could maybe get around to, don't clear=
ly have an idea how much work this would be but I've done
> > crazier things.
> > But is this is something that someone might be able to whip up in an ho=
ur or two? Someone who actually does have a clue about vhost
> > and virtio maybe? ;-)
>
> I believe https://wiki.qemu.org/Features/VirtioVhostUser is what you
> are after. It's still being discussed and non-trivial, but not very
> active lately afaik.

virtio-vhost-user is being experimented with in the SPDK community but
there has been no activity on VIRTIO standardization or the QEMU
patches for some time.  More info here:
https://ndragazis.github.io/spdk.html

I think the new ivshmem v2 feature may provide the functionality you
are looking for, but I haven't looked at them yet.  Here is the link:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg668749.html

And here is Jan's KVM Forum presentation on ivshmem v2:
https://www.youtube.com/watch?v=3DTiZrngLUFMA

Stefan

