Received: from eggs.gnu.org ([2001:4830:134:3::10]:51594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEeue-0008H0-A7
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEeud-0001br-HM
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:17:44 -0500
Date: Wed, 7 Dec 2016 17:17:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207161736.GI4773@noname.str.redhat.com>
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202192223.15153-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org

Am 02.12.2016 um 20:22 hat Eric Blake geschrieben:
> Rather than store into a local variable, the copy to the struct
> if the value is valid, then reporting errors otherwise, it is
> simpler to just store into the struct and report errors if the
> value is invalid.  This however requires that the struct store
> a 64-bit number, rather than a narrower type.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
