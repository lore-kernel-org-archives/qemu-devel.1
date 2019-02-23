Received: from eggs.gnu.org ([209.51.188.92]:54524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gxUzT-0003CO-Gk
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gxUzS-0007mc-D0
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:57:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gxUzS-0007TC-5Q
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:57:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so4070174wmg.2
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 02:56:38 -0800 (PST)
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
	<1550047098-1210-3-git-send-email-thuth@redhat.com>
	<CAFEAcA8XGsKzS=4=wn7k0ZYRpw7toNUtaxQarcvfmrcp_7LvZQ@mail.gmail.com>
	<0c13aed3-ff17-8416-270c-f2910ba51fe1@redhat.com>
	<64e51878-7692-1249-5c25-caf2a04c9339@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <27027fbe-af59-5cf4-f843-f8f515dd5708@redhat.com>
Date: Sat, 23 Feb 2019 11:56:35 +0100
MIME-Version: 1.0
In-Reply-To: <64e51878-7692-1249-5c25-caf2a04c9339@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 2/15/19 1:15 PM, Thomas Huth wrote:
> On 14/02/2019 21.35, Paolo Bonzini wrote:
>> On 14/02/19 20:17, Peter Maydell wrote:
>>> On Wed, 13 Feb 2019 at 08:38, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> Add Kconfig dependencies for the highbank machine (and the midway
>>>> machine).
>>>> This patch is slightly based on earlier work by Ákos Kovács (i.e.
>>>> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  default-configs/arm-softmmu.mak |  4 +---
>>>>  hw/arm/Kconfig                  | 12 ++++++++++++
>>>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>>>> index 3baafc4..59734ee 100644
>>>> --- a/default-configs/arm-softmmu.mak
>>>> +++ b/default-configs/arm-softmmu.mak
>>>> @@ -6,6 +6,7 @@ CONFIG_ARM_V7M=y
>>>>  CONFIG_PCI_DEVICES=y
>>>>
>>>>  CONFIG_EXYNOS4=y
>>>> +CONFIG_HIGHBANK=y
>>>>
>>>>  CONFIG_VGA=y
>>>>  CONFIG_NAND=y
>>>> @@ -54,14 +55,12 @@ CONFIG_PL022=y
>>>>  CONFIG_PL031=y
>>>>  CONFIG_PL041=y
>>>>  CONFIG_PL050=y
>>>> -CONFIG_PL061=y
>>>>  CONFIG_PL080=y
>>>>  CONFIG_PL110=y
>>>>  CONFIG_PL181=y
>>>>  CONFIG_PL190=y
>>>>  CONFIG_PL330=y
>>>>  CONFIG_CADENCE=y
>>>> -CONFIG_XGMAC=y
>>>
>>> Could you explain the logic for when CONFIG_*=y
>>> lines get deleted from the arm-softmmu.mak?
>>> In this patch PL061 has been deleted, but PL011,
>>> PL022, PL031 have not, though all these devices are
>>> used in both Highbank and in other not-yet-converted
>>> machine types. What's the difference ?
> 
> My plan was indeed to remove the switches from the default-configs file
> as soon as they are enabled in the Kconfig file. Looks like I missed
> these here in this patch, sorry!
> 
> (but unless there are other reasons for respinning, I think it should
> also be OK if the switches get removed in later patches instead)
> 
>> I think it's a mistake.  I'd not remove any CONFIG_*=y except in a final
>> separate patch.
> 
> Really? In that case it's way harder to see which options from the
> default-configs are really handled in the Kconfig files - and there's a
> risk that some options would get removed that are not enabled in any of
> the preceeding Kconfig patches. So I think it's better this way, bit by bit.

Agreed. This way you can build/test at each step.
