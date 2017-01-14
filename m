Received: from eggs.gnu.org ([2001:4830:134:3::10]:40569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cSPdK-0003tV-6N
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 09:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cSPdJ-0007xn-Eg
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 09:48:42 -0500
Date: Sat, 14 Jan 2017 15:48:25 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20170114144825.ma5lwhdwwzjxyfri@grep.be>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<B07FDA27-AF64-4BF1-874A-9B4AF201BA8E@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B07FDA27-AF64-4BF1-874A-9B4AF201BA8E@alex.org.uk>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Bob Chen <a175818323@gmail.com>

On Thu, Jan 12, 2017 at 06:56:42PM +0000, Alex Bligh wrote:
> My preferred way to do this would be essentially to allow NBD_OPT_INFO
> to be sent (wrapped appropriately) during the main transmission phase.
> That would allow *any* INFO stuff to be reread.

Can you go into a bit more detail how you'd see that? It feels a bit
awkward to me, at best; but I could be missing something.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
