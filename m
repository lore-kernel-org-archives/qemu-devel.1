Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF32C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B483120714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B483120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jED9Y-0003bA-Us
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jED8s-00033Y-0j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jED8r-0000jt-0l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:24:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:31978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jED8n-0000Dt-GW; Tue, 17 Mar 2020 10:24:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8F8117461AE;
 Tue, 17 Mar 2020 15:24:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6A886745953; Tue, 17 Mar 2020 15:24:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6884874569F;
 Tue, 17 Mar 2020 15:24:19 +0100 (CET)
Date: Tue, 17 Mar 2020 15:24:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 6/7] hw/ide: Move MAX_IDE_DEVS define to
 hw/ide/internal.h
In-Reply-To: <7a616aa2-9482-1735-8f29-1d69b7393891@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003171523240.40468@zero.eik.bme.hu>
References: <cover.1584437957.git.balaton@eik.bme.hu>
 <2abde3829a94acf0aa90942794ff0c4b03c653f4.1584437958.git.balaton@eik.bme.hu>
 <7a616aa2-9482-1735-8f29-1d69b7393891@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1165243856-1584455059=:40468"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1165243856-1584455059=:40468
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2020, John Snow wrote:
> On 3/17/20 5:39 AM, BALATON Zoltan wrote:
>> We can move this define now that less files use it to internal.h to
>> further reduce dependency on hw/ide.h.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/hw/ide.h          | 2 --
>>  include/hw/ide/internal.h | 2 ++
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/ide.h b/include/hw/ide.h
>> index d52c211f32..c5ce5da4f4 100644
>> --- a/include/hw/ide.h
>> +++ b/include/hw/ide.h
>> @@ -4,8 +4,6 @@
>>  #include "hw/isa/isa.h"
>>  #include "exec/memory.h"
>>
>> -#define MAX_IDE_DEVS	2
>> -
>>  /* ide-isa.c */
>>  ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isa=
irq,
>>                          DriveInfo *hd0, DriveInfo *hd1);
>> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
>> index 1bc1fc73e5..55da35d768 100644
>> --- a/include/hw/ide/internal.h
>> +++ b/include/hw/ide/internal.h
>> @@ -27,6 +27,8 @@ typedef struct IDEDMAOps IDEDMAOps;
>>  #define TYPE_IDE_BUS "IDE"
>>  #define IDE_BUS(obj) OBJECT_CHECK(IDEBus, (obj), TYPE_IDE_BUS)
>>
>> +#define MAX_IDE_DEVS 2
>> +
>>  /* Bits of HD_STATUS */
>>  #define ERR_STAT		0x01
>>  #define INDEX_STAT		0x02
>>
>
> /home/jsnow/src/qemu.git/ide/hw/mips/mips_r4k.c: In function
> =E2=80=98mips_r4k_init=E2=80=99:
> /home/jsnow/src/qemu.git/ide/hw/mips/mips_r4k.c:190:33: error:
> =E2=80=98MAX_IDE_DEVS=E2=80=99 undeclared (first use in this function);=
 did you mean
> =E2=80=98MAX_IDE_BUS=E2=80=99?
>  190 |     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      |                                 ^~~~~~~~~~~~
>      |                                 MAX_IDE_BUS
>
>
>
> Missed a spot.

Probably due to dropping patch 4, I'll check and send a v3. Is there=20
anything else besides Philippe's suggestion?

Regards,
BALATON Zoltan
--3866299591-1165243856-1584455059=:40468--

