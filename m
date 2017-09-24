Received: from eggs.gnu.org ([2001:4830:134:3::10]:60243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwB5i-0008Jk-Ov
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 13:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwB5i-000845-7k
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 13:53:18 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:53212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dwB5i-00082i-06
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 13:53:18 -0400
Date: Sun, 24 Sep 2017 19:53:14 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170924175314.zersnursl7wegobo@var.youpi.perso.aquilenet.fr>
References: <20170920204205.40191-1-cernekee@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920204205.40191-1-cernekee@chromium.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] slirp: Fix intermittent send queue
 hangs on a socket
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

Hello,

Kevin Cernekee, on mer. 20 sept. 2017 13:42:04 -0700, wrote:
> if_output() originally sent one mbuf per call and used the slirp->next_m
> variable to keep track of where it left off.  But nowadays it tries to
> send all of the mbufs from the fastq, and one mbuf from each session on
> the batchq.  The next_m variable is both redundant and harmful: there is
> a case[0] involving delayed packets in which next_m ends up pointing
> to &slirp->if_batchq when an active session still exists, and this
> blocks all traffic for that session until qemu is restarted.

That also makes things simpler, I applied it to my tree, thanks!

Samuel
