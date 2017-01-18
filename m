Received: from eggs.gnu.org ([2001:4830:134:3::10]:42367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTpcH-0003kR-83
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTpcC-0006NA-Oa
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:45:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTpcC-0006M6-IX
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:45:24 -0500
Date: Wed, 18 Jan 2017 10:45:21 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118124521.GS3491@thinpad.lan.raisama.net>
References: <1484664152-24446-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1484664152-24446-2-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170117200913.GO3491@thinpad.lan.raisama.net>
	<9e041398-8fc2-9809-ddd4-2ca0fe2b8e4e@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e041398-8fc2-9809-ddd4-2ca0fe2b8e4e@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Ensure the numa_post_machine_init
 func in the appropriate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: stefanha@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

On Wed, Jan 18, 2017 at 12:02:35PM +0800, Dou Liyang wrote:
> Hi, Eduardo
> 
> At 01/18/2017 04:09 AM, Eduardo Habkost wrote:
> > On Tue, Jan 17, 2017 at 10:42:31PM +0800, Dou Liyang wrote:
> > > In the numa_post_machine_init(), we use CPU_FOREACH macro to set all
> > > CPUs' namu_node. So, we should make sure that we call it after Qemu
> > > has already initialied all the CPUs.
> > > 
> > > As we all know, the CPUs can be created by "-smp"(pc_new_cpu) or
> > > "-device"(qdev_device_add) command. But, before the device init,
> > > Qemu execute the numa_post_machine_init earlier. It makes the mapping
> > > of NUMA nodes and CPUs incorrect.
> > > 
> > > The patch move the numa_post_machine_init func in the appropriate
> > > location.
> > > 
> > > Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> > 
> > I would like to move cpu_index initialization to
> > qom/cpu.c:cpu_common_realizefn(), and remove
> > numa_post_machine_init() completely.
> 
> Thanks, it is a good idea. I will try it later.
> 
> But, I hope to know that:
> 
> If you may want to say the cpu->**numa_node** initialization?
> Because the **cpu_index** initialization is in pc_cpu_pre_plug()
> currently, like that: cs->cpu_index = idx;

Oops, I meant the numa_node initialization. :)

-- 
Eduardo
