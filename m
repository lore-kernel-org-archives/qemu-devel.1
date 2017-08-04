Received: from eggs.gnu.org ([2001:4830:134:3::10]:45061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dhiru.kholia@gmail.com>) id 1ddaA2-00015b-M6
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dhiru.kholia@gmail.com>) id 1dda8y-0007T2-KQ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:48:54 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:34294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dhiru.kholia@gmail.com>)
	id 1dda8y-0007SY-DU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:47:48 -0400
Received: by mail-oi0-x22e.google.com with SMTP id x3so11595811oia.1
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 03:47:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170804110539.3885a22d@nial.brq.redhat.com>
References: <20170804064540.10523-1-dhiru.kholia@gmail.com>
	<20170804110539.3885a22d@nial.brq.redhat.com>
From: Dhiru Kholia <dhiru.kholia@gmail.com>
Date: Fri, 4 Aug 2017 16:17:07 +0530
Message-ID: <CANO7a6x6EaWNZ8y=MvLU=w_LjRLXserO3NmsgHvaYE0aUCCWzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pc/acpi: Fix booting of macOS with Clover
 EFI bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, BALATON Zoltan <balaton@eik.bme.hu>, Gabriel Somlo <somlo@cmu.edu>

On Fri, Aug 4, 2017 at 2:35 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Fri,  4 Aug 2017 12:15:40 +0530
> Dhiru Kholia <dhiru.kholia@gmail.com> wrote:
>
>> This was tested with macOS 10.12.5 and Clover r4114.
>>
>> Without this patch, the macOS boot process gets stuck at the Apple logo
>> without showing any progress bar.
>>
>> I have documented the process of running macOS on QEMU/KVM at,
>>
>> https://github.com/kholia/OSX-KVM/
>>
>> Instead of using this patch, adding an additional command-line knob
>> which exposes this setting (force_rev1_fadt) to the user might be a more
>> general solution.
>
> it's been reported that OVMF had issues that were fixed,
> you probably want to read this thread:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg468456.html

Hi Igor,

I have now tested various OVMF versions with the latest QEMU (commit
aaaec6acad7c).

When using edk2.git-ovmf-x64-0-20170726.b2826.gbb4831c03d.noarch.rpm
from [1] macOS does not boot and gets stuck. The CPU usage goes to
100%. I haven't confirmed this but this OVMF build should have both
198a46d and 072060a edk2 commits in it, based on the build date.

The OVMF blob from Gabriel Somlo [2] hangs on the OVMF logo screen and
it too results in 100% CPU usage after hanging.

I am using "boot-clover.sh" script from my repository [4] to test the
various OVMF versions.

The only OVMF blob which works with the current QEMU for booting macOS
is the one from Proxmox [3]. Unfortunately, I don't know the
corresponding commit in the edk2 repository for this working OVMF
blob.

References,

[1] https://www.kraxel.org/repos/jenkins/edk2/

[2] https://www.contrib.andrew.cmu.edu/~somlo/OSXKVM/

[3] https://git.proxmox.com/?p=pve-qemu-kvm.git;a=tree;f=debian

[4] https://github.com/kholia/OSX-KVM/

It would be great if someone else could reproduce these results too.

Thanks,
Dhiru
