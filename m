Received: from eggs.gnu.org ([209.51.188.92]:35763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YxF-0008Rl-0I
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YxD-0004Fk-DN
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:59:36 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-3-jsnow@redhat.com>
	<28d6183a-f654-de55-36ed-ee0bafb47739@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fe8ae9ab-068d-cc24-76de-e2a99215ea5f@redhat.com>
Date: Wed, 6 Mar 2019 10:59:19 -0500
MIME-Version: 1.0
In-Reply-To: <28d6183a-f654-de55-36ed-ee0bafb47739@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] block/qcow2-bitmap: Allow bitmap
 flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 3/6/19 7:58 AM, Eric Blake wrote:
> On 3/5/19 5:43 PM, John Snow wrote:
>> Usually, we only write out bitmaps when we're about to close out the file,
>> so we always remove the bitmaps after to make it easier to determine the
>> source of truth for migration purposes.
>>
>> However, there may be times we want to flush bitmap data more aggressively,
>> like after a truncate event where we need to make the metadata consistent
>> again.
> 
> Or, as I've mentioned in other threads, after every
> bitmap-add/bitmap-delete operation, so that 'qemu-img info -U' can see
> which persistent bitmaps exist. But that's one step further than this
> series, so I won't insist on it today.
> 

Yes, I was keeping that in mind as I wrote this. I think it extends to
those cases trivially, so long as Vladimir is OK with what I'm trying to do.
