Received: from eggs.gnu.org ([2001:4830:134:3::10]:38074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgB4f-0004Rq-Ov
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgB4d-0008TM-7Z
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dgB4c-0008Sr-UC
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:38:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD68E51E8C
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 14:38:01 +0000 (UTC)
References: <1502461148-10154-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5dfccc7d-d9a5-7da8-c043-b7533192e378@redhat.com>
Date: Fri, 11 Aug 2017 09:37:58 -0500
MIME-Version: 1.0
In-Reply-To: <1502461148-10154-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6FwAW2OvvtAvEGVR2LWO63grepShvVBf2"
Subject: Re: [Qemu-devel] [PATCH v2] tests/qmp-test: Add generic,
 basic test of query commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: crosa@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6FwAW2OvvtAvEGVR2LWO63grepShvVBf2
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: crosa@redhat.com
Message-ID: <5dfccc7d-d9a5-7da8-c043-b7533192e378@redhat.com>
Subject: Re: [PATCH v2] tests/qmp-test: Add generic, basic test of query
 commands
References: <1502461148-10154-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1502461148-10154-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 09:19 AM, Markus Armbruster wrote:
> A command is a query if it has no side effect and yields a result.
> Such commands are typically named query-FOO, but there are exceptions.
>=20
> The basic idea is to find candidates with query-qmp-schema, filter out
> the ones that aren't queries with an explicit blacklist, and test the
> remaining ones against a QEMU with no special arguments.
>=20

> ---
> v2:
> * Make the test pass for all targets (note to self: do not post
>   patches after dark)
> * Tighten the test for query-spice, query-xen-replication-status:
>   expect failure only when they are stubs
> * Don't blacklist query-acpi-ospm-status and query-hotpluggable-cpus;
>   they fail reliably

Indeed, looks like quite a few changes.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6FwAW2OvvtAvEGVR2LWO63grepShvVBf2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmNwUYACgkQp6FrSiUn
Q2rzXAgAh/eooiHlqVMCiTphuKC3vtmbEYVxAlgZlN8NiT4l/hIZxhAPHv6Wf8X6
roUVJMSTEWVLpF7GL0szqG2qPZpaK5K1LNjmtsr04rQiV8wNjJUrl3ns3O8NBmx4
9CSoCFrY2lm5ddj7Xjp/QK8bhpvdFd11JJFjBVlkpDKZR7cU23M8wuQgnIGbXSjO
kys6VIfd1Fvm3NNKKMqzLoAE4uMM0MuovVVwsKtQ3adzz7lAOdjlnhLvje9/s9EX
onbEkTPrf3/+Igiq0JYcMGsVhUzutv0Ko5rG5klMhYI9jckEzebX9ifTV0GTZpze
rgOgqBz7KIX3q1aVqhlq63gmV3QQyw==
=OPVC
-----END PGP SIGNATURE-----

--6FwAW2OvvtAvEGVR2LWO63grepShvVBf2--
