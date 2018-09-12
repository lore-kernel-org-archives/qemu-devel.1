Received: from eggs.gnu.org ([2001:4830:134:3::10]:33546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g06DR-0000Do-CZ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g06DN-0000VA-GV
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:34:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52846 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g06DL-0000So-H4
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:33:56 -0400
References: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
	<1529421657-14969-2-git-send-email-jingqi.liu@intel.com>
	<20180716135400.4e7f7d7b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01a7678e-14d0-6687-3545-e408abf59b52@redhat.com>
Date: Wed, 12 Sep 2018 09:33:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180716135400.4e7f7d7b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1 RESEND 1/6] hmat acpi: Build Memory
 Subsystem Address Range Structure(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Liu Jingqi <jingqi.liu@intel.com>
Cc: ehabkost@redhat.com, pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, rth@twiddle.net, armbru@redhat.com, qemu-devel@nongnu.org

On 7/16/18 6:54 AM, Igor Mammedov wrote:

>> +
>> +#include "unistd.h"
>> +#include "fcntl.h"
>> +#include "qemu/osdep.h"
>> +#include "sysemu/numa.h"
>> +#include "hw/i386/pc.h"
>> +#include "hw/i386/acpi-build.h"
>> +#include "hw/acpi/acpi.h"
>> +#include "hw/acpi/hmat.h"
>> +#include "hw/acpi/aml-build.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +#include "hw/acpi/bios-linker-loader.h"
> Do all this headers are really needed here?

Furthermore, "qemu/osdep.h" MUST be listed first (as it may set macros 
that affect the content of other headers); "qemu/osdep.h" already takes 
care of including <unistd.h> and <fcntl.h>; and even if it hadn't, 
system headers should be spelled like <unistd.h> rather than "unistd.h".

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
