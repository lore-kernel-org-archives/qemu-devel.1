Received: from eggs.gnu.org ([2001:4830:134:3::10]:35241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecfhF-0004im-Ft
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 18:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecfhE-0005kt-HX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 18:03:41 -0500
References: <20180119224735.12169-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <086ccaa6-eefb-47e4-a865-78075ddd827d@redhat.com>
Date: Fri, 19 Jan 2018 17:03:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180119224735.12169-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JUxs1XHKRbnw390AsGQIE632ohLwY4pv0"
Subject: Re: [Qemu-devel] [PATCH v4] file-posix: specify expected filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JUxs1XHKRbnw390AsGQIE632ohLwY4pv0
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Message-ID: <086ccaa6-eefb-47e4-a865-78075ddd827d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] file-posix: specify expected filetypes
References: <20180119224735.12169-1-jsnow@redhat.com>
In-Reply-To: <20180119224735.12169-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 04:47 PM, John Snow wrote:
> Adjust each caller of raw_open_common to specify if they are expecting
> host and character devices or not. Tighten expectations of file types u=
pon
> open in the common code and refuse types that are not expected.
>=20
> This has two effects:
>=20
> (1) Character and block devices are now considered deprecated for the
>     'file' driver, which expects only S_IFREG, and
> (2) no file-posix driver (file, host_cdrom, or host_device) can open
>     directories now.
>=20
> I don't think there's a legitimate reason to open directories as if
> they were files. This prevents QEMU from opening and attempting to prob=
e
> a directory inode, which can break in exciting ways. One of those ways
> is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
> size instead of EISDIR. This can coax QEMU into responding with a
> confusing "file too big" instead of "Hey, that's not a file".
>=20
> See: https://bugs.launchpad.net/qemu/+bug/1739304/
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JUxs1XHKRbnw390AsGQIE632ohLwY4pv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpieUEACgkQp6FrSiUn
Q2pPGAf/cqoeP6HxOpRFRL/fSx39wf+gTVDiP9z7fDiCgr472wTX3l0RDoYLFcTZ
Y03JW61JXOQ6gWbaPyB3SspHHkg6r5ahaGzT5pMXDnFxMjWMKAwLCtz4hwZVh15e
IyCUS/yuppi5xSGoXnxSb+JMqSILXVCPzd+iOhyWv0XzRuXJ/OMZyS4V7pUSEXxL
ZgcCSAeICj9rCv/eiR/K6lMFVZS8wU/XOtMHdMjZrJFrQLc5vkL05ILk73f4Dpqr
Kn3YZC6jc2XazcWVYQ476l6HOLOAdqVrdk4M9qTJ3LUkTZpCSPdlZZGDbEP8lEut
NFzuGGGxlLTT1nbflyorfpG8E/LtwA==
=tZaf
-----END PGP SIGNATURE-----

--JUxs1XHKRbnw390AsGQIE632ohLwY4pv0--
