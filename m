Received: from eggs.gnu.org ([2001:4830:134:3::10]:58194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ez8a7-0007VX-Hf
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 18:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ez8a6-0006ZJ-Kd
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 18:21:11 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:45981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ez8a6-0006Z5-ER
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 18:21:10 -0400
Received: by mail-oi0-x229.google.com with SMTP id 71-v6so8763544oie.12
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 15:21:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <xnbmfflpqr.fsf@greed.delorie.com>
References: <20180322220924.GJ2787@redhat.com>
	<xnbmfflpqr.fsf@greed.delorie.com>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 22 Mar 2018 15:21:08 -0700
Message-ID: <CAHNT7Nsyp+87qfNi=6g9Deqw35nuerv1pYdVAr38X8JpaUFNkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: DJ Delorie <dj@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Mar 22, 2018 at 3:17 PM, DJ Delorie <dj@redhat.com> wrote:

> "Richard W.M. Jones" <rjones@redhat.com> writes:
> > DJ, am I remembering correctly that you tried the test case on the
> > HiFive evaluation board and it didn't demonstrate the bug?
>
> I tested it on the vc707 board, without seeing the bug.
>
> I can test other test cases if needed, I've got the board running Fedora
> at the moment.
>

Okay, I'll assume its a QEMU RISC-V bug.
