Received: from eggs.gnu.org ([209.51.188.92]:45772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hM3oo-0007GR-UN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hM3om-0005M9-Bd
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:59:38 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hM3od-0004d2-74
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:59:29 -0400
Received: by mail-pf1-x442.google.com with SMTP id z28so542015pfk.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 21:59:13 -0700 (PDT)
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190502040459.GE13618@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5aca63b1-72e9-9402-8828-d2dd054b3313@linaro.org>
Date: Wed, 1 May 2019 21:59:09 -0700
MIME-Version: 1.0
In-Reply-To: <20190502040459.GE13618@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for
 ppc64le
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org

On 5/1/19 9:04 PM, David Gibson wrote:
> I've staged this tentatively in ppc-for-4.1.  However while it removes
> the "Invalid ELF image" message I still get:
> 
>   TEST    test-mmap (4096 byte pages) on ppc64le
> test-mmap: Invalid argument
> make[2]: *** [/home/dwg/qemu/tests/tcg/multiarch/Makefile.target:35: run-test-mmap-4096] Error 255
> make[2]: Target 'run' not remade because of errors.
> make[1]: *** [/home/dwg/qemu/tests/tcg/Makefile.include:71: run-guest-tests] Error 2
> make: *** [/home/dwg/qemu/tests/Makefile.include:1079: run-tcg-tests-ppc64le-linux-user] Error 2
> 
> Running on a POWER9 host.  Do you see that as well?

Yes.

It's a semi-bogus test, really.  We can't run test-mmap
with a page size smaller than that of the host, and of
course ppc64le uses 64k pages.

This needs a different set of cleanups.  ;-)


r~
