Received: from eggs.gnu.org ([2001:4830:134:3::10]:38441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh8oH-0003RK-OX
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 01:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh8oE-0002PM-N1
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 01:57:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eh8oE-0002P2-Hr
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 01:57:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-2-armbru@redhat.com>
	<1fed5cb6-e8c7-e289-ef56-08abca0913c9@redhat.com>
Date: Thu, 01 Feb 2018 07:57:19 +0100
In-Reply-To: <1fed5cb6-e8c7-e289-ef56-08abca0913c9@redhat.com> (Thomas Huth's
	message of "Wed, 31 Jan 2018 16:40:08 +0100")
Message-ID: <87mv0trycw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 01/19] Use #include "..." for our own
 headers, <...> for others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

Thomas Huth <thuth@redhat.com> writes:

> On 31.01.2018 15:48, Markus Armbruster wrote:
>> System headers should be included with <...>, our own headers with
>> "...". Offenders tracked down with an ugly, brittle and probably
>> buggy Perl script.  Previous iteration was commit a9c94277f0.
>> 
>> Put the cleaned up system header includes first, except for the ones
>> the next commit will delete.
>
> That's a little bit of code churn ... why not delete them here
> immediately, or simply ignore these headers here and just delete them in
> the next patch?

Ignore won't do, as scripts/clean-includes won't find them then.

Delete is possible, but requires still more explanation in the commit
message.  Worthwhile?

>> While there, separate #include from file comment with a blank line,
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
> [...]
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 0570f597ec..9968974fbe 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -13,8 +13,8 @@
>>   */
>>  
>>  
>
> While you're at it, remove one of the two blank lines?

Yes.

>> -#include "inttypes.h"
>> -#include "stdio.h"
>> +#include <inttypes.h>
>> +#include <stdio.h>
>>  #include "cpu_features_def.h"
>
> Above remarks are just nits, anyway patch looks fine, so:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!
