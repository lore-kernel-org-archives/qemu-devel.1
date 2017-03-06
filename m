Received: from eggs.gnu.org ([2001:4830:134:3::10]:50249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckmwU-0003OT-IW
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckmwQ-0000ve-LA
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:20:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ckmwQ-0000vX-F2
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:20:22 -0500
Date: Mon, 6 Mar 2017 12:50:15 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <bd2e3c1d-0fa5-7be4-c223-81d87c87fe0c@redhat.com>
Message-ID: <alpine.LFD.2.20.1703061247550.22459@wniryva>
References: <20170303112503.32277-1-ppandit@redhat.com>
	<bd2e3c1d-0fa5-7be4-c223-81d87c87fe0c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] linux-user: limit number of arguments to
 execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>

  Hello Eric,

+-- On Fri, 3 Mar 2017, Eric Blake wrote --+
| much smaller, or you should consider using the heap instead of the stack
| (alloca should never be used for more than about 4k).  And there's still
| the possibility that even with your cap, that you are not handling E2BIG
| correctly.  You'll need to respin this patch.

  Yes, sent a revised patch set v2.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
