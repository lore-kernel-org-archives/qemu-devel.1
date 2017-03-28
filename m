Received: from eggs.gnu.org ([2001:4830:134:3::10]:35059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1csoEO-0007ta-SV
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1csoEK-0007bh-PX
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:20:04 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:48666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1csoEK-0007Y9-HR
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:20:00 -0400
References: <CAFEAcA-t7xRo-2CkipmYKE_vUxp8oUBML8ss7G8U_pVhM79H6w@mail.gmail.com>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <1b4e550d-2a0a-e155-c78e-d6fd0a87cc08@physik.fu-berlin.de>
Date: Tue, 28 Mar 2017 12:19:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-t7xRo-2CkipmYKE_vUxp8oUBML8ss7G8U_pVhM79H6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] packed structures and unaligned accesses (sparc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Knut Omang <knut.omang@oracle.com>

On 03/27/2017 07:34 PM, Peter Maydell wrote:
> That all makes sense in isolation, but shouldn't something have
> at least warned that "&h.size" isn't actually a uint32_t* in
> the sense of being something you can validly pass to a
> function that takes a uint32_t* ?

It turns out that clang actually emits a warning in this case:

root@deb4g:~# clang-4.0 packed.c -o packed
packed.c:18:18: warning: taking address of packed member 'size' of class or structure 'hdr' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
  return getval(&h.size);
                 ^~~~~~
1 warning generated.
root@deb4g:~#

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
