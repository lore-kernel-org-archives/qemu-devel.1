Received: from eggs.gnu.org ([2001:4830:134:3::10]:58963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZgMD-0004yn-6A
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZgM7-0005ZO-Sr
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZgM7-0005XY-Mp
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:14:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181219091248.9641-1-armbru@redhat.com>
	<20181219170150.m2tmhhg3tuyfrnvx@SPB-NB-133.local>
Date: Wed, 19 Dec 2018 19:14:01 +0100
In-Reply-To: <20181219170150.m2tmhhg3tuyfrnvx@SPB-NB-133.local> (Roman
	Bolshakov's message of "Wed, 19 Dec 2018 20:01:50 +0300")
Message-ID: <87d0pxcrkm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa: Include less of the generated
 modular QAPI headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

Roman Bolshakov <r.bolshakov@yadro.com> writes:

> On Wed, Dec 19, 2018 at 10:12:48AM +0100, Markus Armbruster wrote:
>> Avoids pointless recompilation.  Missed in commit 112ed241f5d.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> Untested; I don't have access to a Mac.
>> 
>>  ui/cocoa.m | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index ecf12bfc2e..43e751693c 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -32,7 +32,8 @@
>>  #include "ui/input.h"
>>  #include "sysemu/sysemu.h"
>>  #include "qapi/error.h"
>> -#include "qapi/qapi-commands.h"
>> +#include "qapi/qapi-commands-block-core.h"
>> +#include "qapi/qapi-commands-misc.h"
>>  #include "sysemu/blockdev.h"
>>  #include "qemu-version.h"
>>  #include <Carbon/Carbon.h>
>> -- 
>> 2.17.2
>> 
>> 
>
> Hi Markus,
>
> You should change change qapi/qapi-commands-block-core.h to
> qapi/qapi-commands-block.h to avoid:
>
> ui/cocoa.m:1225:5: warning: implicit declaration of function 'qmp_eject' is invalid in C99 [-Wimplicit-function-declaration]
>     qmp_eject(true, [drive cStringUsingEncoding: NSASCIIStringEncoding],
>     ^
> ui/cocoa.m:1225:5: warning: this function declaration is not a prototype [-Wstrict-prototypes]
>
> Thanks,
> Roman

Will do, thanks!
