Received: from eggs.gnu.org ([2001:4830:134:3::10]:41485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fR1Lo-0002YC-Ey
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fR1Ln-0001b4-Fd
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:17:40 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fR1Ln-0001XM-3O
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:17:39 -0400
Received: by mail-oi0-x242.google.com with SMTP id c128-v6so9799306oig.11
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 13:17:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8484d1a4-b9e4-3d69-090c-22c230878566@amsat.org>
References: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
	<8484d1a4-b9e4-3d69-090c-22c230878566@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 21:17:18 +0100
Message-ID: <CAFEAcA_qc-x0rnDRyJaoiZyL=G2BU6HoiiKbzV=_phRMwHo4zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] cuda/mos6522 migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 7 June 2018 at 20:18, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> You forgot patch 5 "vmstate: Remove VMSTATE_TIMER_PTR_TEST" :)

It's a generic macro that might have utility in future,
and it fits into a slot in the matrix of possible VMSTATE
macros, so I wouldn't bother. (It's kind of irritating that we
have an almost but not quite orthogonal set of VMSTATE
macros.)

thanks
-- PMM
