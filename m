Received: from eggs.gnu.org ([2001:4830:134:3::10]:60270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dxYaA-0005xO-3S
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dxYa0-0001k6-EC
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:10:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56358
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1dxYa0-0001J9-87
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:10:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8SD9dNv079687
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:09:45 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d8xbu3we0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:09:40 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Thu, 28 Sep 2017 09:09:02 -0400
References: <1504511031-26834-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<5577a43c-0c60-a1c7-e5ab-7b940225ea85@amsat.org>
	<0476b7f3-e760-273a-7edf-07ff90157dc4@linux.vnet.ibm.com>
	<a2b139bd-f389-be61-b38f-51fa4fe64523@redhat.com>
From: seeteena <s1seetee@linux.vnet.ibm.com>
Date: Thu, 28 Sep 2017 18:38:55 +0530
MIME-Version: 1.0
In-Reply-To: <a2b139bd-f389-be61-b38f-51fa4fe64523@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <1cc1c650-9b82-0332-6d63-fce3334745da@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5] vl: exit if maxcpus is
 negative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


Thanks Thomas. Since you already put them on cc. I will wait for the=20
response.


On 09/25/2017 02:21 PM, Thomas Huth wrote:
> On 25.09.2017 10:43, seeteena wrote:
>> Hi Philippe,
>>
>> I have not seen patch went upstream..
> You need to get the attention of a maintainer who could pick up the
> patch, e.g. by putting them on CC:. See the MAINTAINERS file for who is
> responsible for the various parts of QEMU. I've put Eduardo (Numa) and
> Paolo (vl.c) on CC: now, I hope one of them can pick up the patch.
>
>   Thomas
>
>
>> On 09/04/2017 09:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 09/04/2017 04:43 AM, Seeteena Thoufeek wrote:
>>>> ---Steps to Reproduce---
>>>>
>>>> When passed a negative number to 'maxcpus' parameter, Qemu aborts
>>>> with a core dump.
>>>>
>>>> Run the following command with maxcpus argument as negative number
>>>>
>>>> ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
>>>> pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D200g -device virtio-blk-=
pci,
>>>> drive=3Drootdisk -drive file=3D/home/images/pegas-1.0-ppc64le.qcow2,
>>>> if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3Dqcow2 -monitor telnet
>>>> :127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net
>>>> user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=3D1,
>>>> threads=3D1,maxcpus=3D-12
>>>>
>>>> (process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
>>>>  =C2=A0 18446744073709550568 bytes
>>>>
>>>> Trace/breakpoint trap
>>>>
>>>> Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
>>>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>
>>>> ---
>>>> v1 -> v2:
>>>>  =C2=A0=C2=A0 - Fix the error check in vl.c to make it generic.
>>>> v2 -> v3:
>>>>  =C2=A0=C2=A0 - Fix coding style pointed out by patchew.
>>>>  =C2=A0=C2=A0 - Fix check for "<=3D 0" instead of just "< 0".
>>>> v3 -> v4:
>>>>  =C2=A0=C2=A0 - Fix subject line.
>>>>  =C2=A0=C2=A0 - Removed space before ":" from vl.c:1248
>>>>  =C2=A0=C2=A0 - Removed Reviewed-by: flag
>>>> v4-> v5:
>>>>  =C2=A0=C2=A0 - Code rework to declare max_cpus as unsigned int in s=
ysemu.h
>>>>  =C2=A0=C2=A0 - Remove the error check in vl.c referred in v2.
>>>>  =C2=A0=C2=A0 - declare max_cpus as unsigned int in vl.c
>>>> ---
>>>>  =C2=A0 include/sysemu/sysemu.h | 2 +-
>>>>  =C2=A0 vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>>>  =C2=A0 2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>>> index b213696..c083869 100644
>>>> --- a/include/sysemu/sysemu.h
>>>> +++ b/include/sysemu/sysemu.h
>>>> @@ -113,7 +113,7 @@ extern int win2k_install_hack;
>>>>  =C2=A0 extern int alt_grab;
>>>>  =C2=A0 extern int ctrl_grab;
>>>>  =C2=A0 extern int smp_cpus;
>>>> -extern int max_cpus;
>>>> +extern unsigned int max_cpus;
>>>>  =C2=A0 extern int cursor_hide;
>>>>  =C2=A0 extern int graphic_rotate;
>>>>  =C2=A0 extern int no_quit;
>>>> diff --git a/vl.c b/vl.c
>>>> index 8e247cc..1470c21 100644
>>>> --- a/vl.c
>>>> +++ b/vl.c
>>>> @@ -164,7 +164,7 @@ Chardev *sclp_hds[MAX_SCLP_CONSOLES];
>>>>  =C2=A0 int win2k_install_hack =3D 0;
>>>>  =C2=A0 int singlestep =3D 0;
>>>>  =C2=A0 int smp_cpus =3D 1;
>>>> -int max_cpus =3D 1;
>>>> +unsigned int max_cpus =3D 1;
>>>>  =C2=A0 int smp_cores =3D 1;
>>>>  =C2=A0 int smp_threads =3D 1;
>>>>  =C2=A0 int acpi_enabled =3D 1;
>>>> @@ -4233,8 +4233,8 @@ int main(int argc, char **argv, char **envp)
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_class->max_cpus =3D m=
achine_class->max_cpus ?: 1; /*
>>>> Default to UP */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_cpus > machine_class->max_cp=
us) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Number of =
SMP CPUs requested (%d) exceeds max
>>>> CPUs "
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "supported by machine=
 '%s' (%d)", max_cpus,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Invalid SM=
P CPUs %d. The max CPUs "
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "supported by machine=
 '%s' is %d", max_cpus,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_c=
lass->name, machine_class->max_cpus);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>
