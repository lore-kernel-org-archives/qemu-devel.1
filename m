Received: from eggs.gnu.org ([208.118.235.92]:40827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1gbi0T-0005cH-Sl
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 03:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1gbi0Q-0005Yg-NY
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 03:24:05 -0500
From: "Kang, Luwei" <luwei.kang@intel.com>
Date: Tue, 25 Dec 2018 08:23:49 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172C97D77@SHSMSX101.ccr.corp.intel.com>
References: <20181221124410.11920-1-pbonzini@redhat.com>
In-Reply-To: <20181221124410.11920-1-pbonzini@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

> From: Qemu-devel [mailto:qemu-devel-bounces+luwei.kang=3Dintel.com@nongnu=
.org] On Behalf Of Paolo Bonzini
> Sent: Friday, December 21, 2018 8:44 PM
> To: qemu-devel@nongnu.org
> Cc: ehabkost@redhat.com; qemu-stable@nongnu.org
> Subject: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as unmi=
gratable
>=20
> Marshaling of processor tracing MSRs is not yet implemented in QEMU, mark=
 the feature as unmigratable.

Hi Paolo,
    I think Intel PT has supported live migration. I don't understand what =
you mean.

    commit b77146e9a129bcdb60edc23639211679ae846a92
    Author: Chao Peng <chao.p.peng@linux.intel.com>
    Date:   Mon Mar 5 00:48:36 2018 +0800
    i386: Add support to get/set/migrate Intel Processor Trace feature

Thanks,
Luwei Kang

>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c index 9c54c41e7a..a6a5=
97d2bf 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1012,6 +1012,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WO=
RDS] =3D {
>              .needs_ecx =3D true, .ecx =3D 0,
>              .reg =3D R_EBX,
>          },
> +        .unmigratable_features =3D CPUID_7_0_EBX_INTEL_PT,
>          .tcg_features =3D TCG_7_0_EBX_FEATURES,
>      },
>      [FEAT_7_0_ECX] =3D {
> --
> 2.20.1
>=20
