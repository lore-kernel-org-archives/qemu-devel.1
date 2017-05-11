Received: from eggs.gnu.org ([2001:4830:134:3::10]:50404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d8qi6-0000B2-Jo
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d8qi2-00045L-GM
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:13:02 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:13274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d8qi2-00043m-2w
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:12:58 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170510161201.387edc47@bahia.kaod.org>
	<22325f3a-133a-a1e3-77ae-57e0c8235696@huawei.com>
	<ce4f0817-64a0-a3c9-2e2c-1617c0c1bd62@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <2db76353-e545-40a0-6e9f-6f4e4137671d@huawei.com>
Date: Thu, 11 May 2017 18:12:30 +0200
MIME-Version: 1.0
In-Reply-To: <ce4f0817-64a0-a3c9-2e2c-1617c0c1bd62@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/4] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, Pradeep
	Jagadeesh <pradeepkiruvale@gmail.com>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 5/10/2017 9:48 PM, Eric Blake wrote:
> On 05/10/2017 10:27 AM, Pradeep Jagadeesh wrote:
>
>>>
>>> Isn't it a bit overkill to introduce a new file for a single function ?
>>> Maybe you could simply move this to util/throttle.c ?
>>>
>> OK, but I will add one more function later patch. Still do you think
>> better to move to util/thottle.c?
>
> As long as util/throttle.c is not already huge, adding multiple new
> functions to that file over the course of the series should be just fine.
OK, I will use util/throttle.c.
>
