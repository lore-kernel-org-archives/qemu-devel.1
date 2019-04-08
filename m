Received: from eggs.gnu.org ([209.51.188.92]:54618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDTTR-0001P8-JH
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDTTO-00041E-II
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:34:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDTTM-0003y9-6a
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:34:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-11-armbru@redhat.com>
	<eebcf43e-a4d3-d8b1-1611-23b665ebbe6e@gmail.com>
Date: Mon, 08 Apr 2019 14:33:57 +0200
In-Reply-To: <eebcf43e-a4d3-d8b1-1611-23b665ebbe6e@gmail.com> (Marcel
	Apfelbaum's message of "Mon, 8 Apr 2019 11:44:44 +0300")
Message-ID: <8736msr80a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/15] vl: Make -machine $TYPE,
 help and -accel help print to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org

Marcel Apfelbaum <marcel.apfelbaum@gmail.com> writes:

> Hi Markus,
>
> On 4/8/19 11:36 AM, Markus Armbruster wrote:
>> Command line help help explicitly requested by the user should be
>> printed to stdout, not stderr.  We do elsewhere.  Adjust -machine
>> $TYPE,help and -accel help to match: use printf() instead of
>> error_printf().
>>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   vl.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index c696ad2a13..792ef36001 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -1556,12 +1556,12 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
>>               continue;
>>           }
>>   -        error_printf("%s.%s=%s",
>> MACHINE_GET_CLASS(machine)->name,
>> -                     prop->name, prop->type);
>> +        printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
>> +                    prop->name, prop->type);
>
> Does the line above have an alignment issue?

Oops!  Will fix.

> Anyway,
>
> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thank you!
