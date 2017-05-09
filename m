Received: from eggs.gnu.org ([2001:4830:134:3::10]:38128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d85fM-0007UG-MC
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d85fL-0004cZ-M9
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:59:04 -0400
In-Reply-To: <alpine.BSF.2.20.1705091148560.78100@zero.eik.bme.hu>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
	<BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
	<20170508225007.2duqxlo5ab2aenpl@aurel32.net>
	<alpine.BSF.2.20.1705091148560.78100@zero.eik.bme.hu>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F3D7AC88-099F-432D-B46F-97F2A6F7B0E3@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 9 May 2017 09:58:56 -0400
Subject: Re: [Qemu-devel] [Qemu-ppc]  Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Aurelien Jarno <aurelien@aurel32.net>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On May 9, 2017, at 5:55 AM, BALATON Zoltan wrote:

> On Tue, 9 May 2017, Aurelien Jarno wrote:
>> | main.c: In function 'print_fpscr_settings':
>> | main.c:73:26: warning: suggest parentheses around comparison in  
>> operand of '&' [-Wparentheses]
>> |          if ((fpscr >> i) & 0x1 == 1) {
>> |                           ^
>
> Actually the compiler is correct here, this should be:
>
> if ((fpscr >> i & 0x1) == 1) {
>
> or even just
>
> if (fpscr >> i & 1) {
>
> because & is lower priority than == but the result may still be the  
> same by chance if 0x1 == 1 is always 1 and ANDing the shifted value  
> with this is either 0 or 1 so it may give the correct result but  
> not the way one would think looking at the expression.

I changed it to this:
if (((fpscr >> i) & 0x1) == 1)

Thank you.
