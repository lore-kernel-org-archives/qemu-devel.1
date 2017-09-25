Received: from eggs.gnu.org ([2001:4830:134:3::10]:45043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwcig-0001sQ-V3
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwcif-0003J8-Fy
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:23:22 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:50888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwcif-0003IR-AA
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:23:21 -0400
Received: by mail-wm0-x22d.google.com with SMTP id b195so2199985wmb.5
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:23:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2017 00:22:59 +0100
Message-ID: <CAFEAcA9GtLniZNyO7Uv=vL9HiSBGjvWRYdR-Zi1E+W4N9qiB6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/31] Trivial patches for 2017-09-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 24 September 2017 at 22:22, Michael Tokarev <mjt@tls.msk.ru> wrote:
> This is a collection of trivial stuff collected for quite some time.
> It includes various stuff, and just one series from
> Philippe Mathieu-Daud=C3=A9 (MAINTAINERS update), - other his series are
> in the works.
>
> Thanks,
>
> /mjt
>
> The following changes since commit 460b6c8e581aa06b86f59eebd9e52edfe7adf4=
17:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-09-23 12:55:40 +0100)
>
> are available in the git repository at:
>
>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>
> for you to fetch changes up to 97fb016a2aae686098f01d1c2dc194ed0f8e1c36:
>
>   hw/isa/pc87312: Mark the device with user_creatable =3D false (2017-09-=
25 00:09:11 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2017-09-25

This fails 'make check' on most of my configs:

  GTESTER check-qtest-ppc64
qemu-system-ppc64: -object
filter-mirror,id=3Dqtest-f0,netdev=3Dqtest-bn0,queue=3Dtx,outdev=3Dmirror0:
Device 'qtest-bn0' not found
Broken pipe
GTester: last random seed: R02Sb816ff80b7d08ef6a5328ff373d8cd65

GLib-CRITICAL **: void g_hook_destroy_link(GHookList *, GHook *):
assertion `hook !=3D NULL' failed
aborting...
  GTESTER check-qtest-ppcemb
  GTESTER check-qtest-s390x
qemu-system-s390x: -object
filter-mirror,id=3Dqtest-f0,netdev=3Dqtest-bn0,queue=3Dtx,outdev=3Dmirror0:
Device 'qtest-bn0' not found
Broken pipe
GTester: last random seed: R02S61c57a88e229192da22afbf90262d768

GLib-CRITICAL **: void g_hook_destroy_link(GHookList *, GHook *):
assertion `hook !=3D NULL' failed
aborting...
  GTESTER check-qtest-sh4
  GTESTER check-qtest-sh4eb
  GTESTER check-qtest-sparc
  GTESTER check-qtest-sparc64
  GTESTER check-qtest-tricore
  GTESTER check-qtest-unicore32
  GTESTER check-qtest-x86_64
qemu-system-x86_64: -object
filter-mirror,id=3Dqtest-f0,netdev=3Dqtest-bn0,queue=3Dtx,outdev=3Dmirror0:
Device 'qtest-bn0' not found
Broken pipe
GTester: last random seed: R02S2210aede2be05fdbaceb0c1e23378915

GLib-CRITICAL **: void g_hook_destroy_link(GHookList *, GHook *):
assertion `hook !=3D NULL' failed
aborting...
  GTESTER check-qtest-xtensa


thanks
-- PMM
