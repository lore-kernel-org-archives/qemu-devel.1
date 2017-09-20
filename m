Received: from eggs.gnu.org ([2001:4830:134:3::10]:49817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dufRY-0000Kv-4a
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dufRV-0004z0-3X
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dufRU-0004yn-Tv
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:53:33 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1504081950-2528-7-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 30 Aug 2017 16:32:03 +0800")
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-7-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 20 Sep 2017 11:06:50 +0200
Message-ID: <87shfhkac5.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 06/33] migration: reuse
 mis->userfault_quit_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:

> @@ -448,8 +449,15 @@ static void *postcopy_ram_fault_thread(void *opaque)
>          }
>=20=20
>          if (pfd[1].revents) {
> -            trace_postcopy_ram_fault_thread_quit();
> -            break;
> +            uint64_t tmp64 =3D 0;
> +
> +            /* Consume the signal */
> +            read(mis->userfault_event_fd, &tmp64, 8);

make: Entering directory '/scratch/qemu/next/all'
  CC      migration/postcopy-ram.o
/mnt/kvm/qemu/next/migration/postcopy-ram.c: In function =E2=80=98postcopy_=
ram_fault_thread=E2=80=99:
/mnt/kvm/qemu/next/migration/postcopy-ram.c:460:13: error: ignoring return =
value of =E2=80=98read=E2=80=99, declared with attribute warn_unused_result=
 [-Werror=3Dunused-result]
             read(mis->userfault_event_fd, &tmp64, 8);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
