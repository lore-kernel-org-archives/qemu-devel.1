Received: from eggs.gnu.org ([2001:4830:134:3::10]:38423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cscth-0004Jw-90
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 18:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1csctd-0005CZ-V3
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 18:13:57 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:53022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1csctd-0005BZ-NX
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 18:13:53 -0400
References: <CAFEAcA-t7xRo-2CkipmYKE_vUxp8oUBML8ss7G8U_pVhM79H6w@mail.gmail.com>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <029110dd-f2cf-a65e-bacc-661879be26b9@physik.fu-berlin.de>
Date: Tue, 28 Mar 2017 00:13:46 +0200
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
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Cc: Knut Omang <knut.omang@oracle.com>

On 03/27/2017 07:34 PM, Peter Maydell wrote:
> That all makes sense in isolation, but shouldn't something have
> at least warned that "&h.size" isn't actually a uint32_t* in
> the sense of being something you can validly pass to a
> function that takes a uint32_t* ?

This seems to be related to this gcc bug report [1].

Adrian

> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=51628

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
