Received: from eggs.gnu.org ([2001:4830:134:3::10]:36144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFlm-0000ZZ-9R
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFlh-0003fg-Hi
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:40:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqFlh-0003eL-At
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:40:09 -0400
Date: Fri, 8 Sep 2017 10:40:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908094002.GH3609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170831142430.16665-1-berrange@redhat.com>
	<87r2vhfsc2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2vhfsc2.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] qapi: support py2 & py3 in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Michael <fedora.dm0@gmail.com>

On Fri, Sep 08, 2017 at 11:33:01AM +0200, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > Since I claimed that supporting py2 & py3 in parallel would be easy
> > for QEMU, I figured I ought to actually give it a try to backup that
> > assertion.
> >
> > This small patch series is the result of that effort. I tested this
> > series on Fedora 26 using 2.7.13 and Python 3.6.2.
> >
> > To test with py3, I hacked config-host.mak to change the PYTHON
> > variable to point to 'python3' binary, then compared the following
> > generated content for the files:
> >
> >    qmp-commands.h qapi-types.h  qapi-visit.h  qapi-event.h
> >    qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
> >    qmp-introspect.c qmp-introspect.h
> >
> > with that generated under py2 to see they are identical.
> >
> > It is possible there's still more bugs hiding that could impact
> > on 2.6 or earlier versions of 3.x or 2.7.x, so this probably
> > needs a bit wider testing, but I think the series illustrates
> > the broad scope of the changes we can expect. Only the need
> > to adapt to different module import locations adds to the
> > line count, and that's fairly minimal.
> 
> This hasn't made it to the front of my review queue, but I got a quick
> question meanwhile.
> 
> I guess this was triggered by the discussion of David's "[PATCH]
> scripts: Support building with Python 3".  How does it differ from
> David's patch?  Is it derived from it?  Or is it an independently
> developed replacement?

I didn't notice David's existed. In terms of the qapi file changes,
his patch appears equivelent to combining my patches 2->5.

He didn't seem to convert the print statement to a print function
though (my patch 1), so I'm surprised his changes actually work
with py3...


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
