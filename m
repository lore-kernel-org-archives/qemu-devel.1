Received: from eggs.gnu.org ([2001:4830:134:3::10]:36593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTSGU-0007yj-7C
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTSGT-0005ha-C8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:21:42 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:30256 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTSGT-0005hA-0e
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:21:41 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-24-vsementsov@virtuozzo.com>
	<871sps7kdj.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <652acde8-a873-f0ec-50e6-1cecdd72184b@virtuozzo.com>
Date: Fri, 7 Jul 2017 15:21:24 +0300
MIME-Version: 1.0
In-Reply-To: <871sps7kdj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v22 23/30] qmp: add persistent flag to
 block-dirty-bitmap-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

07.07.2017 10:54, Markus Armbruster wrote:
> QAPI schema review only...  I apologize for its lateness.
>
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>
>> Add optional 'persistent' flag to qmp command block-dirty-bitmap-add.
>> Default is false.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> ---
> [...]
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index f85c2235c7..13f98ec146 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1561,10 +1561,16 @@
>>   # @granularity: the bitmap granularity, default is 64k for
>>   #               block-dirty-bitmap-add
>>   #
>> +# @persistent: the bitmap is persistent, i.e. it will be saved to the
>> +#              corresponding block device image file on its close. For now only
>> +#              Qcow2 disks support persistent bitmaps. Default is false for
>> +#              block-dirty-bitmap-add. (Since: 2.10)
> "for block-dirty-bitmap-add" suggests there could be other users, with
> different (but unspecified) defaults.  What about replacing the sentence
> by "(default: false)"?
>
> Please wrap your comment lines around column 70.

Why 70, is it written somewhere? There are a lot of lines over 70 
characters in this file, so, as series are already in Max's block branch 
I think it would be better to fix the whole file, if it is really needed.

>
>> +#
>>   # Since: 2.4
>>   ##
>>   { 'struct': 'BlockDirtyBitmapAdd',
>> -  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32' } }
>> +  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
>> +            '*persistent': 'bool' } }
>>   
>>   ##
>>   # @block-dirty-bitmap-add:


-- 
Best regards,
Vladimir
