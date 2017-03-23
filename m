Received: from eggs.gnu.org ([2001:4830:134:3::10]:59214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr2eb-0006w8-TH
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr2ea-0003Ey-Mr
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:19:49 -0400
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-16-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59448b66-430d-48a1-cf98-541873c87cb7@redhat.com>
Date: Thu, 23 Mar 2017 08:19:24 -0500
MIME-Version: 1.0
In-Reply-To: <1490189568-167621-16-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P1T8rw3QOnNhb7OK8Xe149ex66f6mQU1N"
Subject: Re: [Qemu-devel] [PATCH for-2.10 15/23] QMP: include
 CpuInstanceProperties into query_cpus output output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P1T8rw3QOnNhb7OK8Xe149ex66f6mQU1N
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao
 <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <59448b66-430d-48a1-cf98-541873c87cb7@redhat.com>
Subject: Re: [PATCH for-2.10 15/23] QMP: include CpuInstanceProperties into
 query_cpus output output
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
 <1490189568-167621-16-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-16-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 08:32 AM, Igor Mammedov wrote:
> if board supports CpuInstanceProperties, report them for
> each CPU thread listed. Main motivation for this is to
> provide these properties introspection via QMP interface
> for using in test cases to verify numa node to cpu mapping,
> which includes not only boards that support cpu hotplug
> and have this info in query-hotpluggable-cpus (pc/spapr)
> but also for boards that don't not support hotpluggable-cpus
> but support numa mapping (virt-arm).
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

> @@ -1860,6 +1863,12 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>  #else
>          info->value->arch =3D CPU_INFO_ARCH_OTHER;
>  #endif
> +        if ((info->value->has_props =3D !!mc->cpu_index_to_instance_pr=
ops)) {

checkpatch.pl doesn't flag that? We generally try to avoid side-effects
inside conditionals.

> +            CpuInstanceProperties *props;
> +            props =3D g_malloc0(sizeof(*props));
> +            *props =3D mc->cpu_index_to_instance_props(ms, cpu->cpu_in=
dex);
> +            info->value->props =3D  props;

Why two spaces after =3D?

With those cleaned up,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--P1T8rw3QOnNhb7OK8Xe149ex66f6mQU1N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY08tcAAoJEKeha0olJ0Nq+VkIAIsuKx1YXnvSqeuJvsKry60q
FPqiyvM7dAxlxVfW+vZhQgyOedBrQ6d4k6kRKODGmm93R6bSItdEwTX1vfAeVOpt
NwyE3VGWqCKQkgN4TVkJNIMmPFo5aanQpoN2ZqiqV6+0Uzh7Kv3jtGpb54XEBkZI
0ykdx2O3PRWySWkD9DrcKhQAGRQwJbuIjg/E9vFjZl/w+TjbgjYMKI5kj7LJ2EEG
xuwTga8YSUEwXNOPk5FYguDq/0OaLRFqI5DSklzhY6xRVawTrcX2zYNF1U6yFGsT
o4vk0qvFIsBk86tuuKDySiK8vDAw+dokJ0xlWjRUJml4lc4YHRJK2BsyXSnuIBg=
=p5hB
-----END PGP SIGNATURE-----

--P1T8rw3QOnNhb7OK8Xe149ex66f6mQU1N--
