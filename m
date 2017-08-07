Received: from eggs.gnu.org ([2001:4830:134:3::10]:56571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dehRE-0003I5-TD
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dehRA-0000Ms-3g
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:47:16 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:20593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dehR9-0000LR-Pd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:47:12 -0400
References: <1502109458-31251-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1502109458-31251-6-git-send-email-pradeep.jagadeesh@huawei.com>
	<8d3843e5-3e6e-84fc-c568-521603abb4c2@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <bacbecc8-5409-8dd1-990f-a59a26b8a849@huawei.com>
Date: Mon, 7 Aug 2017 14:46:43 +0200
MIME-Version: 1.0
In-Reply-To: <8d3843e5-3e6e-84fc-c568-521603abb4c2@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 5/6] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, alberto garcia <berto@igalia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 8/7/2017 2:44 PM, Eric Blake wrote:
> On 08/07/2017 07:37 AM, Pradeep Jagadeesh wrote:
>> This patch introduces qmp interfaces for the fsdev
>> devices. This provides two interfaces one
>> for querying info of all the fsdev devices. The second one
>> to set the IO limits for the required fsdev device.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>>  Makefile                    |  4 +++
>>  fsdev/qemu-fsdev-dummy.c    | 11 ++++++
>>  fsdev/qemu-fsdev-throttle.c | 76 ++++++++++++++++++++++++++++++++++++++++
>>  fsdev/qemu-fsdev-throttle.h |  8 +++--
>>  fsdev/qemu-fsdev.c          | 38 ++++++++++++++++++++
>>  monitor.c                   |  5 +++
>>  qapi-schema.json            |  3 ++
>>  qapi/fsdev.json             | 84 +++++++++++++++++++++++++++++++++++++++++++++
>>  qmp.c                       | 14 ++++++++
>>  9 files changed, 241 insertions(+), 2 deletions(-)
>>  create mode 100644 qapi/fsdev.json
>>
>
>> +##
>> +# @fsdev-set-io-throttle:
>> +#
>> +# Change I/O limits for a 9p/fsdev device.
>> +#
>> +# I/O limits can be enabled by setting throttle value to non-zero number.
>> +#
>> +# I/O limits can be disabled by setting all throttle values to 0.
>> +#
>> +# Returns: Nothing on success
>> +#          If @device is not a valid fsdev device, GenericError
>> +#
>> +# Since: 2.10
>> +#
>

> 2.11, now.

Hmm!.

-Pradeep

>
