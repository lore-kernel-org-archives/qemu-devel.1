Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1dslW2-0005lP-5b
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1dslVy-0007Bf-9x
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:58:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1dslVy-0007A6-4K
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:58:18 -0400
Date: Fri, 15 Sep 2017 09:58:14 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20170915075814.GC5256@orkuz.home>
References: <CADak6y79L+eUYg3LmO2MGTf5BKxHZ8rG5zHBJ9UKPhKHNxsFkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADak6y79L+eUYg3LmO2MGTf5BKxHZ8rG5zHBJ9UKPhKHNxsFkQ@mail.gmail.com>
Subject: Re: [Qemu-devel] host doesn't support requested feature:
 CPUID.01H:EDX.ds [bit 21] Does this warn affect virtual machine performance
 or use?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Schlacter <wlfightup@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Sep 14, 2017 at 20:48:49 +0800, Paul Schlacter wrote:
> this is my stackoverflow question:
> https://stackoverflow.com/questions/46219552/host-doesnt-support-requested-feature-cpuid-01hedx-ds-bit-21-does-this-warn
> 
> 
> I found a lot of warning from the VM qemu log, Does this warn affect
> virtual machine performance or use? , is my libvirt.xml file problem? Or
> support hot-plug will have these warnings
> 
> This is my libvirt xml configuration:
> 
> <domain type='kvm' id='315'>
...
>   <cpu mode='host-model'>
>     <model fallback='allow'/>
>     <numa>
>       <cell id='0' cpus='0-1' memory='2097152' unit='KiB'/>
>     </numa>
>   </cpu>
...
> 2017-09-14T12:16:03.441702Z qemu-kvm: warning: CPU(s) not present in
> any NUMA nodes: 2 3 4 5 6 7
> 2017-09-14T12:16:03.441773Z qemu-kvm: warning: All CPU(s) up to
> maxcpus should be described in NUMA config
> warning: host doesn't support requested feature: CPUID.01H:EDX.ds [bit 21]
> warning: host doesn't support requested feature: CPUID.01H:EDX.acpi [bit 22]
> warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
> warning: host doesn't support requested feature: CPUID.01H:EDX.tm [bit 29]
...

Similar warnings are expected with host-model CPUs on older libvirt
which didn't know how to ask QEMU what CPU features are supported on the
host. Thus libvirt just used CPUID and asked for everything and QEMU
filtered a lot of them. You need a recent QEMU and libvirt to avoid
these warnings.

Jirka
