Received: from eggs.gnu.org ([2001:4830:134:3::10]:37983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fBgBK-0002Q0-9r
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fBgBH-0003Sq-5R
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:39:26 -0400
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
	<CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
	<c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
	<20180426140807.4a4a577b.olaf@aepfle.de>
	<20180426121002.GG26812@redhat.com>
	<20180426141140.7d7b39d0.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b976e072-78c5-e12a-ba72-2075b8b635e3@redhat.com>
Date: Thu, 26 Apr 2018 14:39:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180426141140.7d7b39d0.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="heMzP0w4qrRolDhXNTr2rYQgIFW62lCpB"
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--heMzP0w4qrRolDhXNTr2rYQgIFW62lCpB
From: Paolo Bonzini <pbonzini@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <b976e072-78c5-e12a-ba72-2075b8b635e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
References: <20180418123838.3511-1-olaf@aepfle.de>
 <20180418124753.GM27579@redhat.com>
 <CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
 <20180418144433.GV27579@redhat.com>
 <CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
 <c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
 <20180426140807.4a4a577b.olaf@aepfle.de> <20180426121002.GG26812@redhat.com>
 <20180426141140.7d7b39d0.olaf@aepfle.de>
In-Reply-To: <20180426141140.7d7b39d0.olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/04/2018 14:11, Olaf Hering wrote:
> Am Thu, 26 Apr 2018 13:10:02 +0100
> schrieb Daniel P. Berrang=C3=A9 <berrange@redhat.com>:
>=20
>> Presumably the min-glib docker job didn't enable the vfio feature, whi=
ch
>> is what contained the bad code.
>=20
> It is Linux=3Dy, every following commit would have failed too.
> I suggest to revisit that testcase.

That's because Red Hat backported g_realloc_n into RHEL6 :) probably
because it's used for security reasons and they expected users to appear
in the next 10-ish years.

https://bugzilla.redhat.com/show_bug.cgi?id=3D573966

Thanks,

Paolo


--heMzP0w4qrRolDhXNTr2rYQgIFW62lCpB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlrhyGsACgkQv/vSX3jH
roNMNwf7Bd7qOPDAJlllwz8SZf65EJqvPoV0x9dnjEeB/GM0VrkA7GVgaamaHTn7
e09ZM1YJRMvg/pFSigBzlEWfFI5sME38jSNYAMnOPkPAGMs0DxdzxXxrYoQsAVSh
yrt+fDMs8xBMiEzYF4Yw8wPTqtphC24g1U1Z3dZtvLCXKJ/iGJTOl/wMT6fh4C0P
6yoG/Amh0FiufsAM8uAywiAX2PvTltT00KLhuLJKmUzIr9X1O6bPrnR+uBLClW3r
UPmNsBI6FbzozcvObUj8L60JtZSsgFJnZ7PajHlmuuS6SobJ5LuY9y1T4bpEIOyJ
jKOBpNEI8acAAbeqea3AcAyhZOePEg==
=Fpd1
-----END PGP SIGNATURE-----

--heMzP0w4qrRolDhXNTr2rYQgIFW62lCpB--
