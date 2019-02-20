Received: from eggs.gnu.org ([209.51.188.92]:58761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwU5X-0001if-JL
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwU5W-0003Sv-6l
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:47:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37361)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwU5V-0003Jc-Rb
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:47:10 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-6-git-send-email-pbonzini@redhat.com>
	<b48ecdfe-ab7c-9fde-89fd-0296863648eb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69b61fc5-2d4e-2982-92b5-c651cbf23c30@redhat.com>
Date: Wed, 20 Feb 2019 16:46:32 +0100
MIME-Version: 1.0
In-Reply-To: <b48ecdfe-ab7c-9fde-89fd-0296863648eb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/51] kconfig: introduce kconfig files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, philmd@redhat.com

On 20/02/19 16:42, Thomas Huth wrote:
> On 07/02/2019 18.56, Paolo Bonzini wrote:
>> The Kconfig files were generated mostly with this script:
>>
>>   for i in `grep -ho CONFIG_[A-Z0-9_]* default-configs/* | sort -u`; do
>>     set fnord `git grep -lw $i -- 'hw/*/Makefile.objs' `
>>     shift
>>     if test $# = 1; then
>>       cat >> $(dirname $1)/Kconfig << EOF
>> config ${i#CONFIG_}
>>     bool
>>
>> EOF
>>       git add $(dirname $1)/Kconfig
>>     else
>>       echo $i $*
>>     fi
>>   done
>>   sed -i '$d' hw/*/Kconfig
>>   for i in hw/*; do
>>     if test -d $i && ! test -f $i/Kconfig; then
>>       touch $i/Kconfig
>>       git add $i/Kconfig
>>     fi
>>   done
>>
>> Whenever a symbol is referenced from multiple subdirectories, the
>> script prints the list of directories that reference the symbol.
>> These symbols have to be added manually to the Kconfig files.
>>
>> Kconfig.host and hw/Kconfig were created manually.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>> Message-Id: <20190123065618.3520-27-yang.zhong@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
> [...]
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> new file mode 100644
>> index 0000000..64cd698
>> --- /dev/null
>> +++ b/hw/arm/Kconfig
>> @@ -0,0 +1,119 @@
>> +config ARM_VIRT
>> +    bool
>> +
>> +config DIGIC
>> +    bool
>> +
>> +config EXYNOS4
>> +    bool
>> +
>> +config HIGHBANK
>> +    bool
>> +
>> +config INTEGRATOR
>> +    bool
>> +
>> +config MAINSTONE
>> +    bool
>> +
>> +config MUSICPAL
>> +    bool
>> +
>> +config NETDUINO2
>> +    bool
>> +
>> +config NSERIES
>> +    bool
>> +
>> +config OMAP
>> +    bool
>> +
>> +config PXA2XX
>> +    bool
>> +
>> +config REALVIEW
>> +    bool
>> +
>> +config STELLARIS
>> +    bool
>> +
>> +config STRONGARM
>> +    bool
>> +
>> +config VERSATILE
>> +    bool
>> +
>> +config ZYNQ
>> +    bool
>> +
>> +config ARM_V7M
>> +    bool
>> +
>> +config EXYNOS4
>> +    bool
> 
> I just noticed: EXYNOS4 is defined twice in this file (it's also the
> third entry from the top). You can remove one of those.
> 
>> +config ALLWINNER_A10
>> +    bool
>> +
>> +config RASPI
>> +    bool
>> +
>> +config STM32F205_SOC
>> +    bool
>> +
>> +config XLNX_ZYNQMP_ARM
>> +    bool
>> +
>> +config XLNX_VERSAL
>> +    bool
>> +
>> +config FSL_IMX25
>> +    bool
>> +
>> +config FSL_IMX31
>> +    bool
>> +
>> +config FSL_IMX6
>> +    bool
>> +
>> +config ASPEED_SOC
>> +    bool
>> +
>> +config MPS2
>> +    bool
>> +
>> +config IOTKIT
>> +    bool
> 
> Are we using IOTKIT anywhere?

It's been renamed to ARMSSE.  I'll fix both.

Paolo
