Received: from eggs.gnu.org ([209.51.188.92]:38767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hERNb-0005Ix-CC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 00:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hERNa-0005Ue-Dx
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 00:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hERNa-0005UX-6B
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 00:32:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
	<874l764eez.fsf@dusky.pond.sub.org>
	<38442eb0-501e-dbf8-60e0-74675a999dba@redhat.com>
	<87bm1e2yfa.fsf@dusky.pond.sub.org>
	<CAKmqyKM7fX6UqSU5K+w25xGxO2K4kqtyoRz7LMFN7GtBYL56KA@mail.gmail.com>
	<b73bbac0-a501-0004-5a41-748e2b23ab13@redhat.com>
Date: Thu, 11 Apr 2019 06:31:53 +0200
In-Reply-To: <b73bbac0-a501-0004-5a41-748e2b23ab13@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed,
	10 Apr 2019 17:47:44 +0200")
Message-ID: <8736mpw4au.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/10/19 8:34 AM, Alistair Francis wrote:
>> On Tue, Apr 9, 2019 at 10:59 PM Markus Armbruster <armbru@redhat.com> wr=
ote:
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>> On 4/10/19 7:28 AM, Markus Armbruster wrote:
>>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
[...]
>>>>>> BTW how did you figure that out?
>>>>>
>>>>> Downstream handling of upstream commit da885fe1ee8 led me to the
>>>>> function.  I spotted dt_size =3D get_image_size(filename_path).
>>>>> Experience has taught me to check the left hand side's type.  Bad.  T=
hen
>>>>> I saw how dt_size gets increased.  Worse.
>>>>
>>>> So you genuinely neglected to mention Kurtis Miller then :)
>>>
>>> Explanation, not excuse: the only occurence of the name in my downstream
>>> reading was a two-liner BZ comment, which I totally missed in my haste
>>> to give the fix a chance to make 4.0.  I certainly didn't mean to
>>> deprive him of credit!
>
> My English teacher explained me neglected sounds like a
> reprimand/reproach (as in negligence), sorry I didn't mean to be rude
> here, I wanted to say something like "Peter remarked you did gave
> credits to the first one who reported this issue, but since you figured
> this bug via your own way, the omission was not intentional then."

Don't worry, my social interactions teacher taught me to assume good
intent ;)

[...]
