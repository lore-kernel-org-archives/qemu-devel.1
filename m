Received: from eggs.gnu.org ([2001:4830:134:3::10]:42147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQSmT-00083S-9y
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 03:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQSmQ-00050J-68
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 03:22:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47748 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQSmQ-000502-10
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 03:22:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DCE9401EF23
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 07:22:49 +0000 (UTC)
Date: Wed, 6 Jun 2018 09:22:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180606092247.54bd320d@redhat.com>
In-Reply-To: <20180605181246.GN7451@localhost.localdomain>
References: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
	<1528207243-268226-2-git-send-email-imammedo@redhat.com>
	<20180605181246.GN7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, ldoktor@redhat.com

On Tue, 5 Jun 2018 15:12:46 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Jun 05, 2018 at 04:00:42PM +0200, Igor Mammedov wrote:
> [...]
> > Based on
> >   From: Michal Privoznik <mprivozn@redhat.com>
> >   Subject: [PATCH] cli: Don't run early event loop if no --preconfig was specified
> >   Message-Id: <ad910973c593c5ac2fed3a10ea958f7e9c12f82c.1527935663.git.mprivozn@redhat.com>  
> 
> Michal's patch is already queued on machine-next.  It should be
> dropped if this patch gets included, correct?
> 
yep, it should be dropped as it has migrations issues.
