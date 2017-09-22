Received: from eggs.gnu.org ([2001:4830:134:3::10]:46869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dvO3N-0005JR-2m
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dvO3K-0002Cj-Fa
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:31:37 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:48718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dvO3K-0002CX-A1
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:31:34 -0400
Received: by mail-io0-x232.google.com with SMTP id n69so3050977ioi.5
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 06:31:34 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
	<cff16e31-4be0-9665-62d7-88a12b6d0b56@weilnetz.de>
	<15608989-cb43-a522-9a7d-b57b3a393155@weilnetz.de>
	<abc99a4a-1386-2757-e605-f10d0afe6b3e@redhat.com>
	<2a90999d-6f79-cbd4-aaba-a6cd425980c6@redhat.com>
	<125b2e2a-290e-568a-0e33-d40150220912@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <be48c711-10af-c4bc-f129-88a844f3ecc4@twiddle.net>
Date: Fri, 22 Sep 2017 08:31:29 -0500
MIME-Version: 1.0
In-Reply-To: <125b2e2a-290e-568a-0e33-d40150220912@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 09/21/2017 04:59 AM, Thomas Huth wrote:
> $ time ppc64-softmmu/qemu-system-ppc64 -nographic -vga none -prom-env
> 'use-nvramrc?=true' -prom-env 'nvramrc=power-off'
> [...]
> real	0m13.953s
> user	0m13.904s
> sys	0m0.046s
> 
> That's impressive! Richard, may I ask what's the current state of this?
> Do you plan to merge this soon, or are there still issues (like the ones
> that Paolo mentioned)?

I had been assuming that it would go in via the normal ppc tree.
If I should just merge it with tcg-next, I can do so...

> However, I only see that speed-up with the normal x86 backend. I've also
> tried it with TCI, but I hardly saw any improvements there ... is there
> still something missing in the TCI backend that is required for the
> tcg_gen_lookup_and_goto_ptr feature?

Yes.

r~
