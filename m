Received: from eggs.gnu.org ([209.51.188.92]:51749)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmGPi-0008LI-9O
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmGPh-0002Wf-2v
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:09:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:34211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmGPg-0002KM-Nx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:09:45 -0500
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
Date: Wed, 23 Jan 2019 12:10:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nxrzrwIWgdauMCUrEnyFxbeE56JBSqhF8"
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nxrzrwIWgdauMCUrEnyFxbeE56JBSqhF8
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>
Message-ID: <52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
References: <20190123080005.31078-1-kraxel@redhat.com>
 <20190123080005.31078-5-kraxel@redhat.com>
 <484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
 <20190123093657.GC27270@redhat.com>
 <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
 <20190123101238.GD27270@redhat.com>
 <379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
 <CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
In-Reply-To: <CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.2019 11:59, Peter Maydell wrote:
> On Wed, 23 Jan 2019 at 10:37, Kamil Rytarowski <n54@gmx.com> wrote:
>> OSS is the portable UNIX audio backend. We could point some flaws in i=
t,
>> but it's a good enough for portable UNIX applications. The question is=

>> what UNIX-like desktop OS does not implement it or removed it.
>=20
> If your desktop's native audio API is pulse, like Linux's often
> is, then you want to use pulse directly, because the compat layers
> are (or were last time I looked) not great, and typically add
> in an extra thread and an extra layer of buffering, which means
> more latency or more audio dropouts or both.
>=20
> thanks
> -- PMM
>=20

Pulseaudio uses OSS backend on NetBSD anyway and we keep an in-kernel
mixer. So it adds nothing except additional intermediate layer.

For non-professional audio purposes OSS is good enough for such
applications.


--nxrzrwIWgdauMCUrEnyFxbeE56JBSqhF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxIS5MMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsug0QAKybE3crdovbt1TdW2i6DQUBT5RsMHZV30sR88d1
XFg3axzhHf7s++I5AVbvfc2dYfbgtuTYpg6l2vtKIFGMNHk1wObVrEN/MLPLLQ5G
GxwmsbOvyfqCV5XYpg/KrMEv+yj7/nC6XXK5ilkJnNa+MR5f0BSLDxo5W+4XgIdi
QLBrwV7pD1dnsiwc4/Bc92leNSW7+mI2ktwkChQeNAFKy5Uu35k9IxwWCAShv3jN
aqFnu85S+89atzr1fnKAVlves8N3I63cmbTeMfawdgchHkkiajeSp0Z1Ddg1l4fx
2FSNZzSDLzzFWHt5NlHgMS0Ig0eH5xbArcXFEp/aV9eThPx6mrgr2plWuRYv/llc
eOAJHDTww4arYtfe1qK8ooxLO0ZGbtznOaZJwmhWH2j/4UmCwAjOopHD7PYR+jvo
ijbyGg1b/f6iaoTtT3Qcfh8JIp5AR2CnOEi5FRuWvs0GBsQst4QIjxqllGZdDLu9
zO90IQ6LVOCM/08WEUiemH8BtFaiQImlzYXHQ+ETO1iQDuhMG63NZ8LjuPA3jmMk
e2kMxAplPwOU6PsClnzsFAXR/6Fucp5U/QnnrfciLjgxrOeihNxE+uZPhve4eazw
WJ64C7qYl6J94vNPm43DPkedMuYubGA1V7scp/inXepB8YYFLwYewXuPvwX0g3UC
EMH9
=qtr5
-----END PGP SIGNATURE-----

--nxrzrwIWgdauMCUrEnyFxbeE56JBSqhF8--
