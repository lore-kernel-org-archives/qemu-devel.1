Received: from eggs.gnu.org ([209.51.188.92]:40913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hCJYE-0002Ln-90
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hCJYD-0000FB-5g
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:46:14 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:45095
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hCJYC-00005B-RM
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:46:13 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-4-marcandre.lureau@redhat.com>
	<08893010-9018-65df-bbcc-56796bba5062@adacore.com>
	<CAMxuvazK7YcFm0fORScBfcv+=_kqbexvU5Dvwke8fb8uFkY-eg@mail.gmail.com>
	<c1d595db-dcc1-0742-0771-3ed6c6195932@adacore.com>
Message-ID: <bd3c7dd1-0f2f-150e-020a-647514867c2b@adacore.com>
Date: Fri, 5 Apr 2019 09:46:04 +0200
MIME-Version: 1.0
In-Reply-To: <c1d595db-dcc1-0742-0771-3ed6c6195932@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] chardev: use a child source for qio
 input source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

Hi Marc,

I did more experiments.. It seems to be an issue in glib-2.44.1 which is =
quite
old. I updated and it seems I don't see the issue anymore.

Thanks for your input on this!

Cheers,
Fred

Le 4/4/19 =C3=A0 5:49 PM, KONRAD Frederic a =C3=A9crit=C2=A0:
>=20
>=20
> Le 4/4/19 =C3=A0 5:44 PM, Marc-Andr=C3=A9 Lureau a =C3=A9crit=C2=A0:
>> Hi
>>
>> On Thu, Apr 4, 2019 at 5:18 PM KONRAD Frederic
>> <frederic.konrad@adacore.com> wrote:
>>>
>>> Hi guys,
>>>
>>> We have some random delays with gdbstub since this commit under Windo=
ws.
>>> Basically while debugging the next command can sometimes take more th=
an 5
>>> seconds while it usually tooks 30ms before. It is not target dependen=
t I see
>>> that happening with sparc, ppc, riscv, etc.. but only on Windows host=
.
>>>
>>> Does that ring a bell?
>>
>> No, is this with a socket chardev or other kind?
>=20
> It's connecting through the TCP socket. '-s -S' option.
>=20
>>
>> Could you check the chardev behaviour with the HMP monitor for ex:
>> qemu -chardev socket,id=3Dfoo,server,host=3Dlocalhost,port=3D9999 -mon=
itor chardev:foo
>>
>> Is this also taking a few seconds to reply?
>>
>> Have you checked running tests/test-char on windows? Is this also
>> taking long (>2sec)?
>=20
> I'll try to test that.
>=20
> Thanks!
> Fred
>=20
