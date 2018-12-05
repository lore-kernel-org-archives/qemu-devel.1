Received: from eggs.gnu.org ([2001:4830:134:3::10]:43681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gUUic-0004oG-BF
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gUUiY-0006Pr-6Y
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:47:50 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gUUiX-0006Js-Ll
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:47:46 -0500
Received: by mail-lj1-x244.google.com with SMTP id x85-v6so17879856ljb.2
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 02:47:45 -0800 (PST)
Date: Wed, 5 Dec 2018 13:47:38 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-ID: <20181205134738.30b1cd18@phystech.edu>
In-Reply-To: <20181204172535.2799-1-armbru@redhat.com>
References: <20181204172535.2799-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Stefan Berger <stefanb@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org

On Tue,  4 Dec 2018 18:25:35 +0100
Markus Armbruster <armbru@redhat.com> wrote:

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
> ---

For the elf2dmp:

>  contrib/elf2dmp/pdb.h                     | 2 --
>  contrib/elf2dmp/pe.h                      | 1 -
>  contrib/elf2dmp/qemu_elf.h                | 1 -

Acked-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

-- 
Viktor Prutyanov
