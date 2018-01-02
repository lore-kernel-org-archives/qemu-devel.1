Received: from eggs.gnu.org ([2001:4830:134:3::10]:50920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPph-0007ER-7s
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPpg-0008WN-In
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:54:33 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWPpg-0008Vo-Dc
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:54:32 -0500
Received: by mail-pg0-x243.google.com with SMTP id r2so9115633pgq.13
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:54:32 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-12-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5fe7c99f-1123-629e-40c6-aac0359a73a8@linaro.org>
Date: Tue, 2 Jan 2018 08:54:28 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-12-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 11/17] target/m68k: add reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
> The instruction traps if the CPU is not in
> Supervisor state but the helper is empty because
> there is no easy way to reset all the peripherals
> without resetting the CPU itself.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/helper.c    |  7 +++++++
>  target/m68k/helper.h    |  4 ++++
>  target/m68k/translate.c | 13 +++++++++++++
>  3 files changed, 24 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
