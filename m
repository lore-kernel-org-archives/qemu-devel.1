Received: from eggs.gnu.org ([2001:4830:134:3::10]:49455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAYn8-0002oy-7U
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAYn7-0002Gg-9C
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:06:06 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAYn6-0002Fu-17
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:06:04 -0400
Received: by mail-ot1-x342.google.com with SMTP id l1so8480527otj.5
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 04:06:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <997db16e-3da8-b66a-b29b-517674ae860f@redhat.com>
References: <20181011090007.1103-1-maozhongyi@cmss.chinamobile.com>
	<20181011090007.1103-5-maozhongyi@cmss.chinamobile.com>
	<997db16e-3da8-b66a-b29b-517674ae860f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Oct 2018 12:05:41 +0100
Message-ID: <CAFEAcA9+zzccFDQpGYTp8iwBR8u5wMuh8_R_d2m6BZXui2wOKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>

On 11 October 2018 at 11:45, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> On 11/10/2018 11:00, Mao Zhongyi wrote:
>> Cc: Jan Kiszka <jan.kiszka@web.de>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> To: qemu-arm@nongnu.org
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>  hw/arm/musicpal.c          | 16 ++++++++--------
>>  hw/audio/marvell_88w8618.c |  3 +--
>>  include/hw/audio/wm8750.h  |  1 +
>>  3 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
>> index ac266f9253..6425f1d50f 100644
>> --- a/hw/arm/musicpal.c
>> +++ b/hw/arm/musicpal.c
>> @@ -406,7 +406,7 @@ static void mv88w8618_eth_realize(DeviceState *dev, =
Error **errp)
>>  }
>>
>>  static const VMStateDescription mv88w8618_eth_vmsd =3D {
>> -    .name =3D "mv88w8618_eth",
>> +    .name =3D TYPE_MV88W8618_ETH,
>
> I understand TYPE_device name might changed, but once used,
> VMStateDescription shouldn't, else this would break migration.
> Thus I wouldn't recommend using TYPE_name in VMStateDescription.name.
>
> Since I'm not sure I cc'ed the migration maintainers.

Yes, that's the usual approach -- the vmstate struct names
aren't inherently the same as the QOM type names, and so
we keep them decoupled to avoid accidentally breaking migration.

thanks
-- PMM
