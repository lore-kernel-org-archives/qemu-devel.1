Received: from eggs.gnu.org ([2001:4830:134:3::10]:45389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faaaM-0008T4-H6
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 01:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faaaI-0003Vk-NU
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 01:44:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57736 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1faaaI-0003VT-Ii
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 01:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29EF840201C7
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 05:44:10 +0000 (UTC)
Date: Wed, 4 Jul 2018 13:44:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180704054405.GB2568@xz-mi>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87sh52b3bp.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sh52b3bp.fsf_-_@dusky.pond.sub.org>
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

On Mon, Jul 02, 2018 at 07:43:06AM +0200, Markus Armbruster wrote:
> More lose ends:
> 
> * scripts/qmp/ doesn't support OOB, yet.  qmp-shell.py in particular
> 
> * test-qmp-cmds neglects to cover the OOB additions to qmp-dispatch.c

Would you mind I put these aside for now?

I'm afraid things grow then we lose control, so not sure whether I can
just focus on the bugs first (e.g., the COMMAND_DROP event
broadcasting, and also the response queue flow control issue).

Thanks,

-- 
Peter Xu
