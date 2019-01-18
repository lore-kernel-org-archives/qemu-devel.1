Received: from eggs.gnu.org ([209.51.188.92]:59273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gkY3o-0006Ru-JR
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gkY3j-0001RT-Tt
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:36:04 -0500
References: <20190118171848.27332-1-alex.bennee@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <84ac5896-e865-9730-2b1d-2dfa6839e0c3@redhat.com>
Date: Fri, 18 Jan 2019 18:35:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190118171848.27332-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/s390x: define TCG_GUEST_DEFAULT_MO
 for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

On 18.01.19 18:18, Alex Benn=C3=A9e wrote:
> MTTCG should be enabled by default whenever the memory model allows
> it. s390x was missing its definition of TCG_GUEST_DEFAULT_MO meaning
> the user had to manually specify  --accel tcg,thread=3Dmulti.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 8c2320e882..47d2c2e9cf 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -35,6 +35,10 @@
>  #define CPUArchState struct CPUS390XState
> =20
>  #include "exec/cpu-defs.h"
> +
> +/* The z/Architecture has a strong memory model with some store-after-=
load re-ordering */
> +#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)

Didn't know this was the way to make it be enabled as default.

As discussed on IRC

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

> +
>  #define TARGET_PAGE_BITS 12
> =20
>  #define TARGET_PHYS_ADDR_SPACE_BITS 64
>=20


--=20

Thanks,

David / dhildenb
