Received: from eggs.gnu.org ([2001:4830:134:3::10]:38980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1daiEu-0000jc-Pf
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1daiEu-00035m-4p
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:50:04 -0400
Date: Thu, 27 Jul 2017 20:49:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170727124952.GL5117@lemon.lan>
References: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/8] Optimize VMDK I/O by allocating
 multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@gmail.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

On Thu, 06/29 14:53, Ashijeet Acharya wrote:
> Changes in v7:
> - comment the use of MIN() in calculating skip_end_bytes
> - use extent->cluster_sectors instead of 128
> - place check for m_data != NULL
> - use g_new0(VmdkMetaData, 1) instead of g_malloc0(sizeof(*m_data))

There is a minor regression as I replied inline, otherwise:

Reviewed-by: Fam Zheng <famz@redhat.com>
