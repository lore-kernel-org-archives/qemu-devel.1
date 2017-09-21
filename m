Received: from eggs.gnu.org ([2001:4830:134:3::10]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dv0Rn-0000IQ-7S
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dv0Rk-0001FM-0Z
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:19:15 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:35884 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dv0Rj-0001En-LH
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:19:11 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
Date: Thu, 21 Sep 2017 15:18:47 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] nbd structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>

Hi all!

I'm about this:

"A server SHOULD try to minimize the number of chunks sent in a reply, 
but MUST NOT mark a chunk as final if there is still a possibility of 
detecting an error before transmission of that chunk completes"

What do we mean by "possibility"? Formally, such possibility exists 
always, so, we'll never mark a chunk as final.

-- 
Best regards,
Vladimir
