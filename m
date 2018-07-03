Received: from eggs.gnu.org ([2001:4830:134:3::10]:41711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faK8U-0004gP-0p
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faK8R-0001rs-As
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:10:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faK8Q-0001rL-WB
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 538D3308FB9D
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 12:10:18 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 14:10:10 +0200
Message-Id: <20180703121013.12126-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Audio 20180703 patches
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

The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c6=
56:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into =
staging (2018-07-02 17:57:46 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20180703-pull-request

for you to fetch changes up to 1a961e785f59eba1fa8e06d5b1ebc84927b4b3a3:

  audio: add audio timer trace points (2018-07-03 11:46:47 +0200)

----------------------------------------------------------------
audio: hda fixes, timer tracing

----------------------------------------------------------------

Gerd Hoffmann (3):
  audio/hda: adjust larger gaps faster
  audio/hda: fix CID 1393631
  audio: add audio timer trace points

 audio/audio.c        | 28 +++++++++++++++++++++++++---
 hw/audio/hda-codec.c |  5 ++++-
 audio/trace-events   |  5 +++++
 3 files changed, 34 insertions(+), 4 deletions(-)

--=20
2.9.3
