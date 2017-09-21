Received: from eggs.gnu.org ([2001:4830:134:3::10]:39417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sementcov-ogievskii.vo@mipt.ru>) id 1dv0HO-0002ih-51
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sementcov-ogievskii.vo@mipt.ru>) id 1dv0HI-00033Q-7Y
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:30 -0400
Received: from relay1.telecom.mipt.ru ([81.5.91.10]:38358)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sementcov-ogievskii.vo@mipt.ru>) id 1dv0HH-0002rB-R9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:24 -0400
From: Vladimir Sementsov-Ogievskiy <sementcov-ogievskii.vo@mipt.ru>
Message-ID: <af87f7e0-f0df-63ab-36d3-86458ce5c36b@mipt.ru>
Date: Thu, 21 Sep 2017 15:08:11 +0300
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
To: Eric Blake <eblake@redhat.com>, Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>
Cc: nbd-general@lists.sourceforge.net, qemu-devel <qemu-devel@nongnu.org>

Hi all!

I'm about this:

"A server SHOULD try to minimize the number of chunks sent in a reply, 
but MUST NOT mark a chunk as final if there is still a possibility of 
detecting an error before transmission of that chunk completes"

What do we mean by "possibility"? Formally, such possibility exists 
always, so, we'll never mark a chunk as a final.

-- 
Best regards,
Vladimir
