Received: from eggs.gnu.org ([209.51.188.92]:58829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gucOk-0005OX-8T
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gucOj-0000AC-GA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:15:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gucOj-00008W-5F
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:15:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6A42144194
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:15:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-160.ams2.redhat.com [10.36.116.160])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 151DB1001944
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:15:14 +0000 (UTC)
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
	<1550047098-1210-3-git-send-email-thuth@redhat.com>
	<CAFEAcA8XGsKzS=4=wn7k0ZYRpw7toNUtaxQarcvfmrcp_7LvZQ@mail.gmail.com>
	<0c13aed3-ff17-8416-270c-f2910ba51fe1@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <64e51878-7692-1249-5c25-caf2a04c9339@redhat.com>
Date: Fri, 15 Feb 2019 13:15:14 +0100
MIME-Version: 1.0
In-Reply-To: <0c13aed3-ff17-8416-270c-f2910ba51fe1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/25] hw/arm: Express dependencies of
 the highbank machines with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 14/02/2019 21.35, Paolo Bonzini wrote:
> On 14/02/19 20:17, Peter Maydell wrote:
>> On Wed, 13 Feb 2019 at 08:38, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> Add Kconfig dependencies for the highbank machine (and the midway
>>> machine).
>>> This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs=
 (i.e.
>>> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  default-configs/arm-softmmu.mak |  4 +---
>>>  hw/arm/Kconfig                  | 12 ++++++++++++
>>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-so=
ftmmu.mak
>>> index 3baafc4..59734ee 100644
>>> --- a/default-configs/arm-softmmu.mak
>>> +++ b/default-configs/arm-softmmu.mak
>>> @@ -6,6 +6,7 @@ CONFIG_ARM_V7M=3Dy
>>>  CONFIG_PCI_DEVICES=3Dy
>>>
>>>  CONFIG_EXYNOS4=3Dy
>>> +CONFIG_HIGHBANK=3Dy
>>>
>>>  CONFIG_VGA=3Dy
>>>  CONFIG_NAND=3Dy
>>> @@ -54,14 +55,12 @@ CONFIG_PL022=3Dy
>>>  CONFIG_PL031=3Dy
>>>  CONFIG_PL041=3Dy
>>>  CONFIG_PL050=3Dy
>>> -CONFIG_PL061=3Dy
>>>  CONFIG_PL080=3Dy
>>>  CONFIG_PL110=3Dy
>>>  CONFIG_PL181=3Dy
>>>  CONFIG_PL190=3Dy
>>>  CONFIG_PL330=3Dy
>>>  CONFIG_CADENCE=3Dy
>>> -CONFIG_XGMAC=3Dy
>>
>> Could you explain the logic for when CONFIG_*=3Dy
>> lines get deleted from the arm-softmmu.mak?
>> In this patch PL061 has been deleted, but PL011,
>> PL022, PL031 have not, though all these devices are
>> used in both Highbank and in other not-yet-converted
>> machine types. What's the difference ?

My plan was indeed to remove the switches from the default-configs file
as soon as they are enabled in the Kconfig file. Looks like I missed
these here in this patch, sorry!

(but unless there are other reasons for respinning, I think it should
also be OK if the switches get removed in later patches instead)

> I think it's a mistake.  I'd not remove any CONFIG_*=3Dy except in a fi=
nal
> separate patch.

Really? In that case it's way harder to see which options from the
default-configs are really handled in the Kconfig files - and there's a
risk that some options would get removed that are not enabled in any of
the preceeding Kconfig patches. So I think it's better this way, bit by b=
it.

 Thomas
