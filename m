Received: from eggs.gnu.org ([2001:4830:134:3::10]:36000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1elyA0-0006mr-Pw
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ely9z-0006rm-RA
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:35:48 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <18b3a8c6-4f5c-3623-a781-5beb94375331@virtuozzo.com>
Date: Wed, 14 Feb 2018 17:35:30 +0300
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] BLOCK_STATUS extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Alex Bligh <alex@alex.org.uk>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Hi all.

Just note: looks like we allow zero-sized metadata context name. Is it ok?

  *

    |NBD_REP_META_CONTEXT| (4)

    A description of a metadata context. Data:

      o 32 bits, NBD metadata context ID.
      o String, name of the metadata context. This is not required to be
        a human-readable string, but it MUST be valid UTF-8 data.



-- 
Best regards,
Vladimir
