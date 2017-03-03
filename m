Received: from eggs.gnu.org ([2001:4830:134:3::10]:57829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjjmJ-0006oC-VK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjjmG-0006Hc-Rd
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:45:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cjjmG-0006HQ-Iy
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:45:32 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8ABC43D965
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 09:45:32 +0000 (UTC)
References: <1488531088-12483-1-git-send-email-jasowang@redhat.com>
	<148853172005.285.13690184348448239628@0e2666bad730>
	<20170303091803.GD7097@lemon.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2a087870-0264-5b12-6c6e-7ffa49af32fe@redhat.com>
Date: Fri, 3 Mar 2017 17:45:24 +0800
MIME-Version: 1.0
In-Reply-To: <20170303091803.GD7097@lemon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com



On 2017=E5=B9=B403=E6=9C=8803=E6=97=A5 17:18, Fam Zheng wrote:
> On Fri, 03/03 01:02,no-reply@patchew.org  wrote:
>>    CC      ppc-softmmu/hw/misc/ivshmem.o
>> In file included from /var/tmp/patchew-tester-tmp-krtyhjt1/src/hw/misc=
/ivshmem.c:19:0:
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/include/qemu/osdep.h:30:25: f=
atal error: config-host.h: No such file or directory
>>   #include "config-host.h"
>>                           ^
>> compilation terminated.
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for targ=
et 'hw/misc/ivshmem.o' failed
>> make[1]: *** [hw/misc/ivshmem.o] Error 1
>> Makefile:322: recipe for target 'subdir-ppc-softmmu' failed
>> make: *** [subdir-ppc-softmmu] Error 2
>> make: *** Waiting for unfinished jobs....
>> shell-init: error retrieving current directory: getcwd: cannot access =
parent directories: No such file or directory
>>    CC      ppc64-softmmu/hw/vfio/pci-quirks.o
>> Assembler messages:
>> Fatal error: can't create hw/net/virtio-net.o: No such file or directo=
ry
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for targ=
et 'hw/net/virtio-net.o' failed
>> make[1]: *** [hw/net/virtio-net.o] Error 1
>> Makefile:322: recipe for target 'subdir-ppcemb-softmmu' failed
>> make: *** [subdir-ppcemb-softmmu] Error 2
>> shell-init: error retrieving current directory: getcwd: cannot access =
parent directories: No such file or directory
>>    CC      s390x-softmmu/monitor.o
>> In file included from /var/tmp/patchew-tester-tmp-krtyhjt1/src/monitor=
.c:24:0:
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/include/qemu/osdep.h:30:25: f=
atal error: config-host.h: No such file or directory
>>   #include "config-host.h"
>>                           ^
>> compilation terminated.
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for targ=
et 'monitor.o' failed
>> make[1]: *** [monitor.o] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> In file included from /var/tmp/patchew-tester-tmp-krtyhjt1/src/hw/vfio=
/pci-quirks.c:13:0:
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/include/qemu/osdep.h:30:25: f=
atal error: config-host.h: No such file or directory
>>   #include "config-host.h"
>>                           ^
>> compilation terminated.
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for targ=
et 'hw/vfio/pci-quirks.o' failed
>> make[1]: *** [hw/vfio/pci-quirks.o] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> shell-init: error retrieving current directory: getcwd: cannot access =
parent directories: No such file or directory
>>    CC      ppc64-softmmu/hw/vfio/platform.o
>> In file included from /var/tmp/patchew-tester-tmp-krtyhjt1/src/hw/vfio=
/platform.c:17:0:
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/include/qemu/osdep.h:30:25: f=
atal error: config-host.h: No such file or directory
>>   #include "config-host.h"
>>                           ^
>> compilation terminated.
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for targ=
et 'hw/vfio/platform.o' failed
>> make[1]: *** [hw/vfio/platform.o] Error 1
>> Assembler messages:
>> Fatal error: can't create cpus.o: No such file or directory
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for targ=
et 'cpus.o' failed
>> make[1]: *** [cpus.o] Error 1
>> Makefile:322: recipe for target 'subdir-s390x-softmmu' failed
>> make: *** [subdir-s390x-softmmu] Error 2
>> Assembler messages:
>> Fatal error: can't create hw/vfio/pci.o: No such file or directory
>> /var/tmp/patchew-tester-tmp-krtyhjt1/src/rules.mak:69: recipe for targ=
et 'hw/vfio/pci.o' failed
>> make[1]: *** [hw/vfio/pci.o] Error 1
>> Makefile:322: recipe for target 'subdir-ppc64-softmmu' failed
>> make: *** [subdir-ppc64-softmmu] Error 2
>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>
> I'm touching the tester machine to investigate into the recent s390x qt=
est
> failure, this is me stepping onto its toes. Please ignore it, and sorry=
 for the
> noise.
>
> Fam
>

I see, thanks.
