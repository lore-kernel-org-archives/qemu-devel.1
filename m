Received: from eggs.gnu.org ([2001:4830:134:3::10]:51293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjssr-0006Rv-1i
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjssn-0001lU-UV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:28:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjssn-0001l5-Nx
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:28:53 -0500
Date: Fri, 3 Mar 2017 16:28:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170303192850.GF2778@thinpad.lan.raisama.net>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170302195337.31558-3-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/11] target/i386/cpu.h: declare
 TCG_GUEST_DEFAULT_MO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com

On Thu, Mar 02, 2017 at 07:53:28PM +0000, Alex Benn=E9e wrote:
> This suppresses the incorrect warning when forcing MTTCG for x86
> guests on x86 hosts. A future patch will still warn when
> TARGET_SUPPORT_MTTCG hasn't been defined for the guest (which is still
> pending for x86).
>=20
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I assume the whole series is going to be merged through the same
tree, so:

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  target/i386/cpu.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 12a39d590f..ecdd3bbc2a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -30,6 +30,9 @@
>  #define TARGET_LONG_BITS 32
>  #endif
> =20
> +/* The x86 has a strong memory model with some store-after-load re-ord=
ering */
> +#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
> +
>  /* Maximum instruction code size */
>  #define TARGET_MAX_INSN_SIZE 16
> =20
> --=20
> 2.11.0
>=20

--=20
Eduardo
