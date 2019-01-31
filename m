Received: from eggs.gnu.org ([209.51.188.92]:55148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpCWy-0005b6-Dp
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpCWx-0007yP-3E
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:37:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gpCWv-0007wl-D8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:37:22 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-33-git-send-email-pbonzini@redhat.com>
	<fee0555f-1570-0006-96d0-410e364600d4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ba6f469-1556-7b99-eadd-3877b0a8d8e2@redhat.com>
Date: Thu, 31 Jan 2019 14:37:14 +0100
MIME-Version: 1.0
In-Reply-To: <fee0555f-1570-0006-96d0-410e364600d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 32/52] kconfig: introduce kconfig files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com

On 31/01/19 14:21, Thomas Huth wrote:
> On 2019-01-25 11:06, Paolo Bonzini wrote:
> [...]
>> diff --git a/hw/misc/macio/Kconfig b/hw/misc/macio/Kconfig
>> new file mode 100644
>> index 0000000..c6caeb6
>> --- /dev/null
>> +++ b/hw/misc/macio/Kconfig
>> @@ -0,0 +1,11 @@
>> +config CUDA
>> +    bool
>> +
>> +config MAC_PMU
>> +    bool
>> +
>> +config MAC_DBDMA
>> +    bool
>> +
>> +config MACIO_GPIO
>> +    bool
> [...]
>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> new file mode 100644
>> index 0000000..9da9d7d
>> --- /dev/null
>> +++ b/hw/ppc/Kconfig
> [...]
>> +
>> +config MAC_DBDMA
>> +    bool
>> +
>> +config MAC_PMU
>> +    bool
>> +
>> +config XIVE
>> +    bool
>> +
>> +config MACIO_GPIO
>> +    bool
>> +
>> +config XIVE_SPAPR
>> +    bool
>> +
>> +config CUDA
>> +    bool
> 
> I just noticed that the config switches from hw/misc/macio/Kconfig are
> duplicated here. Kind of ugly. Would it be possible to define them only
> in one place?

Yes, of course.  It's also a good idea to detect duplicate "config"
directives.

Paolo
