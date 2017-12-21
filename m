Received: from eggs.gnu.org ([2001:4830:134:3::10]:35121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRpoL-0000bz-OV
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRpoK-00039A-N9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:38:13 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-3-vsementsov@virtuozzo.com>
	<a07578ae-f57b-cb82-e87e-23b6c39cbd10@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d4ed06f2-161d-7d42-0889-953bb33465dd@redhat.com>
Date: Wed, 20 Dec 2017 19:38:05 -0600
MIME-Version: 1.0
In-Reply-To: <a07578ae-f57b-cb82-e87e-23b6c39cbd10@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd/server: add nbd_opt_{read,
 drop} to track client->optlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

On 11/22/2017 02:03 PM, Eric Blake wrote:
> On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/server.c | 34 ++++++++++++++++++++++------------
>>   1 file changed, 22 insertions(+), 12 deletions(-)
>>
> 

> I think that means we need a tri-state return from nbd_opt_read(): < 0
> on I/O failure, 0 if the EINVAL message has been sent, and 1 if the read
> was successful; I also think it means that the handler for
> NBD_OPT_EXPORT_NAME does not really fit the bill for using the same
> handler.  Hopefully this explanation will give you more insight into the
> counter-proposal patch I'm about to post.

Hmm, I never posted the counter-proposal, because I got caught up in 
handling the CVEs that I spotted in the same area, then the 2.11 
release.  I'll get back to this series shortly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
