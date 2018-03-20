Received: from eggs.gnu.org ([2001:4830:134:3::10]:43746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyGaC-0002Dc-8O
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyGa7-0006Ut-Tc
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:41:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyGa7-0006UU-P1
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:41:35 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 20 Mar 2018 12:41:15 +0000
Message-Id: <20180320124117.40573-1-dgilbert@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, jixiang_zhang@h3c.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 4bdc24fa018901892bb8a5bd1808ebd605f4c6=
4d:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-qapi-2018-03-12-v=
4' into staging (2018-03-20 09:51:49 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20180320

for you to fetch changes up to 95372184b7acdfd82ee748b6f0c6df1d839982ba:

  hmp: free sev info (2018-03-20 12:32:06 +0000)

----------------------------------------------------------------
HMP fixes for 2.12

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      hmp: free sev info

zhangjixiang (1):
      HMP: Initialize err before using

 hmp.c                 | 2 +-
 target/i386/monitor.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
