Received: from eggs.gnu.org ([2001:4830:134:3::10]:42769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cderq-0004Cm-E2
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cderm-0005aE-Ad
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:18:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cderm-0005Zg-4V
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:18:06 -0500
Date: Tue, 14 Feb 2017 23:18:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214151803.GD20715@lemon.lan>
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-3-alex.bennee@linaro.org>
	<CAFEAcA8cXXc3oABFzvZQaTjxtZTxjuzi+7NBxTfM86rfPqGcqw@mail.gmail.com>
	<87fujgvmf9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87fujgvmf9.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] new: debian docker targets for
 cross-compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 02/14 15:09, Alex Benn=E9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On 14 February 2017 at 10:07, Alex Benn=E9e <alex.bennee@linaro.org> =
wrote:
> >> This provides a basic Debian install with access to the emdebian cro=
ss
> >> compilers. The debian-armhf-cross and debian-arm64-cross targets bui=
ld
> >> on the basic Debian image to allow cross compiling to those targets.
> >
> > Is there a particular reason for creating different docker images
> > for each cross target rather than just having one image with
> > all the cross compilers in it?
>=20
> Mainly the clashing of build-dependencies. Debian's multi-arch is prett=
y
> good but you still can't generally have two arches worth of complex
> dependencies installed at once.
>=20
> I did originally have one base docker image with all the compilers and
> intended to do the dependencies step as part of test-build. However whe=
n
> running as builders the docker images don't actually have network
> ability so couldn't download them.

Yes, having to "prepare", especially to download things, for each test
invocation is not resource friendly for CI too.

Fam
