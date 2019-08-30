Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC0C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6952341C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSmeTcYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6952341C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3cvY-00021Z-E8
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 05:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3crQ-0001JR-LI
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3crM-0008Q2-E2
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:06:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3crM-00084Z-4s
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:06:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id p13so6662740wmh.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AcGGbQCProEi2yhXItlgqt/SFnRLFVnIij98L2feLsU=;
 b=MSmeTcYJFhz1ISHugDPfFoCyPQsiTRcijS3hCNv19Pa2xqHtuNpzU9jDFqLvlWs55v
 g+Wqlmx1b4ac9lirKyYIitQF+ZgUoLt/xfcUPQ5+1Ivn2uC2uxJT/JIjIfW17eLlZ5kP
 Hhlr8HGU9gI9L10wJBjqHxhFkwiIyRnbzGWNRUBv+AQL5FWM5r6AZbuEysjndPrIh7Ki
 cUNd01/lxDO7FKci0W+o/XdcjEC40UKc+cqv767TEAKCWY55iiiZsZppYtl3AJOvsT9f
 HQGltCbEV+1p7hRXfTwfQWxcqoRiEf970Oax4b0dX9UJbCIniLJopskDctfhUtf/7RI/
 uAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AcGGbQCProEi2yhXItlgqt/SFnRLFVnIij98L2feLsU=;
 b=DTozi+PKH3jbIa67tDAEIaGJuSGA6XYkILpVaLunFbRhGR1xjFiqxlwcNyxmAoyf/e
 RNyd4jhCDg4zQcEBsXd+dlQv2dkN3IYM0RLfk4L7DT/8oPEFbNULH7XXTU5FNnT4etsz
 NkRW7gwlBhz0YiYBlX/sc4K9+beuhiYK3nNc/DD/iL/ZIXezKEOMmDkEC3n8w/Udvugs
 4ZPn3/to65Pw6/mluArJP+L1GHdrQtw756B4cdIG3wZpZt+bkKivnRDlaHI8ysAb/TWz
 XhT1rMoDFSMSw69686cTbVzskNPK8yamqr5QAn8NmJXddHZ09K7Xe6oTNxObmEofjbor
 osiQ==
X-Gm-Message-State: APjAAAWpz09+og9BtGTbT5PVi0DptiuiNvuDK4wFcD1i4XD6ggqRY6pb
 RTCscB8L+8U5yqMcFQu60R9JSQ==
X-Google-Smtp-Source: APXvYqw5ORjP8yOBzwlXQgYxCEnDbU0L6unbhB3pU5tOIc5cWf/P9GAOmS54KpWIIbgm09+EGGbhVw==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr15726600wmg.159.1567155973579; 
 Fri, 30 Aug 2019 02:06:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u129sm6103161wmb.12.2019.08.30.02.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 02:06:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C278A1FF87;
 Fri, 30 Aug 2019 10:06:11 +0100 (BST)
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <CAKmqyKMDmaABGWyLZD2R-4J8=jM6hry6Bfmu498+UZzQtxsTMA@mail.gmail.com>
 <af15b620-1350-aa1a-0f02-2a46518f0ef2@c-sky.com>
 <CAKmqyKPUxyMZnnOd896aK4ZRoG+6iiBQ0E3MJbEqRv9KudbN7Q@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alistair Francis <alistair23@gmail.com>
In-reply-to: <CAKmqyKPUxyMZnnOd896aK4ZRoG+6iiBQ0E3MJbEqRv9KudbN7Q@mail.gmail.com>
Date: Fri, 30 Aug 2019 10:06:11 +0100
Message-ID: <87tv9z3tvg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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


Alistair Francis <alistair23@gmail.com> writes:

> On Thu, Aug 29, 2019 at 5:05 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>>
>> On 2019/8/29 =E4=B8=8A=E5=8D=885:34, Alistair Francis wrote:
>> > On Wed, Aug 28, 2019 at 12:04 AM liuzhiwei <zhiwei_liu@c-sky.com> wrot=
e:
>> >> Change-Id: I3cf891bc400713b95f47ecca82b1bf773f3dcb25
>> >> Signed-off-by: liuzhiwei <zhiwei_liu@c-sky.com>
>> >> ---
>> >>   fpu/softfloat.c                         |   119 +
>> >>   include/fpu/softfloat.h                 |     4 +
>> >>   linux-user/riscv/cpu_loop.c             |     8 +-
>> >>   target/riscv/Makefile.objs              |     2 +-
>> >>   target/riscv/cpu.h                      |    30 +
>> >>   target/riscv/cpu_bits.h                 |    15 +
>> >>   target/riscv/cpu_helper.c               |     7 +
>> >>   target/riscv/csr.c                      |    65 +-
>> >>   target/riscv/helper.h                   |   354 +
>> >>   target/riscv/insn32.decode              |   374 +-
>> >>   target/riscv/insn_trans/trans_rvv.inc.c |   484 +
>> >>   target/riscv/translate.c                |     1 +
>> >>   target/riscv/vector_helper.c            | 26563 +++++++++++++++++++=
+++++++++++
>> >>   13 files changed, 28017 insertions(+), 9 deletions(-)
>> >>   create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>> >>   create mode 100644 target/riscv/vector_helper.c
>> >>
>> > Hello,
>> >
>> > Thanks for the patch!
>> >
>> > As others have pointed out you will need to split the patch up into
>> > multiple smaller patches, otherwise it is too hard to review almost
>> > 30,000 lines of code.
>>
>> Hi, Alistair
>>
>> I'm so sorry for the inconvenience. It will be a patch set with a cover
>> letter in V2.
>
> No worries.
>
>>
>> > Can you also include a cover letter with your patch series describing
>> > how you are testing this? AFAIK vector extension support isn't in any
>> > compiler so I'm assuming you are handwriting the assembly or have
>> > toolchain patches. Either way it will help if you can share that so
>> > others can test your implementation.
>>
>> Yes, it's handwriting assembly. The assembler in Binutils has support
>> Vector extension.  First define an function test_vadd_vv_8 in assembly
>> and then it can be called from a C program.
>>
>> The function is something like
>>
>> /* vadd.vv */
>> TEST_FUNC(test_vadd_vv_8)
>>          vsetvli        t1, x0, e8, m2
>>          vlb.v           v6, (a4)
>>          vsb.v           v6, (a3)
>>          vsetvli        t1, a0, e8, m2
>>          vlb.v           v0, (a1)
>>          vlb.v           v2, (a2)
>>          vadd.vv     v4, v0, v2
>>          vsb.v          v4, (a3)
>> ret
>>          .size   test_vadd_vv_8, .-test_vadd_vv_8
>
> If possible it might be worth releasing the code that you are using for t=
esting.
>
>>
>> It takes more time to test than to implement the instructions. Maybe
>> there is some better test method or some forced test cases in QEMU.
>> Could you give me some advice for testing?
>
> Richard's idea of risu seems like a good option.
>
> Thinking about it a bit more we are going to have other extensions in
> the future that will need assembly testing so setting up a test
> framework seems like a good idea. I am happy to help try and get this
> going as well.

tests/tcg already has the bits you need for both linux-user and system
based testing. The main problem is getting a version of gcc that is new
enough to emit the newer instructions. I recently updated the images to
buster so gcc is pretty recent now (8.3).

I did start down the road of a general "op" test frame work which tried
to come up with a common framework/boilerplate so all you needed to do
was supply a new function (possible with a hex encoded instruction) and
a list of expected inputs and outputs:

  https://github.com/stsquad/qemu/commits/testing/generic-op-tester

I suspect it was over engineered but perhaps it would be worth reviving
it (or something like it) to make adding a simple single instruction
test case with minimal additional verbiage?

>
> Alistair
>
>>
>> Best Regards,
>>
>> Zhiwei
>>
>> > Alex and Richard have kindly started the review. Once you have
>> > addressed their comments and split this patch up into smaller patches
>> > you can send a v2 and we can go from there.
>> >
>> > Once again thanks for doing this implementation for QEMU!
>> >
>> > Alistair
>> >


--
Alex Benn=C3=A9e

