Received: from eggs.gnu.org ([2001:4830:134:3::10]:40149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgW5a-0005Rt-7t
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgW5Y-00084A-Ub
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:32:09 -0500
Date: Wed, 22 Feb 2017 13:31:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170222123158.GJ4112@noname.str.redhat.com>
References: <20170217005127.21010-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217005127.21010-1-nirsof@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-img raw preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 17.02.2017 um 01:51 hat Nir Soffer geschrieben:
> This series add missing tests for raw image preallocation, refine
> preallocation=full and improve documentation.
> 
> Create on top of the commit	10ddfe7b6044 (qemu-img: Do not truncate
> before preallocation) from Kevin block branch.

Thanks, applied to the block branch.

I changed the commit message of patch 2 so that it doesn't mention the
commit ID. This is because the commit ID is only stable once the commit
has made it into master. I also added a few words ("...so don't do that
here") to the comment in patch 3 because outside the context of the
patch, talking about a truncation seemed weird when there is no
truncation happening. I hope you're okay with these changes.

Kevin
