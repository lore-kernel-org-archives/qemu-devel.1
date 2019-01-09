Received: from eggs.gnu.org ([209.51.188.92]:52467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghH9I-0004rn-Ga
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghH9H-0005v8-Rb
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:56:12 -0500
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
	<20190109112311.GB4867@localhost.localdomain>
	<5ddd78e0-90ed-a6e5-c454-f1a2e44c1a37@redhat.com>
	<20190109165111.GI4867@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61f6ac4d-91ab-f9cb-67e5-e0f5ce17524d@redhat.com>
Date: Wed, 9 Jan 2019 17:55:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190109165111.GI4867@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: add rough-block-status
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org

On 09/01/19 17:51, Kevin Wolf wrote:
> Am 09.01.2019 um 17:42 hat Paolo Bonzini geschrieben:
>> On 09/01/19 12:23, Kevin Wolf wrote:
>>> Also note that this is only metadata preallocation; full preallocation
>>> will still return allocated for the protocol layer and so it will always
>>> be slow.
>>
>> Full preallocation these days can create images with preallocated but
>> known-zero blocks, I think?
> 
> That would defeat one of the main purposes of preallocation because it
> would still require COW and metadata updates on the first write.

Sorry I mean at the protocol level, like FALLOC_FL_ZERO_RANGE.  It would
still require metadata updates on the filesystem level, unlike "real"
full preallocation, but no qcow2 metadata updates.
> If there is demand, we could add something like preallocation=data where
> data clusters are preallocated but COW/metadata updates still happen at
> runtime, but so far nobody has asked for it. Not sure when you would use
> it either.
> 
> Kevin
> 
