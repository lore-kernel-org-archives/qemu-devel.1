Received: from eggs.gnu.org ([209.51.188.92]:42755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrEQ-0007aV-OE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqr2e-0000Qe-Ni
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:04:58 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-3-philmd@redhat.com>
	<cdfb4f7e-0182-386a-6508-a13a56e6de16@redhat.com>
	<0462853c-2f19-58ff-aee5-d667a86322e1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e67828c-3f62-da8f-f615-259f721a4bba@redhat.com>
Date: Mon, 4 Feb 2019 21:04:30 -0600
MIME-Version: 1.0
In-Reply-To: <0462853c-2f19-58ff-aee5-d667a86322e1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sXLOWP9kGgGkqMI64bs4nTR4MoA1QfdRC"
Subject: Re: [Qemu-devel] [PATCH v2 02/18] configure: Disable W^X on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sXLOWP9kGgGkqMI64bs4nTR4MoA1QfdRC
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Message-ID: <1e67828c-3f62-da8f-f615-259f721a4bba@redhat.com>
Subject: Re: [PATCH v2 02/18] configure: Disable W^X on OpenBSD
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-3-philmd@redhat.com>
 <cdfb4f7e-0182-386a-6508-a13a56e6de16@redhat.com>
 <0462853c-2f19-58ff-aee5-d667a86322e1@redhat.com>
In-Reply-To: <0462853c-2f19-58ff-aee5-d667a86322e1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 1:17 AM, Thomas Huth wrote:

>> test ... -a ...
>>
>> is not portable (POSIX permits non-XSI systems to omit support for the=
se
>> operators, but even where they are supported, there are some inherentl=
y
>> ambiguous inputs where you CANNOT predict whether the shell will parse=

>> -a as a binary operator or as an argument to some other operator).
>> Instead, you should ALWAYS break dual tests into:
>>
>> test ... && test ...
>>
>> instead.  (Same for '-o' vs '|| test')
>=20
> $ grep 'test.* -a ' configure | wc -l
> 21
> $ grep 'test.* && ' configure | wc -l
> 16
>=20
> Looks like we do not really care?

Well, I care. Enough to propose a patch :)

https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00960.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--sXLOWP9kGgGkqMI64bs4nTR4MoA1QfdRC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxY/T4ACgkQp6FrSiUn
Q2rTzAf+L5+nmQmwx2lsMb9fasnP9FR6GGwxeWypycM2AS9qzMSTv6KuIXUN4n4H
ovKKrIO+qIdrOa6Agb/xvaAnc0rIhalJzI2EDcStL43bk0j3oLml1i7CqDXjQHmZ
FvQtEBnhdODTy06wKrUOD1TH5vdAfZ4nu8neJiTpjCu1ygAoQewBnhE4IZd+ymiR
jMN4eHbz+qc/KgLvR7HbVMGBNmOO9ZuUUY1wHCdgXADpus74kwYjZ0XJWjrdJl2G
Mu1MznHcpOcWEHkCZupVpD71BiQ2VjCNxxc7vw+xWht7d2wJNtabiZ1UNrRsBA7R
S8Qgnk7et/5tFPg2R+PMQUt1zSnKHw==
=CCZH
-----END PGP SIGNATURE-----

--sXLOWP9kGgGkqMI64bs4nTR4MoA1QfdRC--
