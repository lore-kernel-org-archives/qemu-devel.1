Received: from eggs.gnu.org ([2001:4830:134:3::10]:38271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1tZh-0004DU-Oj
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1tZg-0001xa-O0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:23:53 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:43428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1tZg-0001xB-Gl
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:23:52 -0400
Received: by mail-wm0-x22e.google.com with SMTP id m72so15636849wmc.0
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 05:23:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 13:23:30 +0100
Message-ID: <CAFEAcA9iZauiFoFU9G3cjGAha7W-7EXoVSTixujeWRXL0M-oXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/23] Queued TCG patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 October 2017 at 01:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
> One trivial cleanup from Jiang.  Cherry-picking half of Emilio's
> patch set that has been reviewed.
>
>
> r~
>
>
> The following changes since commit 530049bc1dcc24c1178a29d99ca08b6dd08413=
e0:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2017-10-06 17:43:02 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20171009
>
> for you to fetch changes up to 5de8a6a471ba6b86c6b4fb681e5a3c594ed5a684:
>
>   tcg/mips: delete commented out extern keyword. (2017-10-09 17:07:32 -07=
00)
>
> ----------------------------------------------------------------
> Queued tcg patches
>
> ----------------------------------------------------------------

This fails to build on w32, I'm afraid:

/home/petmay01/linaro/qemu-for-merges/util/osdep.c:85:22: error:
format =E2=80=98%d=E2=80=99 expects argument of type =E2=80=98int=E2=80=99,=
 but argument 3 has type
=E2=80=98DWORD {aka long unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
         error_report("%s: VirtualProtect failed with error code %d",
                      ^


and on aarch32 host, the alpha bios boot test fails:

QTEST_QEMU_BINARY=3Dalpha-softmmu/qemu-system-alpha QTEST_QEMU_IMG=3Dqemu-i=
mg MALLOC
_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} gtester -k --v=
erbose
-m=3Dquick tests/boot-serial-test tests/qmp-test tests/device-introspect-te=
st test
s/qom-test tests/test-hmp
TEST: tests/boot-serial-test... (pid=3D20893)
  /alpha/boot-serial/clipper:                                          **
ERROR:/home/peter.maydell/qemu/tests/boot-serial-test.c:68:check_guest_outp=
ut: a
ssertion failed: (output_ok)
FAIL
GTester: last random seed: R02Sa8d34a40641001b23d1e3c2a89a29b09
(pid=3D20898)
FAIL: tests/boot-serial-test


thanks
-- PMM
