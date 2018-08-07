Received: from eggs.gnu.org ([2001:4830:134:3::10]:41145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fn1CA-0005d2-EV
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fn1C7-0008FJ-Ae
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:34:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1fn1C7-0008F1-66
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:34:35 -0400
Date: Tue, 7 Aug 2018 14:34:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180807123431.GB4499@localhost.localdomain>
References: <CAB3eZftOpC9tj4SrRKX=s40md+UjSCC-X=+NC89aV=EVs_XbUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3eZftOpC9tj4SrRKX=s40md+UjSCC-X=+NC89aV=EVs_XbUw@mail.gmail.com>
Subject: Re: [Qemu-devel] How to discard one range which overlap with
 backing file and its children img?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Am 07.08.2018 um 09:06 hat lampahome geschrieben:
> I have image A & B, and A is backing file of B.
> 
> After I mount A to /dev/nbd0 and I write from position 0~999 in nbd0.
> 
> Then create B and set A as backing file of B.
> 
> I mount B on /dev/nbd1 and I can saw the data from pos:0~999 because A is
> B's backing file. That's reasonable.
> 
> 
> But I want to discard range 0~500 in B. I expect there's no data in 0~500
> after discard and re-mount B next time.
> 
> But the data is still in A.
> 
> How can I discard range 0~500?

Note that discard simply means that you don't care about the content any
more. This doesn't guarantee that the old data can't be read any more.
If you want to make the data invisible, you need a zero write operation
instead. For a Linux guest, have a look at the "fallocate -z" command
line tool.

Kevin
