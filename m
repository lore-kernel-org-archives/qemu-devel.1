Received: from eggs.gnu.org ([2001:4830:134:3::10]:56768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPxd-0003pB-7l
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPxc-00066A-Kc
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:02:45 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWPxc-00065p-ER
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:02:44 -0500
Received: by mail-pl0-x243.google.com with SMTP id 1so27533035plv.0
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 09:02:44 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-15-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8b46b84b-d673-b0b3-e989-d3484093e48f@linaro.org>
Date: Tue, 2 Jan 2018 09:02:39 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-15-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 14/17] target/m68k: add 680x0 "move to
 SR" instruction
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
> Some cleanup, and allows SR to be moved from any addressing mode.
> Previous code was wrong for coldfire: coldfire also allows to
> use addressing mode to set SR/CCR. It only supports Data register
> to get SR/CCR (move from)
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
