Received: from eggs.gnu.org ([2001:4830:134:3::10]:35239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cX2we-00011x-T2
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cX2wb-0005yu-5F
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:35:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cX2wa-0005xx-Vv
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:35:45 -0500
Date: Fri, 27 Jan 2017 09:35:38 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170127093538.GA26553@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <b44e4a5f-cdc0-f5fd-a25e-f2d5e711d57c@gameservers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Brian Rak <brak@gameservers.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, Jan 24, 2017 at 05:02:25PM -0500, Brian Rak wrote:
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

Can you clarify the exact setup you have ?  As mentioned on IRC, I don't
see any degradation in performance betweeen builtin websockets vs a
websockets proxy - if anything the builtin websockets is marginally less
laggy.  I was connecting over TCP localhost, however, so would not see
any effects of network latency. My test was QEMU git master, with noVNC
git master.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
