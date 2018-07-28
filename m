Received: from eggs.gnu.org ([2001:4830:134:3::10]:41370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fjWTV-00031B-2Z
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 17:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fjWTR-0003SM-Va
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 17:10:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fjWTR-0003Rf-Qm
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 17:10:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DB4640241C0
	for <qemu-devel@nongnu.org>; Sat, 28 Jul 2018 21:10:00 +0000 (UTC)
Date: Sun, 29 Jul 2018 00:09:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180729000937-mutt-send-email-mst@kernel.org>
References: <1532703031-166467-1-git-send-email-imammedo@redhat.com>
	<20180727215240.GX12380@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727215240.GX12380@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On Fri, Jul 27, 2018 at 06:52:40PM -0300, Eduardo Habkost wrote:
> On Fri, Jul 27, 2018 at 04:50:31PM +0200, Igor Mammedov wrote:
> [...]
> > NOTE TO MAINTAINER: UPDATE REFERRENCE APCI TABLE BLOBS IN TESTS
> 
> Why this needs to be done manually?  Can't the ACPI table update
> be included in the e-mailed patch?

Yes but then there's no guarantee it will apply to my tree:
binary diff conflicts can't be resolved.

> -- 
> Eduardo
