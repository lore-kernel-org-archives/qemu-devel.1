Received: from eggs.gnu.org ([2001:4830:134:3::10]:59700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYAcO-0008Ru-QU
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYAcJ-0005Ok-2K
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:36:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYAcI-0005OC-MG
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:36:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47FC377888
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:36:14 +0000 (UTC)
Date: Wed, 27 Jun 2018 21:36:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180627133609.GC2455@xz-mi>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87po0cad8n.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87po0cad8n.fsf_-_@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 09:40:40AM +0200, Markus Armbruster wrote:
> Another lose end: event COMMAND_DROPPED seems to lack test coverage.

This one I can do.  Since I'll try to prepare some patches to fix the
event issue, I can try to add the test alongside.

Thanks for mentioning!

-- 
Peter Xu
