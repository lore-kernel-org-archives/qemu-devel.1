Received: from eggs.gnu.org ([2001:4830:134:3::10]:52367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dE20H-00026s-0J
	for qemu-devel@nongnu.org; Thu, 25 May 2017 19:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dE20D-0007H8-SV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 19:17:13 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dE20D-0007Gq-Ko
	for qemu-devel@nongnu.org; Thu, 25 May 2017 19:17:09 -0400
Received: by mail-it0-x244.google.com with SMTP id d68so60742ita.1
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:17:09 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170525200537.GA12666@pacoca>
Date: Thu, 25 May 2017 19:17:06 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF82FB10-14E9-4446-AF02-67F1F30DBE97@gmail.com>
References: <mailman.73115.1495441935.22737.qemu-devel@nongnu.org>
	<BBC4E515-FE7D-4600-A5CA-BBCE26059415@gmail.com>
	<87efvghzb9.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170524023303.GA12163@pacoca> <20170525200537.GA12666@pacoca>
Subject: Re: [Qemu-devel] [PATCH risu] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: joserz@linux.vnet.ibm.com
Cc: Peter Maydell <peter.maydell@linaro.org>, Sandipan Das <sandipandas1990@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, aNikunj A Dadhania <nikunj@linux.vnet.ibm.com>


On May 25, 2017, at 4:05 PM, joserz@linux.vnet.ibm.com wrote:

> On Tue, May 23, 2017 at 11:33:03PM -0300, joserz@linux.vnet.ibm.com =
wrote:
>> On Tue, May 23, 2017 at 11:47:30AM +0530, Nikunj A Dadhania wrote:
>>> G 3 <programmingkidx@gmail.com> writes:
>>>=20
>>>> On May 22, 2017, at 4:32 AM, qemu-devel-request@nongnu.org wrote:
>>>>=20
>>>> Hello I have also done some work risu. My patches add ppc32 =
support. =20
>>>> Well my patches were made to work with Mac OS X but they are =
required =20
>>>> to work with Linux. Do you think you could help port these patches =
to =20
>>>> Linux?
>>>=20
>>> Ziviani did the ppc64 work, lets see if he can spare some time.
>>>=20
>>> The patches haven't come right on the mailing list, its tedious to =
pull
>>> them. Please resend them with git send-mail.
>>>=20
>>=20
>> Hey, sure I can help. I'll take a look on them.
>>=20
>>>>=20
>>>> ppc.risu:
>>>> https://patchwork.kernel.org/patch/9697489/
>=20
> Hi John,
>=20
> What do you think about sharing the same ppc64.risu file to ppc and =
ppc64/ppc64le. Then, instead of:
>=20
> <NAME> PPC64LE 01111...
>=20
> we'd have:
>=20
> <NAME> PPC 01111...
>=20
> So, specific instructions would be:
>=20
> <NAME> PPC64LE 01111...
> <NAME> PPC64 01111...
> <NAME> PPC32 01111...
>=20
> It will allow users to select the arch by using patterns like: =
./risugen
> --pattern "PPC64*", or --pattern "PPC32*".
>=20
> Finally, we could rename ppc64.risu to powerpc.risu :).
>=20
> What do you think?
>=20
> Thanks

I think have two separate files is best. Making the .out file becomes so =
much easier. There is no worry for PPC64 instructions being included =
accidentally in a PPC test. Also generating the .out file wouldn't =
require the --pattern option. There is also the possibility of =
instructions acting in a different manner between the two architectures. =
The ADD instruction may work without problems but instructions that do =
need to know the bit size of the processor  like CMP will not be easy to =
implement on both architectures.=20

Thank you
