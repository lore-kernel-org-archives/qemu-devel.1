Received: from eggs.gnu.org ([2001:4830:134:3::10]:42102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGp4X-0002JV-I5
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGp4W-00049X-JQ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:09:41 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:35876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGp4W-00049J-Dy
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:09:40 -0400
Received: by mail-oi0-x22e.google.com with SMTP id v2-v6so2402102oif.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 10:09:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502221552.3873-1-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:09:19 +0100
Message-ID: <CAFEAcA_wNfL2YqWB6xykyf2UbTjwViodUt8AvdRS+HA+RMssuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/14] target/arm: Fixups for
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2 May 2018 at 23:15, Richard Henderson <richard.henderson@linaro.org> wrote:
> When running the gcc testsuite with current aarch64-linux-user,
> the testsuite detects the presence of the fp16 extension and
> enables lots of extra tests for builtins.
>
> Quite a few of these new tests fail because we missed implementing
> some instructions.  We really should go back and verify that nothing
> else is missing from this (rather large) extension.
>
> In addition, it tests some edge conditions on data that show flaws
> in the way we were performing integer<->fp conversion; particularly
> with respect to scaled conversion.
>
> Changes since v1:
>   * Rebased vs master instead of tgt-arm-sve-9.
>   * Alex did some additional digging through the ARM xhtml
>     and came up with some additional missing instructions.
>   * Everything cc'd to qemu-stable.

I'm going to take patches 1..4 into target-arm.next, just to
reduce the size of this a bit. Patch 5 is the FMOV one which
is missing some decode. Otherwise I've reviewed all the ones
which still needed review. Don't forget to fix the patch 12
patchew warning:
ERROR: space required before the open parenthesis '('
#41: FILE: target/arm/translate-a64.c:4683:
+    switch(type) {

thanks
-- PMM
