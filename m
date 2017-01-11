Received: from eggs.gnu.org ([2001:4830:134:3::10]:35093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRMWm-0006n6-Bl
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRMWj-0001JO-3h
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:17:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cRMWi-0001JB-Tx
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:17:33 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 215A88123A
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:17:33 +0000 (UTC)
Date: Wed, 11 Jan 2017 17:17:27 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170111171727.GS12072@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163858.GB19869@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170110163858.GB19869@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Jan 10, 2017 at 04:38:58PM +0000, Stefan Hajnoczi wrote:
> On Fri, Jan 06, 2017 at 03:54:58PM +0000, Daniel P. Berrange wrote:
> > diff --git a/io/Makefile.objs b/io/Makefile.objs
> > index 9d8337d..94cb74e 100644
> > --- a/io/Makefile.objs
> > +++ b/io/Makefile.objs
> > @@ -8,3 +8,5 @@ io-obj-y += channel-watch.o
> >  io-obj-y += channel-websock.o
> >  io-obj-y += channel-util.o
> >  io-obj-y += task.o
> > +trace-obj-y += trace.o
> > +trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
> 
> Is there a way to eliminate this boilerplate?  If the directory has a
> trace-events file then it requires trace.o/trace-dtrace.o.

Yes in fact. I figured out a rule in the top level Makefile.objs that can
do this for all sub-dirs

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
