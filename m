Received: from eggs.gnu.org ([2001:4830:134:3::10]:51274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecToU-00072r-Ss
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecToU-0003H4-3h
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:22:22 -0500
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
	<20180118181123.37056-7-vsementsov@virtuozzo.com>
	<b78ed017-a01d-2e03-e998-e99c4d5c1f57@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9a3dbbf4-7e3a-f725-576f-9f368c4435e8@virtuozzo.com>
Date: Fri, 19 Jan 2018 13:22:11 +0300
MIME-Version: 1.0
In-Reply-To: <b78ed017-a01d-2e03-e998-e99c4d5c1f57@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 6/6] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

19.01.2018 01:43, Eric Blake wrote:
> On 01/18/2018 12:11 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/201     | 159 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/201.out |   5 ++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 165 insertions(+)
>>   create mode 100644 tests/qemu-iotests/201
>>   create mode 100644 tests/qemu-iotests/201.out
>>
>> +
>> +    def assertExistingClients(self, result):
>> +        self.assert_qmp(result, 'error/desc',
>> +                        "NBD export 'exp' has 1 active connection. To force "
>> +                        "remove it (and hard disconnect clients) use "
>> +                        "mode='hard'")
> Needs tweaking if we massage the error message earlier in the series.
>
> I'm still worried that this test may fail spuriously due to a hard-coded
> port, but some testing is better than none, and if the CI engines don't
> immediately reject it, whoever first encounters it will be nice and let
> us know.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>

Looked through other tests, looks like same approach is only in 147, and 
other iotests uses unix sockets for nbd-server-start. May be, it is 
better to move to unix socket here.
I'll resend today with unix-socket.

-- 
Best regards,
Vladimir
