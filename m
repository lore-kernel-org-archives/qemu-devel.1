Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D90EC5DF61
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4255E214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4255E214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS0Re-0006U2-CZ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iS0Qx-00062C-IS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iS0Qv-0005x8-4f
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:07:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11411)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iS0Qu-0005m4-Ob
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:07:49 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7A71BDF9
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 15:07:45 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id f11so2739917wmc.8
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 07:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lwqGrgSoizz3cx6aCtWZDdt7YOk5RSQMK0PNqyncHZI=;
 b=KdPo7PutAEcAuPXor7OQXjP7iEurRceTdJVt2F/Aczyeb7tbwbYGNfx1Tzf7T/hg+l
 +CEyLkwwmIjeI/Otkn8dQeeeY4epy6GSAlEKnQwD1qzP5GiL/IbI1RUPpHJ5tY+9u5/a
 gNknw3Tcfq2mziiQjx8//2ck1kMY1LKMDCY1TQ77Xa1ZzeY19uuu601CUsB4yYT421SR
 NS+D6Nr8KmUCRdplWCLEPchv8dKqY9zgujo74fWfD/mUfghX4B3c7nbZxR/hiEmui0DM
 rVNRI61TNmvcDyokarKTddnHPi6urxNqvROE/I2hGhZvMLtsPIr1JtDddL/PUwgHBO/P
 80bQ==
X-Gm-Message-State: APjAAAXNZcsJ2Pej8vJetph2+sIx1wlPc1b9kmlVAQH5uErZrFuFViLt
 kKsys4+GQJ3NmnhL1QlK7qKWt9CpyqbJhsTkLA2tp+GDr4QJEvp6yS3fd7gEcqXalVULWRQ5N9J
 h6b+FmThpnY/ewN8=
X-Received: by 2002:adf:a48c:: with SMTP id g12mr27002928wrb.212.1572966464303; 
 Tue, 05 Nov 2019 07:07:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwI0zHyLPBkPIcHAFlQyY3/ubmJc4dww+FITgBy/XhSXjwbXUSdzaXh8UTr19LwOMGflRq4Ig==
X-Received: by 2002:adf:a48c:: with SMTP id g12mr27002880wrb.212.1572966463826; 
 Tue, 05 Nov 2019 07:07:43 -0800 (PST)
Received: from [192.168.43.238] (241.red-95-127-150.staticip.rima-tde.net.
 [95.127.150.241])
 by smtp.gmail.com with ESMTPSA id a16sm28861935wmd.11.2019.11.05.07.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2019 07:07:43 -0800 (PST)
Subject: Re: [PATCH] Makefile: Fix config-devices.mak not regenerated when
 Kconfig updated
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191104095530.22091-1-philmd@redhat.com>
 <20191105145503.GE42501@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a980d79-7add-407a-705c-efc05b517ddc@redhat.com>
Date: Tue, 5 Nov 2019 16:07:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191105145503.GE42501@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/19 3:55 PM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Nov 04, 2019 at 10:55:30AM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> When hw/$DIR/Kconfig is changed, the corresponding generated
>> hw/$DIR/config-devices.mak is not being updated.
>> Fix this by including all the hw/*/Kconfig files to the prerequisite
>> names of the rule generating the config-devices.mak files.
>>
>> Fixes: e0e312f3525a (build: switch to Kconfig)
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> If OK, I plan to include this fix in the "hw/i386/pc: Split PIIX3
>> southbridge from i440FX northbridge" pull request.
>> ---
>>   Makefile | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 0e994a275d..c1461b21e8 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -384,7 +384,10 @@ MINIKCONF_ARGS =3D \
>>       CONFIG_LINUX=3D$(CONFIG_LINUX) \
>>       CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
>>  =20
>> -MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
>> +MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig =
\
>> +                   $(patsubst %,$(SRC_PATH)/hw/%,$(shell sed -ne \
>> +                                                    's/source \(.*\)/=
\1/p' \
>> +                                                    < $(SRC_PATH)/hw/=
Kconfig))
>=20
> Why can't we use the simpler wildcard statement:
>=20
>     $(wildcard $(SRC_PATH)/hw/*/Kconfig)
>=20
> instead of reading the file names from the hw/Kconfig file ?

You might have uncommited Kconfig files, but this shouldn't be a=20
problem, make is only interested in checking the modification time of=20
these files.

Thanks for reviewing, I'll respin.

