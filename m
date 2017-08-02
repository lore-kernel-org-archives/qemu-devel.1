Received: from eggs.gnu.org ([2001:4830:134:3::10]:53216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dcoRM-0003En-Qq
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dcoRI-0006bw-V3
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:51:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dcoRI-0006ZG-OD
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:51:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8660C24EE86
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 07:51:28 +0000 (UTC)
Date: Wed, 2 Aug 2017 09:51:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170802095122.228fc8a8@nial.brq.redhat.com>
In-Reply-To: <20170802001139-mutt-send-email-mst@kernel.org>
References: <1501515652-33372-1-git-send-email-imammedo@redhat.com>
	<20170802001139-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/5] tests: acpi: make sure FADT
 is compared to reference table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

On Wed, 2 Aug 2017 00:14:18 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 31, 2017 at 05:40:47PM +0200, Igor Mammedov wrote:
> > While refactoring i386/FADT generation to build_append_int_noprefix()            
> > and testing it, It turned out that FADT is only tested for valid                 
> > checksum but actual test for unintended changes isn't applied to it              
> > even though we have reference tables in tree.                                    
> > So here goes a couple of cleanups to reflect what fuctions do +                  
> > some comments and actual fix.                                                    
> >                                                                                  
> > Note to maintainer:                                                              
> >   FADT reference table is out of sync and should be updated along with           
> >   series applied.                                                                
> >                                                                                  
> > CC: "Michael S. Tsirkin" <mst@redhat.com>                                        
> > CC: Marcel Apfelbaum <marcel@redhat.com>   
> 
> Absolutely good stuff, but not a bugfix as such (it's not that the
> test is wrong, it's that we skip FADT for now)
> so I don't think this is 2.10 material.
Agreed, it could go in when 2.11 merge window is open.

> 
> > Igor Mammedov (5):
> >   tests: acpi: move tested tables array allocation outside of
> >     test_acpi_dsdt_table()
> >   tests: acpi: init table descriptor in test_dst_table()
> >   tests: acpi: rename test_acpi_tables()/test_dst_table() to reflect its
> >     usage
> >   tests: acpi: add comments to fetch_rsdt_referenced_tables/data->tables
> >     usage
> >   tests: acpi: fix FADT not being compared to reference table
> > 
> >  tests/bios-tables-test.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > -- 
> > 2.7.4  
