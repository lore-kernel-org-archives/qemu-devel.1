Received: from eggs.gnu.org ([209.51.188.92]:37483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggpq9-0006jP-5C
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggpq7-0000k5-9V
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:46:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ggpq2-0000Sy-CV
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:46:31 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-18-yang.zhong@intel.com>
	<ac00d820-95b3-5e36-f971-0f0d5f305209@redhat.com>
	<20190108091523.GD27840@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e203c7c-ce84-9c3f-2ea8-6fb3246e57ea@redhat.com>
Date: Tue, 8 Jan 2019 12:46:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190108091523.GD27840@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 17/25] i2c: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com

On 08/01/19 10:15, Yang Zhong wrote:
>>  config SM501
>>      bool
>> +    depends on I2C
>>  
>>  config TCX
>>      bool
> I think XLNX_ZYNQMP_ARM likely needs "depends on I2C" nowadays, too ?

CONFIG_DDC should depend on I2C, while CONFIG_AUX should select I2C.

In a second phase, XLNX_ZYNQMP will select DDC.

Paolo
