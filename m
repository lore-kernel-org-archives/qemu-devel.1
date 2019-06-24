Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C73C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0677520645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsNBigXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0677520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54478 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfVQY-0000kL-8P
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59793)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hfVNu-0007nq-TU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hfVNs-0001t7-Mw
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:16:14 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hfVNs-0001qY-Ac; Mon, 24 Jun 2019 16:16:12 -0400
Received: by mail-lj1-x242.google.com with SMTP id a21so13872201ljh.7;
 Mon, 24 Jun 2019 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5PQ5wmDY5RAVnyBwr117W10VjHZMVuGv+wq1nmeJyqo=;
 b=HsNBigXcs+wmP1ZRAr1PBmp8Jk4OY+PHDlxliy6rmsOCp2YOnGsgxe+gaiUEZkVXSU
 P6CJRJBmBrlHJRYsclJJdolIZ+E8X9EUkgJC1O+UN143meCqMpPiojduBL2W/tpvokJc
 0dDpdFWh4HvtrypfJbGifi0fQD1SRnf1BbqA5RlDr4lV+Y6n5bnmO2osiKa/FMAqISkf
 Fxy1vZB3NrDaDpht6OiavagcRx+EfVLQGm+lxrek20kk/6WgDca4kfMBs1nSjHsR8pBh
 aQBHMIVYsT7JPovoq7COGEuqzG1wyN2s/O1ZtjFyVfxiQb0p7Po5WwkcmOmRq5iQIXnE
 gCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5PQ5wmDY5RAVnyBwr117W10VjHZMVuGv+wq1nmeJyqo=;
 b=XFyBGHcwU+HsIp1Iy7eZt3VUWTQduTfKaowwpq3aCGJQqWHrIaMTE5DK4bkkWRKT9c
 N+O5bQPKqdpHlk0OxGNbyd61qD8hdRIXdNFKMWSytFVo5pOS6mteDOHkEFgptn/r3RZK
 J7TtVtuIYWOptHU/NndVrIH1U25EOTqy0BPJRSAgNBigYVLRobev0tKIV0CkmnoySLt6
 2sAZBAFuG6g06JDl6ONXXMMlkT9LZo9avCQ2UcrMRMqgRz6j+amEq9XUo+izoVIUAMrp
 LAht7vrqLyc+LoXzexxnaQofEKIbqqzx20fwbneLwRwk+RZz9TWGxOvlgSLqEQJspiTq
 WCBw==
X-Gm-Message-State: APjAAAWI5HCiVY77On7ak5bQThgMgeBOpQHPz/VwKOu5bNZLdS59nWaW
 knatzpCcqPflKWyOHQlEEe/a7UFq1jfSbw19KXc=
X-Google-Smtp-Source: APXvYqxLleBKFFqbRU3rF6kr4AlVZ3YJcalXYks+89F4X3sRDsgvL2kxKL3EdpSxQXJI7tz8uT30cyvSxuKxgLPC8z0=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr30378518ljj.58.1561407370029; 
 Mon, 24 Jun 2019 13:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560821342.git.alistair.francis@wdc.com>
 <mhng-1bb3bc4e-1846-4e2a-ab19-ab4436041f63@palmer-si-x1e>
In-Reply-To: <mhng-1bb3bc4e-1846-4e2a-ab19-ab4436041f63@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Jun 2019 13:13:15 -0700
Message-ID: <CAKmqyKN01ZWxSZH+VLa1QTXuwiSUZ9mycY9iOMZm7=b1E6xDOQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v1 0/9] Update the RISC-V specification
 versions
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 2:33 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 17 Jun 2019 18:31:00 PDT (-0700), Alistair Francis wrote:
> > Based-on: <cover.1555726824.git.alistair.francis@wdc.com>
> >
> > Now that the RISC-V spec has started to be ratified let's update our
> > QEMU implementation. There are a few things going on here:
> >  - Add priv version 1.11.0 to QEMU
> >     - This is the ratified version of the Privledge spec
> >     - There are almost no changes to 1.10
> >  - Mark the 1.09.1 privledge spec as depreated
> >      - Let's aim to remove it in two releases
> >  - Set priv version 1.11.0 as the default
> >  - Remove the user_spec version
> >      - This doesn't really mean anything so let's remove it
> >  - Add support for the "Counters" extension
> >  - Add command line options for Zifencei and Zicsr
> >
> > We can remove the spec version as it's unused and has never been exposed
> > to users. The idea is to match the specs in specifying the version. To
> > handle versions in the future we can extend the extension props to
> > handle version information.
> >
> > For example something like this: -cpu rv64,i=2.2,c=2.0,h=0.4,priv_spec=1.11
> >
> > NOTE: This isn't supported today as we only have one of each version.
> >
> > This will be a future change if we decide to support multiple versions
> > of extensions.
> >
> > The "priv_spec" string doesn't really match, but I don't have a better
> > way to say "Machine ISA" and "Supervisor ISA" which is what is included
> > in "priv_spec".
> >
> > For completeness I have also added the Counters, Zifencei and Zicsr
> > extensions.
> >
> > Everything else seems to match the spec names/style.
> >
> > Please let me know if I'm missing something. QEMU 4.1 is the first
> > release to support the extensions from the command line, so we can
> > easily change it until then. After that it'll take more work to change
> > the command line interface.
> >
> > Alistair Francis (9):
> >   target/riscv: Restructure deprecatd CPUs
> >   target/riscv: Add the privledge spec version 1.11.0
> >   target/riscv: Comment in the mcountinhibit CSR
> >   target/riscv: Set privledge spec 1.11.0 as default
> >   qemu-deprecated.texi: Deprecate the RISC-V privledge spec 1.09.1
> >   target/riscv: Require either I or E base extension
> >   target/riscv: Remove user version information
> >   target/riscv: Add support for disabling/enabling Counters
> >   target/riscv: Add Zifencei and Zicsr as command line options
> >
> >  qemu-deprecated.texi                          |  8 +++
> >  target/riscv/cpu.c                            | 72 ++++++++++---------
> >  target/riscv/cpu.h                            | 19 ++---
> >  target/riscv/cpu_bits.h                       |  1 +
> >  target/riscv/csr.c                            | 13 +++-
> >  .../riscv/insn_trans/trans_privileged.inc.c   |  2 +-
> >  6 files changed, 71 insertions(+), 44 deletions(-)
>
> Aside from the comments on 3 and 9
>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> I've got these, along with my proposed modifications, queued up.  LMK if that's
> a problem, particularly the two-patch replacement for 9 needs a review as it's
> entirely new code.

I haven't looked at the new code yet, but it all passes my tests so LGTM.

Alistair

