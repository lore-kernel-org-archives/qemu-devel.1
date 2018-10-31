Received: from eggs.gnu.org ([2001:4830:134:3::10]:51232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqxQ-0006Hq-6z
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqxL-0004DU-Vn
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:54:52 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:41066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gHqxL-00042y-El
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:54:47 -0400
References: <20181031121443.605-1-richard.henderson@linaro.org>
	<20181031121443.605-4-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <f5695608-19ff-6418-5b81-20abcb05d299@mail.uni-paderborn.de>
Date: Wed, 31 Oct 2018 14:54:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181031121443.605-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v2 3/3] decodetree: Allow multiple input
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org


On 10/31/18 1:14 PM, Richard Henderson wrote:
> While it would be possible to concatenate input files with make,
> passing the original input files to decodetree.py allows us to
> generate error messages which allows compilation environments
> (read: emacs) to next-error to the correct input file.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)

Reviewed-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
