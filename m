Received: from eggs.gnu.org ([2001:4830:134:3::10]:38635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1domAQ-0001do-4E
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1domAN-0007wI-1I
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:51:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1domAM-0007vY-Ol
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:51:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v847moUn048831
	for <qemu-devel@nongnu.org>; Mon, 4 Sep 2017 03:51:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cs15bm89f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 03:51:29 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Mon, 4 Sep 2017 01:51:28 -0600
References: <1503985539-7205-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<c61ae7e6-a117-a9c1-6a73-73beaede08a8@amsat.org>
	<e70b2b00-e471-7d9b-c754-6245b723ea94@linux.vnet.ibm.com>
	<59193a65-f1d1-4383-b776-053dce6e9746@linux.vnet.ibm.com>
	<8947138e-fbe5-5e86-f42e-b79c2d6fb33a@amsat.org>
From: seeteena <s1seetee@linux.vnet.ibm.com>
Date: Mon, 4 Sep 2017 13:21:21 +0530
MIME-Version: 1.0
In-Reply-To: <8947138e-fbe5-5e86-f42e-b79c2d6fb33a@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <bbb41312-8f52-05ac-00df-bf738b3fe75c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] vl: exit if maxcpus is negative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, famz@redhat.com, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

On 08/30/2017 10:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Seeteena,
>
>>>> On 08/29/2017 02:45 AM, Seeteena Thoufeek wrote:
>>>>> ---Steps to Reproduce---
>>>>>
>>>>> When passed a negative number to 'maxcpus' parameter, Qemu aborts
>>>>> with a core dump.
>>>>>
>>>>> Run the following command with maxcpus argument as negative number
>>>>>
>>>>> ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
>>>>> pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D200g -device virtio-blk=
-pci,
>>>>> drive=3Drootdisk -drive file=3D/home/images/pegas-1.0-ppc64le.qcow2=
,
>>>>> if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3Dqcow2 -monitor telnet
>>>>> :127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net
>>>>> user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=3D1,
>>>>> threads=3D1,maxcpus=3D-12
>
> Using 'extern unsigned int max_cpus;' I get:
>
> qemu-system-ppc64: Number of SMP CPUs requested (-12) exceeds max CPUs=20
> supported by machine 'pseries-2.10' (1024)
>
> Which looks weird but sane :)

With ''extern unsigned int max_cpus;" How about changing the message to=20
print as follows

/qemu_ubuntu1710/qemu-2.10~rc3+dfsg# ppc64-softmmu/qemu-system-ppc64=20
--nographic -vga none -machine pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D=
20g=20
-device virtio-blk-pci,drive=3Drootdisk -drive=20
file=3D/var/lib/libvirt/images/avocado-fvt-wrapper/data/avocado-vt/images=
/ubuntu-17.10-ppc64le.qcow2,if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3D=
qcow2=20
-monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net=
=20
user -device nec-usb-xhci -smp 8,cores=3D1,threads=3D1,maxcpus=3D-12

qemu-system-ppc64: Invalid SMP CPUs -12. The max CPUs supported by=20
machine 'pseries-artful' is 1024

/qemu_ubuntu1710/qemu-2.10~rc3+dfsg# ppc64-softmmu/qemu-system-ppc64=20
--nographic -vga none -machine pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D=
20g=20
-device virtio-blk-pci,drive=3Drootdisk -drive=20
file=3D/var/lib/libvirt/images/avocado-fvt-wrapper/data/avocado-vt/images=
/ubuntu-17.10-ppc64le.qcow2,if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3D=
qcow2=20
-monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net=
=20
user -device nec-usb-xhci -smp 8,cores=3D1,threads=3D1,maxcpus=3D12


SLOF ********************************************************************=
**
QEMU Starting
 =C2=A0Build Date =3D Jan=C2=A0 4 2017 05:15:48
 =C2=A0FW Version =3D buildd@ release 20161019
 =C2=A0Press "s" to enter Open Firmware.


~/qemu_ubuntu1710/qemu-2.10~rc3+dfsg# ppc64-softmmu/qemu-system-ppc64=20
--nographic -vga none -machine pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D=
20g=20
-device virtio-blk-pci,drive=3Drootdisk -drive=20
file=3D/var/lib/libvirt/images/avocado-fvt-wrapper/data/avocado-vt/images=
/ubuntu-17.10-ppc64le.qcow2,if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3D=
qcow2=20
-monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net=
=20
user -device nec-usb-xhci -smp 8,cores=3D1,threads=3D1,maxcpus=3D-1024

qemu-system-ppc64: Invalid SMP CPUs -1024. The max CPUs supported by=20
machine 'pseries-artful' is 1024

~/qemu_ubuntu1710/qemu-2.10~rc3+dfsg# ppc64-softmmu/qemu-system-ppc64=20
--nographic -vga none -machine pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D=
20g=20
-device virtio-blk-pci,drive=3Drootdisk -drive=20
file=3D/var/lib/libvirt/images/avocado-fvt-wrapper/data/avocado-vt/images=
/ubuntu-17.10-ppc64le.qcow2,if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3D=
qcow2=20
-monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net=
=20
user -device nec-usb-xhci -smp 8,cores=3D1,threads=3D1,maxcpus=3D1026
qemu-system-ppc64: Invalid SMP CPUs 1026. The max CPUs supported by=20
machine 'pseries-artful' is 1024

/qemu_ubuntu1710/qemu-2.10~rc3+dfsg# ppc64-softmmu/qemu-system-ppc64=20
--nographic -vga none -machine pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D=
20g=20
-device virtio-blk-pci,drive=3Drootdisk -drive=20
file=3D/var/lib/libvirt/images/avocado-fvt-wrapper/data/avocado-vt/images=
/ubuntu-17.10-ppc64le.qcow2,if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3D=
qcow2=20
-monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net=
=20
user -device nec-usb-xhci -smp 8,cores=3D1,threads=3D1,maxcpus=3D0
qemu-system-ppc64: maxcpus must be equal to or greater than smp

>
>>>>>
>>>>> (process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
>>>>> =C2=A0 18446744073709550568 bytes
>>>>>
>>>>> Trace/breakpoint trap
>>>>>
>>>>> Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
>>>>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>>>>> ---
>>>>> v1 -> v2:
>>>>> =C2=A0=C2=A0 - Fix the error check in vl.c to make it generic.
>>>>> v2 -> v3:
>>>>> =C2=A0=C2=A0 - Fix coding style pointed out by patchew.
>>>>> =C2=A0=C2=A0 - Fix check for "<=3D 0" instead of just "< 0".
>>>>> v3 -> v4:
>>>>> =C2=A0=C2=A0 - Fix subject line.
>>>>> =C2=A0=C2=A0 - Removed space before ":" from vl.c:1248
>>>>> =C2=A0=C2=A0 - Removed Reviewed-by: flag.
>>>>> ---
>>>>> =C2=A0 vl.c | 5 ++++-
>>>>> =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/vl.c b/vl.c
>>>>> index 8e247cc..2d9e73d 100644
>>>>> --- a/vl.c
>>>>> +++ b/vl.c
>>>>> @@ -1244,7 +1244,10 @@ static void smp_parse(QemuOpts *opts)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_c=
pus =3D qemu_opt_get_number(opts, "maxcpus", cpus);
>>>>> -
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_cpus <=3D 0) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 error_report("Invalid max_cpus: %d", max_cpus);
>>>>
>>>> I disagree with this patch, I think the correct fix is to declare=20
>>>> max_cpus as unsigned.
>>>> Looking at the codebase I can't find any signed use of it.
>>> =C2=A0=C2=A0 if I declare max_cpus as unsigned, the error check is no=
 more=20
>>> valid as the value max_cpus fetches is of unsigned type and hence we=20
>>> cannot do this below check.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (max_cpus <=3D=20
>>> 0) {
>>> error_report("Invalid max_cpus: %d", max_cpus);
>>>
>>> When I remove the error check with max_cpus defined as unsigned, the=20
>>> code behaves as follows when negetive value is passed for maxcpus
>>> =C2=A0=C2=A0 ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -m=
achine=20
>>> pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D20g -device=20
>>> virtio-blk-pci,drive=3Drootdisk -drive=20
>>> file=3D/var/lib/libvirt/images/avocado-fvt-wrapper/data/avocado-vt/im=
ages/ubuntu-17.10-ppc64le.qcow2,if=3Dnone,cache=3Dnone,id=3Drootdisk,form=
at=3Dqcow2=20
>>> -monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio=20
>>> -net user -device nec-usb-xhci -smp 8,cores=3D1,threads=3D1,maxcpus=3D=
-12
>>>
>>>
>>> SLOF=20
>>> *********************************************************************=
*
>>> QEMU Starting
>>> =C2=A0Build Date =3D Jan=C2=A0 4 2017 05:15:48
>>> =C2=A0FW Version =3D buildd@ release 20161019
>>> =C2=A0Press "s" to enter Open Firmware.
>>>
>>
>> Adding .. between we have max_cpus declared as extern int max_cpus;=20
>> in sysemu.h file.
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 exit(1);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_cpus=
 < cpus) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_report("maxcpus must be equal to or greater=20
>>>>> than smp");
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 exit(1);
>>>>>
>>>>
>>>> Regards,
>>>>
>>>> Phil.
>>>>
>>>
>>
>
