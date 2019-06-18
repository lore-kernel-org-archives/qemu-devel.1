Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52269C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E2520873
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHDSCWN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E2520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdMYk-00045g-Cf
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 18:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51106)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdMXz-0003gj-0t
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdMXy-0007aN-1l
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:25:46 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:34218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdMT3-0002PC-8r; Tue, 18 Jun 2019 18:20:42 -0400
Received: by mail-lf1-x143.google.com with SMTP id y198so10492834lfa.1;
 Tue, 18 Jun 2019 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2R/yr25SgwJbeYXTxlBioodxbM8AJCpuqbKHCdOCpkI=;
 b=GHDSCWN346NM9o0bkA8uNM7U7muahYAgfkhlRBin8BfU4qUoCHeaQ2cBeukW9AJjZV
 NC5R2oeFDpSmYj6T4iRv8oFnWvCAvb3GtvGqoQ/d2FJZwZuOt/nvsheTEQXhoasX8suU
 KwmIObg+dPdUUGJjQtrVSB9JuK22rXhhfXN4Q+ebI1lBXxbhgB8aOfsYzoQKJotEi16v
 /dgSq5uhAW/+LuPnXcMIUMaixbPil2Iqa1l4yYMbOujqOcMh0Ccm6dtIDbn7zEI8d37y
 m85RT0Nyql1nzx31iuVXGf/xop0sPScTFWGvnKtGBvYlCkkWt2LH5SYgoFzggxOk/gwF
 C+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2R/yr25SgwJbeYXTxlBioodxbM8AJCpuqbKHCdOCpkI=;
 b=uDAPuJ2SRgheBsdTNS0zVcE+mts7N2t08R6cztJLJolgNut2Kn7mQMA7u1Zu1sRB/O
 jY2tFSnB3q264fBXFlLtEvnSLqtOawcVBR5PYiZJXM4gSrFhZsVmh2dOBWaYAU134Pd+
 2v3kxtILrUYDNzvLJICNFr1jGR8+71TFVOAjJA9E9w6bvbhXyz2gd6qAe8NWQZ5/umOw
 GKUesM8rCtl8utzjvxZxwfm/RHQPoSFmvsG2SfFmkrFrKGQv22KuOw3kLTUYnyqphg2p
 aBkmZq80kCBRJslOzgecczLl8rYKBOaMCl62M8fLiKHpKdnGwuYlnSWDBcGv398IetAE
 iKFg==
X-Gm-Message-State: APjAAAXeIGu5/4QmRBD4puc8bxYFf+1pRzzMyg9ndBa4AzlH35ca9+bV
 K42hWLlDOFv2jnlNrota84qOIOHO+ZBO8JVnhq8=
X-Google-Smtp-Source: APXvYqymdOPTTFJaDZRbMMvljpiUBIDKVRL/ugfo3eICEKqcQgng6XJo9TKTmOTiFs5qSaz/Z31b9mIInZqdguMKucU=
X-Received: by 2002:a19:710b:: with SMTP id m11mr54416271lfc.135.1560896439982; 
 Tue, 18 Jun 2019 15:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMs4nt0eddFkXHG9vOdxnj=yB8jx8s9NivNiwvVg8TObA@mail.gmail.com>
 <mhng-03d5c9ed-4818-4efc-99e0-cdceab2eab3d@palmer-si-x1e>
 <20190611063019.2uiatioxh73lrgqz@sirius.home.kraxel.org>
In-Reply-To: <20190611063019.2uiatioxh73lrgqz@sirius.home.kraxel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Jun 2019 15:17:52 -0700
Message-ID: <CAKmqyKMgNrGchEa0D+FsbmoOfs259awtge20EaNb=Bv1JtP6vA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] RISC-V: Include ROM in QEMU
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, onathan@fintelia.io,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 10, 2019 at 11:30 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Jun 07, 2019 at 05:03:42PM -0700, Palmer Dabbelt wrote:
> > On Thu, 06 Jun 2019 16:22:47 PDT (-0700), alistair23@gmail.com wrote:
> > > Hello,
> > >
> > > As a test of the waters, how would the QEMU community feel about
> > > including the RISC-V OpenSBI project as a ROM submodule?
> > >
> > > The idea would be to have OpenSBI (similar to ATF for ARM and a BIOS
> > > for x86) included by default to simplify the QEMU RISC-V boot process
> > > for users. This would remove the requirement for users/developers to
> > > build a RISC-V firmware. The goal here is to allow people to just
> > > download and run their kernel as easily as they currently do for x86.
> > >
> > > We would make sure that it can be disabled! That is users/developers
> > > can use their own (or none) if they want to. The idea here is just to
> > > simplify the boot process, not lock anyone out.
> >
> > I like it.  My only question is about the mechanics of doing so: are we just
> > going to assume there's a cross compiler in PATH?  I guess that's less of a
> > usability headache than needing a complier and a firmware.
>
> Usual way to add firmware:
>
>   (1) Add a submodule below roms/
>   (2) Add rules to build the firmware to roms/Makefile.  Firmware
>       maintainers can use them, and they also document the build process.
>       A normal qemu build will not automatically build the firmware
>       though.
>   (3) Place a pre-built binary in pc-bios/
>
> There is some cross compiler detection logic in roms/Makefile which you
> can use.

Thanks for the info. I have it all working now, just running a few
more tests. I will send my patches out today or tomorrow.

Alistair

>
> cheers,
>   Gerd
>

