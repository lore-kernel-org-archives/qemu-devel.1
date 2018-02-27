Received: from eggs.gnu.org ([2001:4830:134:3::10]:53783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eqkRH-00013m-Lh
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eqkRE-0007v2-J9
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:57:23 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180227183958.15167-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <376a816f-780e-18da-f7e2-4efa2e25b06b@twiddle.net>
Date: Tue, 27 Feb 2018 10:57:16 -0800
MIME-Version: 1.0
In-Reply-To: <20180227183958.15167-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Report AArch64 FP16 support
 via hwcap bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 02/27/2018 10:39 AM, Peter Maydell wrote:
> Set the appropriate Linux hwcap bits to tell the guest binary if we
> have implemented half-precision floating point support.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is intended to go after Alex's FP16 stuff since it
> uses the ARM_FEATURE_V8_FP16 bit that defines.
> There is as yet no kernel definition of an AArch32 hwcap
> bit to report FP16.
> 
> Based-on: <20180227143852.11175-1-alex.bennee@linaro.org>
> 
>  linux-user/elfload.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
