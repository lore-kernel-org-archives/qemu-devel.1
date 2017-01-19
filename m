Received: from eggs.gnu.org ([2001:4830:134:3::10]:35732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvg-000719-7b
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvd-0004s8-08
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:32 -0500
Received: from mail.kernel.org ([198.145.29.136]:56158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvc-0004qo-Pf
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:28 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id AAF4820547
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 21:07:26 +0000 (UTC)
Received: from redhat.com (unknown [66.187.232.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9C67620373
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 21:07:25 +0000 (UTC)
Date: Thu, 19 Jan 2017 23:07:24 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484859998-25074-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v3 0/4] ARRAY_SIZE fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Turns out virtio kept using ARRAY_SIZE on fields which stopped
being arrays, this was noticed by a coverity scan.
I fixed this up, this patchset fixes up the ARRAY_SIZE macro so that this
bug does not reappear in any other place.

changes from v2:
    - dropped the merged virtio patch
    - whitespace changes
    - rewrote BUG_ON macros from an array to a struct for portability

Michael S. Tsirkin (4):
  compiler: drop ; after BUILD_BUG_ON
  compiler: rework BUG_ON using a struct
  compiler: expression version of QEMU_BUILD_BUG_ON
  ARRAY_SIZE: check that argument is an array

 include/qemu/compiler.h | 11 +++++++++--
 include/qemu/osdep.h    |  9 ++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
MST
