Received: from eggs.gnu.org ([2001:4830:134:3::10]:52062)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1f95Q5-0007xE-Ii
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1f95Q4-0005DU-Sn
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:59:57 -0400
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418144538.4aa2f492.cohuck@redhat.com>
	<20180418125545.GN27579@redhat.com> <87sh7rvf27.fsf@dusky.pond.sub.org>
	<20180419093024.27c77433.olaf@aepfle.de>
	<20180419075958.GD10259@redhat.com>
	<CAFEAcA9UYM3hifEbs_sp9jcFkwu5sSSXaLq9CLWuhNbV67+MBQ@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <71ff6ce5-c878-de18-5d03-bb4a8b66a98a@gmx.com>
Date: Thu, 19 Apr 2018 11:01:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9UYM3hifEbs_sp9jcFkwu5sSSXaLq9CLWuhNbV67+MBQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GsdJWqCo4910G8fLK8MvGDsiRkCRPuXpS"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v1] configure: require
 glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GsdJWqCo4910G8fLK8MvGDsiRkCRPuXpS
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71ff6ce5-c878-de18-5d03-bb4a8b66a98a@gmx.com>
Subject: Re: [Qemu-trivial] [Qemu-devel] [PATCH v1] configure: require
 glib-2.24
References: <20180418123838.3511-1-olaf@aepfle.de>
 <20180418144538.4aa2f492.cohuck@redhat.com>
 <20180418125545.GN27579@redhat.com> <87sh7rvf27.fsf@dusky.pond.sub.org>
 <20180419093024.27c77433.olaf@aepfle.de> <20180419075958.GD10259@redhat.com>
 <CAFEAcA9UYM3hifEbs_sp9jcFkwu5sSSXaLq9CLWuhNbV67+MBQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9UYM3hifEbs_sp9jcFkwu5sSSXaLq9CLWuhNbV67+MBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.04.2018 10:54, Peter Maydell wrote:
> On 19 April 2018 at 08:59, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>> I wouldn't say people don't care about SLE11 (or other similarly old d=
istros
>> like RHEL-6). Rather the view in libvirt was that if a user is stuck o=
n such
>> an old distro, they are likely doing that because they want the stabil=
ity
>> inherant in running fixed software versions for years. IOW it is unlik=
ely
>> that they want the stability of an old distro, combined with cutting e=
dge
>> libvirt and/or QEMU.
>=20
> Well, it depends. You might be stuck with an old distro because
> some software you want to run depends on it, but also want to run
> newer versions of some programs like QEMU. If you're in that
> boat you can probably live with having to also compile a newer
> version of glib to go with your newer QEMU, though. I think the
> policy as outlined in that libvirt page seems a good one (it's
> basically a codification of what we've been doing already), with
> a few tweaks -- I think we still believe we support some older
> OSX releases, and would want to mention NetBSD/OpenBSD I guess.
>=20

In NetBSD we don't really support pkgsrc branches more than quarterly
and keep using usually the recent releases.

> thanks
> -- PMM
>=20



--GsdJWqCo4910G8fLK8MvGDsiRkCRPuXpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlrYWwUMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsrJIQALDlGqzgpSybC8zRwsEt2y9fpGqm1/Kwj0XL7HSZ
xlVIqsAZqikZxXJKrHZgEj+6TTVp0SwfEEUkN++PzHydvay/NtvOEUWEphLrY4J+
CYF/IlvVmVEM7jbWcpLwn4WRiza0I2TLESnR2yPGu0+phKiuaLgvnyCcgKKoohzV
UcV1IlPRz618SHwxTvc00uwD+cXZC3n16ncr66Ifpgowz/P+yGDttrL/P917tKzu
Vy6HNjKUupoEHek0KIygYydZXV7AEvKN5knNHqWj+rJFlBFFFZOpaNr7oWFuCSRH
M4E1Mm/Zp8vBTYfzL2gn0e8w5nFe7bX3i8uvHmby1j9BuBocupUZxjBPDzKsesVR
SLXcP556jIhfnGKun1mdumtYtCMlqB+b+p6qcL4TOm//oABJyN2iTSV8krCgfnT5
fajr6unmUjqr2rRrpFX9Pa4804iJzOZEiJHGlZNLZ4KNXUsLDqvXwvex/0D1hFbE
PKGv4FSLlzHYdeTToUO49p3o6xjN8rwBAOZPOjAGZxqlEwsts6VCKY/PghF3Q1Vh
L9SJY2/TxDgoa8/AglnBotGRs3k5VrOUb4ZdCE3IfiIuKnTrURg0LHrVzHnVAZZl
8yMXEbMnHcS31UKEkNhz2KX+rubG2FQ4/RowS7WI4zCR3eFF/7DM2iH8FAw3l031
/OIw
=Ph2C
-----END PGP SIGNATURE-----

--GsdJWqCo4910G8fLK8MvGDsiRkCRPuXpS--
