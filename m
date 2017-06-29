Received: from eggs.gnu.org ([2001:4830:134:3::10]:33996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQcKf-00072F-1N
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQcKd-0000hY-VX
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQcKd-0000h9-Py
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2B4CE254B
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 16:30:14 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-88.ams2.redhat.com
	[10.36.116.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 426ED900B9
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 16:30:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 29 Jun 2017 17:30:09 +0100
Message-Id: <20170629163011.13388-1-dgilbert@redhat.com>
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 454d7dc9bc13e46084e0612076e6952c40f4af=
eb:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into sta=
ging (2017-06-29 16:21:45 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20170629

for you to fetch changes up to bd1d5ad9f9a1347d6f4338f294253617c565c89a:

  Add chardev-send-break monitor command (2017-06-29 17:14:11 +0100)

----------------------------------------------------------------
HMP pull 2017-06-29

----------------------------------------------------------------
Stefan Fritsch (1):
      Add chardev-send-break monitor command

Suraj Jitindar Singh (1):
      monitor: Add -a (all) option to info registers

 chardev/char.c       | 12 ++++++++++++
 hmp-commands-info.hx |  6 +++---
 hmp-commands.hx      | 16 ++++++++++++++++
 hmp.c                |  8 ++++++++
 hmp.h                |  1 +
 monitor.c            | 21 ++++++++++++++++-----
 qapi-schema.json     | 20 ++++++++++++++++++++
 tests/test-char.c    | 12 ++++++++++--
 tests/test-hmp.c     |  1 +
 9 files changed, 87 insertions(+), 10 deletions(-)
