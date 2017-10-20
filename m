Received: from eggs.gnu.org ([2001:4830:134:3::10]:36893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5ZBx-0002LO-Cu
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5ZBu-0003Rf-AO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:26:33 -0400
References: <20171020115803.14093-1-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a889832b-ade3-f924-e49d-386052ae6ff0@redhat.com>
Date: Fri, 20 Oct 2017 10:26:23 -0500
MIME-Version: 1.0
In-Reply-To: <20171020115803.14093-1-david@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NnfPvXHHJMHmNne948b90g8OKVOppWaLq"
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: change CPU type name to
 "s390x-cpu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NnfPvXHHJMHmNne948b90g8OKVOppWaLq
From: Eric Blake <eblake@redhat.com>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, cohuck@redhat.com,
 Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <a889832b-ade3-f924-e49d-386052ae6ff0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: change CPU type name to
 "s390x-cpu"
References: <20171020115803.14093-1-david@redhat.com>
In-Reply-To: <20171020115803.14093-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 06:58 AM, David Hildenbrand wrote:
> For now, e.g. host-s390-cpu wasn't exposed to the user. cpu-add, -cpu
> and the CPU model qmp interfaces didn't care about the actual type,
> as that information was hidden.
>=20
> This changed with CPU hotplug via device_add. Now the type is visible t=
o
> the user. Before we get that supported in a stable version, this is our=

> last chance to change it.
>=20
> So change it form "s390-cpu" to "s390x-cpu", to match the architecture

s/form/from/

> name. Example names are then e.g. z14-s390x-cpu or qemu-s390x-cpu.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NnfPvXHHJMHmNne948b90g8OKVOppWaLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqFZ8ACgkQp6FrSiUn
Q2r8ogf+Kp85WSwxDFyrVvQ4DJEPApN56QyFOY/EhDbfNCwaBJp9GEJ6m82Sxpei
QnYs2TxtsvdsaTVqOB862qodojLD7ddQBghR9+x/fhcLrMLBIDiZcXExlqbs0cUJ
3frYv82+gJ/MM2mLljvo8flrXLEt2qvci8YwkBaR4FteUk49+L9unxdwwVrmDO0d
KwPUaQXg4bLOicKdSgN+SUAN4iRGOeBAda4ske8g2wjOEGxNkjwV6IeMNkvOIyW3
SpF0Lx6q/O+kl5f1O/5OaCSdyi8q+5jWrYZCm5BZ07cu+k7jF2yD5Z3VUBu5KeWU
1F0T9T5zEyOwJHv1UWZjDgFoYFeMfw==
=oGG8
-----END PGP SIGNATURE-----

--NnfPvXHHJMHmNne948b90g8OKVOppWaLq--
