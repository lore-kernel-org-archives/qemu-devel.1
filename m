Received: from eggs.gnu.org ([2001:4830:134:3::10]:48792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUFfv-0001kX-OI
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUFfu-0007nR-Ia
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:44:03 -0500
Date: Tue, 4 Dec 2018 16:43:55 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181204184355.GG18284@habkost.net>
References: <20181204172535.2799-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204172535.2799-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Stefan Berger <stefanb@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org

On Tue, Dec 04, 2018 at 06:25:35PM +0100, Markus Armbruster wrote:
> Clean up includes so that osdep.h is included first and headers
> which it implies are not included manually.
> 
> This commit was created with scripts/clean-includes, with the changes
> to the following files manually reverted:
> 
>     contrib/libvhost-user/libvhost-user-glib.h
>     contrib/libvhost-user/libvhost-user.c
>     contrib/libvhost-user/libvhost-user.h
>     linux-user/mips64/cpu_loop.c
>     linux-user/mips64/signal.c
>     linux-user/sparc64/cpu_loop.c
>     linux-user/sparc64/signal.c
>     linux-user/x86_64/cpu_loop.c
>     linux-user/x86_64/signal.c
>     target/s390x/gen-features.c
>     tests/migration/s390x/a-b-bios.c
>     tests/test-rcu-simpleq.c
>     tests/test-rcu-tailq.c
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
