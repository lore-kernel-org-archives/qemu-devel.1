Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD25CC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C8F2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C8F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Oo7-0000CI-Lm
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Omz-0007vT-A7
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Omy-0006Vb-2R
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Omx-0006UW-R0
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:04:51 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2141C0546F2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:04:50 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n6so861530wrw.14
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bP7ESnZ1RAt0LXK6eH9zKAf51XwW+XJZ3/F1B9BOJw0=;
 b=s5d60tqD440wysF5Ktk0TRzgFwNOFq5TJu/kHQCdUW0qBIBoNBz7gY//h+Ww1vLcin
 aWkSJs676+wTKMQadFd9QpOqczNIOtsZELQGymY6S8Jqw3nk+Kk7kLn4kkn+IRkr4rdg
 CgIxyMQ7ahMqKJVN9lbyHuCh1jiVSrblKJEPOPdV5/g9Lq5vVNgQbkH9YHcfixJdV+gK
 A0Vlmt9FatOtzKLQRkFDVpYuWoZkHbnN14bDIFiVHTAhQ31Z/wFmBosjdrz488A7dYin
 RZJ6BGBLpb32lsY3dqTMGFG4k58UoBTW7fnfNh1xuK91QYk4Y1rA6dDO/YbUAP8em8lN
 VOyg==
X-Gm-Message-State: APjAAAXj4/A945vpSDNhVQ5AsbrOCoWA6ILwFFr5EO3IaNVoUsblmHsE
 jwtlt/io7bnQnDKr617Dmo+jCiIoBbRjYZSYAAXhV2ci6DBavjoVb87+xm/S8k7YrwULKtcJdYG
 JxMfmnyCsTuGeHPs=
X-Received: by 2002:a05:6000:1186:: with SMTP id
 g6mr13880790wrx.17.1567101889464; 
 Thu, 29 Aug 2019 11:04:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPwYJMAFR4A/N/cCiVDp1Nu2yqB5hfc4qi6/dY9+9Yx9MbJS8QHQbcFUi4NaZEVHWbCPKibA==
X-Received: by 2002:a05:6000:1186:: with SMTP id
 g6mr13880761wrx.17.1567101889192; 
 Thu, 29 Aug 2019 11:04:49 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id s1sm7208059wrg.80.2019.08.29.11.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 11:04:48 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190823135811.13883-1-philmd@redhat.com>
 <20190823135811.13883-2-philmd@redhat.com>
 <64061664-f79f-b074-8fec-fea24594d5df@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <427b3a07-b428-fca4-a6ed-ba0d663d6a83@redhat.com>
Date: Thu, 29 Aug 2019 20:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <64061664-f79f-b074-8fec-fea24594d5df@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] target/arm: Restrict pre-ARMv7 cpus to
 TCG
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 7:04 PM, Richard Henderson wrote:
> On 8/23/19 6:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> @@ -2535,6 +2544,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>>      { .name =3D "arm1176",     .initfn =3D arm1176_initfn },
>>      { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
>>      { .name =3D "cortex-m0",   .initfn =3D cortex_m0_initfn,
>> +#endif
>>                               .class_init =3D arm_v7m_class_init },
>>      { .name =3D "cortex-m3",   .initfn =3D cortex_m3_initfn,
>>                               .class_init =3D arm_v7m_class_init },
>=20
> Ifdef is misplaced.  This shouldn't even compile without CONFIG_TCG.

What a shame... I hope I messed this due to a failed rebase...

> Also, m-profile shouldn't work with kvm either, so I think the endif sh=
ould go
> below cortex-m33.

Obviously.

