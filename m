Received: from eggs.gnu.org ([2001:4830:134:3::10]:41829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPEiP-0002tD-Io
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPEiO-0002cP-Nh
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:32:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPEiO-0002cH-H0
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:32:48 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9725261B91
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 20:32:48 +0000 (UTC)
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24cdd629-d593-fad5-8154-c4f44b559ad2@redhat.com>
Date: Thu, 5 Jan 2017 14:32:46 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160321.21786-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9TUlNtm8QfpiJeGmu3bpJMcUrP4HrP3lE"
Subject: Re: [Qemu-devel] [PATCH 4/8] io: add ability to associate an opaque
 "result" with with a task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9TUlNtm8QfpiJeGmu3bpJMcUrP4HrP3lE
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <24cdd629-d593-fad5-8154-c4f44b559ad2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/8] io: add ability to associate an opaque
 "result" with with a task
References: <20170105160321.21786-1-berrange@redhat.com>
 <20170105160321.21786-5-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> Currently there is no data associated with a successful
> task completion. This adds an opaque pointer to the task
> to store an arbitrary result.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/task.h | 27 +++++++++++++++++++++++++++
>  io/task.c         | 20 ++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>=20

I suppose a different approach would have been changing QIOTaskFunc() to
have a void* return, but that would be more invasive.  Grabbing the
result separately from the task completing is a bit weird, but looks
like it will work.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9TUlNtm8QfpiJeGmu3bpJMcUrP4HrP3lE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbq1uAAoJEKeha0olJ0NqQ9wH/3UP+yd4BEvIf7nUk+HsPVP8
3yZ9RvRj2pJtvV3bLoAEt+7ee+J1073Rwf6oPa1Zn05oDnUVmDwJFrihj24K15I9
8bG12gvQqG6H5gOkh3u8HT7GV5zsH43H45baODbU2Z7Q41hlaVQCcWNCh9n8ON4B
CAumyf3GPsTvkFzj9LjuTXA5Np9+ctrtKbR7ubUeyLZoI1HuERvzLfcz1EZJcydS
xxFJrYREPFCVxwlB50SbHnHCVcUC6uV/aa6KNDBKBbOhgcz/ojLxOD0lI/LEf3pa
VCY4WcvObl3yvOc3GxOkm0Ndrcwihy8plmKP33oylBP79ZqKQ+9R99E7Sd9rIHU=
=N1Du
-----END PGP SIGNATURE-----

--9TUlNtm8QfpiJeGmu3bpJMcUrP4HrP3lE--
