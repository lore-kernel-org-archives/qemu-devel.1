Received: from eggs.gnu.org ([2001:4830:134:3::10]:44838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dO1Qw-0005Cb-Ib
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dO1Qs-0005aE-G6
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dO1Qs-0005Zw-9W
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:41:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 051751F580
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:41:56 +0000 (UTC)
Date: Thu, 22 Jun 2017 09:41:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170622124148.GA20956@localhost.localdomain>
References: <20170614203000.19984-1-ehabkost@redhat.com>
	<20170614203000.19984-5-ehabkost@redhat.com>
	<20170622122649.GD2624@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170622122649.GD2624@work-vm>
Subject: Re: [Qemu-devel] [PATCH 4/5] memory: Add 'persistent' parameter to
 memory_region_init_ram_from_file()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Thu, Jun 22, 2017 at 01:26:49PM +0100, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > Make it possible to set the RAM_NONPERSISTENT flag on the RAMBlock when
> > mapping a file.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> A little confusing having a persistent flag passed in but setting a
> NONPERSISTENT flag.
> 
> One thing to watch out for is the other effect, for example I think
> doing an MADV_REMOVE will zero the file;  if that's a ROM file that
> would probably be bad; but your description of persistent=false
> might make sense for a ROM file since it wont be changed.

Good point.  Sounds like a good idea to reword the documentation to
mentiuon that in addition to making data not written back, contents
might be destroyed.

-- 
Eduardo
