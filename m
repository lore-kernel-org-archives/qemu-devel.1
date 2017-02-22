Received: from eggs.gnu.org ([2001:4830:134:3::10]:46429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgT4s-0003Uj-1O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgT4n-00043c-11
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:19:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cgT4m-00043U-RR
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:19:08 -0500
Date: Wed, 22 Feb 2017 17:19:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170222091905.GA2629@lemon.lan>
References: <20170222021801.28658-1-famz@redhat.com>
	<8760k2wqlp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8760k2wqlp.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Install python2 explicitly in
 docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org

On Wed, 02/22 08:56, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > Python is no longer installed implicitly, but the QEMU build system
> > requires it. List it in PACKAGES.
>=20
> Doesn't fedora have a similar system to dpkg's build-deps that we shoul=
d
> use to install dependencies?

It does, but I'm not sure how to generate PACKAGES out of that, for the S=
HOW_ENV
feature.

Fam
