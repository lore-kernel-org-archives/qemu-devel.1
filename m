Received: from eggs.gnu.org ([2001:4830:134:3::10]:34272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBm1V-0006py-LQ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBm1S-0007u2-K2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:53:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBm1S-0007tm-Fg
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:53:38 -0400
References: <20180425153343.24023-1-alex.bennee@linaro.org>
	<cb41b3a5-0e3b-f30b-a02c-1cc333d38ab1@redhat.com>
	<87604ekl0c.fsf@linaro.org>
	<2f69532c-8651-ef67-0910-1fad91808608@redhat.com>
	<874ljxlseb.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2d9d341e-008e-1f84-7a20-5956b4506db3@redhat.com>
Date: Thu, 26 Apr 2018 20:53:29 +0200
MIME-Version: 1.0
In-Reply-To: <874ljxlseb.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/core: expand description of
 null-machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 26.04.2018 20:44, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 26.04.2018 18:09, Alex Benn=C3=A9e wrote:
>>>
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> On 25.04.2018 17:33, Alex Benn=C3=A9e wrote:
>>>>> People following old instructions for QEMU get the message "No mach=
ine
>>>>> specified, and there is no default" and run -machine help to pick a
>>>>> new machine. Lay people might consider the null-machine to be such =
a
>>>>> basic starting point but they won't get far. This leads to confusio=
n,
>>>>> see https://bugs.launchpad.net/qemu/+bug/1766896 as an example.
>>>>>
>>>>> I'm open to better words - I figured "THIS PROBABLY ISN'T WHAT YOU
>>>>> WANT" seemed less helpful though.
>>>>>
>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>> ---
>>>>>  hw/core/null-machine.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>>>>> index cde4d3eb57..72f0815045 100644
>>>>> --- a/hw/core/null-machine.c
>>>>> +++ b/hw/core/null-machine.c
>>>>> @@ -50,7 +50,7 @@ static void machine_none_init(MachineState *mch)
>>>>>
>>>>>  static void machine_none_machine_init(MachineClass *mc)
>>>>>  {
>>>>> -    mc->desc =3D "empty machine";
>>>>> +    mc->desc =3D "empty machine (for probing/QMP)";

Actually, thinking about this again, what about something like:

 "empty machine (for experts only)"

or:

 "empty machine (use only if you know what you are doing)"

or something similar?

 Thomas
