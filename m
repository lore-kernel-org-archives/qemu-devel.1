Received: from eggs.gnu.org ([2001:4830:134:3::10]:43011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8g7P-0006zL-Tg
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8g7O-0006oL-OV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:54:27 -0400
Date: Thu, 11 May 2017 14:36:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170511043625.GG14408@umbus.fritz.box>
References: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
	<1494415802-227633-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
In-Reply-To: <1494415802-227633-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/18] numa: move source of default CPUs
 to NUMA node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 01:29:45PM +0200, Igor Mammedov wrote:
> Originally CPU threads were by default assigned in
> round-robin fashion. However it was causing issues in
> guest since CPU threads from the same socket/core could
> be placed on different NUMA nodes.
> Commit fb43b73b (pc: fix default VCPU to NUMA node mapping)
> fixed it by grouping threads within a socket on the same node
> introducing cpu_index_to_socket_id() callback and commit
> 20bb648d (spapr: Fix default NUMA node allocation for threads)
> reused callback to fix similar issues for SPAPR machine
> even though socket doesn't make much sense there.
>=20
> As result QEMU ended up having 3 default distribution rules
> used by 3 targets /virt-arm, spapr, pc/.
>=20
> In effort of moving NUMA mapping for CPUs into possible_cpus,
> generalize default mapping in numa.c by making boards decide
> on default mapping and let them explicitly tell generic
> numa code to which node a CPU thread belongs to by replacing
> cpu_index_to_socket_id() with @cpu_index_to_instance_props()
> which provides default node_id assigned by board to specified
> cpu_index.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

[snip]
> +static CpuInstanceProperties
> +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> +{
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(ms);
> +
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;
> +}

Suggested follow up patch: Since this function is identical for x86
and ARM, we could have a "thread_granularity_cpu_index_to_props"
helper they could both reference.  M

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZE+pHAAoJEGw4ysog2bOSLPgQAIyJGzDhAyIkImQZUy98cPyI
V5qGylXIdfWRodb+qXDUpf0N9/pjGiU5W7EmURVEQSXOV4wbyZlxf5zR1wANx0Ik
GCJNh9VXE+pnEyv1cxj6aq4QT5xc/fM52AXe5Hu6yadsAmHrZ6mV/VuZa5eD8nXh
JJtnZWOFe1pRywdMmSYGXDR+Iom9u2MD16+qjo1o6RbdbBetW9A2ku4j7VpIYIuK
KJek1bKvOJQoMnCuasP9dtqxE4CZ6jf6/YZK3DVDYxOVJDe2JvLQAHYhKhaCV3LD
IxHrkIsEbH0FLfi9iEqbBJchu9QimZIQmXwGfYtU/JhhqcUNH9hKfSw09yYymi0G
wq7R1lhIqPQAT3bv8E4hBes8cnghRGchv8IHOpegxANT52ZWcZzWweyKHUT02MY8
y0zjR/u0WHIu/9IcR6vM+ONnFITICp0GlERAmijnku07OrHABvXF+E9tSUYxPuAT
x6Hc7pt892dU4ynACR/EuIzN8QDvvMJR3vxLx+ggkCz1O9b3j//9EAcm0+0M3iJC
ODV/MiXZDBJHEjCt1oHhhySaoPkJFKMEXs9jiw3d0+6+bgqsJVNgSNaqt7rLfoPm
qwNc9yQgYrjY/8iXWI0waplW0CrtfZmM2SVI19E2eG6ABgG/GJh0dyww/ZhZyIPK
8XWp/Ul6LL2k/YglM3rJ
=EJL6
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
