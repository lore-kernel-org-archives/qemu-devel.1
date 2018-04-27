Received: from eggs.gnu.org ([2001:4830:134:3::10]:47412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBwoS-0008R1-6g
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBwoR-0002eW-CA
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:24:56 -0400
Date: Fri, 27 Apr 2018 14:24:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180427062447.GF4217@lemon.usersys.redhat.com>
References: <20180420220913.27000-1-mreitz@redhat.com>
	<20180420220913.27000-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420220913.27000-4-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Add creation test to 153
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Sat, 04/21 00:09, Max Reitz wrote:
> This patch adds a test case to 153 which tries to overwrite an image
> (using qemu-img create) while it is in use.  Without the original user
> explicitly sharing the necessary permissions (writing and truncation),
> this should not be allowed.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
