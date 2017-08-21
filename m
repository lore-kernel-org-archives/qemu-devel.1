Received: from eggs.gnu.org ([2001:4830:134:3::10]:53588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1djnLu-0000ej-4I
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1djnLp-00009Z-E8
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1djnLp-00009Q-8K
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:06:45 -0400
Date: Mon, 21 Aug 2017 15:06:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170821140635.GF2231@work-vm>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
	<20170821085851.GA4371@lemon>
	<20170821100555.GC30356@pxdev.xzpeter.org>
	<20170821101727.GB2231@work-vm> <20170821140444.GD4371@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170821140444.GD4371@lemon>
Subject: Re: [Qemu-devel] [RFC 0/6] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Fam Zheng (famz@redhat.com) wrote:
> On Mon, 08/21 11:17, Dr. David Alan Gilbert wrote:
> > From previous discussions we've had, one suggestion was to have some
> > type of 'safe' command; once issued in a thread, the monitor thread
> > would only allow other lock-free commands to be issued; it stops any
> > accidents of them issuing unsafe commands.
> 
> I'm not sure I understand. If the 'safe' command is not issued, users are
> allowed to do unsafe things? What are the possible consequences of those
> 'unsafe' commands? Errors/hangs/crashes?

With or without the safe command no command could cause a crash.
However, a command might try and take the bql and block waiting for it.
With the 'safe' command only those commands that were declared as
not-wanting the lock would be allowed.

Dave

> Fam
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
