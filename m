Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66379C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F4123428
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avb70Jdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F4123428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3lst-0007it-EK
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i3ls7-0007If-Lc
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i3ls6-00007Z-62
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:43:43 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:38856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i3ls5-00006y-UF; Fri, 30 Aug 2019 14:43:42 -0400
Received: by mail-lf1-x143.google.com with SMTP id c12so6087570lfh.5;
 Fri, 30 Aug 2019 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kaOBQ4A7nBcUJgK5RMy0DpTWmFUVKRzfj7tcDVEsdks=;
 b=avb70JdrnjmpkoKSk9kUncNScnSVjmP9uxv5VBE4paN6rR8LpaPWAbSTSb+HMvUNyZ
 +uKho38U+AbvG7V/9Ufz935R/DY0HZLAdGy+2U0mOQwbBHj9FfoODEzzJihZeA6UDxWX
 sZI2DSRLvOI6crbAQalO+5oM2ZlfacejO/UNOq3bUs2jTr1egGW1idvlayZTbuhcDkjV
 rLbfLHmlRdpP4WWsB4Mc57tsrswfQ5TX/eQ7z8VL9je0xSiceCFK4B1+wkL4RWl1Muyg
 pkNp6Cj3FkU8L2qIupGZXwBSVOd26I5wAifFXh3QxOIUAgSTHP1iAyemEI8+PC3M5RV2
 QNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kaOBQ4A7nBcUJgK5RMy0DpTWmFUVKRzfj7tcDVEsdks=;
 b=WomXetH2f3Ndl+ymCdK1ZWxVcmiknE6NtmtQoHx41nyt0y0CFEDi8YWsbMfHBmrhQE
 D3JuPRWOTBQxURIqOpETUl7A73wPeXixz9Ve7YSz8/GrGTgOaDCvqs+fyiexMn6lTu+G
 YNOO2GvNRFxI33PFlSyDfaTmSVP9q52zKPLXBamuk0N3X9GGT3OF5E7Yz+DAGrrn7PUQ
 hmUsZKuDtDlvP8Y928msI3BcYtXmxtoQKxmgPp8n7W6EYEJslveK4qsZv1vqirCTg+SQ
 8APfqqZZimH5Lv4uv9n63sf/odsFNnXZoDqfEpA0ifW0eITIMo5xt0e0amhVoDT1T540
 qGtw==
X-Gm-Message-State: APjAAAVCYqvvOlaex7qNqx3JOM0yiZCOT5/js4dNaGdFPS7SdTPLnLnf
 k13/C6OkvV680Ns08WVbZKYVIA8wMaxSzZE8WPU=
X-Google-Smtp-Source: APXvYqzq3Oe+PetVFVU1PxUX1vrCzP6Flqe5+pFsL5YMXpajrof7yw1CkN5WoHlhSOSHYGl5tf2elAiwH5ls7+Ldmv0=
X-Received: by 2002:ac2:4a69:: with SMTP id q9mr4097753lfp.86.1567190619998;
 Fri, 30 Aug 2019 11:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <CAKmqyKMDmaABGWyLZD2R-4J8=jM6hry6Bfmu498+UZzQtxsTMA@mail.gmail.com>
 <af15b620-1350-aa1a-0f02-2a46518f0ef2@c-sky.com>
 <CAKmqyKPUxyMZnnOd896aK4ZRoG+6iiBQ0E3MJbEqRv9KudbN7Q@mail.gmail.com>
 <87tv9z3tvg.fsf@linaro.org>
In-Reply-To: <87tv9z3tvg.fsf@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2019 11:39:29 -0700
Message-ID: <CAKmqyKMf=gTvFrk+ndsXQPmO1dVGGXNJ8ByFrKu=jokA+LC8iA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>, liuzhiwei <zhiwei_liu@c-sky.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 30, 2019 at 2:06 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Alistair Francis <alistair23@gmail.com> writes:
>
> > On Thu, Aug 29, 2019 at 5:05 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
> >>
> >> On 2019/8/29 =E4=B8=8A=E5=8D=885:34, Alistair Francis wrote:
> >> > On Wed, Aug 28, 2019 at 12:04 AM liuzhiwei <zhiwei_liu@c-sky.com> wr=
ote:
> >> >> Change-Id: I3cf891bc400713b95f47ecca82b1bf773f3dcb25
> >> >> Signed-off-by: liuzhiwei <zhiwei_liu@c-sky.com>
> >> >> ---
> >> >>   fpu/softfloat.c                         |   119 +
> >> >>   include/fpu/softfloat.h                 |     4 +
> >> >>   linux-user/riscv/cpu_loop.c             |     8 +-
> >> >>   target/riscv/Makefile.objs              |     2 +-
> >> >>   target/riscv/cpu.h                      |    30 +
> >> >>   target/riscv/cpu_bits.h                 |    15 +
> >> >>   target/riscv/cpu_helper.c               |     7 +
> >> >>   target/riscv/csr.c                      |    65 +-
> >> >>   target/riscv/helper.h                   |   354 +
> >> >>   target/riscv/insn32.decode              |   374 +-
> >> >>   target/riscv/insn_trans/trans_rvv.inc.c |   484 +
> >> >>   target/riscv/translate.c                |     1 +
> >> >>   target/riscv/vector_helper.c            | 26563 +++++++++++++++++=
+++++++++++++
> >> >>   13 files changed, 28017 insertions(+), 9 deletions(-)
> >> >>   create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
> >> >>   create mode 100644 target/riscv/vector_helper.c
> >> >>
> >> > Hello,
> >> >
> >> > Thanks for the patch!
> >> >
> >> > As others have pointed out you will need to split the patch up into
> >> > multiple smaller patches, otherwise it is too hard to review almost
> >> > 30,000 lines of code.
> >>
> >> Hi, Alistair
> >>
> >> I'm so sorry for the inconvenience. It will be a patch set with a cove=
r
> >> letter in V2.
> >
> > No worries.
> >
> >>
> >> > Can you also include a cover letter with your patch series describin=
g
> >> > how you are testing this? AFAIK vector extension support isn't in an=
y
> >> > compiler so I'm assuming you are handwriting the assembly or have
> >> > toolchain patches. Either way it will help if you can share that so
> >> > others can test your implementation.
> >>
> >> Yes, it's handwriting assembly. The assembler in Binutils has support
> >> Vector extension.  First define an function test_vadd_vv_8 in assembly
> >> and then it can be called from a C program.
> >>
> >> The function is something like
> >>
> >> /* vadd.vv */
> >> TEST_FUNC(test_vadd_vv_8)
> >>          vsetvli        t1, x0, e8, m2
> >>          vlb.v           v6, (a4)
> >>          vsb.v           v6, (a3)
> >>          vsetvli        t1, a0, e8, m2
> >>          vlb.v           v0, (a1)
> >>          vlb.v           v2, (a2)
> >>          vadd.vv     v4, v0, v2
> >>          vsb.v          v4, (a3)
> >> ret
> >>          .size   test_vadd_vv_8, .-test_vadd_vv_8
> >
> > If possible it might be worth releasing the code that you are using for=
 testing.
> >
> >>
> >> It takes more time to test than to implement the instructions. Maybe
> >> there is some better test method or some forced test cases in QEMU.
> >> Could you give me some advice for testing?
> >
> > Richard's idea of risu seems like a good option.
> >
> > Thinking about it a bit more we are going to have other extensions in
> > the future that will need assembly testing so setting up a test
> > framework seems like a good idea. I am happy to help try and get this
> > going as well.

Ah, I looked into this more and it compares it to hardware running the
same binary. In this case there is no hardware so that doesn't work
too well.

What we could do though, is compare it to Spike (which I think has the
vector instructions?) which would have the same effect.

>
> tests/tcg already has the bits you need for both linux-user and system
> based testing. The main problem is getting a version of gcc that is new
> enough to emit the newer instructions. I recently updated the images to
> buster so gcc is pretty recent now (8.3).

In this case there is no GCC with the new instructions.

>
> I did start down the road of a general "op" test frame work which tried
> to come up with a common framework/boilerplate so all you needed to do
> was supply a new function (possible with a hex encoded instruction) and
> a list of expected inputs and outputs:
>
>   https://github.com/stsquad/qemu/commits/testing/generic-op-tester
>
> I suspect it was over engineered but perhaps it would be worth reviving
> it (or something like it) to make adding a simple single instruction
> test case with minimal additional verbiage?

That would be interesting, I'll take a look.

Alistair

>
> >
> > Alistair
> >
> >>
> >> Best Regards,
> >>
> >> Zhiwei
> >>
> >> > Alex and Richard have kindly started the review. Once you have
> >> > addressed their comments and split this patch up into smaller patche=
s
> >> > you can send a v2 and we can go from there.
> >> >
> >> > Once again thanks for doing this implementation for QEMU!
> >> >
> >> > Alistair
> >> >
>
>
> --
> Alex Benn=C3=A9e

