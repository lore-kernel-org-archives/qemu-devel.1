Received: from eggs.gnu.org ([2001:4830:134:3::10]:50438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gAQgp-0007vn-Uz
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gAQgl-0001i3-VX
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gAQgl-0001ay-Ny
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:26:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F24F71E2CC
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 02:26:58 +0000 (UTC)
Date: Thu, 11 Oct 2018 10:26:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181011022650.GC5014@xz-x1>
References: <20181009062718.1914-1-peterx@redhat.com>
	<902c92e2-3454-771e-51ff-ab38b970e86e@redhat.com>
	<049fc618-6e13-5030-4124-1c9f4315f7eb@redhat.com>
	<5ca812f7-c574-36fc-c7cd-f11e71a0efc1@redhat.com>
	<20181011000555.GA5014@xz-x1>
	<6b5b28f9-2ab9-93c2-ce32-6f767d8df97c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b5b28f9-2ab9-93c2-ce32-6f767d8df97c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 0/6] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Oct 10, 2018 at 08:17:41PM -0500, Eric Blake wrote:
> On 10/10/18 7:05 PM, Peter Xu wrote:
> 
> > > other than the command line that is hanging:
> > > 
> > > /home/eblake/qemu/x86_64-softmmu/qemu-system-x86_64 -S -no-user-config
> > > -nodefaults -nographic -machine none,accel=kvm:tcg -qmp
> > > unix:/var/lib/libvirt/qemu/capabilities.monitor.sock,server,nowait -pidfile
> > > /var/lib/libvirt/qemu/capabilities.pidfile -daemonize
> > > 
> > > And I suspect it is the -daemonize that is causing the hang I'm seeing when
> > > run by libvirt.
> > > 
> 
> > 
> > It's very possible the daemonize thing, actually Wolfgang Bumiller has
> > posted patches to fix this up (it's not the problem of this series,
> > but it just exposed this to libvirt by the series since it only
> > happens when oob and daemonize are both enabled).  The fixes are:
> > 
> >    [PATCH v2 0/2] delay monitor iothread creation
> > 
> > Since it cannot be applied cleanly onto this series, I resolved the
> > conflicts and pushed a tree here in case you wanna try with these two
> > extra patches applied:
> > 
> >    https://github.com/xzpeter/qemu/tree/test-oob
> 
> Technically, we should apply the patches in the opposite order (Wolfgang's
> first, then yours), so that bisection does not land on a known-bad hang
> situation.

Agreed, that patch actually fixes bug of current master (current
master could possibly hit the same issue when with x-oob=on and
-daemonize), so should be applied earlier when proper.

> 
> > 
> > Please feel free to test with libvirt again with that.
> > 
> > Thanks for playing with the tree and further investigation!  I will
> > also mention this in the next version of cover letter (if there is one).
> 
> Confirmed that libvirt no longer hung with Wolfgang's patches added in.

Thanks!

-- 
Peter Xu
