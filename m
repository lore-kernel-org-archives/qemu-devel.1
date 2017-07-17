Received: from eggs.gnu.org ([2001:4830:134:3::10]:60581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXAwp-0007bc-MZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXAwo-0002wu-Rv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXAwo-0002wC-Ln
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:40:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A160180F90
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 18:40:45 +0000 (UTC)
Date: Mon, 17 Jul 2017 15:40:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170717184043.GF5167@localhost.localdomain>
References: <20170707122215.8819-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707122215.8819-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] qmp: Return extra information on
 qom-list-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On Fri, Jul 07, 2017 at 09:22:12AM -0300, Eduardo Habkost wrote:
> This series adds 'abstract' and 'parent' fields to the output of
> qom-list-types.
> 
> For reference, below are the sizes of the output of
> "qom-list-types abstract=true" on qemu-system-x86_64, before and
> after applying the patches:
> 
> * before: 11724 bytes
> * with 'abstract' field: 13146 bytes
> * with 'abstract' and 'parent': 24046 bytes
> 
> This is just a rebase of v2.  I'm sending it as v3 because a long
> time has passed since v2 was submitted.

As we're close to soft freeze, I'm queueing this on my
machine-next branch.

-- 
Eduardo
