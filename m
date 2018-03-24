Received: from eggs.gnu.org ([2001:4830:134:3::10]:47507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezYCI-00040v-AF
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 21:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezYCF-0003Oe-5A
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 21:42:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezYCE-0003OT-UU
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 21:42:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 308914068026
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 01:42:04 +0000 (UTC)
Date: Sat, 24 Mar 2018 09:41:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180324014150.GU32362@xz-mi>
References: <20180323103239.32414-1-marcandre.lureau@redhat.com>
	<20180323153537.GS32362@xz-mi>
	<CAMxuvax=SPeOui3mGcmK8HAo7EqDbpUSZ8Fq3mVHCrLztmBCLA@mail.gmail.com>
	<15aaea55-9ebd-8a16-c25e-c9bc709fcabc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15aaea55-9ebd-8a16-c25e-c9bc709fcabc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: fix expected qmp_capabilities
 error description regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Mar 23, 2018 at 04:56:34PM -0500, Eric Blake wrote:

[...]

> > > 
> > 
> > Works for me (fwiw, I'll probably need the replace "hack" again,
> > because in the RFC series I am about to send, the code is factored out
> > / generalized in qmp-dispatch), but that works in the meantime, please
> > send a patch.
> 
> There have been quite a few patch ideas across multiple threads related to
> OOB fallout.  Hopefully I can keep straight which patches are intended for
> 2.12 (anything that fixes a bug, like this one, is a good candidate,

I'll mark patches with "for-2.12" if there are.

> and it
> would be nice if we can undo the temporary reversion of exposing OOB if we
> can solve all the issues that iotests exposed).

IMHO it'll still be risky considering what has already reported.

Here's my plan, hopefully to make everyone happy - we keep OOB turned
off for 2.12 and even later.  In 2.13, I'll post some new patches to
add a new monitor parameter to allow user to enable OOB explicitly,
otherwise we never enable it.  After all, for now the only real user
should be postcopy. Then we don't need to struggle around all these
mess.  What do you think?

-- 
Peter Xu
