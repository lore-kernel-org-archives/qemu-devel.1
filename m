Received: from eggs.gnu.org ([2001:4830:134:3::10]:55354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYGxt-0003di-0w
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYGxo-0005VF-0T
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:18:24 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-6-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <71a11f23-39e7-d89a-36d5-2870ed76d940@twiddle.net>
Date: Thu, 20 Jul 2017 09:18:11 -1000
MIME-Version: 1.0
In-Reply-To: <20170720150426.12393-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 05/23] softfloat3c: initial
 build machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 07/20/2017 05:04 AM, Alex Bennée wrote:
> +# so they can still be linked when needed. We build these files surpressing so of the normal CFLAGS.

"surpressing so" -> "suppressing some"

Do we gain any confidence for our still supported but less tested 32-bit hosts 
(all of which do support a 64-bit type) by dropping the FAST_INT64 distinction?

> -#ifdef __GNUC_STDC_INLINE__
> -#define INLINE inline
> -#else
> -#define INLINE extern inline

Why are you removing this?



r~
