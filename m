Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fJiXi-0006uy-HT
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fJiXh-0001Hc-NX
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:47:46 -0400
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
	<20180518131303.6f0778eb@bahia.lan>
	<e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
	<20180518141642.6ad639ac@bahia.lan>
	<8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <3db651e3-a237-fbaa-6ffe-ecc5db43ad0f@tuxfamily.org>
Date: Fri, 18 May 2018 18:47:38 +0200
MIME-Version: 1.0
In-Reply-To: <8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PPC64] P5020DS: Booting from img possible
 (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 18.05.2018 14:33, Christian Zigotzky wrote:
> On 18 May 2018 at 2:16PM, Greg Kurz wrote:
>> On Fri, 18 May 2018 13:50:42 +0200
>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>
>>> On 18 May 2018 at 1:13PM, Greg Kurz wrote:
>>>> And of course your kernel should be built with virtio support.
>>> I think I have enabled virtio support. Please find attached my kernel
>>> config.
>>>
>> Indeed, what about passing root=/dev/vda3 to the kernel ?
>>
> ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17
> -drive
> file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img,index=0,if=virtio
> -net nic,vlan=0,model=e1000 -net user,vlan=0 -append "rw root=/dev/vda3"
> -machine dt_compatible=fsl,,P5020DS
> 
> or
> 
> ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17
> -machine dt_compatible=fsl,,P5020DS -device virtio-scsi -drive
> if=none,id=c1,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img
> -device scsi-cd,drive=c1 -append "root=/dev/vda3"
> 
> or
> 
> ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17
> -machine dt_compatible=fsl,,P5020DS -drive
> if=virtio,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img
> -append "root=/dev/vda3"
> 
> Output:
> 
> [    0.000000] MMU: Supported page sizes
> [    0.000000]          4 KB as direct
> [    0.000000]       4096 KB as direct
> [    0.000000]      16384 KB as direct
> [    0.000000]      65536 KB as direct
> [    0.000000]     262144 KB as direct
> [    0.000000]    1048576 KB as direct
> [    0.000000] MMU: Book3E HW tablewalk not supported
> [    0.000000] Linux version 4.17.0-rc5_A-EON_A1-X5000
> (christian@christian-virtual-machine) (gcc version 5.4.0 20160609
> (Ubuntu 5.4.0-6ubuntu1~16.04.4)) #1 SMP Mon May 14 09:34:52 CEST 2018
> [    0.000000] Using CoreNet Generic machine description

No clue, so just a blind guess: Is "CoreNet Generic" the right machine?
What happens if you set "CONFIG_CORENET_GENERIC=n" in your kernel config?

 Thomas
