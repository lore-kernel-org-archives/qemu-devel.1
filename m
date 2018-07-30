Received: from eggs.gnu.org ([2001:4830:134:3::10]:58193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fk2vV-0007xS-HP
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fk2vS-0003jF-F6
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:49:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fk2vS-0003ir-AR
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 374948160F82
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 07:49:05 +0000 (UTC)
Date: Mon, 30 Jul 2018 09:49:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180730094903.2b469c71@redhat.com>
In-Reply-To: <20180729000937-mutt-send-email-mst@kernel.org>
References: <1532703031-166467-1-git-send-email-imammedo@redhat.com>
	<20180727215240.GX12380@localhost.localdomain>
	<20180729000937-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] pc: acpi: fix memhp regression by
 reducing stub SRAT entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On Sun, 29 Jul 2018 00:09:58 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jul 27, 2018 at 06:52:40PM -0300, Eduardo Habkost wrote:
> > On Fri, Jul 27, 2018 at 04:50:31PM +0200, Igor Mammedov wrote:
> > [...]  
> > > NOTE TO MAINTAINER: UPDATE REFERRENCE APCI TABLE BLOBS IN TESTS  
> > 
> > Why this needs to be done manually?  Can't the ACPI table update
> > be included in the e-mailed patch? 
additional reason is that we can't really review the binary part,
hence we came up with this reminder policy
 
> Yes but then there's no guarantee it will apply to my tree:
> binary diff conflicts can't be resolved.
> 
> > -- 
> > Eduardo  
