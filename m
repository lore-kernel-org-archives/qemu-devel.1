Received: from eggs.gnu.org ([209.51.188.92]:58589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvrAq-0005XG-3Q
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvr0n-00079M-M9
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:03:42 -0500
References: <20190213232356.21034-1-jsnow@redhat.com>
	<20190213232356.21034-7-jsnow@redhat.com>
	<13aee80d-3e4b-4c1c-b731-57c066bf9a72@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a8f05727-f136-e921-385d-504cca805e10@redhat.com>
Date: Mon, 18 Feb 2019 17:03:23 -0500
MIME-Version: 1.0
In-Reply-To: <13aee80d-3e4b-4c1c-b731-57c066bf9a72@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] block/dirty-bitmaps: move comment
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, "libvir-list@redhat.com" <libvir-list@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 2/18/19 12:39 PM, Vladimir Sementsov-Ogievskiy wrote:
> 14.02.2019 2:23, John Snow wrote:
>> Simply move the big status enum comment block to above the status
>> function, and document it as being deprecated. The whole confusing
>> block can get deleted in three releases time.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> But I think, it's OK to remove it now. It mostly unrelated to code now, so,
> is it needed? And it is unrelated to deprecation. As I understand, user-seen
> information is DirtyBitmapStatus declaration in qapi, and it is deprecated
> and to be removed in three releases.
> 

I decided to keep it because I wanted to document the particulars of
what the fields meant internally before we finally remove it some future
release, in case we need to change this function around to maintain
backwards compatibility.

It'll get removed at that point in time.

--js
