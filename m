Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gD1Bs-0003Ax-8Q
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 01:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gD1Bo-0003Yz-EV
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 01:49:48 -0400
Received: from mail.ispras.ru ([83.149.199.45]:49944)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gD1Bm-0003Qz-HE
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 01:49:43 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181017090750.4378-1-pbonzini@redhat.com>
	<001f01d465fd$01af8b80$050ea280$@ru>
	<CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
	<0817e2fe-5a97-a4ed-9ae2-2e8dee6c9a43@redhat.com>
	<004201d4660d$e86ef1e0$b94cd5a0$@ru>
	<a29da0a1-85d7-c57c-5c42-27594a7849ac@redhat.com>
	<005c01d4661c$3a9cd0a0$afd671e0$@ru>
	<CANzW0mtAh9vjWa-TAdB60b1kvyN_3O07kbyvFzYO_eL6sNjHQQ@mail.gmail.com>
In-Reply-To: <CANzW0mtAh9vjWa-TAdB60b1kvyN_3O07kbyvFzYO_eL6sNjHQQ@mail.gmail.com>
Date: Thu, 18 Oct 2018 08:49:43 +0300
Message-ID: <000001d466a6$5e940430$1bbc0c90$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "icount: remove obsolete warp call"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Clement Deschamps' <clement.deschamps@greensocs.com>, qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>

I made a fix to ensure that QBox patch doesn=E2=80=99t break the replay.

Now I tried it on couple of tests and didn=E2=80=99t see any regression.

=20

Pavel Dovgalyuk

=20

From: Artem Pisarenko [mailto:artem.k.pisarenko@gmail.com]=20
Sent: Wednesday, October 17, 2018 4:32 PM
To: Pavel Dovgalyuk
Cc: Paolo Bonzini; Clement Deschamps; qemu-devel@nongnu.org; Pavel =
Dovgalyuk
Subject: Re: [PATCH] Revert "icount: remove obsolete warp call"

=20

> I found the source of the bug. As QEMU becomes more multi-threaded and =
non-> synchronized,

> checkpoints move from thread to thread.
> And the event queue that processed at checkpoints should belong to the =
same thread
> in both record and replay executions.
>=20
> Current problem was with the checkpoint for virtual timers. They are =
processed from different threads:
> from vCPU and from aio_dispatch function.

=20

What bug you're talking about ? This patch thread started with intention =
to fix generic bug with icount, which is being encountered in non-rr =
mode. As far as I understood your words (and patch content) it will not =
fix that generic bug.

Anyway, it's a good news!

--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =
=D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=BE
