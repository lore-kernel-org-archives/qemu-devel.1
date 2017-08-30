Received: from eggs.gnu.org ([2001:4830:134:3::10]:33086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dn1qh-0003OK-HQ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dn1qe-0006hN-E6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:11:59 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:22454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dn1qe-0006gR-4j
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:11:56 -0400
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuc98di8.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <9b24c28f-f891-1046-f09f-bffded9e316f@huawei.com>
Date: Wed, 30 Aug 2017 14:10:53 +0200
MIME-Version: 1.0
In-Reply-To: <w51fuc98di8.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 8/30/2017 2:07 PM, Alberto Garcia wrote:
> On Tue 29 Aug 2017 04:23:01 PM CEST, Pradeep Jagadeesh wrote:
>> These patches provide the qmp interface, to query the io throttle
>> status of the all fsdev devices that are present in a vm.
>
> I'm trying to read from an 9p share that has limits set with hmp
> fsdev_set_io_throttle and I'm having some problems.
>
> For example if I'm reading a large file and I change the I/O limits
> while the file is still being read then the guest process freezes.
>
> Can you try to reproduce that scenario?
Thanks for letting me know about the issue.
OK, I will try to reproduce.have a look.

-Pradeep

>
> Berto
>
