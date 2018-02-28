Received: from eggs.gnu.org ([2001:4830:134:3::10]:57225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er8MY-00082k-NM
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er8MV-0008NL-HO
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:30:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45174 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1er8MV-0008Mb-C7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:30:03 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<c2faa919-65c6-d5a3-508d-2f069f2ba61e@redhat.com>
	<1e3244d2-daea-6f3f-f852-642bdf216e17@virtuozzo.com>
	<d1e7c1c5-622c-ff78-4aec-ce62b0273d24@redhat.com>
	<20180228130816.GA19355@grep.be>
	<cf2357b2-deed-46d3-3306-5eabf0a0abae@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3bb6152-cb7f-baf9-91fa-bdd3c90ffab1@redhat.com>
Date: Wed, 28 Feb 2018 14:29:46 -0600
MIME-Version: 1.0
In-Reply-To: <cf2357b2-deed-46d3-3306-5eabf0a0abae@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Alex Bligh <alex@alex.org.uk>, nbd list <nbd@other.debian.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 02/28/2018 02:26 PM, Eric Blake wrote:

> 
> Okay, I've gone ahead and reverted the renumbering; NBD_INFO_BLOCK_SIZE 
> is back to 5

It helps if I don't copy-and-paste the wrong thing.  NBD_INFO_BLOCK_SIZE 
remains 3 (as it has always been), NBD_REPLY_TYPE_BLOCK_STATUS is 
reverted back to 5 (undoing part of commit 56c77720).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
