Received: from eggs.gnu.org ([2001:4830:134:3::10]:48455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxU8h-0002qk-3r
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxU8c-0005Ym-CT
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:30:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxU8c-0005XF-7A
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:30:14 -0400
Date: Wed, 5 Sep 2018 17:30:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180905093003.GC23021@xz-x1>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180720092717.GB16910@xz-mi>
	<4c3e07f4-ba82-9b88-6d32-4407b10a9926@virtuozzo.com>
	<20180905033255.GA16809@xz-x1>
	<bc0fc93d-0ad8-0715-de64-82181e83e4c0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc0fc93d-0ad8-0715-de64-82181e83e4c0@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/17] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Sep 05, 2018 at 12:18:09PM +0300, Denis Plotnikov wrote:
> Hi Peter,
> 
> Thanks for the reply.
> 
> Ok, I understand about tcg.
> So my only option is to wait for userfaultfd-wp.
> Do you know if anyone is  currently working on this? And if so, then is
> there any estimations when the userfaultfd is ready?

I am working on it, but it's only progressing slowly.  The latest
status is that I can run with QEMU/tcg now with Andrea's tree (will
need two more patches to be applied upon from me) however all the
changes are still unmature (e.g., one of the patch is discussing on
the linux-mm list, the other one I haven't discussed with anyone; but
these patches worked for me).

Let me know if want to play with the tree, at least I can share with
you on what I got (so maybe at least you can try to run your live
snapshot with QEMU/tcg with my userfaultfd tree; if error occurred we
can investigate).  Again, it is always welcomed if you want to
participate in the kernel work too.

Let me know what you think about it.

Regards,

-- 
Peter Xu
