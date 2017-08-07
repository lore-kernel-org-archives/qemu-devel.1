Received: from eggs.gnu.org ([2001:4830:134:3::10]:41647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dejtA-00005E-Kd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dejt5-00032x-SJ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:24:16 -0400
Date: Mon, 7 Aug 2017 17:23:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170807152351.GH6578@localhost.localdomain>
References: <20170804140942.19342-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804140942.19342-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] vmdk: Fix error
 handling/reporting of vmdk_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 04.08.2017 um 16:09 hat Fam Zheng geschrieben:
> Errors from the callees must be captured and propagated to our caller,
> ensure this for both find_extent() and bdrv_getlength().
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
