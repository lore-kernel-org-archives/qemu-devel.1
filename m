Received: from [2001:4830:134:3::10] (port=45749 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fotlh-0003sk-5s
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fotla-0000zs-6Z
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:02:59 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fotlZ-0000zV-Ou
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:02:58 -0400
Received: by mail-oi0-x244.google.com with SMTP id y207-v6so23483396oie.13
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 10:02:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <682260bc-a2bb-bfe5-f7e9-edc5fbc067c9@vivier.eu>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1533574847-19294-63-git-send-email-aleksandar.markovic@rt-rk.com>
	<BN7PR08MB4868618C0BD26540E737839AC63A0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<682260bc-a2bb-bfe5-f7e9-edc5fbc067c9@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 12 Aug 2018 17:29:24 +0100
Message-ID: <CAFEAcA-kxFseoXkxeeCsuv9JGCEjGsbOYd0qzcPZ+2SvpvFXGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 62/80] linux-user: Add syscall numbers
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

On 12 August 2018 at 17:23, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 12/08/2018 =C3=A0 17:44, Aleksandar Markovic a =C3=A9crit :
>> ping
>
> Where can we find the kernel source for nanoMIPS to be able to compare
> the QEMU syscall numbers definition?

I think we shouldn't take the linux-user code into QEMU until
the kernel port is in mainline, so that we don't accidentally
implement a version of the ABI which isn't the final one
accepted into the kernel. (This has happened to us before,
and it's an awkward situation, so I'd prefer to avoid it.)

thanks
-- PMM
