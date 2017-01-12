Received: from eggs.gnu.org ([2001:4830:134:3::10]:48317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRiNW-0000Xb-V0
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRiNR-0006Du-3J
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:37:31 -0500
References: <20170111173457.30455-1-lersek@redhat.com>
	<20170112163009-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1b1eca80-08e2-e9dd-1d04-c208f68e8a57@redhat.com>
Date: Thu, 12 Jan 2017 17:37:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170112163009-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 wave 1 0/4] fw-cfg: support writeable
 blobs and more files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Gabriel L. Somlo" <somlo@cmu.edu>, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-arm@nongnu.org

On 01/12/17 15:30, Michael S. Tsirkin wrote:
> On Wed, Jan 11, 2017 at 06:34:53PM +0100, Laszlo Ersek wrote:
>> This is the first (fw_cfg) half of the v5 iteration of the series posted
>> here:
>> <http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00129.html>.
>>
>> In this version, the fw_cfg patches have been separated into a
>> standalone "wave", for helping review / maintenance, and also for
>> enabling independent features on top of writeable blobs. More
>> importantly, I've addressed Igor's v4 feedback. See the individual
>> patches for the details.
>>
>> Patch #3 is included verbatim from Eduardo's pending series (see the
>> patch notes for the archive URL), as a dependency for patch #4. If
>> Eduardo's series is merged first, patch #3 can be dropped (in fact
>> git-rebase should do it automatically).
>>
>> Please excuse the surprisingly long list of CC's, it's due to the fact
>> that fw_cfg is quite widely used (see patch #4).
> 
> Looks good. So what's the plan for merging this?
> I think I'll merge part 1 and then Paolo merges part 2 -
> is that what you had in mind?

It certainly works for me, thank you!

Paolo hasn't commented on wave 2 yet, so I'm not sure about that half,
but you did express a preference for this kind of work distribution in
v4, so that's fine with me.

I'll send out v6 with the property name update in a minute (picking up
the feedback tags from Gabriel -- thanks agan for that!)

Cheers
Laszlo


> 
>> Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: Michael Walle <michael@walle.cc>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: qemu-arm@nongnu.org
>>
>> Thanks
>> Laszlo
>>
>>
>> Eduardo Habkost (1):
>>   pc: Add 2.9 machine-types
>>
>> Laszlo Ersek (2):
>>   fw-cfg: turn FW_CFG_FILE_SLOTS into a device property
>>   fw-cfg: bump "file_slots" to 0x20 for 2.9+ machine types
>>
>> Michael S. Tsirkin (1):
>>   fw-cfg: support writeable blobs
>>
>>  docs/specs/fw_cfg.txt          |  36 ++++++++++----
>>  hw/lm32/lm32_hwsetup.h         |   2 +-
>>  include/hw/compat.h            |  10 +++-
>>  include/hw/i386/pc.h           |   2 +
>>  include/hw/loader.h            |   7 +--
>>  include/hw/nvram/fw_cfg.h      |   3 +-
>>  include/hw/nvram/fw_cfg_keys.h |   3 +-
>>  hw/arm/virt-acpi-build.c       |   2 +-
>>  hw/core/loader.c               |  18 ++++---
>>  hw/i386/acpi-build.c           |   4 +-
>>  hw/i386/pc_piix.c              |  15 ++++--
>>  hw/i386/pc_q35.c               |  13 ++++-
>>  hw/nvram/fw_cfg.c              | 110 +++++++++++++++++++++++++++++++++++------
>>  13 files changed, 177 insertions(+), 48 deletions(-)
>>
>> -- 
>> 2.9.3
