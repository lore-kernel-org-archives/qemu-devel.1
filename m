Received: from eggs.gnu.org ([2001:4830:134:3::10]:55496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWTea-0005zD-SS
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWTea-0000GI-1L
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:03:52 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-3-eblake@redhat.com>
	<54a5b82e-f433-4624-d556-72cc9d43dab9@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82bd0f2c-bafa-84ec-5585-3897a47b6325@redhat.com>
Date: Mon, 10 Dec 2018 16:03:37 -0600
MIME-Version: 1.0
In-Reply-To: <54a5b82e-f433-4624-d556-72cc9d43dab9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/14] nbd/client: More consistent error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/5/18 9:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.12.2018 1:03, Eric Blake wrote:
>> Consolidate on using decimal (not hex) and on outputting the
>> option reply name (not just value) when the client reports
>> protocol discrepancies from the server.  While it won't affect
>> normal operation, it makes debugging additions easier.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> +        error_setg(errp, "Unexpected option type %u (%s) expected %u (%s)",
>> +                   reply->option, nbd_opt_lookup(reply->option),
>> +                   opt, nbd_opt_lookup(opt));

>> @@ -378,9 +380,9 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>>                return 1;
>>            }
>>            if (reply.type != NBD_REP_INFO) {
>> -            error_setg(errp, "unexpected reply type %" PRIu32
>> -                       " (%s), expected %u",
>> -                       reply.type, nbd_rep_lookup(reply.type), NBD_REP_INFO);
>> +            error_setg(errp, "unexpected reply type %u (%s), expected %u (%s)",
> 
> hmm, we are definitely inconsistent about having comma before "expected" word...
> 
> anyway,
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

That's minor enough; I'll add commas to all instances, but keep your R-b.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
