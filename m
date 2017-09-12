Received: from eggs.gnu.org ([2001:4830:134:3::10]:36813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drh14-0004Bl-VY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drh11-0008CZ-1h
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:57:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drh10-0008B4-Sg
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:57:54 -0400
Date: Tue, 12 Sep 2017 09:57:50 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912085750.GA17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-7-brandon.carpenter@cypherpath.com>
	<20170911085043.GE21444@redhat.com>
	<1505149415.1214.1@smtp.gmail.com>
	<20170911171015.GU21444@redhat.com>
	<1505156655.1214.3@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505156655.1214.3@smtp.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] io: Reply to ping frames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Cc: qemu-devel@nongnu.org

On Mon, Sep 11, 2017 at 12:04:15PM -0700, Brandon Carpenter wrote:
> On Mon, Sep 11, 2017 at 10:10 AM, Daniel P. Berrange <berrange@redhat.com>
> wrote:
> > It feels like this is still dangerous - the client simply has to
> > interleave each "ping" with a 1 byte binary frame to get around this
> > limit. We need to make sure we have an absolute cap on the output buffer
> > size.
> 
> Okay. I see that now that I look at it more closely. This breed of
> asynchronous I/O is tricky because the conditions for reading/writing are
> all over the place. There's a lot of context to keep in your head.
> 
> I have a fix. And I realized that I was missing a patch in the series for
> RFC-compliant closing of websocket connections, which I must have lost
> during a rebase. Should I submit v3 of the patch series or just add those
> patches to this thread?

It is generally preferred practice to submit new top level threads, rather
than sending more patches to a previous thread.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
