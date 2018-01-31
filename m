Received: from eggs.gnu.org ([2001:4830:134:3::10]:56966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egn7w-0007xb-3T
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egn7s-00081Z-Rv
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:48:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egn7s-00081P-LX
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:48:12 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-2-armbru@redhat.com>
	<alpine.BSF.2.21.1801301417470.81470@zero.eik.bme.hu>
Date: Wed, 31 Jan 2018 08:48:05 +0100
In-Reply-To: <alpine.BSF.2.21.1801301417470.81470@zero.eik.bme.hu> (BALATON
	Zoltan's message of "Tue, 30 Jan 2018 14:22:29 +0100 (CET)")
Message-ID: <87lgge79l6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/18] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 30 Jan 2018, Markus Armbruster wrote:
>> Clean up includes so that osdep.h is included first and headers
>> which it implies are not included manually.
>>
>> This commit was created with scripts/clean-includes, with the change
>> to target/s390x/gen-features.c manually reverted, and blank lines
>> around deletions collapsed.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
[...]
>> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
>> index 17aa930e39..a5d1776756 100644
>> --- a/hw/ide/sii3112.c
>> +++ b/hw/ide/sii3112.c
>> @@ -12,6 +12,7 @@
>>  * http://wiki.osdev.org/User:Quok/Silicon_Image_Datasheets
>>  */
>>
>> +#include "qemu/osdep.h"
>> #include <qemu/osdep.h>
>> #include <hw/ide/pci.h>
>> #include "trace.h"
>
> This is wrong. I've sent a patch instead to change angle brackets to
> quotes for these two includes. This wasn't catched either by
> checkpatch nor review though so maybe it could be added to checkpatch
> if quotes are the preferred style for these includes.

Good catch!  There's more than these two in the tree.  I'll stick in a
suitable cleanup patch.
