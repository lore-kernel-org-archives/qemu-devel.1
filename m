Received: from eggs.gnu.org ([2001:4830:134:3::10]:39117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9GbK-0007tO-EN
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9GbH-0006HO-As
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9GbH-0006H9-4l
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:23:59 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 30 Oct 2017 20:23:54 +0000
Message-Id: <20171030202356.11047-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, groug@kaod.org, lu.zhipeng@zte.com.cn

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit abf6e752e55b2f5afb48303429dea2db7c3a62=
de:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20171030' =
into staging (2017-10-30 13:02:45 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20171030

for you to fetch changes up to 751f8cfe2a556b3ef49f6af2860e2d1d2a1ec66a:

  monitor: fix dangling CPU pointer (2017-10-30 18:46:32 +0000)

----------------------------------------------------------------
hmp pull 2017-10-30

----------------------------------------------------------------
Greg Kurz (1):
      monitor: fix dangling CPU pointer

ZhiPeng Lu (1):
      hmp: Replace error_report_err

 hmp.c     | 26 ++++++++------------------
 monitor.c | 23 ++++++++++++++++++-----
 2 files changed, 26 insertions(+), 23 deletions(-)
