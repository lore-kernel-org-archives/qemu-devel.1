Received: from eggs.gnu.org ([2001:4830:134:3::10]:50541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dlGKt-0007R7-MA
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dlGKp-0002kI-NI
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dlGKp-0002jc-Cu
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:15:47 -0400
References: <1503493480-21691-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1503493480-21691-3-git-send-email-chugh.ishani@research.iiit.ac.in>
	<CAFEAcA_K8XK_pWsy_KUDgJt8gqfAKJsHfDA6MeW651nqGz82CQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4f8e1d78-52e5-8047-5899-4e2a54093dd1@redhat.com>
Date: Fri, 25 Aug 2017 11:15:37 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_K8XK_pWsy_KUDgJt8gqfAKJsHfDA6MeW651nqGz82CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] Test for full Backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>



On 08/25/2017 10:36 AM, Peter Maydell wrote:
> On 23 August 2017 at 14:04, Ishani Chugh
> <chugh.ishani@research.iiit.ac.in> wrote:
>> This patch is the test for full backup implementation in Backup tool.
>> The test employs two basic substests:
>> 1) Backing up an empty guest and comparing it with base image.
>> 2) Writing a pattern to the guest, creating backup and comparing
>>    with the base image.
>>
>> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
>> ---
>>  tests/qemu-iotests/191     | 78 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/191.out | 33 ++++++++++++++++++++
>>  tests/qemu-iotests/group   |  1 +
>>  3 files changed, 112 insertions(+)
>>  create mode 100755 tests/qemu-iotests/191
>>  create mode 100644 tests/qemu-iotests/191.out
>>
>> diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
>> new file mode 100755
>> index 0000000..fb4cde9
>> --- /dev/null
>> +++ b/tests/qemu-iotests/191
>> @@ -0,0 +1,78 @@
>> +#!/bin/bash
>> +#
>> +# Test full backup functionality of qemu-backup tool
>> +#
>> +# Copyright (C) 2009 Red Hat, Inc.
> 
> Should this perhaps have a different copyright owner and date?
> 
> thanks
> -- PMM
> 
Yes!

Ishani, please take credit for your own work! :)
