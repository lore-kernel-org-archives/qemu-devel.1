Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AEDC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC135206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC135206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuPvs-0008DF-Ui
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iuPv1-0007jb-LI
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iuPuq-000855-He
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:00:16 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iuPuq-00082q-Dg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:00:08 -0500
Received: by mail-yb1-f196.google.com with SMTP id x191so767409ybg.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lrfiYWzVetiSJKtIkM2uB2FEUtr1UV8Sl/t3Ot3I78g=;
 b=sGUuCnRpHZUvCAl/emabYXyKIKM9ACDlFOrYoHxeLkFy+Qhx2HeYb9VEn5MKivcY8Y
 Z8pcGQDYObf7rgzvHpWfdmxx8FdFr8+53iHSrot1bJVb8UdJ3ncYFCqsv+m/fbr/+O5w
 6RFRpgCUtwT7GB+FMxHcGKfPhNcEgoCkto8b5RU4iwq6MNozyZCmJ0HP7QBX+z2QiqAP
 y9Qz+pWc93wtavrCSghtcF7CFXrT/ogxU/aZT8W/e7rWRz4S0sAAlfqjhECZhqW6bWKq
 qnVtWcAKDbShNnu3QbzbNOWueU7qwx3Ha02EtyVB5lmLbnXWTj24E2/XbzMAZG0+jBuN
 JS6A==
X-Gm-Message-State: APjAAAVe9MwMHKq+3Il0ise+J1HVj+bovoIMCfZ813wW7HenEo4f/nzP
 8yp07dby43P71tqBKB5dCYQyx8515M56UB5vAhY=
X-Google-Smtp-Source: APXvYqxHTM0/AuE2YgBNNiUswJmIfNaHC2n4sydyD2uwgDlJotvAWiu6pH5tcgG84BDT9teoALxs/RvWSSLqICnP7tw=
X-Received: by 2002:a25:e714:: with SMTP id e20mr8951128ybh.323.1579737605191; 
 Wed, 22 Jan 2020 16:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20200122023256.27556-1-richard.henderson@linaro.org>
 <b7c91905-f1bb-a3ea-e39c-08a27b2ff36e@linaro.org>
 <da98d952-80e6-750a-3324-32723037b94f@redhat.com>
 <CAAdtpL6TYgkNP9Zd-E4Ar1HKfC8conSx74ozA+jObkOdoueUnw@mail.gmail.com>
In-Reply-To: <CAAdtpL6TYgkNP9Zd-E4Ar1HKfC8conSx74ozA+jObkOdoueUnw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 23 Jan 2020 00:59:53 +0100
Message-ID: <CAAdtpL6xmiM=oHxw1Xr5btjsS-hsW+BV+-LNUpNipjOuXt-2Rg@mail.gmail.com>
Subject: Re: [PULL 00/11] target/hppa patch queue
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.196
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
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 12:34 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On Thu, Jan 23, 2020 at 12:28 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 1/22/20 3:47 AM, Richard Henderson wrote:
> > > On 1/21/20 4:32 PM, Richard Henderson wrote:
> > >> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfc=
de0dd40:
> > >>
> > >>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-nex=
t-20200121' into staging (2020-01-21 15:29:25 +0000)
> > >>
> > >> are available in the Git repository at:
> > >>
> > >>    https://github.com/rth7680/qemu.git tags/pull-pa-20200121
> > >>
> > >> for you to fetch changes up to a66cfb7306b7cf7a023e11536fdd942f3f927=
6b9:
> > >>
> > >>    target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-0=
1-21 15:51:54 -1000)
> > >>
> > >> ----------------------------------------------------------------
> > >> Improve LASI emulation
> > >> Add Artist graphics
> > >> Fix main memory allocation
> > >> Improve LDCW emulation wrt real hw
> > >
> > > Ho hum.  Cancel this.  It breaks the hppa boot-serial test.
> >
> > This is due to patch #7 "Add emulation of Artist graphics":
> >
> > 130     /* Graphics setup. */
> > 131     if (machine->enable_graphics && vga_interface_type !=3D VGA_NON=
E) {
> > 132         dev =3D qdev_create(NULL, "artist");
> > 133         qdev_init_nofail(dev);
> > 134         s =3D SYS_BUS_DEVICE(dev);
> > 135         sysbus_mmio_map(s, 0, LASI_GFX_HPA);
> > 136         sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
> > 137     }
> >
> > The hppa boot-serial test use the default options, so the Artist chipse=
t
> > is mapped, and the firmware test/use it.

Since gitweb seems broken...
https://git.qemu.org/git?p=3Dseabios-hppa.git;a=3Dcommit;h=3Dba3c6473baf

Here is the relevant commit information:

- if Artist is mapped:
https://github.com/hdeller/seabios-hppa/commit/ba3c6473baf#diff-c47fa882864=
c690c7dc1dce8b4ac2c99R1739-R1742

- then use it as console (instead of the uart)
https://github.com/hdeller/seabios-hppa/commit/ba3c6473baf#diff-c47fa882864=
c690c7dc1dce8b4ac2c99R477-R483

> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Btw ;)
>
> > We can test like the 40p, using VGA_NONE:
> >
> > -- >8 --
> > diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-t=
est.c
> > index 05c7f44457..971254ae62 100644
> > --- a/tests/qtest/boot-serial-test.c
> > +++ b/tests/qtest/boot-serial-test.c
> > @@ -135,7 +135,7 @@ static testdef_t tests[] =3D {
> >         sizeof(kernel_plml605), kernel_plml605 },
> >       { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0,
> > bios_moxiesim },
> >       { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 =
},
> > -    { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
> > +    { "hppa", "hppa", "-vga none", "SeaBIOS wants SYSTEM HALT" },
> >       { "aarch64", "virt", "-cpu cortex-a57", "TT", sizeof(kernel_aarch=
64),
> >         kernel_aarch64 },
> >       { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 =
},
> > ---
> >
> > You should squash this change in patch #7 (because it belongs there) bu=
t
> > please add a comment, because it is not obvious.
> >
> > Thanks,
> >
> > Phil.

