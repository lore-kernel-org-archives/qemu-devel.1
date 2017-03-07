Received: from eggs.gnu.org ([2001:4830:134:3::10]:46677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clEPA-0001ej-VI
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clEPA-0006aj-Ac
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:39:52 -0500
Date: Tue, 7 Mar 2017 13:39:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170307123944.GK5871@noname.str.redhat.com>
References: <20170307110722.12583-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307110722.12583-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block: More robust error handling
 around perm check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 07.03.2017 um 12:07 hat Fam Zheng geschrieben:
> v2: Fix error handling in both patches. [Kevin]
> 
> These are a couple cases added with the op blocker changes, where errp is
> available but we still use error_abort. Fix them for obvious reasons.

Thanks, applied to the block branch.

Kevin
