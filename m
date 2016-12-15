Received: from eggs.gnu.org ([2001:4830:134:3::10]:39642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHNlh-0002iI-J6
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 23:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHNle-0004Cq-KB
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 23:35:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cHNle-0004CU-56
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 23:35:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 783F7C04B926
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 04:35:40 +0000 (UTC)
Date: Thu, 15 Dec 2016 06:35:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161215063226-mutt-send-email-mst@kernel.org>
References: <20161214142518.10504-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214142518.10504-1-stefanha@redhat.com>
Subject: [Qemu-devel] regression in 2.8: unable to exit screen grab in SDL
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The problem always reproduces for me:
- start qemu with -sdl
- wait for guest to boot
- click anywhere within guest screen
- message "press ctrl+alt to exit capture" appears on screen,
  but pressing that immediately restarts capture again

Note:
- had to exit to another VT and kill qemu
- why was I able to do that?
  should not ctrl-alt-Fn be captured too?

-- 
MST
