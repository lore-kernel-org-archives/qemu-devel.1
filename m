Received: from eggs.gnu.org ([2001:4830:134:3::10]:38294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUr54-0001V8-Q0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUr4z-0004kP-T3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:03:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dUr4z-0004k8-My
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:03:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E92583F45
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 09:03:33 +0000 (UTC)
Date: Tue, 11 Jul 2017 11:03:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170711090329.GD4335@noname.str.redhat.com>
References: <20170710165827.4250-1-pbonzini@redhat.com>
	<20170710165827.4250-4-pbonzini@redhat.com>
	<20170711082451.GA4335@noname.str.redhat.com>
	<555a050c-46cb-72c3-e3c0-fb37fd23bdf4@redhat.com>
	<20170711083911.GC4335@noname.str.redhat.com>
	<ab39bbb2-3007-6387-2bfd-315c7b6e02db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab39bbb2-3007-6387-2bfd-315c7b6e02db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] block: convert bdrv_invalidate_cache
 callback to coroutine_fn
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

Am 11.07.2017 um 10:41 hat Paolo Bonzini geschrieben:
> On 11/07/2017 10:39, Kevin Wolf wrote:
> > Can you just add a comment to this effect to qcow2/qed_do_open() then?
> 
> Good point.
> 
> >>> Or maybe the cleaner way would be bdrv_drained_begin/end() around
> >>> everything directly in bdrv_co_invalidate_cache().
> > 
> > Should we do this anyway? Or assert that no requests are in flight?
> 
> I can certainly add assertions for clarity, but wouldn't requests have
> failed the permission checks and caused assertion failures already?

I'm pretty sure that read requests are allowed on inactive images.

Kevin
