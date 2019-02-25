Received: from eggs.gnu.org ([209.51.188.92]:57476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gyDAN-0000L7-Sp
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gyDAJ-0008Qe-Ro
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:07:19 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:59684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gyDAF-000874-Tc
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:07:12 -0500
References: <20190223232954.7185-1-richard.henderson@linaro.org>
	<20190223232954.7185-3-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <6614e5dc-7a11-ce1a-f52a-64cd7fc7644f@mail.uni-paderborn.de>
Date: Mon, 25 Feb 2019 11:06:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190223232954.7185-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 2/5] decodetree: Move documentation to
 docs/decodetree.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org


On 2/24/19 12:29 AM, Richard Henderson wrote:
> +
> +Argument Sets
> +=============
> +
> +Syntax::
> +
> +  args_def    := '&' identifier ( args_elt )+ ( !extern )?
> +  args_elt    := identifier
> +
> +Each *args_elt* defines an argument within the argument set.
> +Each argument set will be rendered as a C structure "arg_$name"
> +with each of the fields being one of the member arguments.
> +
> +If ``!extern`` is specified, the backing structure is assumed
> +to have been already declared, typically via a second decoder.
> +
> +Argument set examples::
> +
> +  &reg3       ra rb rc
> +  &loadstore  reg base offset
> +


Can we explain why argument sets are useful? This was puzzling for me at 
first. Something like:

This is used to have shared translate functions for instructions with 
differently named arguments. For instance if two variants of the same 
instructions have different sizes in some immediate, we can use a 
argument set to group these immediates together and use the same 
translate functions for both.


Cheers,

Bastian
