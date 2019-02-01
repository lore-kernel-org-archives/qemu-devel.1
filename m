Received: from eggs.gnu.org ([209.51.188.92]:59042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpetu-0000xn-U6
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpett-0002Cu-4b
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:54:58 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:40354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpets-00027X-A7
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:54:56 -0500
Received: by mail-pl1-x632.google.com with SMTP id u18so3729117plq.7
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 11:54:47 -0800 (PST)
References: <20190125225714.10234-1-richard.henderson@linaro.org>
	<20190125225714.10234-8-richard.henderson@linaro.org>
	<871s4xnis9.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5e3ef919-74d2-4ad3-506f-172fe01848b7@linaro.org>
Date: Fri, 1 Feb 2019 11:54:43 -0800
MIME-Version: 1.0
In-Reply-To: <871s4xnis9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/6] tests/tcg/aarch64: Add pauth smoke
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 1/28/19 3:06 AM, Alex Bennée wrote:
> We build all tests with:
> 
>   CFLAGS+=-Wall -O0 -g -fno-strict-aliasing
> 
> mainly because the first thing you want to do when they fail is run them
> through gdb to see what went wrong. Do you actually need optimisation on
> for the build to work? Everything else looks good though:

I needed optimization for the MemTag test to work, and I copied that.
I'll remove it.


r~
