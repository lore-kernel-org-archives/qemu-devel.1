Received: from eggs.gnu.org ([209.51.188.92]:52695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1uP6-0000BM-SY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1uP2-0004up-Kd
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:53:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h1uP0-0004sC-0I
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:53:42 -0500
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<8b794ba1-f719-e1f4-5a17-ba261aeebea6@redhat.com>
	<20190307141642.GE5786@linux.fritz.box>
	<106e1413-85e4-2ed9-0ffa-9c0f9fe73cf9@redhat.com>
	<20190307144017.GI1598@char.us.oracle.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <65b59796-d92f-c94f-ec63-111c3270a93c@redhat.com>
Date: Thu, 7 Mar 2019 15:53:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190307144017.GI1598@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Kevin Wolf <kwolf@redhat.com>, elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com, Govind Singh <govinds@codeaurora.org>, Eyal Ilsar <eilsar@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>

On 07/03/2019 15.40, Konrad Rzeszutek Wilk wrote:
> On Thu, Mar 07, 2019 at 03:21:47PM +0100, Thomas Huth wrote:
>> On 07/03/2019 15.16, Kevin Wolf wrote:
>>> Am 07.03.2019 um 09:14 hat Thomas Huth geschrieben:
>>>> On 07/03/2019 08.22, elena.ufimtseva@oracle.com wrote:
>>>>> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>>>>
>>>>> TODO: Make relevant changes to the doc.
>>>>>
>>>>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>>>>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>>>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>>>>> ---
>>>>>  docs/devel/qemu-multiprocess.txt | 1109 ++++++++++++++++++++++++++=
++++++++++++
>>>>>  1 file changed, 1109 insertions(+)
>>>>>  create mode 100644 docs/devel/qemu-multiprocess.txt
>>>>>
>>>>> diff --git a/docs/devel/qemu-multiprocess.txt b/docs/devel/qemu-mul=
tiprocess.txt
>>>>> new file mode 100644
>>>>> index 0000000..e29c6c8
>>>>> --- /dev/null
>>>>> +++ b/docs/devel/qemu-multiprocess.txt
>>>>> @@ -0,0 +1,1109 @@
>>>>> +/*
>>>>> + * Copyright 2019, Oracle and/or its affiliates. All rights reserv=
ed.
>>>>> + *
>>>>> + * Permission is hereby granted, free of charge, to any person obt=
aining a copy
>>>>> + * of this software and associated documentation files (the "Softw=
are"), to deal
>>>>> + * in the Software without restriction, including without limitati=
on the rights
>>>>> + * to use, copy, modify, merge, publish, distribute, sublicense, a=
nd/or sell
>>>>> + * copies of the Software, and to permit persons to whom the Softw=
are is
>>>>> + * furnished to do so, subject to the following conditions:
>>>>> + *
>>>>> + * The above copyright notice and this permission notice shall be =
included in
>>>>> + * all copies or substantial portions of the Software.
>>>>> + *
>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,=
 EXPRESS OR
>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHAN=
TABILITY,
>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVE=
NT SHALL
>>>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR OTHER
>>>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,=
 ARISING FROM,
>>>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER D=
EALINGS IN
>>>>> + * THE SOFTWARE.
>>>>> + */
>>>>
>>>> Somehow weird to see such a big license statement talking about
>>>> "software", but which applies to a text file only... Not sure if it =
is
>>>> an option for you, but maybe one of the Creative Common licenses
>>>> (dual-licensed with the GPLv2+) would be a better fit? E.g. for the =
QEMU
>>>> website, the content is dual-licensed: https://www.qemu.org/license.=
html
>>>
>>> While we're talking about licenses, the "All rights reserved." notice=
 is
>>> out of place in a license header that declares that a lot of permissi=
ons
>>> are granted. Better to remove it to avoid any ambiguities that could
>>> result from the contradiction. (Applies to the whole series.)
>>
>> Apart from that, it is also not required for other work anymore. See:
>>
>> https://en.wikipedia.org/wiki/All_rights_reserved
>=20
> Interesting. Do folks know why the Linux Foundation does it?
>=20
> See for example cf0d37aecc06801d4847fb36740da4a5690d9d45 (in the Linux =
kernel)
> where every change they stamp it with their 'All Rights Reserved'?

No clue why they use it. Seems unnecessary to me. But as always: IANAL

 Thomas
