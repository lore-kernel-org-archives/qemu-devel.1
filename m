Received: from eggs.gnu.org ([2001:4830:134:3::10]:44772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eribz-0007zo-DX
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eribv-00070s-9P
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:12:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eribv-00070g-3F
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:12:23 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-7-marcandre.lureau@redhat.com>
	<4dc45713-b15d-0db5-d72e-ccb007cd2487@redhat.com>
	<b1eb7e49-f2ba-6115-79b1-a299af8e5032@linux.vnet.ibm.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9b615ca0-bc5a-e160-928d-07042b93e9a0@redhat.com>
Date: Fri, 2 Mar 2018 12:12:06 +0100
MIME-Version: 1.0
In-Reply-To: <b1eb7e49-f2ba-6115-79b1-a299af8e5032@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, qemu-devel@nongnu.org, javierm@redhat.com

On 03/01/18 17:59, Stefan Berger wrote:
> On 02/26/2018 04:58 AM, Laszlo Ersek wrote:
>> On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>
>>> The module allows to tweak and interact with the TPM. Note that many
>>> actions are broken due to implementation of qemu TPM (providing it's
>>> own ACPI table), and the lack of PPI implementation.
>>>
>>> CC: Laszlo Ersek <lersek@redhat.com>
>>> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> Contributed-under: TianoCore Contribution Agreement 1.0
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>> =C2=A0 OvmfPkg/OvmfPkgX64.dsc | 2 ++
>>> =C2=A0 OvmfPkg/OvmfPkgX64.fdf | 1 +
>>> =C2=A0 2 files changed, 3 insertions(+)
>>>
>>> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
>>> index 9bd0709f98..2281bd5ff8 100644
>>> --- a/OvmfPkg/OvmfPkgX64.dsc
>>> +++ b/OvmfPkg/OvmfPkgX64.dsc
>>> @@ -669,6 +669,8 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1.inf
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSha256.=
inf
>>> =C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0 SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
>>> =C2=A0 !endif
>>> =C2=A0 =C2=A0 !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>>> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
>>> index b8dd7ecae4..985404850f 100644
>>> --- a/OvmfPkg/OvmfPkgX64.fdf
>>> +++ b/OvmfPkg/OvmfPkgX64.fdf
>>> @@ -399,6 +399,7 @@ INF=C2=A0
>>> MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe.inf
>>> =C2=A0 =C2=A0 !if $(TPM2_ENABLE) =3D=3D TRUE
>>> =C2=A0 INF=C2=A0 SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf
>>> +INF=C2=A0 SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
>>> =C2=A0 !endif
>>> =C2=A0 =C2=A0
>>> #####################################################################=
###########
>>>
>>>
>> Please drop this patch.
>>
>> In my earlier investigation I wrote, Tcg2ConfigDxe "[p]rovides a Setup
>> TUI interface to configure the TPM. IIUC, it can also save the
>> configured TPM type for subsequent boots (see Tcg2ConfigPei.inf above)=
".
>>
>> The INF file itself says "This module is only for reference only, each
>> platform should have its own setup page."
>>
>> And Jiewen wrote earlier, "Tcg2ConfigPei/Dxe are platform sample drive=
r.
>> A platform may have its own version based upon platform requirement. F=
or
>> example, if a platform supports fTPM, it may use another Tcg2Config
>> driver."
>>
>> Given that OVMF lacks PEI-phase variable access, and that I consequent=
ly
>> suggested cloning, and seriously trimming, Tcg2ConfigPei, it makes no
>> sense to include an HII dialog that sets a variable for PEI phase
>> consumption. Also, as you say, many of the exposed operations are brok=
en
>> due to lack of PPI support. So let's just postpone the inclusion of th=
is
>> driver, for now.
>=20
> Just FYI: The PPI support for the OS requires ACPI

OK

> and, as it is
> currently implemented, SMF where UEFI variables are manipulated.

(I assume s/SMF/SMM/)

You are correct to write "as it is currently implemented". My point in
my previous email(s) was that QEMU should generate the ACPI payload
needed by the OS, for queueing PPI opcodes (i.e. OVMF should install
QEMU's AML, *not* the sample AML code in SecurityPkg). In turn the AML
from QEMU should queue the PPI opcodes in the custom register block of
the TPM device (which is anyway the only NVRAM-emulation possibility
under SeaBIOS).

Given that the PPI opcodes will henceforth not be stored in a UEFI
variable under OVMF either, the SMM requirement in the AML falls away
completely.

Retrieving the PPI opcodes for processing from the custom MMIO register
block of the TPM device, after reboot, as opposed to reading them out of
a UEFI variable, will take custom code in OVMF. We'll get there.

> Some
> menu items in the TPM 2 menu (also TPM 1.2) also require these UEFI
> variables of the PPI interface so that UEFI can react on the menu
> choices upon re.

(I assume s/re/reboot/)

In "SecurityPkg/Tcg/Tcg2Config/Tcg2Config.vfr" (which is the "Visual
Form Representation" of the dialog we're talking about), I see three
variable references. The structures for those are defined in
"SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigNvData.h":

- TCG2_CONFIGURATION_INFO
- TCG2_CONFIGURATION
- TCG2_VERSION

I think the last two are irrelevant under OVMF / QEMU (fixed version 2
TPM, and ACPI comes from QEMU -- consistent with my other comments for
the PEI phase modules).

TCG2_CONFIGURATION_INFO looks more complex, so perhaps we'll have to
scavenge its handling for OVMF. However, it seems that
TCG2_CONFIGURATION_INFO is not needed in the PEI phase.

... Understand this right: I'd be bursting from joy if OVMF had
PEI-phase r/o variable access. I got that feature working for QEMU. But
all my attempts to upstream the work failed (apparently because I'm not
willing to develop a parallel "fake" for Xen -- on Xen, NVRAM/pflash
doesn't even exist, so even if the PEI variable service existed on Xen,
it would have zero chance to return valid data.)

Laszlo
