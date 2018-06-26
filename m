Received: from eggs.gnu.org ([2001:4830:134:3::10]:55520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXsda-0006yE-F3
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXsdV-0003gM-EQ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:24:22 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXsdV-0003gE-8s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:24:17 -0400
Received: by mail-pf0-x244.google.com with SMTP id a22-v6so8456726pfo.12
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:24:17 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-25-richard.henderson@linaro.org>
	<CAFEAcA83Bz+zyugMj10=Fd2n7hTY=ei+PJeb_ZY46-ajiGHS5A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0503f323-2b85-4355-30c1-bd0d1a029d56@linaro.org>
Date: Tue, 26 Jun 2018 11:24:12 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA83Bz+zyugMj10=Fd2n7hTY=ei+PJeb_ZY46-ajiGHS5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 24/35] target/arm: Implement SVE
 floating-point convert to integer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/26/2018 03:58 AM, Peter Maydell wrote:
> This kind of demonstrates that we've got a bit of an inconsistent
> mess of naming with a lot of our fp related helper functions;
> maybe we should regularize that someday.

Yes, probably at the same time that we convert NEON to gvec-style
functions instead of iterating with tcg opcodes.


r~
