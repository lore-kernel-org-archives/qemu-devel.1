Received: from eggs.gnu.org ([209.51.188.92]:33796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj3cm-0000f8-DJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj3cl-0001QN-OX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:54:00 -0500
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
	<20190114143144.GH3686@redhat.com>
	<0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
Date: Mon, 14 Jan 2019 15:53:48 +0100
MIME-Version: 1.0
In-Reply-To: <0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="EgReoxtjv8NxPugkebL3GpYC2Sb3h8bha"
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
--EgReoxtjv8NxPugkebL3GpYC2Sb3h8bha
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
 <CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
 <20190114143144.GH3686@redhat.com>
 <0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
In-Reply-To: <0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2019-01-14 15:50, Eric Blake wrote:
> On 1/14/19 8:31 AM, Daniel P. Berrang=C3=A9 wrote:
>=20
>>>
>>> Can we suppress the warnings with #pragma instead ?
>>> That would avoid compiling the .o file with different
>>> C semantics.
>>
>> IIUC this is a built-in warning you can't disable, except by changing
>> the compilation mode to have gnu89 inline semantics :-(
>=20
> Could we instead fix the warning by one of:
>=20
> Using pragma to declare the header as a system header (used to silence
> warnings from misbehaving external headers),

How do you do that?

> and/or adding #defines around the inclusion of the header to neutralize=

> the poor warnings,

You mean something like:

#define inline /* nothing */

?

=2E.. sounds quite ugly to me, too.

> but without changing the compilation mode of the
> entire project

The patch is only changing libiscsi_cflags, so it's not affecting the
entire project, but just the files that use libiscsi.

 Thomas


--EgReoxtjv8NxPugkebL3GpYC2Sb3h8bha
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcPKKBAAoJEC7Z13T+cC21WcEP/0dUWdgO2BiQPTaTEvXpKFOp
FADUrynn8nLVZr5PecgW05kOBXyF5DxHhOXYdcunFL8+mWoYjQN7q6N2cBkSjcTB
3FXUFLAfBTwBLwgkl7MtpUkVE9yrB7Ih62KMO6YGRpe69qz9lRkCZ5H9X5IpFEGp
AUuWTuAOnjcO/lyewnvICdGgVpHBbTpFUKBxQ+gB+gZMBwXZaiV68sSrYi9wfBOk
seQNby+6rx0/8nPAe9Ocky7IA3SbJXSnXVDsianfeLbvSBX9OFlnT2XrOdiSECmk
6/WffgLAM25Ztf/mYaA+U4t2L1KComqWBO2RvMu4NL3gP47kgdVZorSb5l54AjvT
ibxfy0mQ4FxAcaWypdCTsNASlZUzCvoeOfsoJ3d0sUusufdA2vVq94mIJwXLsj3Y
F2L078p4jNTMwfluhqCNs11hA+gDMJ5A6fjbBVbMtSW/zUMtjV9ize6Nio9AgfFl
ARwX27ziRQ4NgXRs0xYpKwdx50aJQ5DipXcH1nNcOGqNDTv//FJ0TaErWYTv8HNH
nNiL7eMhPgqjMNlBkT7zXyJLxRSyre45nPot4ajiQ/AM1gH2t0XxyhpZcNjPrkCZ
A1GI3KCUDyUbrSZ/ugDqh9gYWSrRu+t9bi/b1FwE0TCngBwF7tsiwFhBF0C9quC/
OxoGl7hJMOplgUZoA3Vu
=UgeW
-----END PGP SIGNATURE-----

--EgReoxtjv8NxPugkebL3GpYC2Sb3h8bha--
