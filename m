Received: from eggs.gnu.org ([2001:4830:134:3::10]:50879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d8qkL-0001Z7-9F
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d8qkH-0004nC-5P
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:15:21 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:13275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d8qkG-0004mN-R1
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:15:17 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-4-git-send-email-pradeep.jagadeesh@huawei.com>
	<3797fb7d-bd3d-c1b0-0707-57f95852cb5f@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <f17af06c-82d5-f502-a9f4-6c31825b5eba@huawei.com>
Date: Thu, 11 May 2017 18:14:57 +0200
MIME-Version: 1.0
In-Reply-To: <3797fb7d-bd3d-c1b0-0707-57f95852cb5f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/4] qmp: refactor duplicate code
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

On 5/10/2017 9:56 PM, Eric Blake wrote:
> On 05/10/2017 03:41 AM, Pradeep Jagadeesh wrote:
>> This patch factor out the duplicate qmp throttle interface code
>> that was present in both block and fsdev device files.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>>  blockdev.c                      | 53 +++-------------------------------------
>>  hmp.c                           | 21 +++++++++++-----
>>  include/qemu/throttle-options.h |  2 ++
>>  util/throttle-options.c         | 54 +++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 74 insertions(+), 56 deletions(-)
>>
>
>> +++ b/include/qemu/throttle-options.h
>> @@ -94,4 +94,6 @@
>>
>>  void parse_io_throttle_options(ThrottleConfig *, QemuOpts *);
>>
>> +void qmp_set_io_throttle(ThrottleConfig *, IOThrottle *);
>
> I don't think this is the right name for this function.  You are not
> adding a new QMP command (you didn't modify a .json file to add
> 'set-io-throttle').  As mentioned in patch 1/4, you can probably reuse
> the existing util/throttle.c instead of throttle-options.c, and name
> this something starting with throttle_ rather than with qmp_.
>
OK

-Pradeep
>
