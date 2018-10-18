Received: from eggs.gnu.org ([2001:4830:134:3::10]:44540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gD8HE-0008BM-M7
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gD8HD-0000ZK-Rj
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:23:48 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gD8HD-0000Yw-Li
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:23:47 -0400
Received: by mail-ot1-x342.google.com with SMTP id p23so29688831otf.11
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 06:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<ecc524bb47e169394f9bed88c979fdc8d990111a.1539861171.git.artem.k.pisarenko@gmail.com>
	<ede122b1-f98b-b094-f106-119d25243382@redhat.com>
In-Reply-To: <ede122b1-f98b-b094-f106-119d25243382@redhat.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 18 Oct 2018 19:23:35 +0600
Message-ID: <CANzW0mvXfmeFoSqQy42gNg+Pbg12zRrz7bZYKLB2s+oxD=8iiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] Optimize record/replay checkpointing
 for all clocks it applies to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

> We can also move the switch statement to a separate function, it
> simplifies the code:
> ...

When I prepared this patch my intuition said me to add note in advance:
"Paolo, please, don't try to move this to a separate function. I've tried
it already. It cannot be done correct, look nice and not decrease
performancy at the same time". But I've ignored it... :)
Change you did is correct and nice, but (compared to my version) it adds
extra unlock/lock pair for running each timer list when it isn't empty and
in non-rr mode (where we would ignore checkpoints and execution flow would
bypass whole "if (need_replay_checkpoint) {...}" block).
Maybe you're aware of it, but I don't think that such change worth it.
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
