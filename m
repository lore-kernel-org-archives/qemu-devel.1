Received: from eggs.gnu.org ([2001:4830:134:3::10]:53666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erRYI-00015N-HU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erRYF-0003q5-Cc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:59:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38046
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1erRYF-0003pO-0j
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:59:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w21GxAeG137194
	for <qemu-devel@nongnu.org>; Thu, 1 Mar 2018 11:59:26 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gem4ecafq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 11:59:21 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 1 Mar 2018 11:59:20 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-7-marcandre.lureau@redhat.com>
	<4dc45713-b15d-0db5-d72e-ccb007cd2487@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 11:59:16 -0500
MIME-Version: 1.0
In-Reply-To: <4dc45713-b15d-0db5-d72e-ccb007cd2487@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b1eb7e49-f2ba-6115-79b1-a299af8e5032@linux.vnet.ibm.com>
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

On 02/26/2018 04:58 AM, Laszlo Ersek wrote:
> On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> The module allows to tweak and interact with the TPM. Note that many
>> actions are broken due to implementation of qemu TPM (providing it's
>> own ACPI table), and the lack of PPI implementation.
>>
>> CC: Laszlo Ersek <lersek@redhat.com>
>> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Contributed-under: TianoCore Contribution Agreement 1.0
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   OvmfPkg/OvmfPkgX64.dsc | 2 ++
>>   OvmfPkg/OvmfPkgX64.fdf | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
>> index 9bd0709f98..2281bd5ff8 100644
>> --- a/OvmfPkg/OvmfPkgX64.dsc
>> +++ b/OvmfPkg/OvmfPkgX64.dsc
>> @@ -669,6 +669,8 @@
>>         NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSh=
a1.inf
>>         NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLib=
Sha256.inf
>>     }
>> +
>> +  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
>>   !endif
>>  =20
>>   !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
>> index b8dd7ecae4..985404850f 100644
>> --- a/OvmfPkg/OvmfPkgX64.fdf
>> +++ b/OvmfPkg/OvmfPkgX64.fdf
>> @@ -399,6 +399,7 @@ INF  MdeModulePkg/Universal/Variable/RuntimeDxe/Va=
riableRuntimeDxe.inf
>>  =20
>>   !if $(TPM2_ENABLE) =3D=3D TRUE
>>   INF  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf
>> +INF  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
>>   !endif
>>  =20
>>   ####################################################################=
############
>>
> Please drop this patch.
>
> In my earlier investigation I wrote, Tcg2ConfigDxe "[p]rovides a Setup
> TUI interface to configure the TPM. IIUC, it can also save the
> configured TPM type for subsequent boots (see Tcg2ConfigPei.inf above)".
>
> The INF file itself says "This module is only for reference only, each
> platform should have its own setup page."
>
> And Jiewen wrote earlier, "Tcg2ConfigPei/Dxe are platform sample driver.
> A platform may have its own version based upon platform requirement. Fo=
r
> example, if a platform supports fTPM, it may use another Tcg2Config dri=
ver."
>
> Given that OVMF lacks PEI-phase variable access, and that I consequentl=
y
> suggested cloning, and seriously trimming, Tcg2ConfigPei, it makes no
> sense to include an HII dialog that sets a variable for PEI phase
> consumption. Also, as you say, many of the exposed operations are broke=
n
> due to lack of PPI support. So let's just postpone the inclusion of thi=
s
> driver, for now.

Just FYI: The PPI support for the OS requires ACPI and, as it is=20
currently implemented, SMF where UEFI variables are manipulated. Some=20
menu items in the TPM 2 menu (also TPM 1.2) also require these UEFI=20
variables of the PPI interface so that UEFI can react on the menu=20
choices upon re.

    Stefan
