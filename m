Received: from eggs.gnu.org ([2001:4830:134:3::10]:35875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKOw-0004rY-5X
	for Qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKOt-0000QA-IM
	for Qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:22:50 -0400
References: <f3b1276a-92e3-54f3-c6a0-5f8e16124014@redhat.com>
	<507e7a29-5461-e152-123e-aab9dfc1f8ac@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cc3f3aa6-155f-a50d-f89c-54effaaa69cc@redhat.com>
Date: Wed, 26 Jul 2017 06:22:38 -0500
MIME-Version: 1.0
In-Reply-To: <507e7a29-5461-e152-123e-aab9dfc1f8ac@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CmpR17uq1oKjaLbVWclLQFMnagerm3fbN"
Subject: Re: [Qemu-devel] RFC: unified --help information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CmpR17uq1oKjaLbVWclLQFMnagerm3fbN
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu block <qemu-block@nongnu.org>
Message-ID: <cc3f3aa6-155f-a50d-f89c-54effaaa69cc@redhat.com>
Subject: Re: RFC: unified --help information
References: <f3b1276a-92e3-54f3-c6a0-5f8e16124014@redhat.com>
 <507e7a29-5461-e152-123e-aab9dfc1f8ac@redhat.com>
In-Reply-To: <507e7a29-5461-e152-123e-aab9dfc1f8ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 06:11 AM, Paolo Bonzini wrote:

>>
>> qemu-nbd mentions: Report bugs to <qemu-devel@nongnu.org>
>> qemu-ga mentions: Report bugs to <mdroth@linux.vnet.ibm.com>
>>
>> while qemu-system-*, qemu-img, and qemu-io mention nothing at all.  Is=

>> it worth unifying these to all mention qemu-devel@nongnu.org as the
>> primary bug-report site, and/or to add mention of <http://qemu.org> as=
 a
>> site for further information?
>=20
> I think we should point to a more specific bugreport URL.
>=20
> Currently it's http://wiki.qemu.org/Contribute/ReportABug.  If we want
> an URL on qemu.org, we can either add a redirect from qemu.org to the
> wiki, or move the contents to qemu.org (it's static enough that it
> shouldn't be a big issue).  I've sent out a patch for the latter.

So something like these two lines (via a macro) in all of the
executables, ideally at the tail end of --help output?

See <https://qemu.org/contribute/report-a-bug> for bug reports.
More information on the qemu project at <https://qemu.org>

(assuming your recent patch goes in).  I'm also open to bikeshedding on
better wording, or requests on which content is most useful vs. too verbo=
se.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CmpR17uq1oKjaLbVWclLQFMnagerm3fbN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4e34ACgkQp6FrSiUn
Q2pVKgf+LM+uNjTy/ASYN17SVMqaR7/3vdQgxoJSAfR/zeJkNgvCWM26G9CffCiD
z/4eQ05+aGOQVq/ywOo4VXu27FL0Ns4s2U95wOmf/bQHEZ4QDNKP9fiEkxvx7IZZ
sZ0GELF3W7px+fdDxbPmc3aCAOKkIrHqC0Vnft4WmuBbAY/B4P0ex0MQQ8bf5RX1
BfZa28ctYOKZe9hEOk1A8CXXKZi0u6/PGjsWN64pseZkNJath05RhngTQzk5uM2C
l3uBoWy+V3Iqz9jwia0R75CisWNPBAUH+GGZk4s54G5ESR72EtvfakywCCx72nan
XjkQ5sCfoMrTiqHmNfNNkCkYZp+PeA==
=fR2B
-----END PGP SIGNATURE-----

--CmpR17uq1oKjaLbVWclLQFMnagerm3fbN--
