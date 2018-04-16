Received: from eggs.gnu.org ([2001:4830:134:3::10]:47741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f84vq-0007bg-He
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f84vn-00053q-Al
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:16:34 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:41562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f84vm-000530-Tu
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:16:31 -0400
References: <20180416135442.30606-1-alex.bennee@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <aca6055a-1e49-7902-428f-e7e199ed8a12@mail.uni-paderborn.de>
Date: Mon, 16 Apr 2018 16:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180416135442.30606-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>

On 04/16/2018 03:54 PM, Alex Bennée wrote:
> The re-factoring of div_floats changed the order of checking meaning
> an operation like -inf/0 erroneously raises the divbyzero flag.
> IEEE-754 (2008) specifies this should only occur for operations on
> finite operands.
> 
> We fix this by moving the check on the dividend being Inf/0 to before
> the divisor is zero check.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  fpu/softfloat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Tested-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
