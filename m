Received: from eggs.gnu.org ([2001:4830:134:3::10]:50204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3pzE-0007KR-Kd
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3pzB-0001jq-Ag
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d3pzA-0001jj-Vu
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:25:57 -0400
Date: Thu, 27 Apr 2017 17:25:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170427202551.GL3482@thinpad.lan.raisama.net>
References: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
	<24766133-5384-09fd-a24a-8acf964c9367@redhat.com>
	<20170427153222.5d991d2b@nial.brq.redhat.com>
	<874lxa2bex.fsf@dusky.pond.sub.org>
	<20170427164626.78f65611@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427164626.78f65611@nial.brq.redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>, He Chen <he.chen@linux.intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Apr 27, 2017 at 04:46:26PM +0200, Igor Mammedov wrote:
> On Thu, 27 Apr 2017 16:05:42 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
> > Igor Mammedov <imammedo@redhat.com> writes:
> > > On Thu, 27 Apr 2017 07:54:31 -0500
> > > Eric Blake <eblake@redhat.com> wrote:
[...]
> > >> 
> > >> Markus has asked that all new QMP commands have some testsuite exposure;
> > >> he may have some advice on what test would be best to modify to give us
> > >> some coverage of this feature.  
> > 
> > I can't see the QMP command here, but...
> > 
> > > Since it's basically validation of SLIT table, the test case
> > > should be added to tests/bios-tables-test.c  
> > 
> > ... I figure there's new stuff to test all the same.
> it could be a patch on top and doesn't have to hold this one if
> author promises to write testcase

Agreed. I'm applying this to my machine-next branch, but I would
like to get test cases before including it in a pull request.

-- 
Eduardo
