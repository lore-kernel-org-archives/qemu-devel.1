Received: from eggs.gnu.org ([2001:4830:134:3::10]:52312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjjLn-00025a-TR
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjjLj-0004D2-BK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:18:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cjjLj-0004CZ-2O
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:18:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AD1661D3F
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 09:18:07 +0000 (UTC)
Date: Fri, 3 Mar 2017 17:18:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170303091803.GD7097@lemon.lan>
References: <1488531088-12483-1-git-send-email-jasowang@redhat.com>
	<148853172005.285.13690184348448239628@0e2666bad730>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148853172005.285.13690184348448239628@0e2666bad730>
Subject: Re: [Qemu-devel] [PATCH] virtio: unbreak 1.0 device load with
 region cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com

On Fri, 03/03 01:02, no-reply@patchew.org wrote:
>   CC      ppc-softmmu/hw/misc/ivshmem.o
> In file included from /var/tmp/patchew-tester-tmp-krtyhjt1/src/hw/misc/ivshmem.c:19:0:
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/include/qemu/osdep.h:30:25: fatal error: config-host.h: No such file or directory
>  #include "config-host.h"
>                          ^
> compilation terminated.
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for target 'hw/misc/ivshmem.o' failed
> make[1]: *** [hw/misc/ivshmem.o] Error 1
> Makefile:322: recipe for target 'subdir-ppc-softmmu' failed
> make: *** [subdir-ppc-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
> shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
>   CC      ppc64-softmmu/hw/vfio/pci-quirks.o
> Assembler messages:
> Fatal error: can't create hw/net/virtio-net.o: No such file or directory
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for target 'hw/net/virtio-net.o' failed
> make[1]: *** [hw/net/virtio-net.o] Error 1
> Makefile:322: recipe for target 'subdir-ppcemb-softmmu' failed
> make: *** [subdir-ppcemb-softmmu] Error 2
> shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
>   CC      s390x-softmmu/monitor.o
> In file included from /var/tmp/patchew-tester-tmp-krtyhjt1/src/monitor.c:24:0:
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/include/qemu/osdep.h:30:25: fatal error: config-host.h: No such file or directory
>  #include "config-host.h"
>                          ^
> compilation terminated.
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for target 'monitor.o' failed
> make[1]: *** [monitor.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> In file included from /var/tmp/patchew-tester-tmp-krtyhjt1/src/hw/vfio/pci-quirks.c:13:0:
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/include/qemu/osdep.h:30:25: fatal error: config-host.h: No such file or directory
>  #include "config-host.h"
>                          ^
> compilation terminated.
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for target 'hw/vfio/pci-quirks.o' failed
> make[1]: *** [hw/vfio/pci-quirks.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
>   CC      ppc64-softmmu/hw/vfio/platform.o
> In file included from /var/tmp/patchew-tester-tmp-krtyhjt1/src/hw/vfio/platform.c:17:0:
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/include/qemu/osdep.h:30:25: fatal error: config-host.h: No such file or directory
>  #include "config-host.h"
>                          ^
> compilation terminated.
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for target 'hw/vfio/platform.o' failed
> make[1]: *** [hw/vfio/platform.o] Error 1
> Assembler messages:
> Fatal error: can't create cpus.o: No such file or directory
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for target 'cpus.o' failed
> make[1]: *** [cpus.o] Error 1
> Makefile:322: recipe for target 'subdir-s390x-softmmu' failed
> make: *** [subdir-s390x-softmmu] Error 2
> Assembler messages:
> Fatal error: can't create hw/vfio/pci.o: No such file or directory
> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for target 'hw/vfio/pci.o' failed
> make[1]: *** [hw/vfio/pci.o] Error 1
> Makefile:322: recipe for target 'subdir-ppc64-softmmu' failed
> make: *** [subdir-ppc64-softmmu] Error 2
> === OUTPUT END ===
> 

I'm touching the tester machine to investigate into the recent s390x qtest
failure, this is me stepping onto its toes. Please ignore it, and sorry for the
noise.

Fam
