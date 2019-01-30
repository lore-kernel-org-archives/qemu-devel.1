Received: from eggs.gnu.org ([209.51.188.92]:35764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gotYf-0000Hk-3x
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gotYc-0001F8-SS
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:21:53 -0500
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-4-git-send-email-thuth@redhat.com>
	<630e6520-5860-bbd2-f480-07ba367d65a8@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64e87c9f-132c-83a9-7e94-b56f14ddb5b7@redhat.com>
Date: Wed, 30 Jan 2019 18:21:40 +0100
MIME-Version: 1.0
In-Reply-To: <630e6520-5860-bbd2-f480-07ba367d65a8@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/5] ppc: Express dependencies of the
 Mac machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: qemu-ppc@nongnu.org

On 30/01/19 18:13, Mark Cave-Ayland wrote:
>>  config MAC_NEWWORLD
>>      bool
>> +    select ADB
>> +    select MACIO
>> +    select UNIN_PCI
> Also MAC_NEWWORLD has an in-built USB PCI bridge (OHCI) which populates with a USB
> keyboard/mouse rather than ADB when using -M mac99,via=pmu, but I presume USB is
> handled elsewhere?

I guess in that case it's optional, and it is enabled already by
CONFIG_PCI_DEVICES.

But maybe it's a good idea to mark OHCI as "default y on PCI_DEVICES ||
MAC_NEWWORLD" just to document things better.

Paolo
