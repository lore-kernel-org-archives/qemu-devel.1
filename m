Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dDFhE-0006AG-8g
	for qemu-devel@nongnu.org; Tue, 23 May 2017 15:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dDFhA-0000OO-Av
	for qemu-devel@nongnu.org; Tue, 23 May 2017 15:42:20 -0400
References: <20170523111812.13469-1-lvivier@redhat.com>
	<7509d665-566e-2570-9936-44a04bad75fe@linux.vnet.ibm.com>
	<e0a75b06-5bbf-e831-b049-93e2ad5aa717@linux.vnet.ibm.com>
	<6e4170f5-5fbe-dc45-70f7-6c3c5a9e4b33@linux.vnet.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <83b8326b-3dbf-142b-1c18-0483b0feb62b@redhat.com>
Date: Tue, 23 May 2017 21:42:10 +0200
MIME-Version: 1.0
In-Reply-To: <6e4170f5-5fbe-dc45-70f7-6c3c5a9e4b33@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] spapr: disable hotplugging
 without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On 23/05/2017 20:22, Daniel Henrique Barboza wrote:
> 
> 
> This is the Libvirt use case that fails with this patch set applied in
> QEMU master, Libvirt 3.4.0 compiled from
> source:
> 
> # ./virsh start dhb_ub1704_nfs 2
> #
> # ./virsh setvcpus dhb_ub1704_nfs 2 --live
> #
> # ./virsh -c 'qemu:///system' migrate --live --domain dhb_ub1704_nfs
> --desturi qemu+ssh://target_ip/system --timeout 60 --verbose
> error: internal error: unable to execute QEMU command 'device_add': CPU
> hotplug not supported without OS

Good point.

I think I should refine my series to allow hotplug if the machine is not
started.

Thanks,
Laurent
