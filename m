Received: from eggs.gnu.org ([2001:4830:134:3::10]:48090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWSpA-0004Lx-IR
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWSp4-0004Bg-L3
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:06:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eWSp4-0004BH-C6
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:06:06 -0500
References: <20180102170936.6150-1-danielhb@linux.vnet.ibm.com>
	<20180102170936.6150-2-danielhb@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d83ea302-8e38-26bf-7e1f-18b6373e158b@redhat.com>
Date: Tue, 2 Jan 2018 14:06:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180102170936.6150-2-danielhb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="swvjVv32kU3wTJVME40n3n0yW3Nen9Prf"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qmp: adding
 'wakeup-suspend-support' in query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, dgilbert@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--swvjVv32kU3wTJVME40n3n0yW3Nen9Prf
From: Eric Blake <eblake@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, dgilbert@redhat.com, armbru@redhat.com
Message-ID: <d83ea302-8e38-26bf-7e1f-18b6373e158b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qmp: adding 'wakeup-suspend-support'
 in query-target
References: <20180102170936.6150-1-danielhb@linux.vnet.ibm.com>
 <20180102170936.6150-2-danielhb@linux.vnet.ibm.com>
In-Reply-To: <20180102170936.6150-2-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2018 11:09 AM, Daniel Henrique Barboza wrote:
> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
> nutshell is:
>=20
> - qmp_system_wakeup_request set runstate to RUNNING, sets a wakeup_reas=
on
> and notify the event
> - in the main_loop, all vcpus are paused, a system reset is issued, all=

> subscribers of wakeup_notifiers receives a notification, vcpus are then=

> resumed and the wake up QAPI event is fired
>=20
=2E..
>=20
> With this extra tool, management can avoid situations where a guest
> that does not have proper suspend/wake capabilities ends up in
> inconsistent state (e.g.
> https://github.com/open-power-host-os/qemu/issues/31).
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---

Only an interface review:

>  arch_init.c             | 1 +
>  include/sysemu/sysemu.h | 1 +
>  qapi-schema.json        | 3 ++-
>  vl.c                    | 5 +++++
>  4 files changed, 9 insertions(+), 1 deletion(-)
>=20

> +++ b/qapi-schema.json
> @@ -2388,11 +2388,12 @@
>  # Information describing the QEMU target.
>  #
>  # @arch: the target architecture (eg "x86_64", "i386", etc)
> +# @wakeup-suspend-support: true if the target supports wake up from su=
spend

Missing a '(since 2.12)' notation.

>  #
>  # Since: 1.2.0
>  ##
>  { 'struct': 'TargetInfo',
> -  'data': { 'arch': 'str' } }
> +  'data': { 'arch': 'str', 'wakeup-suspend-support': 'bool' } }

The struct is output-only, so adding the new field unconditionally is
backwards-compatible.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--swvjVv32kU3wTJVME40n3n0yW3Nen9Prf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpL5isACgkQp6FrSiUn
Q2rgTAgAndFYD5LsZ2ZXqiiqkMKchz1Sx90IW0dBWrzKLDk3lfXonAnplOb2HZ4F
6UOtlh2eminq1uq63U9p6V2LjUZ1ONwJSYh5XNVf4JCZIM5DzvShI1tFcdTWS7ui
8nnpXx4Rp2yye/W4jNjWhM6/kx21ZRgi5EJcbig67VdXAqRzevdNsqhz//I0OIwx
GWpUtdEbWJ0tHL+XulsbxrQkUvjJPw5G6ALwdCgE0ZtwGfK3MghdYIBXKfCJdQ44
kWnAi4+t3py+OxGiqnRmD3/t7cr9ZZUGjXPvgFw1MQjm+atuhNwKLjps7qovE9MO
L44Ikd7+/YL6UA1r8exrmZGll1F1Gw==
=6Uch
-----END PGP SIGNATURE-----

--swvjVv32kU3wTJVME40n3n0yW3Nen9Prf--
