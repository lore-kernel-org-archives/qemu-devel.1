Received: from eggs.gnu.org ([2001:4830:134:3::10]:38707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRGUc-0005qn-C9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRGUZ-00045a-BA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:50:58 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:33510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cRGUZ-00044X-2F
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:50:55 -0500
Date: Wed, 11 Jan 2017 05:50:54 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2037871271.6865501.1484131854523.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170111103442.GH12072@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<20170110165105.GR27720@redhat.com>
	<80b19297-00c4-f109-dd4f-9d2b41ee618c@redhat.com>
	<20170110183630.GA6628@redhat.com>
	<d0ff9866-2001-a028-09ae-98ba0ad3693b@redhat.com>
	<20170111102832.GG12072@redhat.com>
	<20170111103442.GH12072@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



----- Original Message -----
> From: "Daniel P. Berrange" <berrange@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: qemu-devel@nongnu.org, "Stefan Hajnoczi" <stefanha@redhat.com>
> Sent: Wednesday, January 11, 2017 11:34:42 AM
> Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to modular trace.h file
> 
> On Wed, Jan 11, 2017 at 10:28:32AM +0000, Daniel P. Berrange wrote:
> > On Tue, Jan 10, 2017 at 10:01:12PM +0100, Paolo Bonzini wrote:
> > > 
> > > 
> > > On 10/01/2017 19:36, Daniel P. Berrange wrote:
> > > > 
> > > > It seems you're saying we should also trim the top level dirs, so
> > > > we in fact get:
> > > > 
> > > > 
> > > > -I/home/berrange/src/virt/qemu/hw/scsi
> > > > -Ihw/scsi
> > > > -I/home/berrange/src/virt/qemu/tcg
> > > > -I/home/berrange/src/virt/qemu/tcg/i386
> > > > -I/home/berrange/src/virt/qemu/linux-headers
> > > > -I/home/berrange/src/virt/qemu-build/linux-headers
> > > > -I/home/berrange/src/virt/qemu/include
> > > 
> > > Yes, and ultimately tcg too.
> > 
> > So the problem with dropping BUILD_DIR from the include path is that
> > config-host.h is generated in that location. We'll have to move that
> > into BIULD_DIR/include and add -I$(BUILDDIR)/include to search path
> > instead.
> 
> Sigh and much more needs moving too...
> 
> 	module_block.h
> 	qapi-event.h
> 	qapi-types.h
> 	qapi-visit.h
> 	qemu-doc.html
> 	qemu-version.h
> 	qemu-version.h.tmp
> 	qmp-commands.h
> 	qmp-introspect.h

Can we at least move it at the end?

Paolo
