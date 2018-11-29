Received: from eggs.gnu.org ([2001:4830:134:3::10]:34130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSNlS-0008LU-R1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSNj8-0003Gf-KE
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:55:43 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSNj8-0003G9-Bp
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:55:38 -0500
Received: by mail-pg1-x541.google.com with SMTP id w6so1039406pgl.6
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 06:55:38 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-2-richard.henderson@linaro.org>
	<8736rk3v2a.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <658996a5-3e74-fc03-75b8-ee258dfa774f@linaro.org>
Date: Thu, 29 Nov 2018 06:55:34 -0800
MIME-Version: 1.0
In-Reply-To: <8736rk3v2a.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 01/37] tcg/i386: Always use %ebp
 for TCG_AREG0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

On 11/29/18 4:52 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> For x86_64, this can result in smaller code when manipulating
>> TCG_TYPE_I32, as we can omit a REX prefix.
> 
> I take it you mean passing TCG_TYPE_I32 back and forth from the register
> backing store in CPUEnv which TCG_AREG0 points at?

Yes, exactly.  Perhaps I should expand my comment...


r~
