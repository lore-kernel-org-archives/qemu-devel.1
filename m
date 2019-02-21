Received: from eggs.gnu.org ([209.51.188.92]:48031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gwiwu-00028R-J7
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 02:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gwiwt-0001My-8b
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 02:39:16 -0500
Received: from sonic302-20.consmr.mail.ne1.yahoo.com ([66.163.186.146]:40286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1gwiwt-0001MW-2Y
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 02:39:15 -0500
Date: Thu, 21 Feb 2019 07:39:08 +0000 (UTC)
From: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Message-ID: <1178253251.2697859.1550734748930@mail.yahoo.com>
In-Reply-To: <15e19a9e-8cb4-e767-f5d3-6b268948844e@tuxfamily.org>
References: <251451940.431966.1548259107629.ref@mail.yahoo.com>
	<251451940.431966.1548259107629@mail.yahoo.com>
	<20190123180804.GA1040@flamenco>
	<70145779.391347.1548334794441@mail.yahoo.com>
	<87va2eyy38.fsf@linaro.org>
	<15e19a9e-8cb4-e767-f5d3-6b268948844e@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] m68k gdb has stopped single stepping correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <huth@tuxfamily.org>
Cc: "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

 Hi Thomas,
>=C2=A0did you ever sent the patch? I can't find it on the mailing list, an=
d I=C2=A0think this bug is still pending?Yes, I have patches but was waitin=
g for my first one to be successful in order to make sure I got the process=
 down.=C2=A0 I will finish that shortly.
CheersLuc
  =20
 On 24/01/2019 14.38, Alex Benn=C3=A9e wrote:
>=20
> Lucien Anti-Spam via Qemu-devel <qemu-devel@nongnu.org> writes:
>=20
>>=C2=A0 =C2=A0 > On Thursday, January 24, 2019, 3:08:07 AM GMT+9, Emilio G=
. Cota <cota@braap.org> wrote: > > On Wed, Jan 23, 2019 at 15:58:27 +0000, =
Lucien Anti-Spam via Qemu-devel wrote:> > Hi folks,
>>>> I noticed that with 3.x release that the GDB options (-S -s) for certa=
in CPU results in very weird stepping.Usually stops afer a few steps, whils=
t the stub continues responding the PC doesnt update, however, I have only =
deeply looked at the m68k.
>>>> In the case of the m68K the SR gets the trace bit set (T=3D10b), and t=
he PC doesnt update.The m68k gdbstub, and main gdbstub seem mostly unchange=
d.But it seems the INSN handling has changed greatly for the m68k.
>>>> Does anyone have any ideas what happened?>> Can you please bisect to f=
ind at which point things start misbehaving?
>>>
>>> Thanks,
>>>=C2=A0 Emilio
>> Understood, I was hoping my original post might jog someone's memory abo=
ut the issue.
>> Apparently not, so after some digging I found that it was introduced wit=
h the refactor to TranslatorOps, specifically two lines got dropped that up=
date the PC if single-stepping is being performed ( commit 11ab74b01e0a8ea4=
973eed89c6b90fa6e4fb9fb6 )
>> Since its not valid to revert, shall I go ahead and submit a patch for
>> these two lines?
>=20
> Yes please!

 Hi Lucien,

did you ever sent the patch? I can't find it on the mailing list, and I
think this bug is still pending?

 Thomas
 =20
