Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832FBC282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 11:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474312190B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 11:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474312190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHRWk-0005oc-FP
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 07:17:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1hHRV6-0004pn-CG
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1hHRV5-0003w3-5K
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:16:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:55398 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1hHRV4-0003ux-Sz
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:16:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 17E0DAC44;
	Fri, 19 Apr 2019 11:16:08 +0000 (UTC)
To: Yuval Shaia <yuval.shaia@oracle.com>, Cornelia Huck <cohuck@redhat.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190415103546.GA6854@lap1>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
Date: Fri, 19 Apr 2019 13:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190415103546.GA6854@lap1>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic]
X-Received-From: 195.135.220.15
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: linux-rdma@vger.kernel.org, jgg@mellanox.com,
	virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org,
	mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419111606.1plw6aWlS6MMm1TTSmUMJ_kLGjToWVhMzXZKvrmzL0Y@z>

On 4/15/19 12:35 PM, Yuval Shaia wrote:
> On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
>> On Thu, 11 Apr 2019 14:01:54 +0300
>> Yuval Shaia <yuval.shaia@oracle.com> wrote:
>>
>>> Data center backends use more and more RDMA or RoCE devices and more =
and
>>> more software runs in virtualized environment.
>>> There is a need for a standard to enable RDMA/RoCE on Virtual Machine=
s.
>>>
>>> Virtio is the optimal solution since is the de-facto para-virtualizat=
on
>>> technology and also because the Virtio specification
>>> allows Hardware Vendors to support Virtio protocol natively in order =
to
>>> achieve bare metal performance.
>>>
>>> This RFC is an effort to addresses challenges in defining the RDMA/Ro=
CE
>>> Virtio Specification and a look forward on possible implementation
>>> techniques.
>>>
>>> Open issues/Todo list:
>>> List is huge, this is only start point of the project.
>>> Anyway, here is one example of item in the list:
>>> - Multi VirtQ: Every QP has two rings and every CQ has one. This mean=
s that
>>>    in order to support for example 32K QPs we will need 64K VirtQ. No=
t sure
>>>    that this is reasonable so one option is to have one for all and
>>>    multiplex the traffic on it. This is not good approach as by desig=
n it
>>>    introducing an optional starvation. Another approach would be mult=
i
>>>    queues and round-robin (for example) between them.
>>>
Typically there will be a one-to-one mapping between QPs and CPUs (on=20
the guest). So while one would need to be prepared to support quite some=20
QPs, the expectation is that the actual number of QPs used will be=20
rather low.
In a similar vein, multiplexing QPs would be defeating the purpose, as=20
the overall idea was to have _independent_ QPs to enhance parallelism.

>>> Expectations from this posting:
>>> In general, any comment is welcome, starting from hey, drop this as i=
t is a
>>> very bad idea, to yeah, go ahead, we really want it.
>>> Idea here is that since it is not a minor effort i first want to know=
 if
>>> there is some sort interest in the community for such device.
>>
>> My first reaction is: Sounds sensible, but it would be good to have a
>> spec for this :)
>>
>> You'll need a spec if you want this to go forward anyway, so at least =
a
>> sketch would be good to answer questions such as how many virtqueues
>> you use for which purpose, what is actually put on the virtqueues,
>> whether there are negotiable features, and what the expectations for
>> the device and the driver are. It also makes it easier to understand
>> how this is supposed to work in practice.
>>
>> If folks agree that this sounds useful, the next step would be to
>> reserve an id for the device type.
>=20
> Thanks for the tips, will sure do that, it is that first i wanted to ma=
ke
> sure there is a use case here.
>=20
> Waiting for any feedback from the community.
>=20
I really do like the ides; in fact, it saved me from coding a similar=20
thing myself :-)

However, I'm still curious about the overall intent of this driver.=20
Where would the I/O be routed _to_ ?
It's nice that we have a virtualized driver, but this driver is
intended to do I/O (even if it doesn't _do_ any I/O ATM :-)
And this I/O needs to be send to (and possibly received from)
something.

So what exactly is this something?
An existing piece of HW on the host?
If so, wouldn't it be more efficient to use vfio, either by using SR-IOV=20
or by using virtio-mdev?

Another guest?
If so, how would we route the I/O from one guest to the other?
Shared memory? Implementing a full-blown RDMA switch in qemu?

Oh, and I would _love_ to have a discussion about this at KVM Forum.
Maybe I'll manage to whip up guest-to-guest RDMA connection using=20
ivshmem ... let's see.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)

