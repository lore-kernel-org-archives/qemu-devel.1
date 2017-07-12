Received: from eggs.gnu.org ([2001:4830:134:3::10]:57886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVMxc-0007cY-8u
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVMxX-0004Ld-58
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:06:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVMxW-0004JU-Us
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:06:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEE2D30313C
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 19:06:01 +0000 (UTC)
Date: Wed, 12 Jul 2017 16:05:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170712190558.GK6020@localhost.localdomain>
References: <1499842423-21101-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499842423-21101-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] migration: export cap/params to qdev
 props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jul 12, 2017 at 02:53:40PM +0800, Peter Xu wrote:
[...]
> These properties should only be used for debugging/testing purpose,
> and we should not guarantee any interface compatibility for them (just
> like HMP).

If we don't guarantee compatibility, the property names need to
be prefixed with "x-".

-- 
Eduardo
