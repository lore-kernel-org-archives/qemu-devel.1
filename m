Received: from eggs.gnu.org ([2001:4830:134:3::10]:57283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZtCd-0000wD-UA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZtCc-0003zg-Ri
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:20:19 -0400
Received: from mail-io0-x22e.google.com ([2607:f8b0:4001:c06::22e]:35848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZtCc-0003zS-Mt
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:20:18 -0400
Received: by mail-io0-x22e.google.com with SMTP id g35so18962710ioi.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 23:20:18 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <32f17245-d2ec-6fb2-10b3-3f97e05a66b5@redhat.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-7-ldoktor@redhat.com>
	<989e2216-499c-3c22-3958-0c51ac342dd1@amsat.org>
	<b772f95e-9a3a-0a72-e6c6-7390902f62d1@redhat.com>
	<2cb14375-2300-83d5-a689-db5aadf2cf20@amsat.org>
	<32f17245-d2ec-6fb2-10b3-3f97e05a66b5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 25 Jul 2017 03:20:17 -0300
Message-ID: <CAAdtpL7-RFodvvhpXDQRRgjfoBBuWaku3f9PPf_H3tfijsMqbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/11] qmp.py: Couple of pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Cc: apahim@redhat.com, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Jul 25, 2017 at 3:13 AM, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com=
> wrote:
> Dne 25.7.2017 v 08:04 Philippe Mathieu-Daud=C3=A9 napsal(a):
>> Hi Luk=C3=A1=C5=A1,
>>
>> On 07/24/2017 09:36 AM, Luk=C3=A1=C5=A1 Doktor wrote:
>>> Dne 22.7.2017 v 03:30 Philippe Mathieu-Daud=C3=A9 napsal(a):
>>>> Hi Luk=C3=A1=C5=A1,
>>>>
>>>> Since comment/indent fixes and code changes are not related I'd rather=
 see this split in at least 2 patches.
>>>>
>>> Hello Philippe, thank you for the review, I'm wondering what code chang=
es you have in mind? This is commit should not bring any code changes, just=
 code reorganization (like including the self.* attributes on top of the fi=
le)
>>>
>>>> On 07/20/2017 01:28 PM, Luk=C3=A1=C5=A1 Doktor wrote:
>>>>> No actual code changes, just a few pylint/style fixes and docstring
>>>>> clarifications.
>>>>>
>>>>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>>>>> ---
>>>>>    scripts/qmp/qmp.py | 37 ++++++++++++++++++++++++-------------
>>>>>    1 file changed, 24 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>> [...]
>>>>>        def __init__(self, address, server=3DFalse, debug=3DFalse):
>>>>>            """
>>>>>            Create a QEMUMonitorProtocol class.
>>>>> @@ -42,6 +53,7 @@ class QEMUMonitorProtocol:
>>>>>            self.__address =3D address
>>>>>            self._debug =3D debug
>>>>>            self.__sock =3D self.__get_sock()
>>>>> +        self.__sockfile =3D None
>>
>> I was thinking about this line which is new. Now the declaration and ini=
tialization are done in __init__() while before it was only declared/initia=
lized in connect() or accept().
>>
>> I'm not expert of python interpreter/jit internals but expect the genera=
ted code to be slightly different, even if achieving the same.
>>
>> not a bit deal, just about wording ;)
>>
> Well the difference is that before `connect` you get `AttributeError` whe=
n looking for `self.__sockfile` while with this patch you'll get `None`. In=
 this code nobody queries for `self.__sockfile` before the `connect` so it =
should not change the behavior of this code so I consider that as a `style`=
 fix as it's ugly to extend attributes later in code (with some exceptions =
like Namespace-objects..). Anyway if you insist I can split those patches.

I'm not insisting ;) Just add something like "also initialize
__sockfile to avoid AttributeError while introspecting object before
any call to connect/accept" in the commit message and that's fine to
me.
