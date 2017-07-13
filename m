Received: from eggs.gnu.org ([2001:4830:134:3::10]:41836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dVlsj-0004di-Km
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dVlsg-0004l5-IX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:42:45 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:35517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dVlsg-0004kL-CK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:42:42 -0400
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
	<51a3a21f-6145-d721-170f-b8cf20cbc2d9@twiddle.net>
	<313d3f03-f487-4881-5f0a-6dd150f1ebdc@physik.fu-berlin.de>
	<3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
	<b7f8b2dd-a154-fc14-7be1-1cdbe248d350@twiddle.net>
	<20170713090908.GA25275@physik.fu-berlin.de>
	<20170713105652.GC25275@physik.fu-berlin.de>
	<a18f211f-ea06-51ed-3961-55dbecdbc766@twiddle.net>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <608ab9c6-38d9-e731-a4e0-a764376f641b@physik.fu-berlin.de>
Date: Thu, 13 Jul 2017 23:42:34 +0200
MIME-Version: 1.0
In-Reply-To: <a18f211f-ea06-51ed-3961-55dbecdbc766@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/27] linux-user/sh4: Notice gUSA
 regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/13/2017 11:37 PM, Richard Henderson wrote:
> Unfortunately with something as complex as ghc this doesn't help much.
> I hope you can find something smaller that produces a similar problem...

GHC is truly a complex matter. It's in fact the package that causes most
trouble on qemu-user, both on m68k and sh4. Although it works fine on
qemu-user for ARM.

I will try to reduce the test case.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
