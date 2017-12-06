Received: from eggs.gnu.org ([2001:4830:134:3::10]:39030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1eMdFH-0001fi-H5
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1eMdFC-0001LJ-IX
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:12:31 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:33226 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pradeep.jagadeesh@huawei.com>)
	id 1eMdFC-0001KE-CK
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:12:26 -0500
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<20171206170705.37cda561@bahia.lan>
	<9a0067d4-100b-b3eb-d38e-a99ab885e215@huawei.com>
	<84bafe13-7e56-4aa5-cf48-edadd9c2d579@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <bc7a364b-03a0-529a-870f-340daca26afb@huawei.com>
Date: Wed, 6 Dec 2017 18:12:13 +0100
MIME-Version: 1.0
In-Reply-To: <84bafe13-7e56-4aa5-cf48-edadd9c2d579@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v13 0/6] fsdev: qmp interface for io
 throttling
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
Cc: alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 12/6/2017 5:49 PM, Eric Blake wrote:
> On 12/06/2017 10:15 AM, Pradeep Jagadeesh wrote:
>
>>> I didn't have time to follow the thread, but it's been a month without
>>> activity... where do we stand now ? I've merged I/O throttle for fsdev
>>> in 2.9, is there a chance we get the QMP/HMP part in 2.12 ?
>>
>> Hi Greg,
>>
>> Yes, I am waiting for Eric's reply. Because there were some issues when
>> I merged code with Manos's throttlelimits code. So, I am waiting to see
>> how to go about it. It needs some changes to reuse in fsdev/blk qmp
>> code. I am very much would like to push qmp code upstream.
>
> We missed the window of opportunity to unify any differences in
> interfaces between what Manos added in 2.11 and your code, now that 2.11
> is at -rc4.  That means we are stuck with two slightly different
> interface; although it would still be nice to have glue code that can
> convert into and out of a preferred form, so that the bulk of the code
> can be common operations on the preferred struct.
>
> At this point, I don't know what additional information you want from
> myself or Markus on the interface front; it may be easier to post a
> rebased v14 and tackle it from there (even if it means our interface is
> still in a state of churn).
Thanks for the quick reply. The problem is with the block devices 
code.So I was thinking to pull out those patches and just go ahead with 
the fsdev. I can directly use Manos code directly without any changes in 
fsdev case.So, I would like to go ahead and post v14 patches.

Regards,
Pradeep
>
