Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW4tu-0006AP-4d
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW4tp-00037C-7c
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:28:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cW4tp-00036m-21
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:28:53 -0500
Date: Tue, 24 Jan 2017 19:28:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170124192723-mutt-send-email-mst@kernel.org>
References: <CAF++6APW69OBEzfUaWXK-kXLY5euu8aJjvFrYzwFT1tes-W=gA@mail.gmail.com>
	<CAFEAcA-aEA9cNzd6cJchrdojyX7xKr4eOKECkMEen=fhGucCPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-aEA9cNzd6cJchrdojyX7xKr4eOKECkMEen=fhGucCPA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] changeset b0cb0a66d broken - missing
 QEMU_OPTION_enable_hax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: James Hanley <jhanley@dgtlrift.com>, Vincent Palatin <vpalatin@chromium.org>, qemu-devel <qemu-devel@nongnu.org>

On Mon, Jan 23, 2017 at 07:41:48PM +0000, Peter Maydell wrote:
> On 23 January 2017 at 19:32, James Hanley <jhanley@dgtlrift.com> wrote:
> > Changeset fails to compile:
> >
> > qemu/vl.c:3683:18: error: =E2=80=98QEMU_OPTION_enable_hax=E2=80=99 un=
declared (first use in
> > this function)
> >              case QEMU_OPTION_enable_hax:
> >                   ^
> > I assume that there is details in
> >
> > ./qemu-options.def
> > ./qemu-options.hx
> >
> > that were not included with the commit?
>=20
> Your source tree probably has a stale qemu-options.def in it
> from an attempt to do an in-tree build at some point in the
> past (and now you are doing out-of-tree builds). If you do a
> 'make distclean' in the source tree this will get rid of the
> stale junk and the build should work. (Or you can just git
> clone a fresh tree; or attempt to more carefully remove
> individual stale stuff, but that risks leaving some other
> stale file around.)
>=20
> (The change to qemu-options.hx is sufficient, because we
> generate qemu-options.def from it in the build tree; but
> if you have a stale .def file in the source tree then
> gcc will pick that one up before the one in the build tree;
> which works until something requires a change that postdates
> the stale stuff.)
>=20
> thanks
> -- PMM

Maybe we should change the include order to always prefer
the build tree files if there?
An alternative is to do what Linux does, create a
file in tree when doing a build, and then make an
out of tree one fail and suggest distclean.

--=20
MST
