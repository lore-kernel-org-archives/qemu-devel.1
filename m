Received: from eggs.gnu.org ([2001:4830:134:3::10]:44901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffiXA-0005zg-IA
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffiX7-000120-E4
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:14:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ffiX7-00011b-9Y
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:14:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7BFA4023132
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 09:14:04 +0000 (UTC)
Date: Wed, 18 Jul 2018 17:14:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180718091400.GD6197@xz-mi>
References: <20180718090557.17248-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718090557.17248-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0] qapi: Make 'allow-oob' optional in
 SchemaInfoCommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com

On Wed, Jul 18, 2018 at 11:05:57AM +0200, Markus Armbruster wrote:
> Making 'allow-oob' optional in SchemaInfoCommand permits omitting it
> in the common case.  Shrinks query-qmp-schema's output from 122.1KiB
> to 118.6KiB for me.
> 
> Note that out-of-band execution is still experimental (you have to
> configure the monitor with x-oob=on to use it).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

-- 
Peter Xu
