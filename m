Received: from eggs.gnu.org ([2001:4830:134:3::10]:53069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erkqT-0006x5-NW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erkqQ-0003JL-FB
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:35:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1erkqQ-0003J1-3R
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:35:30 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w22DXlwt090170
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 08:35:28 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gf543pcyh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 08:35:28 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 2 Mar 2018 06:35:26 -0700
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-7-marcandre.lureau@redhat.com>
	<4dc45713-b15d-0db5-d72e-ccb007cd2487@redhat.com>
	<b1eb7e49-f2ba-6115-79b1-a299af8e5032@linux.vnet.ibm.com>
	<9b615ca0-bc5a-e160-928d-07042b93e9a0@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 08:35:21 -0500
MIME-Version: 1.0
In-Reply-To: <9b615ca0-bc5a-e160-928d-07042b93e9a0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a6b41731-afc9-eeab-6467-2bbd1f3b93a9@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 6/7] ovmf: link with Tcg2ConfigDxe
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, qemu-devel@nongnu.org, javierm@redhat.com

On 03/02/2018 06:12 AM, Laszlo Ersek wrote:
> On 03/01/18 17:59, Stefan Berger wrote:
>> On 02/26/2018 04:58 AM, Laszlo Ersek wrote:
>>> On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
>>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>
>>>> The module allows to tweak and interact with the TPM. Note that many
>>>> actions are broken due to implementation of qemu TPM (providing it's
>>>> own ACPI table), and the lack of PPI implementation.
>>>>
>>>> CC: Laszlo Ersek <lersek@redhat.com>
>>>> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>> Contributed-under: TianoCore Contribution Agreement 1.0
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>    OvmfPkg/OvmfPkgX64.dsc | 2 ++
>>>>    OvmfPkg/OvmfPkgX64.fdf | 1 +
>>>>    2 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
>>>> index 9bd0709f98..2281bd5ff8 100644
>>>> --- a/OvmfPkg/OvmfPkgX64.dsc
>>>> +++ b/OvmfPkg/OvmfPkgX64.dsc
>>>> @@ -669,6 +669,8 @@
>>>>        =20
>>>> NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1.inf
>>>>        =20
>>>> NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSha256=
.inf
>>>>      }
>>>> +
>>>> +  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
>>>>    !endif
>>>>      !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>>>> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
>>>> index b8dd7ecae4..985404850f 100644
>>>> --- a/OvmfPkg/OvmfPkgX64.fdf
>>>> +++ b/OvmfPkg/OvmfPkgX64.fdf
>>>> @@ -399,6 +399,7 @@ INF
>>>> MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe.inf
>>>>      !if $(TPM2_ENABLE) =3D=3D TRUE
>>>>    INF  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf
>>>> +INF  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
>>>>    !endif
>>>>    =20
>>>> ####################################################################=
############
>>>>
>>>>
>>> Please drop this patch.
>>>
>>> In my earlier investigation I wrote, Tcg2ConfigDxe "[p]rovides a Setu=
p
>>> TUI interface to configure the TPM. IIUC, it can also save the
>>> configured TPM type for subsequent boots (see Tcg2ConfigPei.inf above=
)".
>>>
>>> The INF file itself says "This module is only for reference only, eac=
h
>>> platform should have its own setup page."
>>>
>>> And Jiewen wrote earlier, "Tcg2ConfigPei/Dxe are platform sample driv=
er.
>>> A platform may have its own version based upon platform requirement. =
For
>>> example, if a platform supports fTPM, it may use another Tcg2Config
>>> driver."
>>>
>>> Given that OVMF lacks PEI-phase variable access, and that I consequen=
tly
>>> suggested cloning, and seriously trimming, Tcg2ConfigPei, it makes no
>>> sense to include an HII dialog that sets a variable for PEI phase
>>> consumption. Also, as you say, many of the exposed operations are bro=
ken
>>> due to lack of PPI support. So let's just postpone the inclusion of t=
his
>>> driver, for now.
>> Just FYI: The PPI support for the OS requires ACPI
> OK
>
>> and, as it is
>> currently implemented, SMF where UEFI variables are manipulated.
> (I assume s/SMF/SMM/)

correct.
>
> You are correct to write "as it is currently implemented". My point in
> my previous email(s) was that QEMU should generate the ACPI payload
> needed by the OS, for queueing PPI opcodes (i.e. OVMF should install
> QEMU's AML, *not* the sample AML code in SecurityPkg). In turn the AML
> from QEMU should queue the PPI opcodes in the custom register block of
> the TPM device (which is anyway the only NVRAM-emulation possibility
> under SeaBIOS).

We can emulate other NVRAM as well. It is a possibility and provides the=20
flexibility of setting flags per implemented PPI code indicating whether=20
the firmware implements the codes and sysfs entries in Linux can then=20
show what is actually supported. If you write code '23' into sysfs and=20
ACPI has no clue whether the firmware implements '23', then you may=20
reboot for nothing and start wondering what is going on because the=20
effect isn't there. Also I don't think we'll implement the same set of=20
commands in both firmwares that we would want to hard-code the checking=20
for implemented code in ACPI produced by the firmware.

>
> Given that the PPI opcodes will henceforth not be stored in a UEFI
> variable under OVMF either, the SMM requirement in the AML falls away
> completely.

I would not modify that code but keep what is there right now and write=20
some glue code around it: Upon reboot detect what PPI code has been set,=20
if any, and write it into the UEFI variable. Then existing UEFI code=20
reads the variable (stemming either from OS or a menu operation) and=20
acts upon it. That keeps much of the existing code unmodified, which I=20
find appealing. Also the code for the menu wouldn't have to be modified.

>
> Retrieving the PPI opcodes for processing from the custom MMIO register
> block of the TPM device, after reboot, as opposed to reading them out o=
f
> a UEFI variable, will take custom code in OVMF. We'll get there.

That custom MMIO register block could, in the worst case, be assigned a=20
different purpose in a future spec...

   Stefan
>
>> Some
>> menu items in the TPM 2 menu (also TPM 1.2) also require these UEFI
>> variables of the PPI interface so that UEFI can react on the menu
>> choices upon re.
> (I assume s/re/reboot/)
>
> In "SecurityPkg/Tcg/Tcg2Config/Tcg2Config.vfr" (which is the "Visual
> Form Representation" of the dialog we're talking about), I see three
> variable references. The structures for those are defined in
> "SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigNvData.h":
>
> - TCG2_CONFIGURATION_INFO
> - TCG2_CONFIGURATION
> - TCG2_VERSION
>
> I think the last two are irrelevant under OVMF / QEMU (fixed version 2
> TPM, and ACPI comes from QEMU -- consistent with my other comments for
> the PEI phase modules).
>
> TCG2_CONFIGURATION_INFO looks more complex, so perhaps we'll have to
> scavenge its handling for OVMF. However, it seems that
> TCG2_CONFIGURATION_INFO is not needed in the PEI phase.
>
> ... Understand this right: I'd be bursting from joy if OVMF had
> PEI-phase r/o variable access. I got that feature working for QEMU. But
> all my attempts to upstream the work failed (apparently because I'm not
> willing to develop a parallel "fake" for Xen -- on Xen, NVRAM/pflash
> doesn't even exist, so even if the PEI variable service existed on Xen,
> it would have zero chance to return valid data.)
>
> Laszlo
>
