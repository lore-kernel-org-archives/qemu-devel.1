Received: from eggs.gnu.org ([2001:4830:134:3::10]:55100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUvgb-0006Zx-5r
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUvga-00059w-6c
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:58:45 -0400
References: <1499755579-31262-1-git-send-email-gengdongjiu@huawei.com>
	<366f019e-50e8-03f4-9b8f-946ef318ca79@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d18b0a8d-5c34-ae4a-a60c-c451c8df9872@redhat.com>
Date: Tue, 11 Jul 2017 08:58:28 -0500
MIME-Version: 1.0
In-Reply-To: <366f019e-50e8-03f4-9b8f-946ef318ca79@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X7RUiSILkwpBBk3FE2Bnfwt9vaKtIpo77"
Subject: Re: [Qemu-devel] [PATCH resend v4 0/3] Generate APEI GHES table and
 dynamically record CPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Dongjiu Geng <gengdongjiu@huawei.com>
Cc: mst@redhat.com, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhihui.gao@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X7RUiSILkwpBBk3FE2Bnfwt9vaKtIpo77
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, Dongjiu Geng <gengdongjiu@huawei.com>
Cc: mst@redhat.com, imammedo@redhat.com, famz@redhat.com,
 qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, zhengqiang10@huawei.com, huangshaoyu@huawei.com,
 wuquanming@huawei.com, zhihui.gao@huawei.com
Message-ID: <d18b0a8d-5c34-ae4a-a60c-c451c8df9872@redhat.com>
Subject: Re: [PATCH resend v4 0/3] Generate APEI GHES table and dynamically
 record CPER
References: <1499755579-31262-1-git-send-email-gengdongjiu@huawei.com>
 <366f019e-50e8-03f4-9b8f-946ef318ca79@redhat.com>
In-Reply-To: <366f019e-50e8-03f4-9b8f-946ef318ca79@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2017 08:43 AM, Laszlo Ersek wrote:
> So send the patches with
>=20
>   git send-email *.patch
>=20
> or put all the patches into a temporary directory, and run
>=20
>   git send-email patch-dir/

Or you can even skip patch files, and directly send things with one lass
chance in your editor:

git send-email -v5 -3 --annotate --cover-letter

[send the top three commits in my current git branch as a version 5
patch series, where I get to write the cover letter and tweak any of the
patches in my preferred $EDITOR before sending anything]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--X7RUiSILkwpBBk3FE2Bnfwt9vaKtIpo77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZNmEAAoJEKeha0olJ0NqhF0H/31M+z6ICVFuXEDGNaZJAYAS
ToSGNkYIhgDTQA5QKrg3/Efm2rYR2CN8vxWDR/ax4MdF2CRUnPXCxSvTb/cSfBhe
vC7PXDoMdaJ5uzYccQkGoNG7g97v/kUNF2cvnxeA5U6jv3FyxPUJrupJvCuUAGI7
c1IkKQ68/5bxXM+FSHtk6A3aX0ddcEj6sUUbeiU7N3Qq9I2tWBQEMitVXbw3/LTs
UYyoH8guyhFJlh1ZsqvrSMPDmcEn+L7y+OuVLzzET/ZZtSNWSA/4EtwHJ5gw5edc
KlAcuaK/68i9MhlH2haBZ6UO36oegDVCAykKTX0aN5vCJVkeELUxIDLGIE7DR/E=
=hLRO
-----END PGP SIGNATURE-----

--X7RUiSILkwpBBk3FE2Bnfwt9vaKtIpo77--
