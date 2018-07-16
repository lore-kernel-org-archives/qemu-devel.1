Received: from eggs.gnu.org ([2001:4830:134:3::10]:51405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fezrE-0003nC-7Y
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fezrB-0003te-4d
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:31:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fezrB-0003sd-0X
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:31:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E629D401EF05
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 09:31:47 +0000 (UTC)
Date: Mon, 16 Jul 2018 17:31:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180716093142.GD20520@xz-mi>
References: <20180716091012.29510-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716091012.29510-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: Fix tracepoint crash on JSON
 syntax error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, eblake@redhat.com

On Mon, Jul 16, 2018 at 11:10:12AM +0200, Markus Armbruster wrote:
> When tracepoint handle_qmp_command is enabled, we crash on JSON syntax
> errors.  Broken in commit 1cc37471525.  Fix by skipping the tracepoint
> on JSON syntax error.  Before the flawed commit, we skipped it by
> returning early.
> 
> Fixes: CID 1394216
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
