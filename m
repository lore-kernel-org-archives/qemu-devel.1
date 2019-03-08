Received: from eggs.gnu.org ([209.51.188.92]:40783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h25pK-0004Dm-R9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 22:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h25pK-00062z-3G
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 22:05:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h25pJ-0005vn-Pz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 22:05:37 -0500
Date: Fri, 8 Mar 2019 11:05:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190308030523.GC16479@xz-x1>
References: <20190306115532.23025-1-peterx@redhat.com>
	<20190306115532.23025-5-peterx@redhat.com>
	<20190307144039.GG2843@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307144039.GG2843@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] iothread: push gcontext earlier in
 the thread_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Mar 07, 2019 at 02:40:39PM +0000, Stefan Hajnoczi wrote:
> On Wed, Mar 06, 2019 at 07:55:31PM +0800, Peter Xu wrote:
> > +    /*
> > +     * We should do this as soon as we enter the thread, because the
> > +     * function will silently fail if it fails to acquire the
> > +     * gcontext.
> > +     */
> > +    g_main_context_push_thread_default(iothread->worker_context);
> 
> I have a hard time understanding this comment.  The mention of how it
> fails makes me think "we'll never find out about failures anyway, so how
> does it help to call this early?".
> 
> I suggest sticking to the point that this function must always be called
> first:
> 
>   /*
>    * g_main_context_push_thread_default() must be called before anything
>    * in this new thread uses glib.
>    */
> 
> Now people will think before moving this function call.

Sorry to be confusing; this looks good to me.  Please let me know if
you want me to repost this patch alone or the patchset with the change.

Thanks,

-- 
Peter Xu
