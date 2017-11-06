Received: from eggs.gnu.org ([2001:4830:134:3::10]:59573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBkcl-0001pC-RD
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBkcj-0000mk-8t
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:51:47 -0500
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:34347)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eBkcj-0000lR-2N
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:51:45 -0500
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 18BBBF04B1
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 17:51:43 +0100 (CET)
Date: Mon, 6 Nov 2017 17:51:36 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171106175136.705ff437@bahia>
In-Reply-To: <5d67c7311aa19c9830cf4927a4e22159.squirrel@mifritscher.de>
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-4-michael@fritscher.net>
	<20171106144422.4bda119f@bahia>
	<5d67c7311aa19c9830cf4927a4e22159.squirrel@mifritscher.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/18] Disable the proxy fsdev under
 Windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>
Cc: sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, Greg Kurz <gkurz@linux.vnet.ibm.com>

On Mon, 6 Nov 2017 16:17:29 +0100
"Michael Fritscher" <michael@fritscher.net> wrote:

> > On Fri, 29 Sep 2017 13:13:08 +0200
> > Michael Fritscher <michael@fritscher.net> wrote:  
> >> Signed-off-by: Michael Fritscher <michael@fritscher.net>  
> >
> > What's the justification for this patch ?  
> It had too much linuxisms in it to fix compiling - so I disabled the proxy
> variant altogether. Reactivating it could be done in a version 2.0 ;-)
> 

That's what I was guessing. Fair enough but it deserves some justification in
the commit log anyway :)

BTW, the main justification for the proxy backend is to provide "extra"
security (the helper chroots into the shared directory). I don't know if
this makes sense on a windows host.

Also, if you go for a windows specific backend as suggested in another
mail, you should probably disable all the other existing backends as
well.

> Best regards,
> Michael Fritscher
> 
> 
