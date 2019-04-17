Received: from eggs.gnu.org ([209.51.188.92]:41428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGYrQ-0000MJ-SP
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 20:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGYrP-0001n9-VL
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 20:55:36 -0400
Received: from mail-it1-x12d.google.com ([2607:f8b0:4864:20::12d]:35883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hGYrP-0001mW-ON
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 20:55:35 -0400
Received: by mail-it1-x12d.google.com with SMTP id y10so1797069itc.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 17:55:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <1328f591-897f-8762-d324-cccb5f63a360@redhat.com>
Date: Tue, 16 Apr 2019 20:55:33 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BCE3056-7CA2-4DAB-8F7F-87E9E1F481D4@oberlin.edu>
References: <20190305051007.56009-1-stephen.checkoway@oberlin.edu>
	<52a82d3a-3b79-c61d-93fa-f087af45f6fb@redhat.com>
	<1328f591-897f-8762-d324-cccb5f63a360@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/char/escc: Lower irq when transmit
 buffer is filled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>



> On Apr 10, 2019, at 16:01, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> So your description and patch makes sens.
> What worries me is the controller could have other pending IRQs to
> deliver and you are clearing them. Shouldn't we only clear the
> INTR_TXINT bit, and call escc_update_irq() which should lower the IRQ =
if
> no bits are pending?
>=20
> Maybe as:
>=20
>    s->wregs[W_INTR] &=3D ~INTR_TXINT;
>    escc_update_irq(s);

I just sent a v2 patch (but it looks like I failed to include Philippe, =
sorry about that!)

I used

    s->txint =3D 0;
    escc_update_irq(s);

which appears to do the right thing in my tests.

Thank you,

Steve

--=20
Stephen Checkoway
