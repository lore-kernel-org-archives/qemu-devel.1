Received: from eggs.gnu.org ([2001:4830:134:3::10]:50976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dpAIN-0005j1-3Y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dpAII-0005Ud-JD
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:37:23 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:22981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dpAII-0005Tj-8h
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:37:18 -0400
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-7-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51tw0h7f9t.fsf@maestria.local.igalia.com>
	<75f2f6f9-7d23-dced-6920-4b0be04876b9@huawei.com>
	<w51r2vl7btq.fsf@maestria.local.igalia.com>
	<0d3ed742-e6f8-8124-29c6-f123b68e8b08@huawei.com>
	<w51o9qp7al2.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <a89406c9-2725-7016-fa3d-7c5008d19b5e@huawei.com>
Date: Tue, 5 Sep 2017 11:36:20 +0200
MIME-Version: 1.0
In-Reply-To: <w51o9qp7al2.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 6/6] fsdev: hmp interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 9/5/2017 11:34 AM, Alberto Garcia wrote:
> On Tue 05 Sep 2017 11:13:09 AM CEST, Pradeep Jagadeesh wrote:
>>> a) Declare an Error, pass it _and then handle it_ (if you don't
>>>    handle it, you're leaking it):
>>>
>>> Here you have no other way to know if qmp_query_fsdev_io_throttle()
>>> fails, so you should choose (a).
>>>
>> OK, I will pass NULL.
>
> :-)
>
> (it's ok I guess, I don't see how that function can ever be made to fail
> in the future)
:) Agreed.

-Pradeep

>
> Berto
>
