Received: from eggs.gnu.org ([2001:4830:134:3::10]:47585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnQb6-0001iK-IE
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnQb1-0004Pt-TS
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnQb1-0004PZ-MW
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:37:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0BBF6146E
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 14:37:26 +0000 (UTC)
References: <20170831094643.22567-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b32aa8f5-1b8f-a343-5516-9d4cd8de4165@redhat.com>
Date: Thu, 31 Aug 2017 09:37:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170831094643.22567-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="utaCKOFmbfNR5odCNBN7FH1Ks2sHo9f16"
Subject: Re: [Qemu-devel] [PATCH v2] io: add new qio_channel_{readv, writev,
 read, write}_all functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--utaCKOFmbfNR5odCNBN7FH1Ks2sHo9f16
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Message-ID: <b32aa8f5-1b8f-a343-5516-9d4cd8de4165@redhat.com>
Subject: Re: [PATCH v2] io: add new qio_channel_{readv, writev, read,
 write}_all functions
References: <20170831094643.22567-1-berrange@redhat.com>
In-Reply-To: <20170831094643.22567-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 04:46 AM, Daniel P. Berrange wrote:
> These functions wait until they are able to read / write the full
> requested data buffer(s).
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--utaCKOFmbfNR5odCNBN7FH1Ks2sHo9f16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoHyUACgkQp6FrSiUn
Q2oD8gf/X/GS1R1uWSuykEqnE/Ti+sH/ehTMCyjqKbdw+sExudQNNpL3PLhgWl5A
IQA4ua3/AlCDkKzOdRBAad59wJeWJsRxgVwnAZ2fJ6jFl3c0ZhuDyn2lW3pzTfPY
idje1x9MqGhWncmc/0LwhdiGtC7ICXzs6ZiE7a2EGbnXgbcq6yom5nzAylsLLRD7
80ujli2zSe7o6jjBDRwxaSeFR5CBzoWsSfZD8alFt6Hl+LO5YZS3uC2F/PBapfja
C+r0A7Jaq+oMu+q+9oqOwOWIhSrTtUZErFgb3fUxzq+XaATVCxHTKFz//GYsopWC
XoZTqC8Dck1FfjAFo0rRMsuO+hYxXQ==
=B7fE
-----END PGP SIGNATURE-----

--utaCKOFmbfNR5odCNBN7FH1Ks2sHo9f16--
