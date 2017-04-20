Received: from eggs.gnu.org ([2001:4830:134:3::10]:54241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d18T0-00085F-53
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d18Sz-0007QU-8a
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:33:34 -0400
Date: Thu, 20 Apr 2017 11:33:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170420093325.GA4747@noname.redhat.com>
References: <1492679992-7805-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492679992-7805-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: check bs_n when use old style
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

Am 20.04.2017 um 11:19 hat jemmy858585@gmail.com geschrieben:
> From: Lidong Chen <lidongchen@tencent.com>
> 
> When use old style option like -o backing_file, img_convert
> continue run when bs_n > 1, this patch fix this bug.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

I think this is a duplicate of Max' "[PATCH for-2.10 3/3]
qemu-img/convert: Move bs_n > 1 && -B check down".

Also, -B is the old-style option, not -o backing_file.

Kevin
