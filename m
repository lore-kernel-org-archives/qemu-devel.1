Received: from eggs.gnu.org ([2001:4830:134:3::10]:33062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fGGMm-0003hw-Lh
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fGGMi-000256-MB
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:06:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fGGMi-00023X-IP
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:06:08 -0400
Date: Wed, 9 May 2018 12:05:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180509040554.GF19024@xz-mi>
References: <20180502104740.12123-1-peterx@redhat.com>
	<20180502104740.12123-3-peterx@redhat.com>
	<87r2mm6uv4.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2mm6uv4.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v8 02/24] migration: new postcopy-pause
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, May 08, 2018 at 05:16:15PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Introducing a new state "postcopy-paused", which can be used when the
> > postcopy migration is paused. It is targeted for postcopy network
> > failure recovery.
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> > +# @postcopy-paused: during postcopy but paused. (since 2.12)
> > +#
> 
> since 2.13
> will fix it when I queue it.

Thanks, Juan.

Do you want to queue only the first patches or the seris?  Do you want
me to repost to fix minor tweaks (e.g., what Dave pointed out in the
other thread, and s/2.12/2.13/ stuff)?

-- 
Peter Xu
