Received: from eggs.gnu.org ([2001:4830:134:3::10]:42536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTTpj-0004Qu-NH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTTpf-0002xa-UD
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:02:11 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:33320 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTTpf-0002wi-Im
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:02:07 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-7-vsementsov@virtuozzo.com>
	<b6c421c8-463a-aa8d-6555-533c4b7c4218@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ed613c75-0674-780b-4232-bb609b62b5ce@virtuozzo.com>
Date: Fri, 7 Jul 2017 17:02:04 +0300
MIME-Version: 1.0
In-Reply-To: <b6c421c8-463a-aa8d-6555-533c4b7c4218@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 6/6] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

06.07.2017 18:44, Eric Blake wrote:
> On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Starting from this patch to enable traces use -trace option of qemu or
>> -T, --trace option of qemu-img, qemu-io and qemu-nbd. For qemu traces
>> also can be managed by qmp commands trace-event-{get,set}-state.
>>
>> Recompilation with CFLAGS=-DDEBUG_NBD is no more needed, furthermore,
>> DEBUG_NBD macro is removed from the code.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> +++ b/nbd/server.c
>> @@ -441,7 +441,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
>>           }
>>           length = be32_to_cpu(length);
>>   
>> -        TRACE("Checking option 0x%" PRIx32, clientflags);
>> +        trace_nbd_negotiate_options_check_option(clientflags);
> This variable is a stupid name (it has nothing to do with flags, but is
> a single integer representing the option requested by the client). Now's

will use your wording for commit message)

> as good as any to rename it to something that makes sense (maybe 'option').
>
>> +nbd_negotiate_options_check_option(uint32_t clientflags) "Checking option 0x%" PRIx32
> and likewise use the saner name in the trace file.  Perhaps as a
> separate cleanup patch.
>

-- 
Best regards,
Vladimir
