Received: from eggs.gnu.org ([2001:4830:134:3::10]:34561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehGnW-0007CC-Rm
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehGnS-0007T4-5t
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:29:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehGnR-0007Sf-Td
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:29:06 -0500
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-18-brijesh.singh@amd.com>
	<87mv0tvs6a.fsf@dusky.pond.sub.org>
	<315572b0-2893-2247-c20b-717becd9661c@amd.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b35e4ea1-92f8-78c6-ea07-fde07667427f@redhat.com>
Date: Thu, 1 Feb 2018 09:28:50 -0600
MIME-Version: 1.0
In-Reply-To: <315572b0-2893-2247-c20b-717becd9661c@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bKRDeOFmNCqxXsz0l5zfweeCobkEqKJnQ"
Subject: Re: [Qemu-devel] [PATCH v6 17/23] qapi: add SEV_MEASUREMENT event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, Markus Armbruster <armbru@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bKRDeOFmNCqxXsz0l5zfweeCobkEqKJnQ
From: Eric Blake <eblake@redhat.com>
To: Brijesh Singh <brijesh.singh@amd.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Tom Lendacky <Thomas.Lendacky@amd.com>, Stefan Hajnoczi
 <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b35e4ea1-92f8-78c6-ea07-fde07667427f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 17/23] qapi: add SEV_MEASUREMENT event
References: <20180129174132.108925-1-brijesh.singh@amd.com>
 <20180129174132.108925-18-brijesh.singh@amd.com>
 <87mv0tvs6a.fsf@dusky.pond.sub.org>
 <315572b0-2893-2247-c20b-717becd9661c@amd.com>
In-Reply-To: <315572b0-2893-2247-c20b-717becd9661c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2018 09:25 AM, Brijesh Singh wrote:

>>> +{ 'event' : 'SEV_MEASUREMENT',
>>> +=C2=A0 'data' : { 'value' : 'str' } }
>>
>> New event -> automatic question: do we need a way to poll for this
>> information?=C2=A0 Say when an event could get lost during a libvirt r=
estart.
>>
>=20
>=20
> In our initial SEV patches for libvirt we ran into similar cases where
> the event was dropped on restart, and now leaning towards dropping this=

> event patch and add a new QMP command which can be used by libvirt to
> retrieve the measurement.

An event may still be useful to minimize the amount of polling required
when the connection is not broken.  It's just that any setup that ONLY
permits events (and not also polling) is fragile.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bKRDeOFmNCqxXsz0l5zfweeCobkEqKJnQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpzMjIACgkQp6FrSiUn
Q2qmcgf/Wbjb1pHzEZamCpKSJ8aWG6oRnLCm9Ncmt3dDZmHS8Chx/ie9DR4bKNF9
XwGjlbcxrVMOj1jipMXI+SEe8YV6FDmiMLOKb9CZJa3Yxu/YdpFaz3TzFRwmu4wM
+C0GYKspAQRiDfTlzqVUBy5ZLZ4ufBzstSx5j0hCFx2LhTD9Cc9VJxUFIF8yMrMc
Z0sTZJuH+gy+lFM4ytC/fG1Zi4woryQF3Yer+QCxTBW3l8zG+a3e+koN8MFWXeSL
wxpSlaZkB2ZAXMmWOwDCwCK+m7sPpRVwx/mvcP3+J+3gkLEFzGZSV4QohXbiEVM8
dim4m3Wj+5NP6BrH7wQGc0JcY//SoQ==
=Qss6
-----END PGP SIGNATURE-----

--bKRDeOFmNCqxXsz0l5zfweeCobkEqKJnQ--
