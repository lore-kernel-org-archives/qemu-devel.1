Received: from eggs.gnu.org ([2001:4830:134:3::10]:43432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZIwk-00006z-Hb
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZIwh-0002qt-Bh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:05:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZIwh-0002qZ-6a
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:05:11 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50566C04D2F2
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 15:05:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  2 Feb 2017 16:05:03 +0100
Message-Id: <1486047907-26685-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] cirrus: multiple bugfixes,
 including CVE-2017-2615 fix.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Here is the vga patch queue, finally bringing the cirrus fixes.

Pull v2 fixes the review and message id lines in patch #4.
No code changes.

please pull,
  Gerd

The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-vga-20170202-2

for you to fetch changes up to 62d4c6bd5263bb8413a06c80144fc678df6dfb64:

  cirrus: fix oob access issue (CVE-2017-2615) (2017-02-02 15:58:23 +0100)

----------------------------------------------------------------
cirrus: multiple bugfixes, including CVE-2017-2615 fix.

----------------------------------------------------------------
Gerd Hoffmann (1):
      cirrus: fix blit address mask handling

Li Qiang (1):
      cirrus: fix oob access issue (CVE-2017-2615)

Wolfgang Bumiller (2):
      cirrus: handle negative pitch in cirrus_invalidate_region()
      cirrus: allow zero source pitch in pattern fill rops

 hw/display/cirrus_vga.c | 64 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 25 deletions(-)
