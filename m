Received: from eggs.gnu.org ([2001:4830:134:3::10]:48903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cgIJv-0002X5-5P
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:50:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cgIJr-0005EX-7w
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:50:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35061
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1cgIJr-0005Dn-0p
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:49:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1LLnQLx108212
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 16:49:57 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28rr987fbt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 16:49:57 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 21 Feb 2017 18:49:54 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 7376C352005F
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 16:49:19 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1LLnrNt35979434
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 18:49:53 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1LLnqov008718
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 18:49:52 -0300
References: <20170220160316.16803-1-danielhb@linux.vnet.ibm.com>
	<87ino3ncg5.fsf@dusky.pond.sub.org>
	<e9388bc4-2c50-0656-e140-b5478f35237b@linux.vnet.ibm.com>
	<87d1ebpr46.fsf@dusky.pond.sub.org> <20170221143222.GJ2377@work-vm>
	<87k28j4kbu.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 18:49:49 -0300
MIME-Version: 1.0
In-Reply-To: <87k28j4kbu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <aab2325c-a50b-f89e-43da-9a1d1e464af5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] Changing error message of QMP
 'migrate_set_downtime' to seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com



On 02/21/2017 12:47 PM, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>
>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>>>
>>>> On 02/21/2017 06:02 AM, Markus Armbruster wrote:
>>>>> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>>>>>
>>>>>> The previous error message was displaying the values in miliseconds,
>>>>>> being misleading with the command that accepts the value in seconds:
>>>>>>
>>>>>> { "execute": "migrate_set_downtime", "arguments": {"value": 3000}}
>>>>>> {"error": {"class": "GenericError", "desc": "Parameter 'downtime_limit'
>>>>>> expects an integer in the range of 0 to 2000000 milliseconds"}}
>>>>>>
>>>>>> This patch changes it to '2000 seconds' to keep consistency with
>>>>>> the expected parameter. The macro 'QERR_INVALID_PARAMETER_VALUE'
>>>>>> was changed for a regular string that allows the use of the
>>>>>> MAX_MIGRATE_SET_DOWNTIME as a parameter, instead of hardcoding
>>>>>> the value in the error message.
>>>>>>
>>>>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>    migration/migration.c | 12 ++++++++----
>>>>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>>> index c6ae69d..c05e764 100644
>>>>>> --- a/migration/migration.c
>>>>>> +++ b/migration/migration.c
>>>>>> @@ -49,6 +49,9 @@
>>>>>>     * for sending the last part */
>>>>>>    #define DEFAULT_MIGRATE_SET_DOWNTIME 300
>>>>>>    +/* Maximum migrate downtime set to 2000*1000 miliseconds */
>>>>>> +#define MAX_MIGRATE_SET_DOWNTIME (2000 * 1000)
>>>>>> +
>>>>>>    /* Default compression thread count */
>>>>>>    #define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
>>>>>>    /* Default decompression thread count, usually decompression is at
>>>>>> @@ -843,10 +846,11 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>>>>>            return;
>>>>>>        }
>>>>>>        if (params->has_downtime_limit &&
>>>>>> -        (params->downtime_limit < 0 || params->downtime_limit > 2000000)) {
>>>>>> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>>>>>> -                   "downtime_limit",
>>>>>> -                   "an integer in the range of 0 to 2000000 milliseconds");
>>>>>> +        (params->downtime_limit < 0 ||
>>>>>> +         params->downtime_limit > MAX_MIGRATE_SET_DOWNTIME)) {
>>>>>> +        error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
>>>>>> +                         "the range of 0 to %d seconds",
>>>>>> +                         MAX_MIGRATE_SET_DOWNTIME / 1000);
>>>>>>            return;
>>>>>>        }
>>>>>>        if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {
>>>>> Isn't this wrong for QMP migrate-set-parameters?  There, the unit is
>>>>> milliseconds, i.e. the new error message is as wrong as the old one is
>>>>> for migrate_set_downtime.
>>>> Actually the unit for migrate-set-parameters, as seen by the caller,
>>>> is seconds. The underlying logic receives the input and multiplies it
>>>> by 1000 in qmp_migrate_set_downtime().
>>> Yes, QMP migrate_set_downtime takes seconds, but I'm talking about QMP
>>> command migrate-set-parameters, which takes milliseconds.
>>>
>>>>> I'm afraid you need to fix the error message in
>>>>> qmp_migrate_set_downtime().  If you assume qmp_migrate_set_parameters()
>>>>> fails only in one way, replace its error object by one with a better
>>>>> message[*].  If you'd rather not assume, you need to refactor things so
>>>>> that each place can set the downtime and create an appropriate error on
>>>>> failure.
>>>> There is at least one similar usage of this error message just
>>>> above this code in max_bandwidth param. Perhaps a new
>>>> function/macro to deal with these cases is justified.
>>>>
>>>>> We might want to check other command wrappers that translate units.
>>>>>
>>>>> Time units are a hopeless mess in QMP.  We should've enforced uniform
>>>>> usage of either seconds or nanoseconds.  The latter to placate
>>>>> irrational fear of floating-point[**].
>>>> I agree that my patch doesn't make it much better. I just set the
>>>> error message to be in seconds to be consistent with the user input,
>>> That's reasonable!  The problem is that you fix one error message by
>>> breaking another one.

I see. The problem is that I haven't taken into consideration that 
set_downtime
can also be set by migrate_set_parameters. My bad.

I'll fix the error message of set_downtime without breaking the one in
set_parameters in v3.


Daniel
>>>
>>>> but the code now feels 'awkward' when you do a verification
>>>> in milliseconds and deliver the error message in seconds.
>>>>
>>>> One thing that can be done is to make migrate-set-downtime to
>>>> accept milliseconds instead of seconds. I wasn't willing at first to
>>>> change the migrate-set-downtime API because of an error
>>>> message, however it really feels like the right thing to do here.
>>> Changing QMP commands incompatibly is a big no-no.
>>>
>>>> Specially when you consider that the default value of this parameter,
>>>> set by DEFAULT_MIGRATE_SET_DOWNTIME, is 300 - a value that
>>>> in theory the user shouldn't be able to set in the API.
>>> I think that's a fine reason for deprecating the migrate_set_downtime
>>> command, and ask people to use migrate-set-parameters instead.
>> OK, but you can set it to 300 from migrate_set_downtime by doing
>> HMP:
>>     migrate_set_downtime 0.3
>> QMP:
>>     { "execute": "migrate_set_downtime", "arguments": { "value": 0.3 } }
>>
>> so it's bogus to say that's a reason to ditch it.
> I bought Daniel's assertion without checking it.  Thanks for the
> correction.
>
>> This has all got rather complex for a simple patch to change an error
>> message.  Can't we just come up with a clear error message that works in
>> all cases.
> I outlined how to fix migrate_set_downtime's error message without
> breaking migrate-set-parameters's in my review.
>
> If we can come up with a single message that works for both commands,
> even better.
>
>> Dave
>>
>>>>> [*] If replacing messages turns out to be a common operation, we can add
>>>>> a function to replace it within the same Error object.
>>>>>
>>>>> [**] If you think the rounding you can get when converting
>>>>> floating-point seconds to integer milli-, micro- or nanoseconds matters,
>>>>> I have time-keeping equipment to sell you.
>>>>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
