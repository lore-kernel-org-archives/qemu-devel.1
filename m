Received: from eggs.gnu.org ([209.51.188.92]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj4Jn-0005FR-EZ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj4JV-00026Q-8i
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:38:16 -0500
From: Thomas Huth <thuth@redhat.com>
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
	<20190114143144.GH3686@redhat.com>
	<0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
	<2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
	<bc8478dd-5f25-47c8-51e0-45bc3c35c0ae@redhat.com>
	<150611f1-774a-a0c9-9e22-756d8e87b7ca@redhat.com>
Message-ID: <6d155740-66a0-3879-4e05-8a6fb50b02b8@redhat.com>
Date: Mon, 14 Jan 2019 16:37:44 +0100
MIME-Version: 1.0
In-Reply-To: <150611f1-774a-a0c9-9e22-756d8e87b7ca@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="mz6SLkD0EY4OTKfZ1ag0DXqb5KkQgl4ky"
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mz6SLkD0EY4OTKfZ1ag0DXqb5KkQgl4ky
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d155740-66a0-3879-4e05-8a6fb50b02b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
 <CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
 <20190114143144.GH3686@redhat.com>
 <0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
 <2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
 <bc8478dd-5f25-47c8-51e0-45bc3c35c0ae@redhat.com>
 <150611f1-774a-a0c9-9e22-756d8e87b7ca@redhat.com>
In-Reply-To: <150611f1-774a-a0c9-9e22-756d8e87b7ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2019-01-14 16:23, Thomas Huth wrote:
> On 2019-01-14 16:02, Eric Blake wrote:
>> On 1/14/19 8:53 AM, Thomas Huth wrote:
[...]
>>> The patch is only changing libiscsi_cflags, so it's not affecting the=

>>> entire project, but just the files that use libiscsi.
>>
>> Even so, limiting the damage to just the wrapper file that includes th=
e
>> problematic header rather than changing the command line for the entir=
e
>> compilation of those files that use libiscsi is even more precise.
>=20
> Then our only option is "#define inline /* nothing */", as far as I can=

> see...

Or this one, which seems to be a better idea to me:

#define inline __attribute__((gnu_inline))

gnu_inline should give the same behavior like the "inline" keywords in
gnu89 mode.

 Thomas


--mz6SLkD0EY4OTKfZ1ag0DXqb5KkQgl4ky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcPKzNAAoJEC7Z13T+cC21gdUP/iMURyq9blPYqYoJlqhkneYd
ZgCG/nt1GG0gA+81wj65w172P4VN279/1LMlrNBuxeZK133pm77Y54O6NbVkhFU9
xN77kZ2belX8JrsTZvHyxoBHywCT+Fqq5SgLqo6eDO2NxRCYrCOtdhLb+i+6g9VF
l1srZsQBK9o84Q+lLsFRJN1GsjiEviVue98F7ZJYqoALufhcmFIXt55SxWJzmlHN
2WG+JjvDCCYKruQedr0wNMkLSO7SpdFmjt+E2I6lgBRxmSxv4/wycgwOp71d2Xiy
3tiVeWR70EDSXHkqveggnGTS8QiqqfWVbIUJt8IPZG7J1RQeiuoVMxWvrBbaN8RR
qNHlsPejWnHkCV9xveF647XlaC5GlOdIYa0HMpGdFDWM3ciGebkisBQhAcXCyv4q
0+qiewRy3Njdcu6emEY+w4oNqKd0LMEv7UN+dYVBdLG1P+FkgnmimR4Z7/c/u8se
SUBxBSE9KWOvEjHTWGMpoyyPKX3z66DbD1vq8CBfIuZYJttrdi0qMQLOEWd/UNNE
JkZpiww1ngRR1I1KSbcTk3m7Y6NqeKLG4oovfV0+daSR85l1Jx2g0VllpvG4mkh9
RpubCRRWtNEkPPOHLNPDk/WG2mNb1CMttTXUEuJysXX+zIo6HFTF488h2qqUU/7r
N9N6lvoVW/WHVqf2Dc1r
=E5FV
-----END PGP SIGNATURE-----

--mz6SLkD0EY4OTKfZ1ag0DXqb5KkQgl4ky--
