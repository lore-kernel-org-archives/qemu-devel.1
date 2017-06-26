Received: from eggs.gnu.org ([2001:4830:134:3::10]:49687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPYUy-0000Gf-VW
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPYUu-0004WW-5s
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:12:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dPYUu-0004W9-0l
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:12:28 -0400
Date: Mon, 26 Jun 2017 14:12:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170626181226.GG17935@flamenco>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838119390.6497.17430428991952287717.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149838119390.6497.17430428991952287717.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v9 04/26] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Sun, Jun 25, 2017 at 11:59:54 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  Makefile.target                |    1 
>  include/exec/gen-icount.h      |    2 
>  include/exec/translate-block.h |  125 +++++++++++++++++++++++++++
>  include/qom/cpu.h              |   22 +++++
>  translate-block.c              |  185 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 334 insertions(+), 1 deletion(-)
>  create mode 100644 include/exec/translate-block.h
>  create mode 100644 translate-block.c
(snip)
> diff --git a/include/exec/translate-block.h b/include/exec/translate-block.h
> new file mode 100644
> index 0000000000..d14d23f2cb
> --- /dev/null
> +++ b/include/exec/translate-block.h
(snip)
> +/**
> + * DisasJumpType:
> + * @DJ_NEXT: Next instruction in program order.
> + * @DJ_TOO_MANY: Too many instructions translated.
> + * @DJ_TARGET: Start of target-specific conditions.
> + *
> + * What instruction to disassemble next.
> + */
> +typedef enum DisasJumpType {
> +    DJ_NEXT,
> +    DJ_TOO_MANY,
> +    DJ_TARGET,
> +} DisasJumpType;

I'd give up on the enum to avoid unnecessary casts. Just define DJ_TARGET
(or rather, DISAS_TARGET :>) and let the architecture code add more define's
using it.

		E.
