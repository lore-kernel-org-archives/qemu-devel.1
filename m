Received: from eggs.gnu.org ([209.51.188.92]:59439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjU4L-0004Ex-Oi
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjU4J-0005Ge-Po
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:08:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gjU49-00059x-Ke
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:08:03 -0500
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
	<CAPyFy2Dw2F3ks_5f8cvWjrsOTS0_Ybr5kELUpyHQmOQWUaeuFg@mail.gmail.com>
	<15cf568b-b914-b48a-79db-4cc9a761654c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71e35c24-ac4a-753d-4c6f-163d60a172c8@redhat.com>
Date: Tue, 15 Jan 2019 13:07:59 -0600
MIME-Version: 1.0
In-Reply-To: <15cf568b-b914-b48a-79db-4cc9a761654c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cNCXHBwmg4Otjxuo9xQzo4t3qZ4orMwFj"
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cNCXHBwmg4Otjxuo9xQzo4t3qZ4orMwFj
From: Eric Blake <eblake@redhat.com>
To: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <71e35c24-ac4a-753d-4c6f-163d60a172c8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
 <CAPyFy2Dw2F3ks_5f8cvWjrsOTS0_Ybr5kELUpyHQmOQWUaeuFg@mail.gmail.com>
 <15cf568b-b914-b48a-79db-4cc9a761654c@redhat.com>
In-Reply-To: <15cf568b-b914-b48a-79db-4cc9a761654c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 1:02 PM, Eric Blake wrote:
> On 1/15/19 12:51 PM, Ed Maste wrote:
>> On Tue, 15 Jan 2019 at 13:42, Ed Maste <emaste@freebsd.org> wrote:
>>>
>>> From: Ed Maste <emaste@freebsd.org>
>>
>> I'm not sure what part of the path between `git send-email` and the
>> list moved this From: into the message body, but it's not intentional.=

>=20
> It doesn't hurt. 'git am' prefers the From: in the message body over th=
e
> From: from the message headers, if the two differ, because that is the
> only way some people have to get git to record their commits correctly
> due to the list having to rewrite their headers to avoid the mail being=

> rejected from over-strict SPF settings.  In your case, the two lines
> look identical (the list didn't rewrite your header From: to work aroun=
d
> SPF); but it may be due to your 'git config format.from' settings.

Hmm - I wrote that they looked identical, but I was reading your reply
(where the From: matched your body), and not your original patch (where
the two differed - the header From: included a subdomain not present in
the commit authorship).  You may also want to look at 'git config
sendemail.from' and sendemail.envelopeSender configurations.

>=20
>> If someone's going to pick up this patch please edit the commit
>> message.
>=20
> 'git am' already does it automatically.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cNCXHBwmg4Otjxuo9xQzo4t3qZ4orMwFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+L48ACgkQp6FrSiUn
Q2oCuQgAn8jz7Nd1O1lWvVugyhBLxSSxM6omnFSPQ3KNIyJxF8dpeA1gwNA6reWj
BsHNG8M9x7yHjIJ+CBe7bkC1vZDQt+RcriKr3/UVB5QNoGl1BcdTmNpCm433V9z6
Q71f8FXWaR/K9Eiq6OoiaIAZd5kn9rS4wkjqsaAjqex1nscGY2kxejae0x75+dEQ
OGnzP8JKdqmNtgXqwNWmw+HMoUrvbD8pZLVx5Xwlpkki3BEc5D/nUBb62FNYqAtt
HGWUp1S40zCqnNtL7SC1ywd5lieyUD9Zb/h/Tt4VOxr4uo09KRO1qmbVtlF/eegk
ZJU0oS6PlLGmkIYO6YqcHJ3HezBrtQ==
=r69Y
-----END PGP SIGNATURE-----

--cNCXHBwmg4Otjxuo9xQzo4t3qZ4orMwFj--
