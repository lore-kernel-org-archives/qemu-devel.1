Received: from eggs.gnu.org ([2001:4830:134:3::10]:47067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgWXR-000357-FS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgWXO-000754-Bn
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:00:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgWXO-00074W-64
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:00:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 956C780495
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 13:00:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 22 Feb 2017 13:42:30 +0100
Message-Id: <1487767351-9190-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] cirrus: add blit_is_unsafe call to
 cirrus_bitblt_cputovideo (CVE-2017-2620)
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

Here is the pull request for the cirrus cve
fix sent to the list yesterday.

please pull,
  Gerd

The following changes since commit 796b288f7be875045670f963ce99991b3c8e96ac:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-21 15:48:22 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-cve-2017-2620-20170222-1

for you to fetch changes up to c4cf7039465b0578035c4ec82f9f2519f7dceaf3:

  cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620) (2017-02-22 12:57:08 +0100)

----------------------------------------------------------------
cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620)

----------------------------------------------------------------
Gerd Hoffmann (1):
      cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620)

 hw/display/cirrus_vga.c | 8 ++++++++
 1 file changed, 8 insertions(+)
