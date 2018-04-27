Received: from eggs.gnu.org ([2001:4830:134:3::10]:53448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBEY-0002QH-79
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBEV-0004Pv-3E
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:48:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fCBEU-0004P3-TO
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:48:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BE398190296
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 21:48:46 +0000 (UTC)
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-5-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3971f590-68ee-45eb-a5b9-bc88e3f9cce3@redhat.com>
Date: Fri, 27 Apr 2018 16:48:45 -0500
MIME-Version: 1.0
In-Reply-To: <1524841523-95513-5-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="357U28w4YoZ56RYgLaxCN7n5wHS0Xb7No"
Subject: Re: [Qemu-devel] [PATCH v6 04/11] hmp: disable monitor in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--357U28w4YoZ56RYgLaxCN7n5wHS0Xb7No
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com
Message-ID: <3971f590-68ee-45eb-a5b9-bc88e3f9cce3@redhat.com>
Subject: Re: [PATCH v6 04/11] hmp: disable monitor in preconfig state
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
 <1524841523-95513-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1524841523-95513-5-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 10:05 AM, Igor Mammedov wrote:
> Ban it for now, if someone would need it to work early,
> one would have to implement checks if HMP command is valid
> at preconfig state.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

There's a bisection window between when RUN_STATE_PRECONFIG is added and
this patch where HMP can be used to screw things up, but I'm less
worried about that being triggered in practice.  If you want to avoid
that window, then introduce RUN_STATE_PRECONFIG in one patch, then this
patch, then add command line --preconfig in a later patch (thus, NOTHING
can get into preconfig state, even though the code is starting to be
modified to honor it, until --preconfig is enabled on the command line).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--357U28w4YoZ56RYgLaxCN7n5wHS0Xb7No
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjmr0ACgkQp6FrSiUn
Q2o8sAf8CL94V8WdzsGLD9mrg3EXwmYc9++Ic4hd1ASrCqtF4YwRAaGmvluY4HZX
7YyC2ZNFiRcHz55eSm7tv3Uh43FlAjzi3TTUzzhk1at4WV/ZIap1B3GRZ0QlM9MM
rEOiLcIOsHPAp5Q7OXpoJxX4NjciIkqAmER/sb1usm0V+dw2/wQihiPl09B9Cw4h
H+QTNeVT9jW730jzi2SCDb0UR2PIHZ/NnpPzTYbWM/E9pg4UDpfUIQsq5siMuGrP
1ckAEoFW5ZsgP2A4LA0GappPqkTFQ8gkrjkmV+LpojJ/YjVAgPMHeVHyz0bZpIwC
a6jVaBQ2evrdGohBz2U+AFkmFjGA9A==
=WKFN
-----END PGP SIGNATURE-----

--357U28w4YoZ56RYgLaxCN7n5wHS0Xb7No--
