Received: from eggs.gnu.org ([2001:4830:134:3::10]:58424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cddf6-0006kt-M3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cddf2-0007O6-KZ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:00:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cddf2-0007NR-EP
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:00:52 -0500
Date: Tue, 14 Feb 2017 22:00:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214140049.GB12294@lemon.lan>
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170214100733.22280-3-alex.bennee@linaro.org>
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
Cc: qemu-devel@nongnu.org

On Tue, 02/14 10:07, Alex Benn=E9e wrote:
> This provides a basic Debian install with access to the emdebian cross
> compilers. The debian-armhf-cross and debian-arm64-cross targets build
> on the basic Debian image to allow cross compiling to those targets.
>=20
> To build against the cross compiler a cross-compile prefix needs to be
> set in the configure options, for example:
>=20
>   make docker-test-build@debian-arm64-cross \
>     EXTRA_CONFIGURE_OPTS=3D"--cross-prefix=3Daarch64-linux-gnu-" \
>     TARGET_LIST=3D"aarch64-softmmu,aarch64-linux-user"

If cross-compile is the only meaningful way to use this image, we probabl=
y
should bake the configure option into the dockerfile and pick it up
automatically in common.rc.  What do you think?

Fam
