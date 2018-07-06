Received: from eggs.gnu.org ([2001:4830:134:3::10]:51039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK3-0001D0-Ek
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUJz-0000kU-1m
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fbUJy-0000k7-Qp
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id u7-v6so4868805wrn.12
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:15:02 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	h40-v6sm13784683wrf.40.2018.07.06.10.15.00
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Jul 2018 10:15:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Jul 2018 19:14:20 +0200
Message-Id: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/8] Bug fixes for 2018-07-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 2a018f6e98782a4931b936a3087404ed81685bac:

  Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-request' into staging (2018-07-03 23:06:18 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e20122ff0faf07cb701d35e39e106d1783c07725:

  checkpatch: handle token pasting better (2018-07-06 18:39:19 +0200)

----------------------------------------------------------------
Bug fixes.

----------------------------------------------------------------
Greg Kurz (1):
      i386: fix '-cpu ?' output for host cpu type

Julia Suvorova (1):
      qtest: Use cpu address space instead of system memory

Michal Privoznik (1):
      pr-helper: Rework socket path handling

Paolo Bonzini (4):
      pr-helper: avoid error on PR IN command with zero request size
      pr-manager-helper: fix memory leak on event
      ioapic: remove useless lower bounds check
      checkpatch: handle token pasting better

xinhua.Cao (1):
      qemu-char: check errno together with ret < 0

 chardev/char-socket.c    |  7 +++-
 hw/intc/ioapic.c         |  2 +-
 qtest.c                  | 39 ++++++++++++-------
 scripts/checkpatch.pl    |  9 ++---
 scsi/pr-manager-helper.c |  1 +
 scsi/qemu-pr-helper.c    | 99 +++++++++++++++++++-----------------------------
 target/i386/cpu.c        | 14 +++----
 7 files changed, 84 insertions(+), 87 deletions(-)
-- 
1.8.3.1
