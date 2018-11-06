Received: from eggs.gnu.org ([2001:4830:134:3::10]:36478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK4ij-0007G0-PQ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK4VS-00035U-CU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:47:12 -0500
Date: Tue, 6 Nov 2018 17:46:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181106164649.GC4758@linux.fritz.box>
References: <20181105150806.13649-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105150806.13649-1-jcfaracco@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Adding LZFSE compression support
 for DMG block driver.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julio Faracco <jcfaracco@gmail.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

Am 05.11.2018 um 16:08 hat Julio Faracco geschrieben:
> Since Mac OS X El Capitain (v10.11), Apple uses LZFSE compression to 
> generate compressed DMGs as an alternative to BZIP2. Possible, Apple
> want to keep this algorithm as default in long term. Some years ago, 
> Apple opened the LZFSE algorithm to opensource and the main source (or 
> the most active repo), can be found at: https://github.com/lzfse/lzfse
> 
> v1-v2: Fixing some error handlings from dmg-lzfse.c
> v2-v3: Master rebasing suggestion from Stefan.

Thanks, applied to the block-next branch (for 3.2).

Stefan, if you have some more comments, we can still modify/dequeue the
patches, but this seems to address all of my review comments for v1.

Kevin
