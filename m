Received: from eggs.gnu.org ([209.51.188.92]:46890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwUXN-0002Ir-Ls
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwUXE-0002Hc-5t
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:15:53 -0500
References: <20190213233618.22484-1-jsnow@redhat.com>
	<20190213233618.22484-3-jsnow@redhat.com>
	<c79e69af-6d00-074a-fc02-5f0808048f4d@virtuozzo.com>
	<c2188cb6-31fe-28e2-647d-42ae2f12212a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <99d8fb0e-d5de-126c-62d4-248153b42726@redhat.com>
Date: Wed, 20 Feb 2019 07:46:35 -0600
MIME-Version: 1.0
In-Reply-To: <c2188cb6-31fe-28e2-647d-42ae2f12212a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] block/dirty-bitmap: implement
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2/19/19 4:00 PM, John Snow wrote:

>>
>> hmm, I also think we should report our deprecated status as locked for inconsistent bitmaps..
>>
>>
> 
> Though we're trying to deprecate the field altogether, I *could* add a
> special status flag that makes it unambiguous. This will catch the
> attention of anyone using the old API.

Adding to the enum, even though it is going away in the future, is still
helpful in the present, so I can live with that approach.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
