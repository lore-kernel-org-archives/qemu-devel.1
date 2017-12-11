Received: from eggs.gnu.org ([2001:4830:134:3::10]:37442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eOLG2-0007h4-Ok
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eOLG1-00023y-Ug
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:24:22 -0500
References: <20171128121055.6954-1-den@openvz.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <8db8f0b0-90a7-e4c0-d76a-2383ac790048@openvz.org>
Date: Mon, 11 Dec 2017 13:24:08 +0300
MIME-Version: 1.0
In-Reply-To: <20171128121055.6954-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for 2.11 0/2] QEMU crashes with CD device
 without media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 11/28/2017 03:10 PM, Denis V. Lunev wrote:
> There are 2 cases I have spotted so far:
> 1) IDE ATAPI read processing. Actually this was reported from field
> 2) QEMU IO hmp command (found during evaluation of (1))
>
> SCSI code checks during access that blk_is_available(). These patches add
> same checks on different code paths.
>
> Pls decide whether these patches should go through sub-system trees or via
> block tree.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: John Snow <jsnow@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
>
any decision on this?
