Received: from eggs.gnu.org ([2001:4830:134:3::10]:36189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d42cj-0002QA-Gq
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d42ce-0007RJ-Kp
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:55:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d42ce-0007QW-Dv
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:55:32 -0400
Date: Fri, 28 Apr 2017 11:55:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170428115527.57312155@nial.brq.redhat.com>
In-Reply-To: <20170428093911.GA26067@he>
References: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
	<24766133-5384-09fd-a24a-8acf964c9367@redhat.com>
	<20170427153222.5d991d2b@nial.brq.redhat.com>
	<874lxa2bex.fsf@dusky.pond.sub.org>
	<20170427164626.78f65611@nial.brq.redhat.com>
	<20170427202551.GL3482@thinpad.lan.raisama.net>
	<20170428093911.GA26067@he>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Andrew Jones <drjones@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, 28 Apr 2017 17:39:11 +0800
He Chen <he.chen@linux.intel.com> wrote:

> On Thu, Apr 27, 2017 at 05:25:51PM -0300, Eduardo Habkost wrote:
> > On Thu, Apr 27, 2017 at 04:46:26PM +0200, Igor Mammedov wrote:  
> > > On Thu, 27 Apr 2017 16:05:42 +0200
> > > Markus Armbruster <armbru@redhat.com> wrote:  
> > > > Igor Mammedov <imammedo@redhat.com> writes:  
> > > > > On Thu, 27 Apr 2017 07:54:31 -0500
> > > > > Eric Blake <eblake@redhat.com> wrote:  
> > [...]  
> > > > >> 
> > > > >> Markus has asked that all new QMP commands have some testsuite exposure;
> > > > >> he may have some advice on what test would be best to modify to give us
> > > > >> some coverage of this feature.    
> > > > 
> > > > I can't see the QMP command here, but...
> > > >   
> > > > > Since it's basically validation of SLIT table, the test case
> > > > > should be added to tests/bios-tables-test.c    
> > > > 
> > > > ... I figure there's new stuff to test all the same.  
> > > it could be a patch on top and doesn't have to hold this one if
> > > author promises to write testcase  
> > 
> > Agreed. I'm applying this to my machine-next branch, but I would
> > like to get test cases before including it in a pull request.
> >   
> You mean we also need a patch to add test case to
> tests/bios-tables-test.c, right? If so, I am very willing to cook and
> submit it.
yes, an additional patch.
