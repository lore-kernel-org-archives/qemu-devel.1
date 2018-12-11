Received: from eggs.gnu.org ([2001:4830:134:3::10]:54281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWiLj-0001OX-Ku
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWiLf-00059p-K8
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:45:23 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:47030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWiLf-00059F-Dr
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:45:19 -0500
Received: by mail-oi1-x244.google.com with SMTP id x202so11973055oif.13
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 05:45:19 -0800 (PST)
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <46cf1f37-546b-899f-712c-bf54dad0abfc@linaro.org>
Date: Tue, 11 Dec 2018 07:45:15 -0600
MIME-Version: 1.0
In-Reply-To: <20181210152829.29271-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/13] tests/tcg/mips: enable
 mips32-dsp/mips32-dspr2/mipsr5900 linux-user (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Markovic <smarkovic@wavecomp.com>, jcmvbkbc@gmail.com, michael@walle.cc, amarkovic@wavecomp.com, edgar.iglesias@gmail.com, shorne@gmail.com, aurelien@aurel32.net

On 12/10/18 9:28 AM, Alex Bennée wrote:
> +# FIXME: I don't know why the general rule in tests/tcg/Makefile isn't enough
> +run-mips32-dspr2/%: mips32-dspr2/%
> +	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on $(TARGET_NAME) $(QEMU_OPTS)")

Perhaps it's the "/"?  Otherwise I agree it doesn't make sense.


r~
