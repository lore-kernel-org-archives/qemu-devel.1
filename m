Received: from eggs.gnu.org ([2001:4830:134:3::10]:59055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUyLq-0002HG-BC
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUyLp-000761-EL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:49:30 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUyLp-00075p-7k
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:49:29 -0400
Received: by mail-wr0-x236.google.com with SMTP id c11so6869820wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 09:49:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
	<CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
	<7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
	<CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 17:49:07 +0100
Message-ID: <CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 11 July 2017 at 16:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 11 July 2017 at 16:07, Ben Warren <ben@skyportsystems.com> wrote:
>> Hi Peter,
>>> On Jul 11, 2017, at 6:32 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>>> Hi -- this test seems to intermittently fail:
>>>
>>> TEST: tests/vmgenid-test... (pid=3D15466)
>>>  /i386/vmgenid/vmgenid/set-guid:                                      *=
*
>>> ERROR:/home/peter.maydell/qemu/tests/vmgenid-test.c:65:acpi_find_vgia:
>>> assertion failed (ACPI_ASSERT_CMP
>>> _str =3D=3D "RSDT"): ("" =3D=3D "RSDT")
>>> FAIL
>>> GTester: last random seed: R02S27021da892f2124a377287729b848ff8
>>> (pid=3D15470)
>>>  /i386/vmgenid/vmgenid/set-guid-auto:                                 O=
K
>>>  /i386/vmgenid/vmgenid/query-monitor:                                 O=
K
>>> FAIL: tests/vmgenid-test
>>>
>>> (that's an aarch32 build).
>>>
>>>
>> I=E2=80=99ll try to reproduce.  How exactly are the tests called?
>
> 'make check V=3D1', same as usual.

The good news is it's not aarch64-specific. I just hit this on
a build on x86_64 host, gcc, debug build:

  GTESTER check-qtest-x86_64
**
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/vmgenid-test.c:65:acpi_fi=
nd_vgia:
assertion failed (ACPI_ASSERT_CMP_str =3D=3D "RSDT"): ("" =3D=3D "RSDT")
GTester: last random seed: R02S9eefaf38297e67e4f67d5db77989350e
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:826:
recipe for target 'check-qtest-x86_64' failed

thanks
-- PMM
