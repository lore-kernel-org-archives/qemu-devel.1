Received: from eggs.gnu.org ([209.51.188.92]:36133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go9Su-0003sq-0d
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go9St-0005N9-Bp
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:08:52 -0500
Date: Mon, 28 Jan 2019 17:08:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128160830.GH5756@localhost.localdomain>
References: <20190125203402.18904-1-philmd@redhat.com>
	<1c788b0e-6a4b-f04f-b413-e7211fc62e85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1c788b0e-6a4b-f04f-b413-e7211fc62e85@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] ahci-test: Add dependency to qemu-img
 tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

Am 25.01.2019 um 22:57 hat John Snow geschrieben:
> On 1/25/19 3:34 PM, Philippe Mathieu-Daud=E9 wrote:
> > Since the ahci-test uses qemu-img, add a dependency to build it
> > before using it.
> > This fixes:
> >=20
> >   $ gmake check-qtest V=3D1
> >   QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IM=
G=3Dqemu-img tests/ahci-test
> >   Failed to execute child process "/tmp/qemu-test.19tMRF/qemu-img" (N=
o such file or directory)
> >   ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !e=
rr)
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> > RFC because while this dependency is valid, I don't think this is the
> > clever way to solve this problem (which is, assuming the host
> > distribution has the qemu-tools installed).
> > I guess remember a thread about it (Eric, John?) where it was asked
> > "What do we want to test, qemu-img or AHCI? Can we trust an unstable
> > version of a tool to verify a device?"
> >=20
> [...]
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>

Are you taking this through your tree, or through which tree should it
be merged?

Kevin
