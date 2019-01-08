Received: from eggs.gnu.org ([209.51.188.92]:38376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggpsO-0008Cm-H0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggpsN-0005iv-RB
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:48:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ggpsN-0005Z1-HZ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:48:55 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-23-yang.zhong@intel.com>
	<1f94070a-d9df-9fb9-66e8-77e576aeb229@redhat.com>
	<20190108105306.GH27840@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7037326c-a4ec-03b9-5018-4321af68ead9@redhat.com>
Date: Tue, 8 Jan 2019 12:48:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190108105306.GH27840@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 22/25] i386-softmmu.mak: remove all
 CONFIG_* except boards definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com

On 08/01/19 11:53, Yang Zhong wrote:
> Thanks for detailed comments, i will change this one by one.
> The previous plan put all "selects" into hw/i386/Kconfig file, which
> can easily config board if we want to optimize i440fx or q35 platform.

The selects are for mandatory devices, so if you remove them the machine
will not start.

If you want to reduce the platform by omitting non-mandatory devices,
you can use default-configs, because non-mandatory devices will be
"default y" (or "default y if PC/PCI/SCSI/I2C"/whatever).

Paolo

> The new solution will spread "selects" into detailed hw/*/Kconfig file.
