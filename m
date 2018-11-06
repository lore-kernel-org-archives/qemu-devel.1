Received: from eggs.gnu.org ([2001:4830:134:3::10]:36466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK4gx-0007Fy-FY
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK4aO-0003BY-Vd
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:52:17 -0500
Date: Tue, 6 Nov 2018 17:52:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181106165200.GD4758@linux.fritz.box>
References: <1541387096-19513-1-git-send-email-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541387096-19513-1-git-send-email-pizhenwei@bytedance.com>
Subject: Re: [Qemu-devel] [PATCH] blockdev: handle error on block latency
 histogram set error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: armbru@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 05.11.2018 um 04:04 hat zhenwei pi geschrieben:
> Function block_latency_histogram_set may return error, but qapi ignore this.
> This can be reproduced easily by qmp command:
> virsh qemu-monitor-command INSTANCE '{"execute":"x-block-latency-histogram-set",
> "arguments":{"device":"drive-virtio-disk1","boundaries":[10,200,40]}}'
> In fact this command does not work, but we still get success result.
> 
> qmp_x_block_latency_histogram_set is a batch setting API, report error ASAP.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Thanks, applied to the block branch.

Kevin
