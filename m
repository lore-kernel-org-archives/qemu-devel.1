Received: from eggs.gnu.org ([2001:4830:134:3::10]:39939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d81s2-0003UR-PR
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d81s1-0006iq-Ey
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:55:54 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:49957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1d81s1-0006iQ-7f
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:55:53 -0400
Date: Tue, 9 May 2017 11:55:36 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170508225007.2duqxlo5ab2aenpl@aurel32.net>
Message-ID: <alpine.BSF.2.20.1705091148560.78100@zero.eik.bme.hu>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
	<BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
	<20170508225007.2duqxlo5ab2aenpl@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc]  Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: G 3 <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Tue, 9 May 2017, Aurelien Jarno wrote:
> | main.c: In function 'print_fpscr_settings':
> | main.c:73:26: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
> |          if ((fpscr >> i) & 0x1 == 1) {
> |                           ^

Actually the compiler is correct here, this should be:

if ((fpscr >> i & 0x1) == 1) {

or even just

if (fpscr >> i & 1) {

because & is lower priority than == but the result may still be the same 
by chance if 0x1 == 1 is always 1 and ANDing the shifted value with this 
is either 0 or 1 so it may give the correct result but not the way one 
would think looking at the expression.

Regards,
BALATON Zoltan
