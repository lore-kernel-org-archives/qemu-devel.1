Received: from eggs.gnu.org ([209.51.188.92]:38095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gono4-0001Cb-89
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:13:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gono2-0002ic-76
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:13:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gono1-0002hR-R5
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:13:22 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-42-git-send-email-pbonzini@redhat.com>
	<815dd9b2-f2fb-40d1-67c1-9862e05f6b22@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0390e138-dc06-f82b-7867-c29e9be2e4fb@redhat.com>
Date: Wed, 30 Jan 2019 12:13:16 +0100
MIME-Version: 1.0
In-Reply-To: <815dd9b2-f2fb-40d1-67c1-9862e05f6b22@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 41/52] isa: express dependencies with
 kconfig
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

On 30/01/19 11:53, Thomas Huth wrote:
>> diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
>> index edb3d42..35ccb72 100644
>> --- a/hw/watchdog/Kconfig
>> +++ b/hw/watchdog/Kconfig
>> @@ -8,6 +8,8 @@ config WDT_IB6300ESB
>>  
>>  config WDT_IB700
>>      bool
>> +    default y
>> +    depends on ISA_BUS
> By the way, for pluggable ISA devices (like NE2000_ISA or WDT_IB700), it
> would be great to have a ISA_DEVICES config switch, just like the
> "PCI_DEVICES" switch, which the ISA devices should then depend on
> instead of "ISA_BUS". Then it would be easier for the users to disable
> optional devices in their builds.

Note that the only reason for PCI_DEVICES's existence is that s390x does
not want _all_ PCI devices.  Is there a use case for disabling
CONFIG_ISA_DEVICES but not wanting to base your configuration on
"allnoconfig"?

Paolo
