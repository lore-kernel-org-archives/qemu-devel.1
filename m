Received: from eggs.gnu.org ([2001:4830:134:3::10]:60503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCkQi-0007V7-9M
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCkQe-0001S6-7Q
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:56:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gCkQd-0001Q7-W9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:55:56 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA9+zzccFDQpGYTp8iwBR8u5wMuh8_R_d2m6BZXui2wOKQ@mail.gmail.com>
	(Peter Maydell's message of "Thu, 11 Oct 2018 12:05:41 +0100")
References: <20181011090007.1103-1-maozhongyi@cmss.chinamobile.com>
	<20181011090007.1103-5-maozhongyi@cmss.chinamobile.com>
	<997db16e-3da8-b66a-b29b-517674ae860f@redhat.com>
	<CAFEAcA9+zzccFDQpGYTp8iwBR8u5wMuh8_R_d2m6BZXui2wOKQ@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 Oct 2018 13:55:40 +0200
Message-ID: <877eigaitf.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] audio: use existing macros istead of
 hardcoded strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 11 October 2018 at 11:45, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>> On 11/10/2018 11:00, Mao Zhongyi wrote:
>>> Cc: Jan Kiszka <jan.kiszka@web.de>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> To: qemu-arm@nongnu.org
>>>
>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>> ---
>>>  hw/arm/musicpal.c          | 16 ++++++++--------
>>>  hw/audio/marvell_88w8618.c |  3 +--
>>>  include/hw/audio/wm8750.h  |  1 +
>>>  3 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
>>> index ac266f9253..6425f1d50f 100644
>>> --- a/hw/arm/musicpal.c
>>> +++ b/hw/arm/musicpal.c
>>> @@ -406,7 +406,7 @@ static void mv88w8618_eth_realize(DeviceState
>>> *dev, Error **errp)
>>>  }
>>>
>>>  static const VMStateDescription mv88w8618_eth_vmsd =3D {
>>> -    .name =3D "mv88w8618_eth",
>>> +    .name =3D TYPE_MV88W8618_ETH,
>>
>> I understand TYPE_device name might changed, but once used,
>> VMStateDescription shouldn't, else this would break migration.
>> Thus I wouldn't recommend using TYPE_name in VMStateDescription.name.
>>
>> Since I'm not sure I cc'ed the migration maintainers.
>
> Yes, that's the usual approach -- the vmstate struct names
> aren't inherently the same as the QOM type names, and so
> we keep them decoupled to avoid accidentally breaking migration.

Yeap, I agree.

Later, Juan.
