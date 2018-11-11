Received: from eggs.gnu.org ([2001:4830:134:3::10]:54099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLqGG-0004PF-C9
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 08:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLqGD-0006Xn-5Q
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 08:58:48 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gLqGC-0006L3-6x
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 08:58:44 -0500
Received: by mail-wm1-x341.google.com with SMTP id r11-v6so5990061wmb.2
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 05:58:30 -0800 (PST)
References: <20181109152119.9242-1-alex.bennee@linaro.org>
	<20181109152119.9242-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2fdd3469-12dd-c65e-d287-372e7f9a6a49@linaro.org>
Date: Sun, 11 Nov 2018 14:58:26 +0100
MIME-Version: 1.0
In-Reply-To: <20181109152119.9242-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] tests/guest-debug: don't use symbol
 resolution for PC checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 11/9/18 4:21 PM, Alex Bennée wrote:
> It turns out symbol resolution isn't enough as modern kernels are
> often padded with check code at the start of functions. GDB seems to
> put the breakpoint at the first non-check instruction which causes
> comparisons with the symbol resolution to fail.

If you want breakpoints at a fixed location, use "*symbol", which will disable
gdb's prologue checking.


r~
