Received: from eggs.gnu.org ([2001:4830:134:3::10]:39441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFN9k-0002hN-VG
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFN9X-0007cW-Ts
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:41:14 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:24007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFN9V-0007Tn-RS
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:41:06 -0400
Date: Wed, 24 Oct 2018 19:40:44 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181024174044.GA5731@sx9>
References: <20181024105733.18605-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181024105733.18605-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] disas/mips: Increase 'member of ISAs' flag
 holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Hi Philippe,

On Wed, Oct 24, 2018 at 12:57:32PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Increase the size of 'membership' holder size to 64 bits. This is
> needed for future extensions since existing bits are almost all used.
> (This change is related to f9c9cd63e3),

I'm queueing your patch to amend the support for the R5900, based on
Aleksandar's latest v2 tag:

https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-2-v2

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  disas/mips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/disas/mips.c b/disas/mips.c
> index 97f661a37e..d73d4094d8 100644
> --- a/disas/mips.c
> +++ b/disas/mips.c
> @@ -301,7 +301,7 @@ struct mips_opcode
>    unsigned long pinfo2;
>    /* A collection of bits describing the instruction sets of which thi=
s
>       instruction or macro is a member. */
> -  unsigned long membership;
> +  uint64_t membership;
>  };
> =20
>  /* These are the characters which may appear in the args field of an
> --=20
> 2.19.1
>=20
