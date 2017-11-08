Received: from eggs.gnu.org ([2001:4830:134:3::10]:57758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCGb7-00015C-VH
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCGb4-00076Q-V9
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:00:14 -0500
Date: Wed, 8 Nov 2017 11:00:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171108030003.GB2834@lemon>
References: <20171108024719.8389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171108024719.8389-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: correctly escape $BACKEND in the
 help output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Tue, 11/07 23:47, Philippe Mathieu-Daud=E9 wrote:
> In Makefiles the $ must be escaped as $$ in shell uses.
>=20
> Since 8a2390a4f47:
>=20
>  $ make docker
>      [...]
>      NETWORK=3D1            Enable virtual network interface with defau=
lt backend.
>      NETWORK=3DACKEND     Enable virtual network interface with ACKEND.
>=20
> Once escaped:
>=20
>  $ make docker
>      [...]
>      NETWORK=3D1            Enable virtual network interface with defau=
lt backend.
>      NETWORK=3D$BACKEND     Enable virtual network interface with $BACK=
END.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Queued, thanks!

Fam
