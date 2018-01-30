Received: from eggs.gnu.org ([2001:4830:134:3::10]:56752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egNOn-0006Qr-3d
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 23:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egNOj-0006AC-Ub
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 23:19:57 -0500
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:37335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1egNOj-00069m-P3
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 23:19:53 -0500
Received: by mail-it0-x230.google.com with SMTP id h129so5586198ita.2
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 20:19:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <d5b6458d-2479-bad2-01fe-87b3a120ff4c@amsat.org>
Date: Mon, 29 Jan 2018 23:19:51 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BCB3150-DA91-40D5-A136-C2064DD758ED@gmail.com>
References: <20180130035827.2360-1-programmingkidx@gmail.com>
	<d5b6458d-2479-bad2-01fe-87b3a120ff4c@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] Only print unknown command message in
 debug mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org


> On Jan 29, 2018, at 11:17 PM, Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>=20
> Hi John,
>=20
> On 01/30/2018 12:58 AM, John Arbuckle wrote:
>> After using QEMU with the sb16 sound card I would see all these =
messages about some numbered command not being understood. It became =
annoying after a while to always see this message, so this patch changes =
things so that the message is only printed when DEBUG is defined.=20
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> hw/audio/sb16.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
>> index 6ab2f6f89a..45b679c4df 100644
>> --- a/hw/audio/sb16.c
>> +++ b/hw/audio/sb16.c
>> @@ -632,7 +632,7 @@ static void command (SB16State *s, uint8_t cmd)
>>     return;
>>=20
>>  warn:
>> -    dolog ("warning: command %#x,%d is not truly understood yet\n",
>> +    ldebug("warning: command %#x,%d is not truly understood yet\n",
>>            cmd, s->needed_bytes);
>=20
> While changing this file can you use the latest logging API? such:
>=20
>     qemu_log_mask(LOG_UNIMP, "unimplemented command 0x%02x (size:%d)",
>                   cmd, s->needed_bytes);
>=20
> So one can enable this log level at runtime (with "-d unimp"), the
> #define DEBUG is compile time (require a rebuild).
>=20
>>     goto exit;

Absolutely. This is a good idea.=
