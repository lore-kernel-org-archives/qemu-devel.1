Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B44C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2305120868
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2305120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZ1g-0005ED-8z
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:19:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hRZ0f-0004ak-TC
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hRZ0e-0001Pp-M1
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:18:37 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:58943
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hRZ0e-0001OM-CI
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:18:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 82A578139A;
	Fri, 17 May 2019 11:18:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PB9IBmn-mfXv; Fri, 17 May 2019 11:18:32 +0200 (CEST)
Received: from [10.10.126.96] (wifi-guest-96.act-europe.fr [10.10.126.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id 5EAEA81399;
	Fri, 17 May 2019 11:18:32 +0200 (CEST)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <1557923493-4836-1-git-send-email-frederic.konrad@adacore.com>
	<c0bba828-7cc8-6ac9-a863-696e93796398@ilande.co.uk>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <d2478601-56b1-fe62-ef33-3b7002dc5855@adacore.com>
Date: Fri, 17 May 2019 11:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c0bba828-7cc8-6ac9-a863-696e93796398@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Leon3 patches
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



Le 5/17/19 =C3=A0 10:51 AM, Mark Cave-Ayland a =C3=A9crit=C2=A0:
> On 15/05/2019 13:31, KONRAD Frederic wrote:
>=20
>> Hi all,
>>
>> Those are some little fixes for the leon3 machine:
>>    * The first patch makes an error message more friendly when no kern=
el / bios
>>      are provided.
>>    * The three next one remove the old-style create function as sugges=
ted by
>>      Mark.
>>    * The fifth part initializes the uart and the timer when no bios ar=
e
>>      provided.
>>    * The sixth part adds AHB and APB plug and play devices to allow to=
 boot
>>      linux.
>>    * The last part adds myself to the MAINTAINERS for this board.
>>
>> The test images are available here: https://www.gaisler.com/anonftp/li=
nux/lin
>> ux-2.6/images/leon-linux-4.9/leon-linux-4.9-1.0/up/
>>
>> Tested with:
>>    qemu-system-sparc -M leon3_generic --nographic --kernel image.ram
>>
>> V2 -> V3:
>>    * rebased.
>>    * added patches 1, 2, 3, 4 as suggested by Mark.
>>    * fixed DEVICE_NATIVE_ENDIAN to DEVICE_BIG_ENDIAN in patch 6 as sug=
gested by
>>      Mark.
>>    * added include/hw/*/grlib* to the MAINTAINED file as suggested by =
Mark.
>> V1 -> V2:
>>    * minor fixes in the first patch suggested by Philippe.
>>
>> Regards,
>> Fred
>>
>> KONRAD Frederic (7):
>>    leon3: fix the error message when no bios are provided
>>    grlib,irqmp: get rid of the old-style create function
>>    grlib,gptimer: get rid of the old-style create function
>>    grlib,apbuart: get rid of the old-style create function
>>    leon3: add a little bootloader
>>    leon3: introduce the plug and play mechanism
>>    MAINTAINERS: add myself for leon3
>>
>>   MAINTAINERS                         |   3 +-
>>   hw/char/grlib_apbuart.c             |   4 +-
>>   hw/intc/grlib_irqmp.c               |   3 +-
>>   hw/misc/Makefile.objs               |   2 +
>>   hw/misc/grlib_ahb_apb_pnp.c         | 269 ++++++++++++++++++++++++++=
++++++++++
>>   hw/sparc/leon3.c                    | 157 ++++++++++++++++++---
>>   hw/timer/grlib_gptimer.c            |   4 +-
>>   include/hw/misc/grlib_ahb_apb_pnp.h |  60 ++++++++
>>   include/hw/sparc/grlib.h            |  78 +----------
>>   9 files changed, 483 insertions(+), 97 deletions(-)
>>   create mode 100644 hw/misc/grlib_ahb_apb_pnp.c
>>   create mode 100644 include/hw/misc/grlib_ahb_apb_pnp.h
>=20
> Thanks for sorting out the old-style functions, this version looks much=
 better. I've

You're welcome!

> applied this to my qemu-sparc branch and will send a PR shortly.
>=20
Great! Thanks!

Regards,
Fred

>=20
> ATB,
>=20
> Mark.
>=20

