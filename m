Received: from eggs.gnu.org ([2001:4830:134:3::10]:56301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4F6h-0001LT-MQ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 19:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4F6e-0000By-Kx
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 19:47:39 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:55505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4F6e-0000BC-Em
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 19:47:36 -0400
Received: by mail-pg0-x229.google.com with SMTP id b11so8078355pgn.12
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 16:47:36 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54b36f17-4e9d-bb9e-6d2d-b1df1ef44480@linaro.org>
Date: Mon, 16 Oct 2017 16:47:31 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 19/30] Fix mask for AdvancedSIMD 2 reg
 misc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> While the group encoding declares bit 28 a zero it is set for
> FCMGT (zero)

I see that's what the documentation says.  Have you validated this?  It really
seems like an isolated typo.  Even if that is right, it isn't (documented) to
be set for the other simd_two_reg_misc_fp16 instructions.  So that means the
rest of your decode is compromised.

This patch needs folding into previous, anyway.


r~
