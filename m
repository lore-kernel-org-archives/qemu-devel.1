Received: from eggs.gnu.org ([2001:4830:134:3::10]:36854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWQ94-00047x-CN
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWQ93-0005ol-GH
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:14:34 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWQ93-0005oE-B5
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:14:33 -0500
Received: by mail-pg0-x242.google.com with SMTP id o13so13769418pgp.4
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 09:14:33 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-18-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7af82486-c27f-e183-444d-b2b345e2056b@linaro.org>
Date: Tue, 2 Jan 2018 09:14:29 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-18-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 17/17] target/m68k: fix
 m68k_cpu_dump_state()
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
> Display correctly the Trace bits for 680x0
> (2 bits instead of 1 for Coldfire).
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.h       | 3 ++-
>  target/m68k/translate.c | 9 ++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
