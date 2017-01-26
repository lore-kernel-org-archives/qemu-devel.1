Received: from eggs.gnu.org ([2001:4830:134:3::10]:53998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWqK0-0008Pc-HI
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWqJv-0000Yn-Gg
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:07:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cWqJv-0000YW-Au
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:06:59 -0500
Date: Thu, 26 Jan 2017 20:06:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170126200654.GC2796@work-vm>
References: <b44e4a5f-cdc0-f5fd-a25e-f2d5e711d57c@gameservers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b44e4a5f-cdc0-f5fd-a25e-f2d5e711d57c@gameservers.com>
Subject: Re: [Qemu-devel] QEMU websockets support is laggy?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brian Rak <brak@gameservers.com>, berrange@redhat.com
Cc: qemu-devel <qemu-devel@nongnu.org>

* Brian Rak (brak@gameservers.com) wrote:
> We've been considering switching over to using qemu's built in websockets
> support (to avoid the overhead of needing websockify running).  We've been
> seeing very poor performance after the switch (it takes the console 4-5
> seconds to update after pressing a key).  So far, I haven't been able to
> find any indication of why this is happening.  The exact same configuration
> works perfectly when running with websockify, but laggy when hitting qemu
> directly.
> 
> I've tried a few things (disabling encryption, bypassing our usual nginx
> proxy, even connecting via a ssh tunnel), and haven't made any sort of
> progress here.  Has anyone else seen this?  Any suggestions as to where I
> should start looking?


copying in Dan Berrange who knows the websocket code.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
