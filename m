Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A0C4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A372B206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A372B206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8QNI-0005r1-B9
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1i8QBh-0006aM-Uk
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1i8QBg-0006Ju-UM
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:35:09 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:36910
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1i8QBg-0006In-OY; Thu, 12 Sep 2019 10:35:08 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 9B98981549;
 Thu, 12 Sep 2019 16:35:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id meCP6MlRMKxx; Thu, 12 Sep 2019 16:35:06 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-447-75.w86-206.abo.wanadoo.fr
 [86.206.4.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 5272E812FD;
 Thu, 12 Sep 2019 16:35:06 +0200 (CEST)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <1568296920-29939-1-git-send-email-frederic.konrad@adacore.com>
 <ca55df80-6461-9650-f2e4-b2136d54adc3@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <0f04b987-28d2-e8d2-6c00-9a939b845cec@adacore.com>
Date: Thu, 12 Sep 2019 16:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ca55df80-6461-9650-f2e4-b2136d54adc3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: Re: [Qemu-devel] [PATCH] target/m68k/fpu_helper.c: rename the
 access arguments
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 9/12/19 =C3=A0 4:32 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> On 9/12/19 4:02 PM, KONRAD Frederic wrote:
>> The "access" arguments clash with a macro under Windows with MinGW:
>>    CC      m68k-softmmu/target/m68k/fpu_helper.o
>>    target/m68k/fpu_helper.c: In function 'fmovem_predec':
>>    target/m68k/fpu_helper.c:405:56: error: macro "access" passed 4 arg=
uments,
>>     but takes just 2
>>                 size =3D access(env, addr, &env->fregs[i], ra);
>>
>> So this renames them access_fn.
>=20
> access() is not your friend... this reminds me of
>=20
> commit 05e015f73c3b5c50c237d3d8e555e25cfa543a5c
> Author: KONRAD Frederic <frederic.konrad@adacore.com>
> Date:   Thu Sep 21 12:04:20 2017 +0200
>=20
>      memory: avoid a name clash with access macro
>=20
>      This avoids a name clash with the access macro on windows 64:

True, I didn't catch this one at the time because we didn't build m68k.

>=20
>      make
>              CHK version_gen.h
>        CC      aarch64-softmmu/memory.o
>      /home/konrad/qemu/memory.c: In function 'access_with_adjusted_size=
':
>      /home/konrad/qemu/memory.c:591:73: error: macro "access" passed 7
> arguments, \
>                       but takes just 2
>                       (size - access_size - i) * 8, access_mask, attrs)=
;
>                                                                       ^
>>
>> Tested with:
>>   ./configure --target-list=3Dm68k-softmmu
>>   make -j8
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

Cheers,
Fred


