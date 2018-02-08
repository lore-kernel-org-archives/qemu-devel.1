Received: from eggs.gnu.org ([2001:4830:134:3::10]:56791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt7I-0004LL-Fd
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt7D-0004Gz-RQ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:48:24 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:52904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejt7D-0004Gc-Ma
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:48:19 -0500
Received: by mail-it0-x22e.google.com with SMTP id o13so8211600ito.2
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:48:19 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <259f8a58-a0ef-c414-464c-4ea504f581f1@linaro.org>
Date: Thu, 8 Feb 2018 12:48:15 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/32] arm/translate-a64: initial decode
 for simd_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> This is the initial decode skeleton for the Advanced SIMD three same
> instruction group.
> 
> The fprintf is purely to aid debugging as the additional instructions
> are added. It will be removed once the group is complete.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/translate-a64.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
