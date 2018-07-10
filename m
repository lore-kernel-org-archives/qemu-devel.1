Received: from eggs.gnu.org ([2001:4830:134:3::10]:58504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fctmB-0000Ip-37
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fctm6-0007IY-HA
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:37:59 -0400
Date: Tue, 10 Jul 2018 11:37:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180710143751.GI7451@localhost.localdomain>
References: <20180710105129.23296-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710105129.23296-1-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH] hw/machine: Remove the Zero check of
 nb_numa_nodes for numa_complete_configuration() follow-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, imammedo@redhat.com

On Tue, Jul 10, 2018 at 06:51:29PM +0800, Dou Liyang wrote:
> This Commit 7747abf11487 misses the curly brackets. Follow Igor's and Eduardo's suggestion,
> 
> Add a follow-up patch for it.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

I'm queueing this for 3.1, but the subject line didn't make sense
(this patch doesn't remove zero check of nb_numa_nodes), so I
rewrote the commit message as:

    machine: Fix coding style at machine_run_board_init()

    Commit 7747abf11487 ("hw/machine: Remove the Zero check of
    nb_numa_nodes for numa_complete_configuration()") removed the
    curly brackets.  Re-add them.

    Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
    Message-Id: <20180710105129.23296-1-douly.fnst@cn.fujitsu.com>
    [ehabkost: rewrote commit message]
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
