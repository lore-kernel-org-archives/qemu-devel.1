Received: from eggs.gnu.org ([2001:4830:134:3::10]:36412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dNiW8-00034d-4L
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dNiW7-0006QB-88
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:30:08 -0400
In-Reply-To: <f2644920-8eda-e768-adee-71db36ea2fa3@amsat.org>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
	<BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
	<20170508225007.2duqxlo5ab2aenpl@aurel32.net>
	<alpine.BSF.2.20.1705091148560.78100@zero.eik.bme.hu>
	<F3D7AC88-099F-432D-B46F-97F2A6F7B0E3@gmail.com>
	<f2644920-8eda-e768-adee-71db36ea2fa3@amsat.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <17FF3B1D-D639-4578-BDDD-FADB07405D87@gmail.com>
Content-Transfer-Encoding: quoted-printable
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 21 Jun 2017 12:29:58 -0400
Subject: Re: [Qemu-devel] [Qemu-ppc] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


On Jun 21, 2017, at 12:14 PM, Philippe Mathieu-Daud=E9 wrote:

> Hi John,
>
> On 05/09/2017 10:58 AM, G 3 wrote:
>>
>> On May 9, 2017, at 5:55 AM, BALATON Zoltan wrote:
>>
>>> On Tue, 9 May 2017, Aurelien Jarno wrote:
>>>> | main.c: In function 'print_fpscr_settings':
>>>> | main.c:73:26: warning: suggest parentheses around comparison in
>>>> operand of '&' [-Wparentheses]
>>>> |          if ((fpscr >> i) & 0x1 =3D=3D 1) {
>>>> |                           ^
>>>
>>> Actually the compiler is correct here, this should be:
>>>
>>> if ((fpscr >> i & 0x1) =3D=3D 1) {
>>>
>>> or even just
>>>
>>> if (fpscr >> i & 1) {
>>>
>>> because & is lower priority than =3D=3D but the result may still be =
the
>>> same by chance if 0x1 =3D=3D 1 is always 1 and ANDing the shifted =
value
>>> with this is either 0 or 1 so it may give the correct result but not
>>> the way one would think looking at the expression.
>>
>> I changed it to this:
>> if (((fpscr >> i) & 0x1) =3D=3D 1)
>>
>> Thank you.
>
> do you think you can add your test as a qtest, to run it with check-=20=

> qtest?
>
> Regards,
>
> Phil.

I would like to see floating point tests added to QEMU. Problem is =20
they will always fail due to a ton of bugs with the floating point unit.=
