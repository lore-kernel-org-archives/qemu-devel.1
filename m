Received: from eggs.gnu.org ([2001:4830:134:3::10]:49647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcqsu-0002Tl-Ge
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcqst-0006bf-Ku
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:28:12 -0400
Date: Wed, 2 Aug 2017 12:27:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170802102759.GA3649@localhost.localdomain>
References: <20170801213127.15036-1-crosa@redhat.com>
	<20170801213127.15036-2-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170801213127.15036-2-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] qemu-iotests/109: Fix lock race
 condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

Am 01.08.2017 um 23:31 hat Cleber Rosa geschrieben:
> A race condition is currently present between the clean up attempt of
> the QEMU process and the execution of qemu-img.  The actual (bad)
> output is:
> 
>  -Warning: Image size mismatch!
>  -Images are identical.
>  +qemu-img: Could not open '<build_dir>/tests/qemu-iotests/scratch/t.raw': Failed to get "consistent read" lock
>  +Is another process using the image?
> 
> A KILL signal is sent to the QEMU process, but qemu-img may begin to
> run before the QEMU process is really gone.  qemu-img will then
> attempt to open the TEST_IMG file before it can secure a lock on it.
> 
> This attempts a more graceful shutdown, and waits for the QEMU process
> to exit.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Thanks, applied to the block branch.

Kevin
