Received: from eggs.gnu.org ([2001:4830:134:3::10]:58255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCmAL-0004rP-Nn
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCmAI-0001R8-JE
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:42:41 -0500
Received: from mail-eopbgr20137.outbound.protection.outlook.com
	([40.107.2.137]:61347
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eCmAI-0001QS-2d
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:42:38 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <37193dd7-a0fc-bfa6-3870-ecbcfefac4e5@virtuozzo.com>
Date: Thu, 9 Nov 2017 15:42:31 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] NBD BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>, nbd list <nbd@other.debian.org>, qemu-devel <qemu-devel@nongnu.org>

Hi!

Interesting fact: list/set_meta_context options are per-export,
so, in the server we should keep context selection per client per export.

And it is possible for client to set contexts for one export and than 
proceed
to transmission phase with another one.

This is not really touched in spec, for example
"Change the set of active metadata contexts. Issuing this command 
replaces all previously-set metadata contexts"

looks like lacking "for specified export" suffix. May be there are other 
places.

-- 
Best regards,
Vladimir
