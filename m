Received: from eggs.gnu.org ([2001:4830:134:3::10]:39912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffi7o-0006CP-3N
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffi7k-0008ST-PN
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:47:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ffi7k-0008RB-J3
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:47:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30E624021FC9
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:47:52 +0000 (UTC)
Date: Wed, 18 Jul 2018 16:47:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180718084746.GC6197@xz-mi>
References: <20180704084507.14560-1-peterx@redhat.com>
	<87o9f7jdzv.fsf@dusky.pond.sub.org> <20180717120855.GG20520@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717120855.GG20520@xz-mi>
Subject: Re: [Qemu-devel] [PATCH 0/9] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Jul 17, 2018 at 08:08:55PM +0800, Peter Xu wrote:

[...]

> > 
> > Whatever we don't address right away we should at least mark FIXME in
> > the source code.
> > 
> > Assuming my list is complete, and my assessments correct, then we're
> > quite close to the point where we can enable OOB.  But since rc1 is
> > tomorrow already, I feel enabling it in 3.0 has become unrealistic.  I
> > understand we need it sooner rather than later for postcopy recovery.
> > However, the current state should be servicable for teaching OOB to
> > libvirt: just follow the recommendation to supply "id" (libvirt always
> > does anyway), pretend COMMAND_DROPPED doesn't exist, and pretend flow
> > control isn't an issue.
> 
> I guess the thing is not about COMMAND_DROPPED; it's about we're going
> to drop the x-oob parameter.  Now we can only use that parameter to
> enable out-of-band, and after we enable it by default we possibly want
> to remove that x-oob parameter.  So we'd better provide a constant way
> for libvirt to enable out-of-band first (and now I'll assume the
> "exec-oob" interface won't change again).  But yes I think we can do
> that after 3.0.

Btw, note that patches 4-7 might still be candidates of bug fixes for
existing out-of-band feature.  It'll drop COMMAND_DROPPED event, but
IMHO it's still better than having a broken flow control for it (and
dropping event declaration is pretty safe even clients implemented
them).  Though the changes are not trivial, so I'll leave the decision
to you on whether we'll still consider them as 3.0 material.  Anyway,
please feel free to let me know if you want me to post them
separately.

Regards,

-- 
Peter Xu
