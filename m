Received: from eggs.gnu.org ([2001:4830:134:3::10]:35591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT3qh-00055g-Oi
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT3qc-00013e-ML
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:17:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dT3qc-000134-Gi
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:17:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86DF161D38
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 10:17:21 +0000 (UTC)
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-8-marcandre.lureau@redhat.com>
	<646ec17e-4baa-66b9-f54b-0ca840303fe6@redhat.com>
	<1885897934.47456724.1499334895441.JavaMail.zimbra@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a37a670a-dae3-bf3d-0af7-8eadc36ecdc8@redhat.com>
Date: Thu, 6 Jul 2017 12:17:17 +0200
MIME-Version: 1.0
In-Reply-To: <1885897934.47456724.1499334895441.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] MAINTAINERS: add Dump maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com

On 07/06/17 11:54, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
>> On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:
>>> Proposing myself, since I have some familiarity with the code now.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  MAINTAINERS | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 839f7ca063..45a0eb4cb0 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1272,6 +1272,13 @@ S: Maintained
>>>  F: device_tree.c
>>>  F: include/sysemu/device_tree.h
>>> =20
>>> +Dump
>>> +S: Supported
>>> +M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> +F: dump.c
>>> +F: include/sysemu/dump.h
>>> +F: include/sysemu/dump-arch.h
>>> +
>>>  Error reporting
>>>  M: Markus Armbruster <armbru@redhat.com>
>>>  S: Supported
>>>
>>
>> That's very kind of you, thanks!
>>
>> Do you have suggestions for the following files?
>>
>> scripts/dump-guest-memory.py
>=20
> This one is yours, no? :) But I am ok to "support" it, meaning I'll tak=
e time to review the patches, and eventually make the pull-requests.

It used to be "mine" until (a) it got rewritten in object-oriented
Python, and (b) it received multi-arch support ;)

> =20
>> stubs/dump.c
>=20
> I can add that one, although it is also maintained by Paolo
>=20
>> target/arm/arch_dump.c
>> target/i386/arch_dump.c
>> target/ppc/arch_dump.c
>> target/s390x/arch_dump.c
>=20
> I'd rather have those maintained by the respective arch maintainers, as=
 they are. But I imagine it would make sense to also cover them with the =
rest of dump.

Yeah there's an overlap here -- I'm not suggesting that you take on
everything, just curious what you think. I'm fine with this patch as it i=
s.

Thanks
Laszlo
