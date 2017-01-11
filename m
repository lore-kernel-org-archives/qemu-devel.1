Received: from eggs.gnu.org ([2001:4830:134:3::10]:35051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRGF2-00079E-2p
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRGEy-0005TJ-BW
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:34:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cRGEy-0005T8-52
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:34:48 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CF5231B32C
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 10:34:48 +0000 (UTC)
Date: Wed, 11 Jan 2017 10:34:42 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170111103442.GH12072@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<20170110165105.GR27720@redhat.com>
	<80b19297-00c4-f109-dd4f-9d2b41ee618c@redhat.com>
	<20170110183630.GA6628@redhat.com>
	<d0ff9866-2001-a028-09ae-98ba0ad3693b@redhat.com>
	<20170111102832.GG12072@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170111102832.GG12072@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Jan 11, 2017 at 10:28:32AM +0000, Daniel P. Berrange wrote:
> On Tue, Jan 10, 2017 at 10:01:12PM +0100, Paolo Bonzini wrote:
> > 
> > 
> > On 10/01/2017 19:36, Daniel P. Berrange wrote:
> > > 
> > > It seems you're saying we should also trim the top level dirs, so
> > > we in fact get:
> > > 
> > > 
> > > -I/home/berrange/src/virt/qemu/hw/scsi
> > > -Ihw/scsi
> > > -I/home/berrange/src/virt/qemu/tcg
> > > -I/home/berrange/src/virt/qemu/tcg/i386
> > > -I/home/berrange/src/virt/qemu/linux-headers
> > > -I/home/berrange/src/virt/qemu-build/linux-headers
> > > -I/home/berrange/src/virt/qemu/include
> > 
> > Yes, and ultimately tcg too.
> 
> So the problem with dropping BUILD_DIR from the include path is that
> config-host.h is generated in that location. We'll have to move that
> into BIULD_DIR/include and add -I$(BUILDDIR)/include to search path
> instead.

Sigh and much more needs moving too...

	module_block.h
	qapi-event.h
	qapi-types.h
	qapi-visit.h
	qemu-doc.html
	qemu-version.h
	qemu-version.h.tmp
	qmp-commands.h
	qmp-introspect.h

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
