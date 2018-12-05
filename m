Received: from eggs.gnu.org ([2001:4830:134:3::10]:40459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gUTHh-0003Zy-Rc
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gUTHc-0001By-Az
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:15:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43260
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gUTHc-0001Bi-4G
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:15:52 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB598hBA009807
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 04:15:51 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p69khpm66-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 04:15:51 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 5 Dec 2018 09:15:49 -0000
Date: Wed, 5 Dec 2018 10:15:41 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181204172535.2799-1-armbru@redhat.com>
References: <20181204172535.2799-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181205101541.5de64eb4@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>, Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

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

Acked-by: Halil Pasic <pasic@linux.ibm.com>

Thanks,
Halil
