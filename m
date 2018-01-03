Received: from eggs.gnu.org ([2001:4830:134:3::10]:48015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWqzm-00059d-PD
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWqzk-00082u-87
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:54:46 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:35233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWqzk-00082N-2C
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:54:44 -0500
Received: by mail-pf0-x22d.google.com with SMTP id j124so1287642pfc.2
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:54:43 -0800 (PST)
References: <20180102234108.32713-1-laurent@vivier.eu>
	<20180102234108.32713-9-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <49949b11-9bd8-21db-56ee-6a3fc952079c@linaro.org>
Date: Wed, 3 Jan 2018 13:54:40 -0800
MIME-Version: 1.0
In-Reply-To: <20180102234108.32713-9-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 08/17] target/m68k: add move16
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

On 01/02/2018 03:40 PM, Laurent Vivier wrote:
> move16 moves the source line to the destination line. Lines are aligned
> to 16-byte boundaries and are 16 bytes long.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v6: split move16 in two functions
> 
>  target/m68k/cpu.c       | 10 ++++++-
>  target/m68k/cpu.h       |  1 +
>  target/m68k/translate.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
