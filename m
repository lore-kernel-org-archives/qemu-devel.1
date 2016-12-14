Received: from eggs.gnu.org ([2001:4830:134:3::10]:48647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cH4RQ-0000fo-AO
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cH4RN-0001t4-6H
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:57:32 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:54213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cH4RM-0001sp-Su
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:57:29 -0500
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-6-git-send-email-thuth@redhat.com>
	<CAFEAcA-BbkYdTkTWQcqyK-jU+dncnrfDyGwQamMTZ4jr1VqL9A@mail.gmail.com>
	<192aeaa3-042c-6e37-80b3-7a21453c542f@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bd4c203a-ac68-2532-b248-41c25bd90065@vivier.eu>
Date: Wed, 14 Dec 2016 08:56:37 +0100
MIME-Version: 1.0
In-Reply-To: <192aeaa3-042c-6e37-80b3-7a21453c542f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/20] arm: Move CPU files to target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

Le 14/12/2016 à 08:43, Thomas Huth a écrit :
> On 13.12.2016 19:19, Peter Maydell wrote:
>> On 9 December 2016 at 12:17, Thomas Huth <thuth@redhat.com> wrote:
>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>> index d4160df..60770d4 100644
>>> --- a/hw/arm/virt-acpi-build.c
>>> +++ b/hw/arm/virt-acpi-build.c
>>> @@ -33,7 +33,7 @@
>>>  #include "qemu/bitmap.h"
>>>  #include "trace.h"
>>>  #include "qom/cpu.h"
>>> -#include "target-arm/cpu.h"
>>> +#include "cpu.h"
>>>  #include "hw/acpi/acpi-defs.h"
>>>  #include "hw/acpi/acpi.h"
>>>  #include "hw/nvram/fw_cfg.h"
>>
>> Something looks wrong here. We definitely want the ARM
>> version of cpu.h, not any random cpu.h. The #include
>> filename should make it clear which file we're getting,
>> both so it's easier for humans to understand and so that
>> one day we might be able to build more than one target
>> CPU into the same QEMU binary.
> 
> Right, good catch, thanks! Looks like I did it right in the other
> patches and used target/ppc/cpu.h there for example ... I'll fix it for
> ARM in the next version of the patch...

There is the same problem in: m68k, alpha, mips and sh4.

Could you fix them too?

Laurent
