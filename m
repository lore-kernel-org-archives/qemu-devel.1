Received: from eggs.gnu.org ([2001:4830:134:3::10]:35336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gClwG-0002Zu-Lq
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gClwF-0007uq-Pt
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:32:40 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gClwD-0007pn-LV
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:32:39 -0400
Received: by mail-oi1-x244.google.com with SMTP id y81-v6so21059445oia.6
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 06:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181017090750.4378-1-pbonzini@redhat.com>
	<001f01d465fd$01af8b80$050ea280$@ru>
	<CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
	<0817e2fe-5a97-a4ed-9ae2-2e8dee6c9a43@redhat.com>
	<004201d4660d$e86ef1e0$b94cd5a0$@ru>
	<a29da0a1-85d7-c57c-5c42-27594a7849ac@redhat.com>
	<005c01d4661c$3a9cd0a0$afd671e0$@ru>
In-Reply-To: <005c01d4661c$3a9cd0a0$afd671e0$@ru>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 19:32:24 +0600
Message-ID: <CANzW0mtAh9vjWa-TAdB60b1kvyN_3O07kbyvFzYO_eL6sNjHQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Clement Deschamps <clement.deschamps@greensocs.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

> I found the source of the bug. As QEMU becomes more multi-threaded and
non-> synchronized,
> checkpoints move from thread to thread.
> And the event queue that processed at checkpoints should belong to the
same thread
> in both record and replay executions.
>
> Current problem was with the checkpoint for virtual timers. They are
processed from different threads:
> from vCPU and from aio_dispatch function.

What bug you're talking about ? This patch thread started with intention to
fix generic bug with icount, which is being encountered in non-rr mode. As
far as I understood your words (and patch content) it will not fix that
generic bug.
Anyway, it's a good news!
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
