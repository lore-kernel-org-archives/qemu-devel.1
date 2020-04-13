Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8597C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DBD206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DBD206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNw6E-0004It-N0
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 06:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jNw58-0003Ov-5Y
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1jNw57-00063g-4u
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:12:46 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:60299
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1jNw56-00062x-Vm
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:12:45 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 67C3E8139C;
 Mon, 13 Apr 2020 12:12:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qVRjDs1v3Q6l; Mon, 13 Apr 2020 12:12:42 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 6BE8C81395;
 Mon, 13 Apr 2020 12:12:41 +0200 (CEST)
Subject: Re: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
 <81737d76-06c6-4c83-1287-b0d14db4ce2f@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <989bf2f5-0e23-f9c3-e9e1-0bd8c03f3231@adacore.com>
Date: Mon, 13 Apr 2020 12:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <81737d76-06c6-4c83-1287-b0d14db4ce2f@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiri Gaisler <jiri@gaisler.se>, Fabien Chouteau <chouteau@adacore.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 4/11/20 =C3=A0 7:30 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> On 3/31/20 12:50 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Philippe Mathieu-Daud=C3=A9 (7):
>>    hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>>      registers
>>    hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>=20
> Ping ^^^ for 5.0?

Hi Philippe,

You already have my rb tag for those one, and IMHO they should be good ca=
ndidate
for 5.0 (if it's not too late).

Cheers,
Fred

>=20
>>    hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>>    hw/timer/grlib_gptimer: Display frequency in decimal
>>    target/sparc/int32_helper: Remove DEBUG_PCALL definition
>>    target/sparc/int32_helper: Extract and use excp_name_str()
>>
>>   hw/misc/grlib_ahb_apb_pnp.c             | 24 ++++++++++++++++++++++-=
-
>>   target/sparc/int32_helper.c             | 23 ++++++++++++-----------
>>   hw/misc/trace-events                    |  4 ++++
>>   hw/timer/trace-events                   |  2 +-
>>   tests/acceptance/machine_sparc_leon3.py |  4 ++++
>>   5 files changed, 43 insertions(+), 14 deletions(-)
>>

