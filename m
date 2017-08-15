Received: from eggs.gnu.org ([2001:4830:134:3::10]:38362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dhWXH-0001L4-Un
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dhWXC-0005Tm-IO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:45:12 -0400
References: <20170815061921.31596-1-el13635@mail.ntua.gr>
	<20170815061921.31596-2-el13635@mail.ntua.gr>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3b7fc9da-ac71-8a37-ed3d-34428021e4d3@virtuozzo.com>
Date: Tue, 15 Aug 2017 10:44:15 +0300
MIME-Version: 1.0
In-Reply-To: <20170815061921.31596-2-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/2] block: use internal filter node in
 backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

15.08.2017 09:19, Manos Pitsidianakis wrote:
> block/backup.c currently uses before write notifiers on the targeted
> node. We can create a filter node instead to intercept write requests
> for the backup job on the BDS level, instead of the BlockBackend level.
>

Hi Manos!

Looks interesting but what is the real benefit of it? It doesn't look 
like it simplifies the code.. Also, is it affect performance?
I think it worth describing in commit message.


-- 
Best regards,
Vladimir
