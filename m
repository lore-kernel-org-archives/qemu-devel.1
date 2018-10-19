Received: from eggs.gnu.org ([2001:4830:134:3::10]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDY8M-0003lP-D2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDY8G-0005Jo-Oc
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDY8G-0005JG-Hl
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so4323944wme.3
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 10:00:16 -0700 (PDT)
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<CAFEAcA9p0dLoNQy7kBdcXMz0HiMGEZTBX67Lq2SizTY3kgeksw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8db2535c-c44c-ac0b-33b3-d2c2af7de15e@redhat.com>
Date: Fri, 19 Oct 2018 19:00:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9p0dLoNQy7kBdcXMz0HiMGEZTBX67Lq2SizTY3kgeksw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/45] Machine queue, 2018-10-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Libvirt <libvir-list@redhat.com>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 19/10/2018 16:12, Peter Maydell wrote:
> On 18 October 2018 at 21:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> The following changes since commit 09558375a634e17cea6cfbfec883ac2376d2dc7f:
>>
>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>>
>> for you to fetch changes up to 6d8e1bcc7dd5e819ce81e6a87fffe23e39c700cc:
>>
>>   numa: Clean up error reporting in parse_numa() (2018-10-17 16:33:40 -0300)
>>
>> ----------------------------------------------------------------
>> Machine queue, 2018-10-18
>>
>> * sysbus init/realize cleanups
>>   (Cédric Le Goater, Philippe Mathieu-Daudé)
>> * memory-device refactoring (David Hildenbrand)
>> * -smp: deprecate incorrect CPUs topology (Igor Mammedov)
>> * -numa parsing cleanups (Markus Armbruster)
>> * Fix hostmem-file memory leak (Zhang Yi)
>> * Typo fix (Li Qiang)
>>
>> ----------------------------------------------------------------
>>
> 
> Hi. This had some problems in merge testing, I'm afraid:
> 
> On aarch64 host, warnings running tests/cpu-plug-test for i386 and s390 targets:
> 
> TEST: tests/cpu-plug-test... (pid=12602)
>   /i386/cpu-plug/pc-i440fx-3.0/cpu-add/1x3x2&maxcpus=12:
> qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
> (1) * cores (3) * threads (2) != maxcpus (12)
> OK
>   /i386/cpu-plug/pc-i440fx-3.0/device-add/1x3x2&maxcpus=12:
> qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
> (1) * cores (3) * threads (2) != maxcpus (12)
> OK
>   /i386/cpu-plug/pc-q35-3.0/cpu-add/1x3x2&maxcpus=12:
> qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
> (1) * cores (3) * threads (2) != maxcpus (12)
> OK
>   /i386/cpu-plug/pc-q35-3.0/device-add/1x3x2&maxcpus=12:
> qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
> (1) * cores (3) * threads (2) != maxcpus (12)
> OK
>   /arm/qom/n800:                                                       OK
> PASS: tests/cpu-plug-test
> [...]
> TEST: tests/cpu-plug-test... (pid=15040)
>   /s390x/cpu-plug/s390-ccw-virtio-3.1/cpu-add/1x3x1&maxcpus=6:
> qemu-system-s390x: warning: Invalid CPU topology deprecated: sockets
> (1) * cores (3) * threads (1) != maxcpus (6)
> OK
>   /s390x/cpu-plug/s390-ccw-virtio-3.1/device-add/1x3x1&maxcpus=6:
> qemu-system-s390x: warning: Invalid CPU topology deprecated: sockets
> (1) * cores (3) * threads (1) != maxcpus (6)
> OK
>   /s390x/cpu-plug/s390-ccw-virtio-3.0/cpu-add/1x3x1&maxcpus=6:
> qemu-system-s390x: warning: Invalid CPU topology deprecated: sockets
> (1) * cores (3) * threads (1) != maxcpus (6)
> OK
>   /s390x/cpu-plug/s390-ccw-virtio-3.0/device-add/1x3x1&maxcpus=6:
> qemu-system-s390x: warning: Invalid CPU topology deprecated: sockets
> (1) * cores (3) * threads (1) != maxcpus (6)
> OK
> PASS: tests/cpu-plug-test
> 
> (plus similar ppc64, x86_64 targets)
> 
> I see similar warnings on hosts SPARC, PPC64BE, S390, 32-bit Arm
> and x86 FreeBSD.
> 
> I also got a build failure on one of my configs, but I think that
> is caused by some latent bug in our makefiles where we don't
> correctly rebuild x86_64-softmmu/config-devices.mak when a
> change is made to default-configs/i386-softmmu.mak -- doing a
> hand rm of the config-devices.mak fixed it.

bisected to:

23d0571a24559b867fa47410aa8ec0519b0a1edd is the first bad commit
commit 23d0571a24559b867fa47410aa8ec0519b0a1edd
Author: Igor Mammedov <imammedo@redhat.com>
Date:   Thu Sep 13 13:06:01 2018 +0200

    vl.c deprecate incorrect CPUs topology

    -smp [cpus],sockets/cores/threads[,maxcpus] should describe topology
    so that total number of logical CPUs [sockets * cores * threads]
    would be equal to [maxcpus], however historically we didn't have
    such check in QEMU and it is possible to start VM with an invalid
    topology.
    Deprecate invalid options combination so we can make sure that
    the topology VM started with is always correct in the future.
    Users with an invalid sockets/cores/threads/maxcpus values should
    fix their CLI to make sure that
       [sockets * cores * threads] == [maxcpus]

> 
> 
> thanks
> -- PMM
> 
