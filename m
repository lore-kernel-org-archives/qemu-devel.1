Received: from eggs.gnu.org ([2001:4830:134:3::10]:45610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8oIj-0008KC-Nk
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8oIi-0003Ky-Kb
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:38:41 -0400
Date: Thu, 11 May 2017 10:38:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170511133832.GI3482@thinpad.lan.raisama.net>
References: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/18] numa: add '-numa cpu' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, May 10, 2017 at 01:29:44PM +0200, Igor Mammedov wrote:
[...]
> Igor Mammedov (18):
>   numa: move source of default CPUs to NUMA node mapping into boards
>   spapr: add node-id property to sPAPR core
>   pc: add node-id property to CPU
>   virt-arm: add node-id property to CPU
>   numa: add check that board supports cpu_index to node mapping
>   numa: mirror cpu to node mapping in MachineState::possible_cpus
>   numa: do default mapping based on possible_cpus instead of node_cpu
>     bitmaps
>   pc: get numa node mapping from possible_cpus instead of
>     numa_get_node_for_cpu()
>   spapr: get numa node mapping from possible_cpus instead of
>     numa_get_node_for_cpu()
>   virt-arm: get numa node mapping from possible_cpus instead of
>     numa_get_node_for_cpu()
>   QMP: include CpuInstanceProperties into query_cpus output output
>   tests: numa: add case for QMP command query-cpus
>   numa: remove no longer need numa_post_machine_init()
>   machine: call machine init from wrapper
>   numa: use possible_cpus for not mapped CPUs check
>   numa: remove node_cpu bitmaps as they are no longer used
>   numa: add '-numa cpu,...' option for property based node mapping
>   tests: check -numa node,cpu=props_list usecase

Queued on numa-next. Thanks!

-- 
Eduardo
