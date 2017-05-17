Received: from eggs.gnu.org ([2001:4830:134:3::10]:51427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dB0L5-0003Lg-Oa
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dB0L1-0005Jm-7T
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:54:11 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:13416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dB0L0-0005Fb-Sw
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:54:07 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
	<6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
Date: Wed, 17 May 2017 16:53:44 +0200
MIME-Version: 1.0
In-Reply-To: <6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 5/10/2017 10:00 PM, Eric Blake wrote:
> On 05/10/2017 03:41 AM, Pradeep Jagadeesh wrote:
>> This patch enables qmp interfaces for the fsdev
>> devices. This provides two interfaces one
>> for querying info of all the fsdev devices. The second one
>> to set the IO limits for the required fsdev device.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>
>> +++ b/qmp.c
>> @@ -130,6 +130,21 @@ void qmp_cpu_add(int64_t id, Error **errp)
>>      }
>>  }
>>
>> +#ifdef _WIN64
>> +
>> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
>> +{
>> +  return;
>> +}
>> +
>> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
>> +{
>> +    abort();
>> +}
>> +
>> +#endif
>
> I think you're missing an addition to monitor.c
> qmp_unregister_commands_hack() if you intend for this command to be
> available only on non-windows platforms (and is your #ifdef the correct
> name, or is this a Linux-only feature rather than a non-windows feature).
I had to add this one here because, I was getting some error when I 
cross compile for Windows. But I do not have any idea about, do I need 
to add in monitor.c or not.

Regards,
Pradeep
>
