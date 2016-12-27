Received: from eggs.gnu.org ([2001:4830:134:3::10]:52885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cLsRg-00079G-GJ
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 09:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cLsRd-0006kT-9f
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 09:09:40 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:1903 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cLsRc-0006k9-TV
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 09:09:37 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <71d6f278-be19-eaeb-7277-c3e6e4512e67@virtuozzo.com>
Date: Tue, 27 Dec 2016 17:09:21 +0300
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

A bit out of topic, but...

> structured replies via `NBD_OPT_STRUCTURED_REPLY`.  Conversely, if
> structured replies are negotiated, the server MUST use a
> structured reply for any response with a payload, and MUST NOT use
> a simple reply for `NBD_CMD_READ` (even for the case of an early
> `EINVAL` due to bad flags), but MAY use either a simple reply or a
> structured reply to all other requests.

What was the reason for it? Why not to negotiate forced structured read 
separately? Actually, this spec forces any server, which wants to 
implement structured reply implement structured read too. But what if it 
don't want to? If it only wants to implement BLOCK_STATUS?

So, what about changing it, to allow BLOCK_STATUS (or other future 
structured replies) without structured read? Structured read is good 
only for sparse formats, when BLOCK_STATUS is more global. I understand, 
that servers may implement simple (and useless) one-chunk structured 
read, but I think that it is better to fix the spec, to not provoke 
servers use such workaround.


-- 
Best regards,
Vladimir
