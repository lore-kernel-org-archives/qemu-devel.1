Received: from eggs.gnu.org ([2001:4830:134:3::10]:49541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgByW-00086H-8L
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgByP-0003TF-23
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:40:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47060
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fgByO-0003Rw-JM
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:40:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6JGeAbe052498
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:40:11 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kau9dgh8v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:40:09 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 19 Jul 2018 10:40:01 -0600
References: <1532012617-16777-1-git-send-email-walling@linux.ibm.com>
	<87sh4f191h.fsf@dusky.pond.sub.org>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 19 Jul 2018 12:39:58 -0400
MIME-Version: 1.0
In-Reply-To: <87sh4f191h.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2dca7714-195f-1532-a907-4e43bfd9355e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: print message when using 'help'
 with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>

On 07/19/2018 12:31 PM, Markus Armbruster wrote:
> You neglected to cc: maintainers.  Cc'ing them increases the odds your
> patch will be noticed and picked up.  You can use
> scripts/get_maintainer.pl to find maintainers.  You don't have to do
> anything for this patch; it got noticed anyway.
> 
> David, this is yours :)

Very true. Was a minor fix that I thought I'd just toss it out there and 
let anyone view it if they had the time. Will be more aware of who to CC
next time around.

Thanks :)

> 
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> When typing 'help' followed by an unknown command, QEMU will
>> not print anything to the command line to let the user know
>> they typed a bad command. Let's fix this by printing a message
>> to the monitor when this happens. For example:
>>
>>     (qemu) help xyz
>>     unknown command: 'xyz'
>>
>> Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  monitor.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 7af1f18..7942f9f 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1034,9 +1034,12 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
>>              } else {
>>                  help_cmd_dump_one(mon, cmd, args, arg_index);
>>              }
>> -            break;
>> +            return;
>>          }
>>      }
>> +
>> +    /* Entry not found */
>> +    monitor_printf(mon, "unknown command: '%s'\n", args[arg_index]);
>>  }
>>  
>>  static void help_cmd(Monitor *mon, const char *name)
> 


-- 
Respectfully,
- Collin Walling
