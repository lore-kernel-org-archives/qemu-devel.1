Received: from eggs.gnu.org ([2001:4830:134:3::10]:50184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCiWN-0008Hy-Bi
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCiWM-000117-EB
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:53:43 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:44579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gCiWM-0000dz-7c
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:53:42 -0400
Received: by mail-oi1-x22e.google.com with SMTP id u74-v6so20535859oia.11
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 02:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181017090750.4378-1-pbonzini@redhat.com>
	<001f01d465fd$01af8b80$050ea280$@ru>
In-Reply-To: <001f01d465fd$01af8b80$050ea280$@ru>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 15:53:21 +0600
Message-ID: <CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

See my last comment in bug report. This kind of modification, even adapted
to changed function name, doesn't solve issue.
I thought long time that it does, but once I catched qemu with a hang. And
of course, I wasn't able to reproduce it. So it just better hides issue.
Take a look at alternative solution from QBox:
https://git.greensocs.com/qemu/qbox/commit/a8ed106032e375e715a531d6e93e4d9e=
c295dbdb
I didn't catched fail with it (yet).
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
