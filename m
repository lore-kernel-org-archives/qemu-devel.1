Received: from eggs.gnu.org ([209.51.188.92]:59878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqzap-0005U5-TM
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqzLy-00059h-31
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:57:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqzLx-00059I-Ta
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:57:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so3318352wmi.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 03:57:24 -0800 (PST)
References: <20190204202609.26956-1-philmd@redhat.com>
	<20190204202609.26956-3-philmd@redhat.com>
	<670e437d-845c-22fa-24d6-f44dd2568e15@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb931549-48d2-5056-bc25-9bb82a91a402@redhat.com>
Date: Tue, 5 Feb 2019 12:57:21 +0100
MIME-Version: 1.0
In-Reply-To: <670e437d-845c-22fa-24d6-f44dd2568e15@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] mips: Express dependencies of the
 Jazz machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>

On 2/5/19 5:04 AM, Thomas Huth wrote:
> On 2019-02-04 21:26, Philippe Mathieu-Daudé wrote:
>> The Jazz use the RC4030 Asic to provide an EISA bus and DMA/IRQ. The
>> framebuffer display is managed by a G364, the network card is a Sonic
>> DP83932. A QLogic ESP216 provides a SCSI bus.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  default-configs/mips-softmmu-common.mak |  1 -
>>  default-configs/mips64-softmmu.mak      |  5 -----
>>  default-configs/mips64el-softmmu.mak    |  6 ------
>>  hw/mips/Kconfig                         | 17 +++++++++++++++++
>>  4 files changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
>> index 8c5fdf5ee1..caebafd416 100644
>> --- a/default-configs/mips-softmmu-common.mak
>> +++ b/default-configs/mips-softmmu-common.mak
>> @@ -3,7 +3,6 @@
>>  CONFIG_ISA_BUS=y
>>  CONFIG_PCI=y
>>  CONFIG_PCI_DEVICES=y
>> -CONFIG_ESP=y
>>  CONFIG_VGA_ISA=y
>>  CONFIG_VGA_ISA_MM=y
>>  CONFIG_VGA_CIRRUS=y
>> diff --git a/default-configs/mips64-softmmu.mak b/default-configs/mips64-softmmu.mak
>> index bad7496672..a169738635 100644
>> --- a/default-configs/mips64-softmmu.mak
>> +++ b/default-configs/mips64-softmmu.mak
>> @@ -1,9 +1,4 @@
>>  # Default configuration for mips64-softmmu
>>  
>>  include mips-softmmu-common.mak
>> -CONFIG_RC4030=y
>> -CONFIG_DP8393X=y
>> -CONFIG_DS1225Y=y
>>  CONFIG_JAZZ=y
>> -CONFIG_G364FB=y
>> -CONFIG_JAZZ_LED=y
>> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
>> index 8b255efc54..23445cfcf9 100644
>> --- a/default-configs/mips64el-softmmu.mak
>> +++ b/default-configs/mips64el-softmmu.mak
>> @@ -2,13 +2,7 @@
>>  
>>  include mips-softmmu-common.mak
>>  CONFIG_IDE_VIA=y
>> -CONFIG_RC4030=y
>> -CONFIG_DP8393X=y
>> -CONFIG_DS1225Y=y
>>  CONFIG_FULONG=y
>> -CONFIG_JAZZ=y
> 
> Please keep the CONFIG_JAZZ line here.

Oops... Thanks for catching this :)

Phil.
