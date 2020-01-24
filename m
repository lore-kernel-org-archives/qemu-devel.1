Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F6720709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OECMSsky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F6720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwbL-0000rW-Gb
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuwZB-0005tw-0O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuwYa-0000kV-KG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:51:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52636
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuwYa-0000j9-FH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579863079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjbvZqpoczPDoeV6seNWyauouAIOFLYf616kaRIHjPg=;
 b=OECMSskyoJ6ZyxLZJzvVEN5DINWaDzhL6tVN2Bc4l47XuYMu6r5CUpzQpgT/rV/RDKV7wl
 JjCX21QCY3ow5GJldp91P1NBrAccG0JhZVm+hO2jC77Nngei5zbO1R4AwRQyoLIduF70na
 Htd2wibsCZfPHu6DbzJP/iliY6Jnl8s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-x9hokcTaPFejU1_qxcNwAg-1; Fri, 24 Jan 2020 05:51:17 -0500
Received: by mail-wr1-f72.google.com with SMTP id z14so987998wrs.4
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TZ9DbU1BrQfEqK+U3ZmiXY/yNPpAPPefKnaomrQsUuY=;
 b=CGdHyoRb8iLC12syXa+Zd4iBBlX8zz0kMKynvr6B9QB7463VIhwBzK0TSUcIstRkWn
 nzxrtOXckETLhj3ME1avDsTiUh+WbY9TNHZuCHIzOmz8zFP5jgLqcE0FkimNndRDVPkm
 8HxuCU+x+R2KY5AvKnaUJEBWtH93KBGukLMkgmnvr5SstC3/XRV7HCJEaFhgyXr8ulx3
 eJ0TYhhXudswcgxIimzQ+ETlAD5VL838RgNmehRZZBpcJsOgqviBSgEEiy3b2njJPYT2
 M97V1yIp8f05/vN+OVUvtg4e+IO/TpU5PuG3kV+XWHQ/NjdJoCQXfERRetpMQRXOvxKU
 DcFg==
X-Gm-Message-State: APjAAAWf+ZTVk5xuGV4GEPyXSeYWQwq/2VWmrUV6juqv60i6ucRiRTh7
 arlDDInzyNEkRqMVykuHDQygbIthACgr9xiu8fDbOQaWj/K4hbqJ7S0GWB3J8CMAkwSGmlmqNDN
 OR3kHeZPPVsqjVzo=
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr2771438wml.107.1579863076167; 
 Fri, 24 Jan 2020 02:51:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqx75dX20BJNh1VUBEnwpTJD5hjXVPNuli4AY+JLCb1Gls9ZXY2uSN01ovf0bXw7q4E1zPqn2w==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr2771399wml.107.1579863075934; 
 Fri, 24 Jan 2020 02:51:15 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id g9sm6952640wro.67.2020.01.24.02.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 02:51:15 -0800 (PST)
Subject: Re: [PATCH rc2 12/25] hw/timer: Add limited support for Atmel 16 bit
 timer peripheral
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 S.E.Harris@kent.ac.uk, Edward Robbins <E.J.C.Robbins@kent.ac.uk>
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-13-f4bug@amsat.org> <875zh1yw38.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <790c5181-c4b0-ea7b-f4e4-07bacae220b2@redhat.com>
Date: Fri, 24 Jan 2020 11:51:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <875zh1yw38.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: x9hokcTaPFejU1_qxcNwAg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, me@xcancerberox.com.ar,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 mrolnik@gmail.com, imammedo@redhat.com, thuth@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Sarah,

On 1/24/20 11:42 AM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
>> From: Michael Rolnik <mrolnik@gmail.com>
>>
>> These were designed to facilitate testing but should provide enough
>> function to be useful in other contexts.  Only a subset of the functions
>> of each peripheral is implemented, mainly due to the lack of a standard
>> way to handle electrical connections (like GPIO pins).
>>
>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>> Message-Id: <20200118191416.19934-13-mrolnik@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> [rth: Squash info mtree fixes and a file rename from f4bug, which was:]
>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> [PMD: Use qemu_log_mask(LOG_UNIMP), replace goto by return]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
> <snip>
>> --- /dev/null
>> +++ b/include/hw/timer/atmel_timer16.h
>> @@ -0,0 +1,94 @@
>> +/*
>> + * Atmel AVR 16 bit timer
>> + *
>> + * Copyright (c) 2018 University of Kent
>> + * Author: Ed Robbins
>=20
> No sign off from the author here?

Hmmm I Sarah Harris's one, who is from the University of Kent, isn't it=20
enough? (I remember patched from Xilinx with Edgar S-o-b but from other=20
authors, Edgar vouched for Xilinx).

Sarah, can you get Ed Signed-off-by?

>> --- /dev/null
>> +++ b/hw/timer/atmel_timer16.c
>> @@ -0,0 +1,605 @@
> <snip>
>> +
>> +/* Helper macros */
>> +#define VAL16(l, h) ((h << 8) | l)
>> +#define DB_PRINT(fmt, args...) /* Nothing */
>> +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ##
>> args)*/
>=20
> Format strings are likely to bitrot. Either use a if (GATE) or
> tracepoints.

Yes...

> <snip>
>=20
> Otherwise:
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks!


