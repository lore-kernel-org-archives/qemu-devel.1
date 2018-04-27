Received: from eggs.gnu.org ([2001:4830:134:3::10]:57853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fC9OE-000747-RI
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fC9OA-0004Dw-Pg
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:50:42 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:38966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fC9OA-0004De-IH
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:50:38 -0400
Received: by mail-wr0-x231.google.com with SMTP id q3-v6so2795235wrj.6
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 12:50:38 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<87wowsk1ih.fsf@linaro.org> <87vaccjx70.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87vaccjx70.fsf@linaro.org>
Date: Fri, 27 Apr 2018 20:50:36 +0100
Message-ID: <87tvrwjunn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/9] target/arm: Fixups for
 ARM_FEATURE_V8_FP16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
<snip>

If you take my patches from:

  https://github.com/stsquad/qemu/tree/review/rth-fp16-fixes

443a7c3d38 arm/translate-a64: fix-up FMOV FP16 immediate
be4430e9c9 arm/translate-a64: add FP16 FCSEL
7badf508ab arm/translate-a64: add FP16 FCMP operations

>> testcases.armv8.2_half/insn_FSQRT_H_floatdp1__INC.risu.bi

This is the only failure I have left. As it is approaching 2100 on a
Friday night I leave that for you to look at as you'll be up before me
on Monday ;-)

--
Alex Benn=C3=A9e
