Received: from eggs.gnu.org ([2001:4830:134:3::10]:33181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ0R0-0006Li-Tp
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ0Qx-0006Yr-Qt
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJ0Qx-0006YS-KZ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:41:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B431719D23E
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 17:41:50 +0000 (UTC)
Date: Wed, 16 May 2018 14:41:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180516174146.GO25013@localhost.localdomain>
References: <1526483174-169008-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526483174-169008-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] numa: clarify error message when node
 index is out of range in -numa dist, ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com

On Wed, May 16, 2018 at 05:06:14PM +0200, Igor Mammedov wrote:
> When using following CLI:
>   -numa dist,src=128,dst=1,val=20
> user gets a rather confusing error message:
>    "Invalid node 128, max possible could be 128"
> 
> Where 128 is number of nodes that QEMU supports (MAX_NODES),
> while src/dst is an index up to that limit, so it should be
> MAX_NODES - 1 in error message.
> Make error message to explicitly state valid range for node
> index to be more clear.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Queued, thanks.

-- 
Eduardo
