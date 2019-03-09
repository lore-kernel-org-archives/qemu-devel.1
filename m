Received: from eggs.gnu.org ([209.51.188.92]:35119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2Uvj-0004Oa-5R
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 00:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2Uvi-0004cb-1o
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 00:53:55 -0500
Received: from m12-12.163.com ([220.181.12.12]:49824)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2Uvh-0004VM-0w
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 00:53:53 -0500
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Sat, 9 Mar 2019 13:53:32 +0800
Message-Id: <5C8354E3.03C6BB.09225@m12-12.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] 'make check' error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "cota@braap.org" <cota@braap.org>

Hi all,=20

Today I =E2=80=98git clone=E2=80=99 && configure && make && make check=20

And get following error,=20

fp-test.c:50:10: fatal error: fail.h: No such file or directory
 #include "fail.h"
          ^~~~~~~~

I look at the commit:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D3ac1f81329f4dfdc10a51=
e180f9cf28dbcb02a3c;hp=3Db44b5abeae4a3b54ccbd7137f59c0a8923cecec9

Seems it=E2=80=99s old commit, I think I got =E2=80=98make check=E2=80=99 w=
ork after this commit.
So I don=E2=80=99t know anywhere wrong.

Any hints?

Thanks,
Li Qiang
