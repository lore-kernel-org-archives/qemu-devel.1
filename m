Received: from eggs.gnu.org ([2001:4830:134:3::10]:49834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpac1-0001Jj-GO
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpaby-0005iB-CK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fpaby-0005hl-50
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id w10-v6so9206275pgv.2
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 07:47:54 -0700 (PDT)
References: <20180814002653.12828-1-richard.henderson@linaro.org>
	<87bma5wdoz.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b926d1a2-0973-ee44-5a7d-3e19cb9482ac@linaro.org>
Date: Tue, 14 Aug 2018 07:47:50 -0700
MIME-Version: 1.0
In-Reply-To: <87bma5wdoz.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm: Fix int64_to_float16
 double-rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org

On 08/14/2018 01:32 AM, Alex Bennée wrote:
> Can't we add the constants to the fcvt test case?

No, they're all half-to-integer.  This is integer-to-half.

We could write another one, I suppose, but it's not just
an add-one-line kind of thing.


r~
