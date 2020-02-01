Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D502C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 18:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697DC20679
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 18:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697DC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixxuQ-0007Ro-Lu
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 13:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixxtk-0006uV-7O
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 13:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixxth-0006kl-Li
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 13:53:39 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixxth-0006k8-54; Sat, 01 Feb 2020 13:53:37 -0500
Received: by mail-yw1-f66.google.com with SMTP id b81so8678686ywe.9;
 Sat, 01 Feb 2020 10:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LxBxfjU6UpH7d7NY+ZsQ4fWGmoFMOfcL+a2XD3Z33Ls=;
 b=PF7ORrrE+RWTm8ttnVxbgfBtR75Xa5vckjs4IajDZtHTuJ7O/McMFV2Cl0e87vfzmX
 GTDsV/u002HqS4/bEL4M4+jpZSG9XdolnzJdSZsaS1i3YusyGO0yMmbtyyu1JzWF4AlU
 RWjNnNPDUOC98stimSiE5cpaZxiGsFhoxGQtHtTCBPXKIoip9gucaQcNow00bxpYSgcf
 Ppw/ZESUoCt6oTtwMLrRcOTbzGBq5CPKjtnlUfKPh1q9VykDEvf6Xi3X+UHRZesjXKm9
 TV/kmC7CzMZyPeldo4R39lN5CT2kMUyA2XbUjwtJC3U+/Z+pGdYGgJ9Klet14lmAFwLu
 F/6g==
X-Gm-Message-State: APjAAAWeqkz4pjtBlrA6FyhKZxkyUKecda3wwk5BuK8qU8P+Ium7pRmN
 vCzZ1zZ3ZMx8QRclSoGVfgj+fjX2KntdonkyKKI=
X-Google-Smtp-Source: APXvYqwx5H/RhwJuCZ8MHmWIXeoH/m3hNZ3Dayb2s3Ynm2DNAIGqWVABkX4K/MOtGwffMoDveabDsdUIGYhsQTsC0/U=
X-Received: by 2002:a0d:d84b:: with SMTP id a72mr11778542ywe.33.1580583216230; 
 Sat, 01 Feb 2020 10:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
 <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
 <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
In-Reply-To: <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 1 Feb 2020 19:53:24 +0100
Message-ID: <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 1, 2020 at 7:51 PM Thomas Huth <thuth@redhat.com> wrote:
> On 01/02/2020 17.09, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 11/20/19 10:10 AM, Thomas Huth wrote:
> >> It's been deprecated since QEMU v3.1. We've explicitly asked in the
> >> deprecation message that people should speak up on qemu-devel in case
> >> they are still actively using the bluetooth part of QEMU, but nobody
> >> ever replied that they are really still using it.
> >>
> >> I've tried it on my own to use this bluetooth subsystem for one of my
> >> guests, but I was also not able to get it running anymore: When I was
> >> trying to pass-through a real bluetooth device, either the guest did
> >> not see the device at all, or the guest crashed.
> >>
> >> Even worse for the emulated device: When running
> >>
> >>  qemu-system-x86_64 -bt device:keyboard
> >>
> >> QEMU crashes once you hit a key.
> >>
> >> So it seems like the bluetooth stack is not only neglected, it is
> >> completely bitrotten, as far as I can tell. The only attention that
> >> this code got during the past years were some CVEs that have been
> >> spotted there. So this code is a burden for the developers, without
> >> any real benefit anymore. Time to remove it.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  Makefile.objs        |    2 -
> >>  bt-host.c            |  198 ----
> >>  bt-vhci.c            |  167 ----
> >>  configure            |   31 -
> >>  hw/Kconfig           |    1 -
> >>  hw/Makefile.objs     |    1 -
> >>  hw/bt/Kconfig        |    2 -
> >>  hw/bt/Makefile.objs  |    3 -
> >>  hw/bt/core.c         |  143 ---
> >>  hw/bt/hci-csr.c      |  512 ----------
> >>  hw/bt/hci.c          | 2263 -----------------------------------------=
-
> >>  hw/bt/hid.c          |  553 -----------
> >>  hw/bt/l2cap.c        | 1367 -------------------------
> >>  hw/bt/sdp.c          |  989 ------------------
> >>  include/hw/bt.h      | 2177 ----------------------------------------
> >>  include/sysemu/bt.h  |   20 -
> >>  qemu-deprecated.texi |    7 -
> >>  qemu-options.hx      |   79 --
> >>  vl.c                 |  136 ---
> >>  19 files changed, 8651 deletions(-)
> >>  delete mode 100644 bt-host.c
> >>  delete mode 100644 bt-vhci.c
> >>  delete mode 100644 hw/bt/Kconfig
> >>  delete mode 100644 hw/bt/Makefile.objs
> >>  delete mode 100644 hw/bt/core.c
> >>  delete mode 100644 hw/bt/hci-csr.c
> >>  delete mode 100644 hw/bt/hci.c
> >>  delete mode 100644 hw/bt/hid.c
> >>  delete mode 100644 hw/bt/l2cap.c
> >>  delete mode 100644 hw/bt/sdp.c
> >>  delete mode 100644 include/hw/bt.h
> >>  delete mode 100644 include/sysemu/bt.h
> >>
> > [...]> diff --git a/configure b/configure
> >> index 6099be1d84..ecce4ada2d 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -349,7 +349,6 @@ unset target_list_exclude
> >>  # Distributions want to ensure that several features are compiled in,=
 and it
> >>  # is impossible without a --enable-foo that exits if a feature is not=
 found.
> >>
> >> -bluez=3D""
> >>  brlapi=3D""
> >>  curl=3D""
> >>  curses=3D""
> >> @@ -1151,10 +1150,6 @@ for opt do
> >>    ;;
> >>    --enable-brlapi) brlapi=3D"yes"
> >>    ;;
> >> -  --disable-bluez) bluez=3D"no"
> >> -  ;;
> >> -  --enable-bluez) bluez=3D"yes"
> >> -  ;;
> >
> > Now than I'm bisecting over this commit, I realize removing this
> > option was not a good idea, we should have done like commit
> > cb6414dfec8 or 315d3184525:
> >
> >   @@ -886,10 +885,6 @@ for opt do
> >   -  --disable-uuid) uuid=3D"no"
> >   -  ;;
> >   -  --enable-uuid) uuid=3D"yes"
> >   -  ;;
> >   ...
> >   +  --enable-uuid|--disable-uuid)
> >   +      echo "$0: $opt is obsolete, UUID support is always built" >&2
> >   +  ;;
>
> Looks trivial ... so if it bugs you, just send a patch?

I thought about it but this won't fix much, it is too late now.

I simply wanted to share this bugged me so we try to avoid doing the
same mistake again.

