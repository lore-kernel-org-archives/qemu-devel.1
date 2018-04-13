Received: from eggs.gnu.org ([2001:4830:134:3::10]:47794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f6zLO-0005Y3-Jx
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f6zLL-00027k-Dg
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:06:26 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:46832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f6zLK-00026T-VC
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:06:23 -0400
References: <20180413140334.26622-1-alex.bennee@linaro.org>
	<20180413140334.26622-3-alex.bennee@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <3a3a9132-8f03-c476-bd0d-b6c91a9cc3a4@mail.uni-paderborn.de>
Date: Fri, 13 Apr 2018 16:06:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180413140334.26622-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] fpu/softfloat: raise float_invalid
 for NaN/Inf in round_to_int_and_pack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 04/13/2018 04:03 PM, Alex Bennée wrote:
> The re-factor broke the raising of INVALID when NaN/Inf is passed to
> the float_to_int conversion functions. round_to_uint_and_pack got this
> right for NaN but also missed out the Inf handling.
> 
> Fixes https://bugs.launchpad.net/qemu/+bug/1759264
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  fpu/softfloat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
