Received: from eggs.gnu.org ([2001:4830:134:3::10]:60389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwB6o-0000Q9-6r
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 13:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwB6n-0008Sy-Jd
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 13:54:26 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:53219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dwB6n-0008Sf-Cx
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 13:54:25 -0400
Date: Sun, 24 Sep 2017 19:54:23 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170924175423.kbahj3bxjhldrdc4@var.youpi.perso.aquilenet.fr>
References: <20170920204205.40191-1-cernekee@chromium.org>
	<20170920204205.40191-2-cernekee@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920204205.40191-2-cernekee@chromium.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Add a special case for the NULL
 socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Cernekee <cernekee@chromium.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

Kevin Cernekee, on mer. 20 sept. 2017 13:42:05 -0700, wrote:
> NULL sockets are used for NDP, BOOTP, and other critical operations.
> If the topmost mbuf in a NULL session is blocked pending resolution,
> it may cause problems if it blocks other packets with a NULL socket.
> So do not add mbufs with a NULL socket field to the same session.

That makes a lot of sense indeed, applied to my tree.

Thanks!
Samuel
