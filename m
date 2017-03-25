Received: from eggs.gnu.org ([2001:4830:134:3::10]:51985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crlcF-0001gU-1Y
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 09:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crlcA-0006fi-Ju
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 09:20:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1crlcA-0006fS-E3
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 09:20:18 -0400
Date: Sat, 25 Mar 2017 06:14:18 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <291670989.7316919.1490436858720.JavaMail.zimbra@redhat.com>
In-Reply-To: <DM2PR21MB006087829595A4E336AFC9BB9E3E0@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
	<1173789300.7253222.1490394527808.JavaMail.zimbra@redhat.com>
	<DM2PR21MB006087829595A4E336AFC9BB9E3E0@DM2PR21MB0060.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] win32: replace custom mutex and condition
 variable with native primitives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Andrey Shedel <ashedel@microsoft.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org



----- Original Message -----
> From: "Andrew Baumann" <Andrew.Baumann@microsoft.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "Andrey Shedel" <ashedel@microsoft.com>, "Stefan Weil" <sw@weilnetz.de>, qemu-devel@nongnu.org
> Sent: Saturday, March 25, 2017 12:14:20 AM
> Subject: Re: [Qemu-devel] [PATCH] win32: replace custom mutex and condition variable with native primitives
> 
> > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > Sent: Friday, 24 March 2017 15:29
> 
> > > From: Andrey Shedel <ashedel@microsoft.com>
> > >
> > > The multithreaded TCG implementation exposed deadlocks in the win32
> > > condition variables: as implemented, qemu_cond_broadcast waited on
> > > receivers, whereas the pthreads API it was intended to emulate does
> > > not. This was causing a deadlock because broadcast was called while
> > > holding the IO lock, as well as all possible waiters blocked on the
> > > same lock.
> > >
> > > This patch replaces all the custom synchronisation code for mutexes
> > > and condition variables with native Windows primitives (SRWlocks and
> > > condition variables) with the same semantics as their POSIX
> > > equivalents. To enable that, it requires a Windows Vista or newer host
> > > OS.
> > >
> > > [AB: edited commit message]
> > > Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> > 
> > Oops, just a nit but an important one: there should be a
> > Signed-off-by for Andrey as well.
> 
> Oops, my fault, since I took his code and prepared the patch submission. We
> can resend with the signoff, but perhaps I should wait for a review?

It's enough if he replies with the Signed-off-by line.

Paolo
