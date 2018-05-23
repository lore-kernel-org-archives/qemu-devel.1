Received: from eggs.gnu.org ([2001:4830:134:3::10]:40251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLJsq-00077o-OU
	for qemu-devel@nongnu.org; Tue, 22 May 2018 22:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLJsq-0000nn-0v
	for qemu-devel@nongnu.org; Tue, 22 May 2018 22:52:12 -0400
Date: Wed, 23 May 2018 10:52:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180523025202.GI28114@lemon.usersys.redhat.com>
References: <20180518142605.19846-1-kwolf@redhat.com>
	<20180518142605.19846-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518142605.19846-2-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu-iotests: Fix paths for NFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Fri, 05/18 16:26, Kevin Wolf wrote:
> Test cases were trying to use nfs:// URLs as local filenames, which made
> every test fail for NFS. With TEST_IMG and TEST_IMG_FILE set like for
> the other protocols, NFS tests can pass again.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
