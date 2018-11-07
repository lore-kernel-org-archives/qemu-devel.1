Received: from eggs.gnu.org ([2001:4830:134:3::10]:41872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKShw-0007ug-DY
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKSht-0007aw-JS
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:37:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gKShr-0007UO-GH
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:37:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAB02C049586
	for <qemu-devel@nongnu.org>; Wed,  7 Nov 2018 18:37:33 +0000 (UTC)
Date: Wed, 7 Nov 2018 16:37:31 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181107183731.GB12503@habkost.net>
References: <1541510826-21031-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541510826-21031-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/device-crash-test: Remove known
 crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Nov 06, 2018 at 02:27:06PM +0100, Thomas Huth wrote:
> Looks like we've fixed them all already in the past months, e.g. with:
> 
>  f7d6bfcdc0fe49040aac3ac131a319cb5427957e
>  spapr_pci: fail gracefully with non-pseries machine types
> 
>  2363d5ee231bf047479422d56d3b85b7d37a7c23
>  hw/ppc/spapr_cpu_core: Add a proper check for spapr machine
> 
>  ef0e8fc768a561dd13a86420b3268f6f3d5d0621
>  iommu: Don't crash if machine is not PC_MACHINE
> 
>  8929fc3a55f33a103adddf9cfd010bcf2b255c7d
>  hw/block/pflash_cfi*.c: fix confusing assert fail message
> 
> ... so we can remove these entries from the ERROR_WHITELIST now.

Nice!

Queueing on python-next, thanks.

-- 
Eduardo
