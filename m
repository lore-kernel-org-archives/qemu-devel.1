Received: from eggs.gnu.org ([2001:4830:134:3::10]:54639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTtgn-000479-0b
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTtgj-0004Ty-Qc
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:06:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTtgj-0004Tk-KW
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:06:21 -0500
Date: Wed, 18 Jan 2017 15:06:18 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118170618.GD3491@thinpad.lan.raisama.net>
References: <148474442644.214.12638212197331646848@790289a7ca88>
	<21a27c35-8495-3b55-b809-5499118660b9@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a27c35-8495-3b55-b809-5499118660b9@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] cpu: numa: Fix the mapping
 initialization of VCPUs and NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, imammedo@redhat.com, vilanova@ac.upc.edu

On Wed, Jan 18, 2017 at 09:26:36PM +0800, Dou Liyang wrote:
> Hi, All
> 
> > **
> > ERROR:/tmp/qemu-test/src/tests/vhost-user-test.c:668:test_migrate: assertion failed: (qdict_haskey(rsp, "return"))
> > GTester: last random seed: R02Sf52546c4daff8087416f43fa7c146db8
> > ftruncate: Permission denied
> > ftruncate: Permission denied
> > qemu-system-aarch64: /tmp/qemu-test/src/qom/cpu.c:346: cpu_common_map_numa_node: Assertion `cpu->cpu_index < max_cpus' failed.
> > Broken pipe
> 
> I don't know What's the meaning of this log ?
> 
> Is the qemu-system-aarch64 can't recognize the
> qom/cpu.c:346: assert(cpu->cpu_index < max_cpus);

This means the assert() line is being triggered for some reason,
and cpu_index is >= max_cpus when we cpu_common_map_numa_node()
gets called. We need to investigate why.

-- 
Eduardo
