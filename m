Received: from eggs.gnu.org ([2001:4830:134:3::10]:51694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dV0Y1-0002L8-9j
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dV0Xw-0000b6-TY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:10:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dV0Xw-0000Yl-N7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:10:08 -0400
Date: Tue, 11 Jul 2017 22:10:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170711220915-mutt-send-email-mst@kernel.org>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
	<CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
	<7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
	<CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
	<CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/21] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Jul 11, 2017 at 05:49:07PM +0100, Peter Maydell wrote:
> On 11 July 2017 at 16:22, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> > On 11 July 2017 at 16:07, Ben Warren <ben@skyportsystems.com> wrote:
> >> Hi Peter,
> >>> On Jul 11, 2017, at 6:32 AM, Peter Maydell <peter.maydell@linaro.or=
g> wrote:
> >>> Hi -- this test seems to intermittently fail:
> >>>
> >>> TEST: tests/vmgenid-test... (pid=3D15466)
> >>>  /i386/vmgenid/vmgenid/set-guid:                                   =
   **
> >>> ERROR:/home/peter.maydell/qemu/tests/vmgenid-test.c:65:acpi_find_vg=
ia:
> >>> assertion failed (ACPI_ASSERT_CMP
> >>> _str =3D=3D "RSDT"): ("" =3D=3D "RSDT")
> >>> FAIL
> >>> GTester: last random seed: R02S27021da892f2124a377287729b848ff8
> >>> (pid=3D15470)
> >>>  /i386/vmgenid/vmgenid/set-guid-auto:                              =
   OK
> >>>  /i386/vmgenid/vmgenid/query-monitor:                              =
   OK
> >>> FAIL: tests/vmgenid-test
> >>>
> >>> (that's an aarch32 build).
> >>>
> >>>
> >> I=E2=80=99ll try to reproduce.  How exactly are the tests called?
> >
> > 'make check V=3D1', same as usual.
>=20
> The good news is it's not aarch64-specific. I just hit this on
> a build on x86_64 host, gcc, debug build:
>=20
>   GTESTER check-qtest-x86_64
> **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/vmgenid-test.c:65:acp=
i_find_vgia:
> assertion failed (ACPI_ASSERT_CMP_str =3D=3D "RSDT"): ("" =3D=3D "RSDT"=
)
> GTester: last random seed: R02S9eefaf38297e67e4f67d5db77989350e
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:826:
> recipe for target 'check-qtest-x86_64' failed
>=20
> thanks
> -- PMM

Couldn't reproduce here. I suspect VM didn't start at all.
Am I right to assume this is without KVM?

--=20
MST
