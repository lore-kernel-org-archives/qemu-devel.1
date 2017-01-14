Received: from eggs.gnu.org ([2001:4830:134:3::10]:46463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cSQHt-00008u-60
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 10:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cSQHs-0005X1-5I
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 10:30:37 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20170114144825.ma5lwhdwwzjxyfri@grep.be>
Date: Sat, 14 Jan 2017 15:30:24 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <E0773C0A-7439-4F70-8983-5199B711DB73@alex.org.uk>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<B07FDA27-AF64-4BF1-874A-9B4AF201BA8E@alex.org.uk>
	<20170114144825.ma5lwhdwwzjxyfri@grep.be>
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
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Bob Chen <a175818323@gmail.com>


> On 14 Jan 2017, at 14:48, Wouter Verhelst <w@uter.be> wrote:
> 
> On Thu, Jan 12, 2017 at 06:56:42PM +0000, Alex Bligh wrote:
>> My preferred way to do this would be essentially to allow NBD_OPT_INFO
>> to be sent (wrapped appropriately) during the main transmission phase.
>> That would allow *any* INFO stuff to be reread.
> 
> Can you go into a bit more detail how you'd see that? It feels a bit
> awkward to me, at best; but I could be missing something.

Well, the idea would be something like: NBD_CMD_INFO, use the offset
specified as the the information type, and put the INFO reply
within the reply block. I guess the client doesn't know the
length of the reply so we'd have to use structured replies
or similar. Although looking through the current info types,
I can't see why today you'd want to reread anything other than
the length, so maybe this is useless futureproofing.

-- 
Alex Bligh
