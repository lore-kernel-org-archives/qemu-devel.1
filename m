Received: from eggs.gnu.org ([2001:4830:134:3::10]:45762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBmqB-0005RQ-Ia
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBmq8-0005Jc-GC
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:46:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBmq8-0005J4-AS
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9A2D8E7B9
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 19:45:59 +0000 (UTC)
References: <20180426183404.3756-1-lersek@redhat.com>
	<20180426183404.3756-5-lersek@redhat.com>
	<16b5979b-3db1-73fe-fb9b-d73b08b11177@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af535d63-2b57-7707-1a5d-0d7175122c52@redhat.com>
Date: Thu, 26 Apr 2018 14:45:58 -0500
MIME-Version: 1.0
In-Reply-To: <16b5979b-3db1-73fe-fb9b-d73b08b11177@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wbUDv1wNrcrQojHsnlsMiBhTZ6cFjsAoz"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qapi: discriminate CpuInfoFast on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wbUDv1wNrcrQojHsnlsMiBhTZ6cFjsAoz
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <af535d63-2b57-7707-1a5d-0d7175122c52@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qapi: discriminate CpuInfoFast on
 SysEmuTarget, not CpuInfoArch
References: <20180426183404.3756-1-lersek@redhat.com>
 <20180426183404.3756-5-lersek@redhat.com>
 <16b5979b-3db1-73fe-fb9b-d73b08b11177@redhat.com>
In-Reply-To: <16b5979b-3db1-73fe-fb9b-d73b08b11177@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 02:41 PM, Eric Blake wrote:

> I also like that this approach is introspectible via 'query-qmp-schema'=

> - if 'query-cpus-fast' has the "target" member, then you know that it i=
s
> fixed (you can ignore "arch" in that case, even though you know it
> works); if it lacks "target", you know that "arch":"s390x" is the only

Correcting myself: "arch":"s390" is the magic string for older qemu; and
your mapping function from target to arch keeps it that way, so that
older clients not aware of "target":"s390x" still get the right behavior.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wbUDv1wNrcrQojHsnlsMiBhTZ6cFjsAoz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriLHcACgkQp6FrSiUn
Q2pmOAgAk0RRu0GYtjvF8XdxCYj0JAdvlUuZhPnOlgAbN2J5hM4IuFB3nxG67Fvk
TSKVdJ8C8We2vyXCgw5j8XeO1prlcPd4AEkdeMCR4omnBsGln3oTBpG6tSN9VbkV
7Bq47yJP1FgLU+5W5oFuzpURJ421WMbr+T8DqITNNe7zosxiNOrYyT+luWlwP94U
phKFcbpWKIi0MF37I2t5H7E2pYbtCBRsSO0jguLLtcyDjU1VsouMVGVGKfRm7wBR
tCfnaRfAEe+Wp/6fED3P+8TIGF68bukFHSkqUNk3RjETpGQ6MK9AWuGByRwMa6n9
Q1XbPvzsNUtF9Jr42Xn+cKT3FmLbNg==
=4sp4
-----END PGP SIGNATURE-----

--wbUDv1wNrcrQojHsnlsMiBhTZ6cFjsAoz--
