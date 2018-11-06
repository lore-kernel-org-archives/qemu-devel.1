Received: from eggs.gnu.org ([2001:4830:134:3::10]:50580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK0mr-0000i0-QD
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK0mq-00058o-UU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:48:53 -0500
Date: Tue, 6 Nov 2018 13:48:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181106124841.GB4758@linux.fritz.box>
References: <20181101062909.18833-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101062909.18833-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] file-posix: Use error API properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com

Am 01.11.2018 um 07:29 hat Fam Zheng geschrieben:
> Use error_report for situations that affect user operation (i.e.  we're
> actually returning error), and warn_report/warn_report_err when some
> less critical error happened but the user operation can still carry on.
> 
> For raw_normalize_devicepath, add Error parameter to propagate to
> its callers.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
