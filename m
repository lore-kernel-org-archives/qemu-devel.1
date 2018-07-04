Received: from eggs.gnu.org ([2001:4830:134:3::10]:37115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1famB8-0006Mc-AO
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1famB3-000297-N3
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:06:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1famB3-00028j-GP
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:06:53 -0400
Date: Wed, 4 Jul 2018 15:06:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180704180649.GY7451@localhost.localdomain>
References: <20180704132239.6506-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704132239.6506-1-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/machine: Remove the Zero check of
 nb_numa_nodes for numa_complete_configuration()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

On Wed, Jul 04, 2018 at 09:22:39PM +0800, Dou Liyang wrote:
> Commit 7a3099fc9c5c("numa: postpone options post-processing till machine_run_board_init()")
> broke the commit 7b8be49d36fc("NUMA: Enable adding NUMA node implicitly").
> 
> The machine_run_board_init() doesn't do NUMA setup if nb_numa_nodes=0,
> but the numa_complete_configuration need add a new node if memory hotplug
> is enabled (slots > 0) even nb_numa_nodes=0.
> 
> So, Remove the check for numa_complete_configuration() to fix this.
> 
> Fixes 7a3099fc9c5c("numa: postpone options post-processing till machine_run_board_init()")
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Thanks!  Queued on machine-next.

-- 
Eduardo
