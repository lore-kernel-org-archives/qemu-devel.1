Received: from eggs.gnu.org ([2001:4830:134:3::10]:39239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3XjE-000398-TT
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3XjA-0007l9-2e
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:00:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3Xj9-0007kD-V2
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:00:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79C358182D16
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 02:00:43 +0000 (UTC)
Date: Wed, 4 Apr 2018 10:00:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180404020040.GH6839@lemon.usersys.redhat.com>
References: <cover.1522760575.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522760575.git.mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Couple of qemu-pr-helper fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, 04/03 15:12, Michal Privoznik wrote:
> The first one is trivial.
> 
> The second is slightly trickier. Libvirt has this virCommand subsystem
> (found under src/util/vircommand.c) which it uses to spawn commands. The
> subsystem allows libvirt to both daemonize a process and learn its PID.
> The latter of course does not work if command daemonizes itself (hence
> libvirt will not use qemu-pr-helper --daemon). BUT, we still need
> qemu-pr-helper to lock the pidfile (so that when libvirt tries to lock
> it it is denied). NB, libvirt uses fnctl(cmd = F_SETLK) to lock
> pidfiles. So leaking locked FD into qemu-pr-helper is not an option
> because that doesn't survive fork().
> 
> Another, trivial reason might be that if I run:
> 
>   qemu-pr-helper --pidfile /tmp/pr.pid
> 
> (without --daemon), I'd still expect qemu-pr-helper to write pidfile
> because I told it to.
> 
> Michal Privoznik (2):
>   qemu-pr-helper: Daemonize before dropping privileges
>   qemu-pr-helper: Write pidfile more often

Reviewed-by: Fam Zheng <famz@redhat.com>
