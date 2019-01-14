Received: from eggs.gnu.org ([209.51.188.92]:34191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj3eT-000207-Op
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj3eR-0002On-P8
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:55:45 -0500
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
	<20190114143144.GH3686@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
Date: Mon, 14 Jan 2019 08:50:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190114143144.GH3686@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nEvP4Yldzx65dAHQIwpDmtP34xOhbQf0m"
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
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nEvP4Yldzx65dAHQIwpDmtP34xOhbQf0m
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
 <CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
 <20190114143144.GH3686@redhat.com>
In-Reply-To: <20190114143144.GH3686@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 8:31 AM, Daniel P. Berrang=C3=A9 wrote:

>>
>> Can we suppress the warnings with #pragma instead ?
>> That would avoid compiling the .o file with different
>> C semantics.
>=20
> IIUC this is a built-in warning you can't disable, except by changing
> the compilation mode to have gnu89 inline semantics :-(

Could we instead fix the warning by one of:

Using pragma to declare the header as a system header (used to silence
warnings from misbehaving external headers),

and/or adding #defines around the inclusion of the header to neutralize
the poor warnings, but without changing the compilation mode of the
entire project

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nEvP4Yldzx65dAHQIwpDmtP34xOhbQf0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw8oagACgkQp6FrSiUn
Q2ozmAf/RCqBhK/i2n32HnVKqAL3h98Eoqgj305uh66YFg44Zt8Fx1lxRHlIu3dP
C37e1jADhH2PvtOEpIoNY5Y3X3oygior0TwLMyN/HUklDkqb1P3Q+dGeWdXenJF4
sul7Pu+otEvUKkff5VxxgPmhnddLHcar4FNjv3FbO0kf3Yh6oWuGpRqqvE2SpC0B
KItaBzSgh0LprKRhm/05EtPGvcMTdAM+JmEVh8Vl+krz99HbjcWfbqa5BaxQDdSL
yWUt/OGVWOfeC8EUE0I95uutO2xe/DMRFnrrMdhtTjBz7COzXzT6zr3l9QAM4Pm8
g6T+XC42ywAO2CNFfc+kBacAHrFBbA==
=jCTr
-----END PGP SIGNATURE-----

--nEvP4Yldzx65dAHQIwpDmtP34xOhbQf0m--
