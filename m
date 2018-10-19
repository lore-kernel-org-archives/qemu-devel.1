Received: from eggs.gnu.org ([2001:4830:134:3::10]:56091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gDOIp-0006uB-JX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gDOIo-0002YE-LO
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:30:31 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gDOIo-0002Ue-Ce
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:30:30 -0400
Received: by mail-ot1-x341.google.com with SMTP id p23so32162599otf.11
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 23:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<3a396555c19468ce89788cc6deabbfef4ab56035.1539860473.git.artem.k.pisarenko@gmail.com>
	<002201d46770$4affc060$e0ff4120$@ru>
In-Reply-To: <002201d46770$4affc060$e0ff4120$@ru>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Fri, 19 Oct 2018 12:30:17 +0600
Message-ID: <CANzW0mui0aaCWH0iQT+KxHygmE1TSh9Xko_Qyrwkg=6kUnM_Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] Optimize record/replay
 checkpointing for all clocks it applies to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

> =E2=80=A6
> This is wrong at least for QEMU_CLOCK_HOST.
> =E2=80=A6
> Reading the host clock here is not protected by the checkpoint.
> Therefore it may incur the inconsistency when replaying the execution.

That's why I didn't like idea of this patch and asked for any possible side
effects beforehand. So, here is one.
I have no idea how to fix it properly and would like to recall this
particular patch from these series (remember, it doesn't match series
goal). Lets leave this patch/issue for separate resolution, although I'm
not very interested in it.
