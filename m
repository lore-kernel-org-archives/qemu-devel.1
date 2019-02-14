Received: from eggs.gnu.org ([209.51.188.92]:46412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guNjN-0001OL-Bd
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guNjK-0002v0-12
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:35:36 -0500
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
	<1550047098-1210-3-git-send-email-thuth@redhat.com>
	<CAFEAcA8XGsKzS=4=wn7k0ZYRpw7toNUtaxQarcvfmrcp_7LvZQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c13aed3-ff17-8416-270c-f2910ba51fe1@redhat.com>
Date: Thu, 14 Feb 2019 21:35:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XGsKzS=4=wn7k0ZYRpw7toNUtaxQarcvfmrcp_7LvZQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 14/02/19 20:17, Peter Maydell wrote:
> On Wed, 13 Feb 2019 at 08:38, Thomas Huth <thuth@redhat.com> wrote:
>>
>> Add Kconfig dependencies for the highbank machine (and the midway
>> machine).
>> This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs =
(i.e.
>> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak |  4 +---
>>  hw/arm/Kconfig                  | 12 ++++++++++++
>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index 3baafc4..59734ee 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -6,6 +6,7 @@ CONFIG_ARM_V7M=3Dy
>>  CONFIG_PCI_DEVICES=3Dy
>>
>>  CONFIG_EXYNOS4=3Dy
>> +CONFIG_HIGHBANK=3Dy
>>
>>  CONFIG_VGA=3Dy
>>  CONFIG_NAND=3Dy
>> @@ -54,14 +55,12 @@ CONFIG_PL022=3Dy
>>  CONFIG_PL031=3Dy
>>  CONFIG_PL041=3Dy
>>  CONFIG_PL050=3Dy
>> -CONFIG_PL061=3Dy
>>  CONFIG_PL080=3Dy
>>  CONFIG_PL110=3Dy
>>  CONFIG_PL181=3Dy
>>  CONFIG_PL190=3Dy
>>  CONFIG_PL330=3Dy
>>  CONFIG_CADENCE=3Dy
>> -CONFIG_XGMAC=3Dy
>=20
> Could you explain the logic for when CONFIG_*=3Dy
> lines get deleted from the arm-softmmu.mak?
> In this patch PL061 has been deleted, but PL011,
> PL022, PL031 have not, though all these devices are
> used in both Highbank and in other not-yet-converted
> machine types. What's the difference ?

I think it's a mistake.  I'd not remove any CONFIG_*=3Dy except in a fina=
l
separate patch.

Paolo
