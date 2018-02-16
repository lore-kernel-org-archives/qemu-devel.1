Received: from eggs.gnu.org ([2001:4830:134:3::10]:38672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1emd5z-0003aY-PW
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1emd5w-0006is-KD
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:18:23 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:44262 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1emd5w-0006gb-DM
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:18:20 -0500
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
	<20180208180019.13683-2-antonios.motakis@huawei.com>
	<20180209133710.4d2c78b4@bahia.lan>
From: Antonios Motakis <antonios.motakis@huawei.com>
Message-ID: <dca157a1-63a5-7e2c-886c-649e5ecb77bd@huawei.com>
Date: Fri, 16 Feb 2018 11:19:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180209133710.4d2c78b4@bahia.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] 9pfs: V9fsQID: set type of version and
 path to unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, cota@braap.org, berrange@redhat.com



On 02/09/2018 01:37 PM, Greg Kurz wrote:
> On Thu, 8 Feb 2018 19:00:16 +0100
> <antonios.motakis@huawei.com> wrote:
>
>> From: Antonios Motakis <antonios.motakis@huawei.com>
>>
>> There is no need for signedness on these QID fields for 9p.
>>
>> Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
>> ---
> I agree these should be unsigned, but you have some more places to adapt
> to this change. At least these:
> - related traces in hw/9pfs/trace-events should then expect unsigned values
> - donttouch_stat() in hw/9pfs/9p.c should stop comparing them to -1

Noted!

>
>>   fsdev/9p-marshal.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fsdev/9p-marshal.h b/fsdev/9p-marshal.h
>> index c8823d8..d1ad364 100644
>> --- a/fsdev/9p-marshal.h
>> +++ b/fsdev/9p-marshal.h
>> @@ -10,8 +10,8 @@ typedef struct V9fsString
>>   typedef struct V9fsQID
>>   {
>>       int8_t type;
> Even if your series doesn't use it, while here, let's drop the sign from
> @type as well.
Agreed

>
>> -    int32_t version;
>> -    int64_t path;
>> +    uint32_t version;
>> +    uint64_t path;
>>   } V9fsQID;
>>   
>>   typedef struct V9fsStat
