Received: from eggs.gnu.org ([2001:4830:134:3::10]:41814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1erlm9-0003iD-Ui
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1erlm4-0001yX-35
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:35:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1erlm3-0001yN-SJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:35:04 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-2-marcandre.lureau@redhat.com>
	<74D8A39837DF1E4DA445A8C0B3885C503AACEB43@shsmsx102.ccr.corp.intel.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f5c15a1e-25c2-c2e4-e6db-374107e3b488@redhat.com>
Date: Fri, 2 Mar 2018 15:34:57 +0100
MIME-Version: 1.0
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503AACEB43@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 1/7] SecurityPkg/Tcg2Pei: drop
 Tcg2PhysicalPresenceLib dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Yao, Jiewen" <jiewen.yao@intel.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Cc: "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, "pjones@redhat.com" <pjones@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>

On 02/24/18 01:09, Yao, Jiewen wrote:
> Reviewed-by: Jiewen.yao@intel.com

Given that Jiewen co-maintains SecurityPkg as of commit 3db2823f1e27
("Maintainers.txt: Add Jiewen to be co-maintainer of SecurityPkg.",
2018-03-02), I pushed this patch in isolation: commit a39e72267034.

However, Marc-Andr=C3=A9, something seems to be wrong with the way you
formatted the patch. The patch email is base64 encoded (which I guess
shouldn't be a problem per se), and I had to pass "--ignore-whitespace"
to git-am. It means that the *context* lines in your patch didn't have
the correct CRLF terminators. That seems very strange because the files
being modified are fully CRLF (I checked).

The git settings that I personally recommend to edk2 contributors are
written up here:

https://github.com/tianocore/tianocore.github.io/wiki/Laszlo's-unkempt-gi=
t-guide-for-edk2-contributors-and-maintainers

Also, if you could push every version of the patch set to a separate
branch in your public edk2 clone (e.g. on github, or elsewhere), that
would be great -- please just mark the repo URL and the branch name in
the cover letter of that version, when you post it.

Thanks!
Laszlo


>> -----Original Message-----
>> From: edk2-devel [mailto:edk2-devel-bounces@lists.01.org] On Behalf Of
>> marcandre.lureau@redhat.com
>> Sent: Friday, February 23, 2018 9:23 PM
>> To: edk2-devel@lists.01.org
>> Cc: qemu-devel@nongnu.org; javierm@redhat.com; pjones@redhat.com; Yao,
>> Jiewen <jiewen.yao@intel.com>; lersek@redhat.com
>> Subject: [edk2] [PATCH 1/7] SecurityPkg/Tcg2Pei: drop Tcg2PhysicalPres=
enceLib
>> dependency
>>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Apparently, unnecessary. Avoids extra build dependency and churn.
>>
>> CC: Laszlo Ersek <lersek@redhat.com>
>> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Contributed-under: TianoCore Contribution Agreement 1.0
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c   | 2 --
>>  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf | 1 -
>>  2 files changed, 3 deletions(-)
>>
>> diff --git a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c
>> b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c
>> index a7ae3354b5..3758fc6a41 100644
>> --- a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c
>> +++ b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c
>> @@ -18,7 +18,6 @@ WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY
>> KIND, EITHER EXPRESS OR IMPLIED.
>>  #include <IndustryStandard/UefiTcgPlatform.h>
>>  #include <Ppi/FirmwareVolumeInfo.h>
>>  #include <Ppi/FirmwareVolumeInfo2.h>
>> -#include <Ppi/LockPhysicalPresence.h>
>>  #include <Ppi/TpmInitialized.h>
>>  #include <Ppi/FirmwareVolume.h>
>>  #include <Ppi/EndOfPeiPhase.h>
>> @@ -44,7 +43,6 @@ WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY
>> KIND, EITHER EXPRESS OR IMPLIED.
>>  #include <Library/MemoryAllocationLib.h>
>>  #include <Library/ReportStatusCodeLib.h>
>>  #include <Library/ResetSystemLib.h>
>> -#include <Library/Tcg2PhysicalPresenceLib.h>
>>
>>  #define PERF_ID_TCG2_PEI  0x3080
>>
>> diff --git a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
>> b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
>> index f7b85444d9..bc910c3baf 100644
>> --- a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
>> +++ b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
>> @@ -58,7 +58,6 @@
>>    PerformanceLib
>>    MemoryAllocationLib
>>    ReportStatusCodeLib
>> -  Tcg2PhysicalPresenceLib
>>    ResetSystemLib
>>
>>  [Guids]
>> --
>> 2.16.1.73.g5832b7e9f2
>>
>> _______________________________________________
>> edk2-devel mailing list
>> edk2-devel@lists.01.org
>> https://lists.01.org/mailman/listinfo/edk2-devel
> _______________________________________________
> edk2-devel mailing list
> edk2-devel@lists.01.org
> https://lists.01.org/mailman/listinfo/edk2-devel
>=20
