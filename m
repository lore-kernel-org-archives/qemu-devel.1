Received: from eggs.gnu.org ([2001:4830:134:3::10]:46437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d6DJS-0003NQ-RR
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d6DJP-0003IR-NA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:44:42 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:12790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d6DJP-0003Hx-Dz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:44:39 -0400
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-4-git-send-email-pradeep.jagadeesh@huawei.com>
	<c3224a61-cc45-c419-6aff-a3cc43ffed80@redhat.com>
	<20170503192126.0d4964a9@bahia>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <4d4c6171-3d42-6347-a0d0-8d5de66c5fe6@huawei.com>
Date: Thu, 4 May 2017 11:44:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170503192126.0d4964a9@bahia>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qmp: refactor duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 5/3/2017 7:21 PM, Greg Kurz wrote:
> On Tue, 2 May 2017 17:15:02 -0500
> Eric Blake <eblake@redhat.com> wrote:
>
>> On 05/02/2017 09:29 AM, Pradeep Jagadeesh wrote:
>>> This patchset factor out the duplicate qmp throttle interface code
>>> that was present in both block and fsdev device files.
>>
>> Instead of adding the duplicate code in patch 2 then cleaning it out
>> here, you should refactor this patch to be first (fix existing code in
>> blockdev.c to make use of the new interfaces), then add the new fsdev
>> code that uses this code right away.
>>
>
> Yeah I second that.
>
> Pradeep,
>
> When you worked on the command line version for 2.9, I didn't really know
> what we would be able to share between fsdev and blockdev... I had hence
> asked to code it separately and then factor out. The situation is different
> here: the core throttling code is in place for both fsdev and blockdev. We
> really want to share as much code as possible. So you probably should move
> this patch and maybe the next one in front and then have fsdev to use the
> new code as Eric is suggesting.

OK, Sure. I will do.
>
> Cheers,
>
> --
> Greg
>
>>>
>>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>>> ---
>>>  blockdev.c                      | 53 +++----------------------------------
>>>  fsdev/qemu-fsdev-throttle.c     | 51 +-----------------------------------
>>>  fsdev/qemu-fsdev.c              |  1 -
>>>  hmp.c                           | 34 ++++++++++++------------
>>>  include/qemu/throttle-options.h |  5 ++++
>>>  util/Makefile.objs              |  1 +
>>>  util/throttle-options.c         | 58 +++++++++++++++++++++++++++++++++++++++++
>>>  7 files changed, 85 insertions(+), 118 deletions(-)
>>>  create mode 100644 util/throttle-options.c
>>>
>>
>
