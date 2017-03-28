Received: from eggs.gnu.org ([2001:4830:134:3::10]:53005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csm8D-0007ns-Ix
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csm88-0006fR-Lk
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:05:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csm88-0006eo-Ga
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:05:28 -0400
References: <1490685583-16987-1-git-send-email-tejaswinipoluri3@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <627c8376-285e-f457-9506-9ab7d2f11ae4@redhat.com>
Date: Tue, 28 Mar 2017 10:05:23 +0200
MIME-Version: 1.0
In-Reply-To: <1490685583-16987-1-git-send-email-tejaswinipoluri3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: fix "info lapic" segfault on
 isapc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tejaswini <tejaswinipoluri3@gmail.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, rth@twiddle.net, ehabkost@redhat.com



On 28/03/2017 09:19, Tejaswini wrote:
> From: Tejaswini Poluri <tejaswinipoluri3@gmail.com>
>=20
> Start QEMU with
> "qemu-system-x86_64 -nographic -M isapc -serial none-monitor stdio"
> and enter "info lapic" at the monitor prompt =E2=87=92
> Segmentation fault
>=20
> Signed-off-by: Tejaswini Poluri <tejaswinipoluri3@gmail.com>
> ---
>  target/i386/helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index e2af340..f11cac6 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -326,6 +326,10 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, F=
ILE *f,
>  {
>      X86CPU *cpu =3D X86_CPU(cs);
>      APICCommonState *s =3D APIC_COMMON(cpu->apic_state);
> +    if (!s) {
> +        cpu_fprintf(f, "local apic state not available\n");
> +        return;
> +    }
>      uint32_t *lvt =3D s->lvt;
> =20
>      cpu_fprintf(f, "dumping local APIC state for CPU %-2u\n\n",
>=20

Queued, thanks.

Paolo
