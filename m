Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2CEC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4C221E6B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4C221E6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUdr-0003tR-TO
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42485)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frederic.konrad@adacore.com>) id 1hpUdh-0003Uo-T6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1hpUdg-0002Wi-Bo
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:29:49 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:48169
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1hpUdg-0002Ve-3O; Mon, 22 Jul 2019 05:29:48 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 51474822D2;
 Mon, 22 Jul 2019 11:29:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id unqYwkd3nd0P; Mon, 22 Jul 2019 11:29:44 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-447-75.w86-206.abo.wanadoo.fr
 [86.206.4.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 7B88D822B2;
 Mon, 22 Jul 2019 11:29:43 +0200 (CEST)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1563603512-5914-1-git-send-email-frederic.konrad@adacore.com>
 <70060fbc-b79f-6385-2b1e-0cebb45ca03e@redhat.com>
 <1f427dc9-deb9-f900-470a-84b79ab32a2a@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <8d86172a-b37f-5445-928a-46ec7f225b18@adacore.com>
Date: Mon, 22 Jul 2019 11:29:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1f427dc9-deb9-f900-470a-84b79ab32a2a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: Re: [Qemu-devel] [PATCH] riscv: htif: use qemu_log_mask instead of
 qemu_log
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kbastian@mail.uni-paderborn.de, palmer@sifive.com, Alistair.Francis@wdc.com,
 Stefan Hajnoczi <stefanha@redhat.com>, sagark@eecs.berkeley.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

Le 7/20/19 =C3=A0 11:50 AM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> Cc'ing Stefan
>=20
> On 7/20/19 11:44 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Frederic,
>>
>> On 7/20/19 8:18 AM, KONRAD Frederic wrote:
>>> There are some debug trace appearing when using GDB with the HTIF map=
ped @0:
>>>   Invalid htif read: address 0000000000000002
>>>   Invalid htif read: address 0000000000000006
>>>   Invalid htif read: address 000000000000000a
>>>   Invalid htif read: address 000000000000000e
>>>
>>> So don't show them unconditionally.
>>>
>>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>>> ---
>>>   hw/riscv/riscv_htif.c | 21 ++++++++++++---------
>>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
>>> index 4f7b11d..6a8f0c2 100644
>>> --- a/hw/riscv/riscv_htif.c
>>> +++ b/hw/riscv/riscv_htif.c
>>> @@ -119,7 +119,8 @@ static void htif_handle_tohost_write(HTIFState *h=
tifstate, uint64_t val_written)
>>>       int resp =3D 0;
>>>  =20
>>>       HTIF_DEBUG("mtohost write: device: %d cmd: %d what: %02" PRIx64
>>> -        " -payload: %016" PRIx64 "\n", device, cmd, payload & 0xFF, =
payload);
>>> +               " -payload: %016" PRIx64 "\n", device, cmd, payload &=
 0xFF,
>>> +               payload);
>>>  =20
>>>       /*
>>>        * Currently, there is a fixed mapping of devices:
>>> @@ -137,7 +138,7 @@ static void htif_handle_tohost_write(HTIFState *h=
tifstate, uint64_t val_written)
>>>                   qemu_log_mask(LOG_UNIMP, "pk syscall proxy not supp=
orted\n");
>>>               }
>>>           } else {
>>> -            qemu_log("HTIF device %d: unknown command\n", device);
>>> +            HTIF_DEBUG("HTIF device %d: unknown command\n", device);
>>
>> Generally, please don't go back to using DPRINTF() but use trace-event=
s
>> instead.
>=20
> Oh, now I see that HTIF_DEBUG() is just an obscure way to report
> crippled log trace-events, not portable to all trace backends.
>=20
> It is only used in 2 files:
>=20
> - hw/riscv/riscv_htif.c
> - target/riscv/pmp.c as PMP_DEBUG()
>=20
> I'd rather remove these macros and use trace-events the same way the
> rest of the codebase use them, usable by all backends.
>=20

Ok why not.. If the RISC-V maintainers are happy with your suggestion I c=
an do
a patch.

Cheers,
Fred

>> However in this calls it seems using qemu_log_mask(LOG_UNIMP) or
>> qemu_log_mask(LOG_GUEST_ERROR) is appropriate.
>>
>>>           }
>>>       } else if (likely(device =3D=3D 0x1)) {
>>>           /* HTIF Console */
>>> @@ -150,12 +151,13 @@ static void htif_handle_tohost_write(HTIFState =
*htifstate, uint64_t val_written)
>>>               qemu_chr_fe_write(&htifstate->chr, (uint8_t *)&payload,=
 1);
>>>               resp =3D 0x100 | (uint8_t)payload;
>>>           } else {
>>> -            qemu_log("HTIF device %d: unknown command\n", device);
>>> +            HTIF_DEBUG("HTIF device %d: unknown command\n", device);
>>>           }
>>>       } else {
>>> -        qemu_log("HTIF unknown device or command\n");
>>> +        HTIF_DEBUG("HTIF unknown device or command\n");
>>>           HTIF_DEBUG("device: %d cmd: %d what: %02" PRIx64
>>> -            " payload: %016" PRIx64, device, cmd, payload & 0xFF, pa=
yload);
>>> +                   " payload: %016" PRIx64, device, cmd, payload & 0=
xFF,
>>> +                   payload);
>>>       }
>>>       /*
>>>        * - latest bbl does not set fromhost to 0 if there is a value =
in tohost
>>> @@ -180,6 +182,7 @@ static void htif_handle_tohost_write(HTIFState *h=
tifstate, uint64_t val_written)
>>>   static uint64_t htif_mm_read(void *opaque, hwaddr addr, unsigned si=
ze)
>>>   {
>>>       HTIFState *htifstate =3D opaque;
>>> +
>>>       if (addr =3D=3D TOHOST_OFFSET1) {
>>>           return htifstate->env->mtohost & 0xFFFFFFFF;
>>>       } else if (addr =3D=3D TOHOST_OFFSET2) {
>>> @@ -189,8 +192,8 @@ static uint64_t htif_mm_read(void *opaque, hwaddr=
 addr, unsigned size)
>>>       } else if (addr =3D=3D FROMHOST_OFFSET2) {
>>>           return (htifstate->env->mfromhost >> 32) & 0xFFFFFFFF;
>>>       } else {
>>> -        qemu_log("Invalid htif read: address %016" PRIx64 "\n",
>>> -            (uint64_t)addr);
>>> +        HTIF_DEBUG("Invalid htif read: address %016" PRIx64 "\n",
>>> +                   (uint64_t)addr);
>>>           return 0;
>>>       }
>>>   }
>>> @@ -219,8 +222,8 @@ static void htif_mm_write(void *opaque, hwaddr ad=
dr,
>>>           htifstate->env->mfromhost |=3D value << 32;
>>>           htifstate->fromhost_inprogress =3D 0;
>>>       } else {
>>> -        qemu_log("Invalid htif write: address %016" PRIx64 "\n",
>>> -            (uint64_t)addr);
>>> +        HTIF_DEBUG("Invalid htif write: address %016" PRIx64 "\n",
>>> +                   (uint64_t)addr);
>>>       }
>>>   }
>>>  =20
>>>

