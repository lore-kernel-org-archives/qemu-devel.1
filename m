Received: from eggs.gnu.org ([2001:4830:134:3::10]:45737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <njh@bandsman.co.uk>) id 1dVdih-0003mt-8g
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <njh@bandsman.co.uk>) id 1dVdie-0002vf-ME
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:59:51 -0400
Received: from nihsmtpxway4.hub.nih.gov ([128.231.90.96]:22485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <njh@bandsman.co.uk>) id 1dVdie-0002vB-Ep
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:59:48 -0400
References: <f1a9dc49-40d8-828b-26fa-76261ee95fab@bandsman.co.uk>
	<CAFEAcA-8qNiyD3yfBS3EBq6rdB8oUcc7B9qeGp5KBQs7SggmAA@mail.gmail.com>
From: Nigel Horne <njh@bandsman.co.uk>
Message-ID: <be531cc1-50d4-4149-7499-ac8fe554bd23@bandsman.co.uk>
Date: Thu, 13 Jul 2017 08:59:46 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8qNiyD3yfBS3EBq6rdB8oUcc7B9qeGp5KBQs7SggmAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] Link error with github source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 7/13/17 8:57 AM, Peter Maydell wrote:
> On 13 July 2017 at 13:51, Nigel Horne <njh@bandsman.co.uk> wrote:
>> The latest version in github fails to link (using gcc-7) with this err=
or:
>>
>>    LINK    aarch64-softmmu/qemu-system-aarch64
>> accel/tcg/cputlb.o: In function `helper_atomic_cmpxchgo_le_mmu':
>> cputlb.c:(.text+0x5f3d): undefined reference to
>> `__atomic_compare_exchange_16'
>> accel/tcg/cputlb.o: In function `helper_atomic_cmpxchgo_be_mmu':
>> cputlb.c:(.text+0x6000): undefined reference to
>> `__atomic_compare_exchange_16'
>> accel/tcg/cputlb.o: In function `helper_atomic_ldo_be_mmu':
>> cputlb.c:(.text+0x602f): undefined reference to `__atomic_load_16'
>> accel/tcg/cputlb.o: In function `helper_atomic_ldo_le_mmu':
>> cputlb.c:(.text+0x5f73): undefined reference to `__atomic_load_16'
>> accel/tcg/cputlb.o: In function `helper_atomic_sto_le_mmu':
>> cputlb.c:(.text+0x5fa9): undefined reference to `__atomic_store_16'
>> accel/tcg/cputlb.o: In function `helper_atomic_sto_be_mmu':
>> cputlb.c:(.text+0x607f): undefined reference to `__atomic_store_16'
>> collect2: error: ld returned 1 exit status
>> Makefile:197: recipe for target 'qemu-system-aarch64' failed
>> make[1]: *** [qemu-system-aarch64] Error 1
>> Makefile:328: recipe for target 'subdir-aarch64-softmmu' failed
>> make: *** [subdir-aarch64-softmmu] Error 2
> Emilio's recent-ish change (commit f3ced3c5928) maybe?
>
> Nigel -- what host architecture are you building for?
x86_64 - Debian Linux.

-Nigel
>
> thanks
> -- PMM


--=20
Nigel Horne
Conductor: Rockville Brass Band, Washington Metropolitan GSO
@nigelhorne | fb/nigel.horne | bandsman.co.uk | concert-bands.co.uk | www=
=2Enigelhorne.com

Unless it's for my eyes only, please use "reply all"
