Received: from eggs.gnu.org ([2001:4830:134:3::10]:52716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNH63-0006Rt-Dm
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 07:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNH62-00068Q-Gy
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 07:13:23 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNH62-00068M-AU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 07:13:22 -0400
Received: by mail-wm0-x230.google.com with SMTP id d73so16885050wma.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 04:13:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8760fqorbp.fsf@frigg.lan>
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 12:13:00 +0100
Message-ID: <CAFEAcA-434=WhBxC=KB2HBhrPG9b+z1i3jqeFgiE=H8ceZJYzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Tracing guest virtual addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jayanto Minocha <jayanto@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 20 June 2017 at 12:02, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:
> Jayanto Minocha writes:
>> But that is only used to instrument the cpu_ld/cpu_st macros, which is o=
nly
>> called in the case of a tlb miss.
>
>> I've been going over the archives, and it looks like I need to instrumen=
t
>> tcg_out_tlb_load. Am I on the right path ?
>
> That event should trace all guest memory accesses performed by the CPU. I=
f you
> found any case where this does not hold, it is likely a bug and I'd appre=
ciate
> it if you can point me to the smallest possible failing example.

Does it catch memory accesses that are performed via helper functions,
or only ones done by inline TCG code?

thanks
-- PMM
