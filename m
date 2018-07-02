Received: from eggs.gnu.org ([2001:4830:134:3::10]:33222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZyAo-0003Zc-ND
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZyAn-0003kd-Ql
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:43:18 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZyAn-0003k6-KT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:43:17 -0400
Received: by mail-oi0-x242.google.com with SMTP id i12-v6so11675042oik.2
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 05:43:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629200710.27626-1-f4bug@amsat.org>
References: <20180629200710.27626-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 13:42:56 +0100
Message-ID: <CAFEAcA-9tsQn+YNVrJPScfG024BZWuLcqNKnOOT0g-DZ3K13_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix --disable-tcg build breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota" <cota@braap.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 29 June 2018 at 21:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Fix the --disable-tcg breakage introduced by 8bca9a03ec60d:
>
>     $ configure --disable-tcg
>     [...]
>     $ make -C i386-softmmu exec.o
>     make: Entering directory 'i386-softmmu'
>       CC      exec.o
>     In file included from source/qemu/exec.c:62:0:
>     source/qemu/include/exec/ram_addr.h:96:6: error: conflicting types fo=
r =E2=80=98tb_invalidate_phys_range=E2=80=99
>      void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end);
>           ^~~~~~~~~~~~~~~~~~~~~~~~
>     In file included from source/qemu/exec.c:24:0:
>     source/qemu/include/exec/exec-all.h:309:6: note: previous declaration=
 of =E2=80=98tb_invalidate_phys_range=E2=80=99 was here
>      void tb_invalidate_phys_range(target_ulong start, target_ulong end);
>           ^~~~~~~~~~~~~~~~~~~~~~~~
>     source/qemu/exec.c:1043:6: error: conflicting types for =E2=80=98tb_i=
nvalidate_phys_addr=E2=80=99
>      void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAtt=
rs attrs)
>           ^~~~~~~~~~~~~~~~~~~~~~~
>     In file included from source/qemu/exec.c:24:0:
>     source/qemu/include/exec/exec-all.h:308:6: note: previous declaration=
 of =E2=80=98tb_invalidate_phys_addr=E2=80=99 was here
>      void tb_invalidate_phys_addr(target_ulong addr);
>           ^~~~~~~~~~~~~~~~~~~~~~~
>     make: *** [source/qemu/rules.mak:69: exec.o] Error 1
>     make: Leaving directory 'i386-softmmu'
>
> Tested to build x86_64-softmmu and i386-softmmu targets.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks; applied to master as a build fix.

(I've also added a notcg config to my test set for merge builds.)

-- PMM
