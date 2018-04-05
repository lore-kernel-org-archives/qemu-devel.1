Received: from eggs.gnu.org ([2001:4830:134:3::10]:38560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f45AG-0002sm-7t
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f45AF-0005vp-GL
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:42:56 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:37821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f45AF-0005vh-BT
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:42:55 -0400
Received: by mail-oi0-x230.google.com with SMTP id f63-v6so10727323oic.4
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 06:42:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f0140026-28ea-fa73-f8bd-7d3514c5ca81@adacore.com>
References: <20180405012241.25714-1-f4bug@amsat.org>
	<20180405012241.25714-2-f4bug@amsat.org>
	<CAFEAcA9Qvjo680JX1yQRKLdqTcL1r7V42adaQrVDh3ne=jt8WQ@mail.gmail.com>
	<eabfade9-5ac5-ce1f-8907-96943231c1ec@amsat.org>
	<CAFEAcA81MOAJ5n5b8g2j=JFcH79MVhTzxPdRy2t9BjB92x+mQw@mail.gmail.com>
	<585f236c-f884-f0c7-f791-cf9111527838@amsat.org>
	<f0140026-28ea-fa73-f8bd-7d3514c5ca81@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 14:42:34 +0100
Message-ID: <CAFEAcA-4R4K09ypXYdF4J3Nt_CNey9MjQLeWdwk3zMgiY0jU_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] memory: Avoid to create tiny RAM
 regions, handled as subpages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 5 April 2018 at 14:34, KONRAD Frederic <frederic.konrad@adacore.com> wro=
te:
> On 04/05/2018 03:31 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Luckily in my case I can workaround with a 4K SRAM, but it took me hours
>> to track this down until Paolo helped me.

> I seems to remember having the same pain with the mmio execution
> stuff. It triggered a bad ram pointer as far a I remember.

I think this would once have ended up in report_bad_exec()
which prints a more-or-less helpful message. However for CPUs
which now implement the unassigned-access or transaction-failed hooks
you'll get a guest exception instead now, I guess.

Incidentally we really ought to fix the interaction of
mmio-exec and migration, rather than just leaving it as it
is (disabling migration for xilinx_qspips device).

thanks
-- PMM
