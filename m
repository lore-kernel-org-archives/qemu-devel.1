Received: from eggs.gnu.org ([2001:4830:134:3::10]:38976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUr8k-0003Tl-PX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUr8f-0005qy-Qp
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:07:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dUr8f-0005qi-KC
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:07:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8587180C26
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 09:07:24 +0000 (UTC)
Date: Tue, 11 Jul 2017 11:07:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170711090721.GE4335@noname.str.redhat.com>
References: <20170710165827.4250-1-pbonzini@redhat.com>
	<20170710165827.4250-2-pbonzini@redhat.com>
	<20170711082836.GB4335@noname.str.redhat.com>
	<fcbd4204-3604-b562-0cde-af697344f2a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcbd4204-3604-b562-0cde-af697344f2a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] qcow2: make qcow2_do_open a
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Am 11.07.2017 um 10:34 hat Paolo Bonzini geschrieben:
> On 11/07/2017 10:28, Kevin Wolf wrote:
> > Am 10.07.2017 um 18:58 hat Paolo Bonzini geschrieben:
> >> It is called from qcow2_invalidate_cache in coroutine context, so always
> >> load metadata from a coroutine.
> >> ---
> >>  block/qcow2.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 40 insertions(+), 5 deletions(-)
> > 
> > Missing S-o-b on patches 1 and 2?
> 
> Oops, yes.  Though I don't think these patches are for 2.10.  They are
> on top of Stefan's bdrv_co_create series, by the way.

Why not for 2.10? They look simple and self-contained. I haven't looked
at bdrv_co_create yet, but it shouldn't be much more complicated either.

Kevin
