Received: from eggs.gnu.org ([2001:4830:134:3::10]:50416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=63880a4e9=anthony.perard@citrix.com>)
	id 1f8Rje-0001fa-7Y
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=63880a4e9=anthony.perard@citrix.com>)
	id 1f8Rjb-0003bu-3R
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:37:30 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:13540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=63880a4e9=anthony.perard@citrix.com>)
	id 1f8Rja-0003bK-Q2
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:37:27 -0400
Date: Tue, 17 Apr 2018 15:37:23 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180417143723.GN2208@perard>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c7d408cb-454c-2322-3812-a7cacecdbe5f@citrix.com>
	<635d45e1-2d97-6313-2348-1e2bc9061d8b@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen/pt: use address_space_memory object
 for memory region hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, sstabellini@kernel.org, ross.lagerwall@citrix.com

On Tue, Apr 17, 2018 at 03:18:55PM +0100, Igor Druzhinin wrote:
> On 17/04/18 15:15, Anthony PERARD wrote:
> > On Fri, Apr 06, 2018 at 10:21:23PM +0100, Igor Druzhinin wrote:
> >> The issue that the original patch tried to workaround (uneven number of
> >> region_add/del calls on device attach/detach) was fixed in later QEMU
> >> versions.
> > 
> > Do you know when the issue was fixed?
> > 
> 
> I haven't tracked down a particular version but the previous behavior of
> memory_listener_unregister() was to remove the listener from the list
> without calling the callback. It has changed since then and now the
> callback is called in listener_del_address_space().

On Tue, Apr 17, 2018 at 03:29:42PM +0100, Igor Druzhinin wrote:
> I think it's this commit:
> 
> commit d25836cafd7508090d211e97acfc0abc5ae88daa
> Author: Peter Xu <peterx@redhat.com>
> Date:   Mon Jan 22 14:02:44 2018 +0800
> 
>     memory: do explicit cleanup when remove listeners


I think these information ought to be in the commit message, in
particular the fact that the callback wasn't call on detach. And with
the commit message updated, you can add my:
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
