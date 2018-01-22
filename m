Received: from eggs.gnu.org ([2001:4830:134:3::10]:50461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ediDB-0005zv-E3
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ediDA-0001I8-RP
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:56:57 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-4-vsementsov@virtuozzo.com>
	<887a889a-e5bc-1a38-7fc9-87bf5d7a6e1b@redhat.com>
	<d838bf06-3198-79b4-53d0-1c729e9ce580@virtuozzo.com>
	<b6e71cfa-19f6-8b98-4e6a-a5d230129f62@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f99445cc-4f70-ca06-4831-b042c1dd30d7@redhat.com>
Date: Mon, 22 Jan 2018 14:56:46 -0500
MIME-Version: 1.0
In-Reply-To: <b6e71cfa-19f6-8b98-4e6a-a5d230129f62@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add
 block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org



On 01/22/2018 02:51 PM, Eric Blake wrote:
> On 01/22/2018 03:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> 
>>>>
>>> I have to admit exposing this interface still makes me nervous, but :)
>>>
>>> Mechanically correct, and with suggesting phrasing changes:
>>>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> Should we go with an x- prefix for now, and let things settle for a
> release before promoting it to fully supported, just in case we find
> something that justifies your nervousness in accepting the interface?
> 

I proposed as much in a reply to the cover letter; I'm willing to take
patch one now for the sake of migration; the rest of this series I want
a test suite that helps document the anticipated use case, or otherwise
an x- prefix for the command names.
