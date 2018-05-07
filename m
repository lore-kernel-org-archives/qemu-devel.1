Received: from eggs.gnu.org ([2001:4830:134:3::10]:52437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fFdSP-0003tt-JL
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fFdSO-0000gP-Qw
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:33:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fFdSO-0000fe-NI
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:33:24 -0400
Date: Mon, 7 May 2018 12:33:20 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180507103320.GE17261@vader>
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<df015c61-0dde-da33-86eb-31abbd6ec805@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df015c61-0dde-da33-86eb-31abbd6ec805@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/1] Bug: Sandbox: libvirt breakdowns qemu
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org, jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, fiuczy@linux.ibm.com, libvir-list@redhat.com

On 07/05/2018 - 11:29:57, Christian Borntraeger wrote:
> On 05/07/2018 05:32 AM, Yi Min Zhao wrote:
> > 1. Problem Description
> > ======================
> > If QEMU is built without seccomp support, 'elevatorprivileges' remains compiled.
> > This option of sandbox is treated as an indication for seccomp blacklist support
> > in libvirt. This behavior is introduced by the libvirt commits 31ca6a5 and
> > 3527f9d. It would make libvirt build wrong QEMU cmdline, and then the guest
> > startup would fail.
> 
> Adding libvirt list.
> 
> This would still fail with older QEMUs, so the question is if we should also OR instead
> change something in libvirt.

Perhaps I'm missing something here, but libvirt can differentiate between
different versions of QEMU, therefore not calling it with wrong or outdated
arguments.

> 
> > 
> > 2. Libvirt Log
> > ==============
> > qemu-system-s390x: -sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,\
> > resourcecontrol=deny: seccomp support is disabled
> > 
> > 3. Fixup
> > ========
> > Wrap the options except 'enable' for qemu_sandbox_opts by CONFIG_SECCOMP.
> > 
> > Yi Min Zhao (1):
> >   sandbox: avoid to compile options if CONFIG_SECCOMP undefined
> > 
> >  vl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> 

-- 
Eduardo Otubo
