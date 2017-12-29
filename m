Received: from eggs.gnu.org ([2001:4830:134:3::10]:55307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1eUxMN-0003JT-4a
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 11:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1eUxMJ-00012f-50
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 11:18:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1eUxMI-0000yA-UA
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 11:18:11 -0500
References: <20171229063145.29167-1-richard.henderson@linaro.org>
	<20171229063145.29167-36-richard.henderson@linaro.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <303eb005-cabe-9948-55ad-c89b958789da@suse.de>
Date: Fri, 29 Dec 2017 17:18:06 +0100
MIME-Version: 1.0
In-Reply-To: <20171229063145.29167-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 35/38] qom: Add MMU_DEBUG_LOAD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de

Hi,

Since you're specifically CC'ing me, some nits:

Am 29.12.2017 um 07:31 schrieb Richard Henderson:
> This lets us tell bottom levels of virtual memory translation
> routines that the access is from within QEMU itself and bypass
> certain tests.

This sentence could use a tweak for clarity: tell bottom levels of
virtual memory translation routines ... to bypass? or that the access
... bypasses? or that this lets us ... bypass?

>=20
> Cc: Andreas F=C3=A4rber <afaerber@suse.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qom/cpu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index c2fa151228..d5361ffd0e 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -64,7 +64,8 @@ typedef uint64_t vaddr;
>  typedef enum MMUAccessType {
>      MMU_DATA_LOAD  =3D 0,
>      MMU_DATA_STORE =3D 1,
> -    MMU_INST_FETCH =3D 2
> +    MMU_INST_FETCH =3D 2,
> +    MMU_DEBUG_LOAD =3D 3

Given that you had to touch the previous line for your comma, it would
be advisable to add one on the new line to avoid that next time.

>  } MMUAccessType;
> =20
>  typedef struct CPUWatchpoint CPUWatchpoint;

Either way please take the patch through a suitable tree.

Cheers,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
