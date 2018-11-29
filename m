Received: from eggs.gnu.org ([2001:4830:134:3::10]:37797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gSPL8-0000PP-Rv
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gSPL3-0008N5-GF
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:38:58 -0500
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:40428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gSPL3-0008MY-8q
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:38:53 -0500
Received: from player772.ha.ovh.net (unknown [10.109.143.72])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0D058EBAEB
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 17:38:52 +0100 (CET)
Date: Thu, 29 Nov 2018 17:38:48 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181129173848.6b561d27@bahia.lan>
In-Reply-To: <20181129162648.GI14786@perard.uk.xensource.com>
References: <154350643288.788685.710801848628732800.stgit@bahia.lan>
	<20181129162648.GI14786@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 4.0 1/2] 9p: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, 29 Nov 2018 16:26:48 +0000
Anthony PERARD <anthony.perard@citrix.com> wrote:

> On Thu, Nov 29, 2018 at 04:47:12PM +0100, Greg Kurz wrote:
> > Because it is a recommended coding practice (see HACKING).
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>  
> 
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> It would have been nice if there were a cover letter for these two
> patches, as we would had automatic build test and coding style test ;-).
> 

Yeah... I had it ready and I simply forgot to pass it to stg mail :-\

I've pushed them to my 9p-next branch, which automatically triggers travis,
so I'll have the build test covered at least :)

Thanks for the review ! 

Cheers,

--
Greg
