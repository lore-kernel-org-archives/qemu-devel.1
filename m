Received: from eggs.gnu.org ([2001:4830:134:3::10]:53871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duV8g-0001et-Pa
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duV8c-0001rt-TT
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1duV8c-0001pn-NW
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:53:22 -0400
Date: Wed, 20 Sep 2017 10:53:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170920025317.GC18491@lemon>
References: <20170919072719.11815-1-famz@redhat.com>
	<20170919072719.11815-7-famz@redhat.com>
	<874lryen8n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <874lryen8n.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 06/13] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com

On Tue, 09/19 16:12, Alex Benn=E9e wrote:
> Could we also do something about locales in this setup. The build gives
> a lot of noise like:
>=20
>     perl: warning: Falling back to a fallback locale ("en_US.UTF-8").
>     perl: warning: Setting locale failed.
>     perl: warning: Please check that your locale settings:
>             LANGUAGE =3D (unset),
>             LC_ALL =3D "en_GB.UTF-8",
>             LC_TIME =3D "en_US.UTF-8",
>             LC_CTYPE =3D "en_GB.UTF-8",
>             LC_MONETARY =3D "en_US.UTF-8",
>             LC_COLLATE =3D "C",
>             LC_ADDRESS =3D "en_US.UTF-8",
>             LC_TELEPHONE =3D "en_US.UTF-8",
>             LC_NAME =3D "en_US.UTF-8",
>             LC_MEASUREMENT =3D "en_US.UTF-8",
>             LC_IDENTIFICATION =3D "en_US.UTF-8",
>             LC_NUMERIC =3D "en_US.UTF-8",
>             LC_PAPER =3D "en_US.UTF-8",
>             LANG =3D "en_US.UTF-8"
>         are supported and installed on your system.

Not sure how en_GB gets into the guest (I assume it is from your host env=
, so
it's SSH?). I'll add a locale directive in the cloud-init file anyway.

Fam
