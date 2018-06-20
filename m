Received: from eggs.gnu.org ([2001:4830:134:3::10]:48154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVaxn-00036F-EO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVaxk-0007bk-Bb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:07:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVaxk-0007bE-6j
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:07:44 -0400
Date: Wed, 20 Jun 2018 13:07:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180620110741.gdywesuqbyhjs4hd@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] regression: sata cdrom boot broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

  Hi,

$subject says all.  Noticed while testing the upcoming seabios update.
Reproducer:

  qemu-system-x86_64 -M q35 -m 4G -cdrom Fedora-Workstation-Live-x86_64-28-1.1.iso

bisected to:

  commit 956556e131e35f387ac482ad7b41151576fef057
  Author: John Snow <jsnow@redhat.com>
  Date:   Wed Jun 6 15:09:50 2018 -0400

    ahci: move PIO Setup FIS before transfer, fix it for ATAPI commands

cheers,
  Gerd
