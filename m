Received: from eggs.gnu.org ([2001:4830:134:3::10]:57378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cRKsW-0002Vs-MP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cRKsS-0002JN-Nx
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:31:56 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:34490 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cRKsS-0002Hq-Bu
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:31:52 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e3c30f7c-8d5b-5cfc-1cc0-5e673a30cd8a@virtuozzo.com>
Date: Wed, 11 Jan 2017 18:31:28 +0300
MIME-Version: 1.0
In-Reply-To: <20161214150840.10899-1-alex@alex.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>, Wouter Verheist <w@uter.be>, nbd-general@lists.sourceforge.net
Cc: Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V . Lunev" <den@openvz.org>

from current version:

 >>> If an error occurs, the server SHOULD set the appropriate error 
code in the error field of an error chunk. However, if the error does 
not involve invalid usage (such as a request beyond the bounds of the 
file), a server MAY reply with a single block status descriptor with 
/length/ matching the requested length, and /status/ of 0 rather than 
reporting the error.

- single block status descriptor for each context? Isn't it 
implementation defined? Or we finally decided to force 0 status to be 
safe default for all contexts? If it is so, it would be better to 
describe this separately. However, personally, I'd prefer to not define 
contexts internal semantics at all.

-- 
Best regards,
Vladimir
