Received: from eggs.gnu.org ([2001:4830:134:3::10]:32966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cRdnW-0004LF-Q7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cRdnT-0005hG-OB
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:44:02 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:31845 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cRdnT-0005gr-9t
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:43:59 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ac0cc1e5-dea5-ba2d-2789-7dd0672ad561@virtuozzo.com>
Date: Thu, 12 Jan 2017 14:43:38 +0300
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

(Sorry, it may be a bit out of topic, but I hope it is comfortable for 
all that I just comment current version of the feature by answering 
cover letter of last related patch set)

 From |"NBD_OPT_LIST_META_CONTEXT| (9)":
> The server MUST either reply with an error (for instance |EINVAL| if 
> the option is not supported), or reply with a list of 
> |NBD_REP_META_CONTEXT| replies followed by |NBD_REP_ACK|.:

NBD_REP_ERR_UNSUP for the case in braces? Should it be normal option 
reply packet?



-- 
Best regards,
Vladimir
