Received: from eggs.gnu.org ([2001:4830:134:3::10]:42383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBmPI-0003eA-OR
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBmPD-0000bk-Px
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:46:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44454
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBmPD-0000b9-JL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:45:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6Ijdg0070950
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 13:45:49 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2v44bpr0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 13:45:48 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 11:45:48 -0700
References: <1507222047-20115-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CLo46LvnfH_EBT9CRzuyKojKz3G-NMfJ7poyXZy5QxPJg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 13:45:44 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLo46LvnfH_EBT9CRzuyKojKz3G-NMfJ7poyXZy5QxPJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7825177e-8347-1340-4fb7-bd1805c8a044@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] specs: Extend TPM spec with TPM emulator
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On 10/06/2017 12:03 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Thu, Oct 5, 2017 at 6:47 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Following the recent extension of QEMU with a TPM emulator device,
>> update the specs describing for how to interact with the device.
>>
>> The results of commands run inside a Linux VM are expected to be
>> similar to those when the TPM passthrough device is used, so we
>> just reuse that.
>>
>> Fix a typo on the way.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
>> ---
>>   docs/specs/tpm.txt | 79 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   1 file changed, 79 insertions(+)
>>
>> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
>> index 914daac..9bef8b3 100644
>> --- a/docs/specs/tpm.txt
>> +++ b/docs/specs/tpm.txt
>> @@ -121,3 +121,82 @@ crw-------. 1 root root 10, 224 Jul 11 10:11 /dev=
/tpm0
>>   PCR-00: 35 4E 3B CE 23 9F 38 59 ...
>>   ...
>>   PCR-23: 00 00 00 00 00 00 00 00 ...
>> +
>> +
>> +=3D=3D The QEMU TPM emulator device =3D=3D
>> +
>> +The TPM emulator device uses an external TPM emulator called 'swtpm' =
for
>> +sending TPM commands to and receiving responses from. The swtpm progr=
am
>> +must have been started before trying to access it through the TPM emu=
lator
>> +with QEMU.
>> +
>> +The TPM emulator implements a command channel for transferring TPM co=
mmands
>> +and responses as well as a control channel over which control command=
s can
>> +be sent. The specification for the control channel can be found here:
>> +
>> +https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioct=
ls.pod
>> +
>> +
>> +The control channel serves the purpose of resetting, initializing, an=
d
>> +migrating the TPM state, among other things.
>> +
>> +The swtpm program behaves like a hardware TPM and therefore needs to =
be
>> +initialized by the firmware running inside the QEMU virtual machine.
>> +One necessary step for initializing the device is to send the TPM_Sta=
rtup
>> +command to it. SeaBIOS, for example, has been instrumented to initial=
ize
>> +a TPM 1.2 or TPM 2 device using this command.
>> +
>> +
>> +QEMU files related to the TPM emulator device:
>> + - hw/tpm/tpm_emulator.c
>> + - hw/tpm/tpm_util.c
>> + - hw/tpm/tpm_util.h
>> +
>> +
>> +The following commands start the swtpm with a UnixIO control channel =
over
>> +a socket interface. They do not need to be run as root.
>> +
>> +mkdir /tmp/mytpm1
> You no longer need swtpm_setup? nice

swtpm_setup is only needed if the TPM 1.2 is supposed to have an=20
endorsement key (EK) and possibly an EK certificate when it starts up.=20
In the simplest case it is not necessary to use swtpm_setup.

     Stefan


>
>> +swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
>> +  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
>> +  --log level=3D20
>> +
>> +Command line to start QEMU with the TPM emulator device using the hos=
t's
>> +hardware TPM /dev/tpm0:

I fixed this to:

Command line to start QEMU with the TPM emulator device communicating
with the swtpm:


    Stefan

>> +
>> +qemu-system-x86_64 -display sdl -enable-kvm \
>> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
>> +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
>> +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>> +  -device tpm-tis,tpmdev=3Dtpm0 test.img
>> +
>> +
>> +In case SeaBIOS is used as firmware, it should show the TPM menu item
>> +after entering the menu with 'ESC'.
>> +
>> +Select boot device:
>> +1. DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
>> +[...]
>> +5. Legacy option rom
>> +
>> +t. TPM Configuration
>> +
>> +
>> +The following commands should result in similar output inside the VM =
with a
>> +Linux kernel that either has the TPM TIS driver built-in or available=
 as a
>> +module:
>> +
>> +#> dmesg | grep -i tpm
>> +[    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
>> +
>> +#> dmesg | grep TCPA
>> +[    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
>> +    BXPCTCPA 0000001 BXPC 00000001)
>> +
>> +#> ls -l /dev/tpm*
>> +crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
>> +
>> +#> find /sys/devices/ | grep pcrs$ | xargs cat
>> +PCR-00: 35 4E 3B CE 23 9F 38 59 ...
>> +...
>> +PCR-23: 00 00 00 00 00 00 00 00 ...
>> --
>> 2.5.5
>>
>
>
