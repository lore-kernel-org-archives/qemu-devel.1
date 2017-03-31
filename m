Received: from eggs.gnu.org ([2001:4830:134:3::10]:47820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cu0XB-0000lB-SM
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cu0X6-0005Lk-Vo
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:40:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cu0X6-0005La-PR
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:40:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83E48437F4C
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 17:40:19 +0000 (UTC)
Date: Fri, 31 Mar 2017 18:40:14 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170331174014.GK13825@redhat.com>
References: <20170331164322.24020-1-stefanha@redhat.com>
	<4de63a1a-e385-e22f-9bc4-f29d90cbdc30@redhat.com>
	<20170331173101.GL30620@redhat.com>
	<692126d8-68ad-d546-1adb-32e041976683@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692126d8-68ad-d546-1adb-32e041976683@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char: kick main loop after adding a watch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Frediano Ziglio <fziglio@redhat.com>

On Fri, Mar 31, 2017 at 07:31:57PM +0200, Paolo Bonzini wrote:
> 
> 
> On 31/03/2017 19:31, Richard W.M. Jones wrote:
> > On Fri, Mar 31, 2017 at 06:53:56PM +0200, Paolo Bonzini wrote:
> >> glib is expecting QEMU to use g_main_context_acquire around accesses to 
> >> GMainContext.  However QEMU is not doing that, instead it is taking its 
> >> own mutex.  So we should add g_main_context_acquire and
> >> g_main_context_release in the two implementations of 
> >> os_host_main_loop_wait; these should undo the effect of Frediano's 
> >> glib patch.
> > 
> > Based on this paragraph, I'm testing the attached patch, and it does
> > also appear to solve the hanging serial port problem.
> 
> Great, can you do more testing and/or send the patch formally as a
> toplevel message?

Sure, I'm going to test it a lot more overnight, and then
if it survives all that I'll post it properly.

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
