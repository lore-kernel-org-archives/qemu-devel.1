Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E40FC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 08:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A602081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 08:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A602081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMTkJ-0006Bm-DK
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 04:40:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hMTjU-0005oO-R2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hMTjT-0001N8-Pj
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:39:52 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:44247
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hMTjT-0001Mb-Js
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:39:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 5588681387;
	Fri,  3 May 2019 10:39:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WC34GkCzxx-T; Fri,  3 May 2019 10:39:50 +0200 (CEST)
Received: from localhost.localdomain
	(apoitiers-155-1-191-106.w109-220.abo.wanadoo.fr [109.220.154.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id 2291881385;
	Fri,  3 May 2019 10:39:50 +0200 (CEST)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
	<5eb69d4e-1d3c-805f-fc79-fce42febf959@ilande.co.uk>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <d18933f2-bea5-e613-fd9a-c7c156a15cb2@adacore.com>
Date: Fri, 3 May 2019 10:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5eb69d4e-1d3c-805f-fc79-fce42febf959@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 194.98.77.210
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Leon3 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, philmd@redhat.com, atar4qemu@gmail.com,
	chouteau@adacore.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503083948.FAGnUZSi8qVhc8st7g_yV1BiELqgYimL_zdiKi7535U@z>



Le 5/3/19 =C3=A0 10:19 AM, Mark Cave-Ayland a =C3=A9crit=C2=A0:
> On 25/04/2019 13:18, KONRAD Frederic wrote:
>=20
>> Hi all,
>>
>> Those are some little fixes for the leon3 machine:
>>    * The first part initializes the uart and the timer when no bios ar=
e
>>      provided.
>>    * The second part adds AHB and APB plug and play devices to allow t=
o boot
>>      linux.
>>    * The third part adds myself to the MAINTAINERS for this board.
>>
>> The test images are available here: https://www.gaisler.com/anonftp/li=
nux/lin
>> ux-2.6/images/leon-linux-4.9/leon-linux-4.9-1.0/up/
>>
>> Tested with:
>>    qemu-system-sparc -M leon3_generic --nographic --kernel image.ram
>>
>> V1 -> V2:
>>    * minor fixes in the first patch suggested by Philippe.
>>
>> Regards,
>> Fred
>>
>> KONRAD Frederic (3):
>>    leon3: add a little bootloader
>>    leon3: introduce the plug and play mecanism
>>    MAINTAINERS: add myself for leon3
>>
>>   MAINTAINERS                         |   1 +
>>   hw/misc/Makefile.objs               |   2 +
>>   hw/misc/grlib_ahb_apb_pnp.c         | 269 ++++++++++++++++++++++++++=
++++++++++
>>   hw/sparc/leon3.c                    | 114 +++++++++++++--
>>   include/hw/misc/grlib_ahb_apb_pnp.h |  60 ++++++++
>>   include/hw/sparc/grlib.h            |  35 +++--
>>   6 files changed, 455 insertions(+), 26 deletions(-)
>>   create mode 100644 hw/misc/grlib_ahb_apb_pnp.c
>>   create mode 100644 include/hw/misc/grlib_ahb_apb_pnp.h
>=20
> Hi Frederic,
>=20
> I've now had a chance to review this - I think it basically looks good,=
 it just needs
> a few minor tweaks. I can also confirm that using the test images at th=
e URL above, I
> can boot to a userspace shell.
>=20
> I'm happy to take this through my qemu-sparc branch once everything is =
ready to go.
>=20
>=20
> ATB,
>=20
> Mark.
>=20

Hi Mark,

Thanks for the review.

Regards,
Fred

