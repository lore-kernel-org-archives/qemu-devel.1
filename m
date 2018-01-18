Received: from eggs.gnu.org ([2001:4830:134:3::10]:38158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecGaG-0006lV-46
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecGaB-0007rF-LT
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:14:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecGaB-0007qp-FD
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:14:43 -0500
Date: Thu, 18 Jan 2018 18:14:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180118201439.GD5292@localhost.localdomain>
References: <20180118021000.27203-1-ehabkost@redhat.com>
	<CAFEAcA_JX_eevQL3kM2Kvf_Z3+xTiDRkg6C-EknfMtj_-cRA1g@mail.gmail.com>
	<3dc09f5a-241a-728f-2051-393010049f1d@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3dc09f5a-241a-728f-2051-393010049f1d@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/19] machine queue, 2018-01-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 18, 2018 at 12:36:19PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 01/18/2018 12:22 PM, Peter Maydell wrote:
> > On 18 January 2018 at 02:09, Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
> >> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42a=
e7ada7c:
> >>
> >>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' =
into staging (2018-01-16 17:36:39 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >>
> >> for you to fetch changes up to 901cc8d31f36ac82824ab68f656ab70504041=
00c:
> >>
> >>   fw_cfg: fix memory corruption when all fw_cfg slots are used (2018=
-01-17 23:04:37 -0200)
> >>
> >> ----------------------------------------------------------------
> >> machine queue, 2018-01-18
> >>
> >> ----------------------------------------------------------------
> >=20
> > Hi. I'm afraid this doesn't build on 32-bit hosts, due to a
> > format string problem:
> >=20
> > In file included from /home/peter.maydell/qemu/exec.c:20:0:
> > /home/peter.maydell/qemu/exec.c: In function 'file_ram_alloc':
> > /home/peter.maydell/qemu/include/qapi/error.h:162:25: error: format
> > '%llx' expects argument of type 'long long unsigned int', but argumen=
t
> > 7 has type 'size_t {aka unsigned int}' [-Werror=3Dformat=3D]
> >                          (fmt), ## __VA_ARGS__)
> >                          ^
> > /home/peter.maydell/qemu/exec.c:1616:9: note: in expansion of macro '=
error_setg'
> >          error_setg(errp, "aligment 0x%" PRIx64
> >          ^
>=20
> Eduardo you can quickly check that running:
>=20
>   $ make docker-test-build@debian-win32-cross
>   (or use the debian-armel-cross image, but win32 is often weirder)
>=20
> I hope one day compiler get smart enough to automatically fix those
> mistakes :)

Reproduced using "make docker-test-build@debian-armel-cross".

--=20
Eduardo
