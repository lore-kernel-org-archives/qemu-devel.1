Received: from eggs.gnu.org ([2001:4830:134:3::10]:41615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4Pm-00054L-Dj
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4Pl-0006i5-KA
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:12:22 -0400
References: <20180727141539.506-1-kwolf@redhat.com>
	<20180727141539.506-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89a2b536-0b00-b6f1-74d8-2c9f4748fa0c@redhat.com>
Date: Fri, 27 Jul 2018 10:12:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180727141539.506-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 3/3] qemu-iotests: Test
 query-blockstats with -drive and -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

On 07/27/2018 09:15 AM, Kevin Wolf wrote:
> Make sure that query-blockstats returns information for every
> BlockBackend that is named or attached to a device model (or both).

Needed for libvirt switching over to -blockdev, so even though we're 
rather late in the 3.0 cycle, I can understand it going in now.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/tests/qemu-iotests/227.out
> @@ -0,0 +1,42 @@
> +QA output created by 227
> +
> +=== blockstats with -drive if=virtio ===
> +
> +Testing: -drive driver=null-co,if=virtio
> +QMP_VERSION
> +{"return": {}}
> +{"return": [{"device": "virtio0", "stats": {"flush_total_time_ns": 0, "wr_highest_offset": 0, "wr_total_time_ns": 0, "failed_wr_operations": 0, "failed_rd_operations": 0, "wr_merged": 0, "wr_bytes": 0, "timed_stats": [], "failed_flush_operations": 0, "account_invalid": true, "rd_total_time_ns": 0, "flush_operations": 0, "wr_operations": 0, "rd_merged": 0, "rd_bytes": 0, "invalid_flush_operations": 0, "account_failed": true, "rd_operations": 0, "invalid_wr_operations": 0, "invalid_rd_operations": 0}, "node-name": "NODE_NAME", "qdev": "/machine/peripheral-anon/device[0]/virtio-backend"}]}

Long lines. Would it be worth writing the test to use QMP pretty mode?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
