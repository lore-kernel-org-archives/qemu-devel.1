Received: from eggs.gnu.org ([2001:4830:134:3::10]:43994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1dvk3N-000504-R2
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 09:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1dvk3I-0001mT-Va
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 09:01:05 -0400
Received: from latin.grep.be ([46.4.76.168]:47915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1dvk3I-0001hZ-L1
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 09:01:00 -0400
Date: Sat, 23 Sep 2017 15:00:36 +0200
From: Wouter Verhelst <w@uter.be>
Message-ID: <20170923130036.372fgo4uhm7yfuoc@grep.be>
References: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
	<cd46a9e9-4e9d-9ac8-53ed-34ba1b6f4dc0@redhat.com>
	<9a3ce498-040d-5d8f-41d0-a2a649771528@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3ce498-040d-5d8f-41d0-a2a649771528@virtuozzo.com>
Subject: Re: [Qemu-devel] nbd structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, Alex Bligh <alex@alex.org.uk>, qemu-devel <qemu-devel@nongnu.org>, nbd@other.debian.org

On Fri, Sep 22, 2017 at 05:57:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> The obvious behavior of client is to fail the whole read if it received one
> error chunk.

Not necessarily.

If a user-space program requests to read X bytes of data, but there is
an error at X-N, then the obvious way to handle that is for the read()
call to return with X-N bytes first, and for the next read() call to
return with -1, and errno set to EIO.

Structured reads allow for that kind of behaviour.

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
