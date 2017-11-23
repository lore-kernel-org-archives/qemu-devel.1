Received: from eggs.gnu.org ([2001:4830:134:3::10]:40053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHlsQ-00087X-M7
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 02:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHlsP-0005rU-Tp
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 02:24:50 -0500
Date: Thu, 23 Nov 2017 15:24:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171123072438.GE1624@lemon>
References: <20171123020832.8165-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/17] iotests: Fix iotests for weird
 formats/options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Thu, 11/23 03:08, Max Reitz wrote:
> (I hate to write Python tests because the boilerplate seems so large and
>  the debugging is so hard.  But there is test 194 which shows that it is
>  possible to write simple bash-like tests as well--and that is how I
>  should probably write tests from now on.)

If the boilerplate means copy&paste from another test it is not a big problem;
if you really mean it's more cumbersome than bash to write test code, I think we
can try new ways to exploit Python's expressiveness. 2c93c5cb43 and f4844ac0ad
are good examples.

So what do you think about debugging? IMO the biggest problem is the less
verbose reference output, and lack of a separate logging channel. We can and
should improve that, even for existing scripts.

And yes, the 194 style is actually better than "iotests.QMPTestCase" ones.

Fam
