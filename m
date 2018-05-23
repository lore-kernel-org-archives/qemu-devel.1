Received: from eggs.gnu.org ([2001:4830:134:3::10]:59961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fLOVA-0003wK-QO
	for qemu-devel@nongnu.org; Wed, 23 May 2018 03:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fLOV7-0002YO-O1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 03:48:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fLOV7-0002Y8-HO
	for qemu-devel@nongnu.org; Wed, 23 May 2018 03:48:01 -0400
Date: Wed, 23 May 2018 09:47:57 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180523074757.GI26766@dnr>
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader> <20180518075212.GE3416@dnr>
	<20180518091916.GA22292@vader> <20180518130729.GF3416@dnr>
	<7149dfa9-7d3a-a2ff-b326-7e9ba71f8fe1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
In-Reply-To: <7149dfa9-7d3a-a2ff-b326-7e9ba71f8fe1@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>
Cc: Eduardo Otubo <otubo@redhat.com>, borntraeger@de.ibm.com, fiuczy@linux.ibm.com, qemu-devel@nongnu.org


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2018 at 04:20:37PM +0800, Yi Min Zhao wrote:
>
>
>=E5=9C=A8 2018/5/18 =E4=B8=8B=E5=8D=889:07, J=C3=A1n Tomko =E5=86=99=E9=81=
=93:
>> On Fri, May 18, 2018 at 11:19:16AM +0200, Eduardo Otubo wrote:
>>> On 18/05/2018 - 09:52:12, J=C3=A1n Tomko wrote:
>>>> But now libvirt requires QEMU >=3D 1.5.0 which already supports
>>>> query-command-line-options, so if you want the option gone completely
>>>> --without-seccomp, I can add the code that probes for it and
>>>> make seccomp_sandbox =3D 0 a no-op if it's compiled out.
>>>
>>> This looks like a good solution for the libvirt side. Can you add
>>> this support
>>> so we can merge this fix?
>>>
>>
>> Patches proposed:
>> https://www.redhat.com/archives/libvir-list/2018-May/msg01430.html
>>
>> Jano
>Thanks for your work!

Now pushed in libvirt master:
commit b87222a90919040c12fb6d7c8dcc20f944a66495
Author:     J=C3=A1n Tomko <jtomko@redhat.com>
AuthorDate: 2018-05-18 14:57:51 +0200
Commit:     J=C3=A1n Tomko <jtomko@redhat.com>
CommitDate: 2018-05-23 09:45:48 +0200

    qemu: only pass -sandbox off if supported

    This way we don't rely on QEMU supplying the -sandbox option
    without CONFIG_SECCOMP.

    Signed-off-by: J=C3=A1n Tomko <jtomko@redhat.com>
    Reviewed-by: John Ferlan <jferlan@redhat.com>

git describe: v4.3.0-258-gb87222a909
https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dcommitdiff;h=3Db87222a90919040=
c12fb6d7c8dcc20f944a66495

Jano

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlsFHKYACgkQyvpdPXT/
AmmntxAAh2tICQB/gomBFRLAl3LheimGa6iG5NCvrY1bkTYFV1H6jRBNRdLzrFmC
Km9Z2CzqgNKSTMf8cLig/zwRpSuCy9kZgLd9GkASd+cHe58j9QhQHhsWCKDRi5R/
b7zOZeLYSb6IZN2hbIiMPpjtOTRu9qP7f/fNZq8bsOOMoBf1Q0PGZjnVwUROwN0/
Yy7swqrfMDeSnwXJ+XHgLbf7RWKJaKeWFE2+4WRZ54dZtTdQKsAMjdJBmv6VYL64
beLFlLYh9Jk64fjoQgCQir1me5CY/deo+0JgQBLroEQWMPKIlKI4EWemXHvneaw7
AJONlVVrxlTM/5sf/X7SERYTJLe9Z5qgafsKpwZ3s+rzmQUC7zGAXtZhkvlHAgH6
QWnwZRcyM3VyTJQW8s3ga5MRfSiO0bvqAn+S5apu5bQMX1+HGYyfxd5Fxy16wv0n
V/M6FnBAYSNypu/nOHI7jEtkLVjgJZ5uspn/rOjxMVwRe1Bbaa7isQTOKnfMr4op
tFyVj6gofKTcQ+e6KTLO0QVAU7leHU0MLcuTaIAu73TxqYepeoardWAuPy8S1ffj
a74nAHmHd9eyNxqwUlvat7jtzYy1zDVm4zGF7SyaW0iiXD2+lnc7sVR0YLRwHZyh
5JjBjl1GjWYOJj0QOvQcf59a8nFq5Hs9Lq9sVDbzQbtaUhH0VUg=
=xNF3
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
