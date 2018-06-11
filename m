Received: from eggs.gnu.org ([2001:4830:134:3::10]:58634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQhq-0004NQ-3x
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQhn-00058g-8w
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQhn-000588-3p
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1098C3086258
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:34:10 +0000 (UTC)
Date: Mon, 11 Jun 2018 14:34:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611173408.GC24764@localhost.localdomain>
References: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
	<1528207243-268226-2-git-send-email-imammedo@redhat.com>
	<20180605181246.GN7451@localhost.localdomain>
	<20180606092247.54bd320d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606092247.54bd320d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] cli: Don't run early event loop if
 no --preconfig was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: ldoktor@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Wed, Jun 06, 2018 at 09:22:47AM +0200, Igor Mammedov wrote:
> On Tue, 5 Jun 2018 15:12:46 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Tue, Jun 05, 2018 at 04:00:42PM +0200, Igor Mammedov wrote:
> > [...]
> > > Based on
> > >   From: Michal Privoznik <mprivozn@redhat.com>
> > >   Subject: [PATCH] cli: Don't run early event loop if no --preconfig was specified
> > >   Message-Id: <ad910973c593c5ac2fed3a10ea958f7e9c12f82c.1527935663.git.mprivozn@redhat.com>  
> > 
> > Michal's patch is already queued on machine-next.  It should be
> > dropped if this patch gets included, correct?
> > 
> yep, it should be dropped as it has migrations issues.

OK, previous patch dequeued, and this one queued.  It will be on
a pull request today.

-- 
Eduardo
