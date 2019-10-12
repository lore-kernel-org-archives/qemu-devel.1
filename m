Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08355C10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 07:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23092087E
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 07:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23092087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJBgo-0008TS-Q4
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJBf4-0007rX-CV
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJBf2-0000wE-Rs
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJBf2-0000vz-Mk
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:17:56 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63DDB33027C
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 07:17:55 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t11so5481089wro.10
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 00:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YMFJqdZvxz7LkdzBSGR29K1A4/C6gMAzg3dfEammoiU=;
 b=pIBjRZrvpD1ECh/wiPoJh8eJNzLAB/7fWv7Tu+lKTAAV1bk6SM5i/qv6EOgXTkdZzF
 3olhSRb4WtrqqP9p1WPKC6a0AsnVmKFom1itqc3IoR/x+HGRpZ8X0qyoKdMq2EDDVMwa
 kfWBmnCfxzB/tCv8ozeAMGFhTcaWUMeEBmDXRZJ8CuduO1YSCSTGr4sb1aWVX2et/9fr
 xWoe7MgHswhA48NwMsgydSlA5K3yqJ+xgKRQDD1zF2EnY+2vClzoiOo5XK0eFYb0o4YY
 GKCwinyzkowTG2KB8UI3NfftFrOCt2OU/yd3SOazrdvhlnnif5XYiRGfEwJJ8IKGuvUR
 RRew==
X-Gm-Message-State: APjAAAVGS5hlVKMOfePrEq/4Qrh0xps6w/c7dZZMh2cIpt17+AmElCAD
 qS6PBYEzb3cVouTYyhJJU5SD0k4/Fz0Y0U6ZBlg/DTFglADY1RGnIbk6DqZyi+A0tve1ly3C3et
 7QThrxoWT+ITldIU=
X-Received: by 2002:adf:fe10:: with SMTP id n16mr5886314wrr.288.1570864674207; 
 Sat, 12 Oct 2019 00:17:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzIL98qd2hOWamNHBpbWDDiPInctjvmGJar+6zs3A0VxVefrYDs5++zdrQ1gRy1APk5nWxi9g==
X-Received: by 2002:adf:fe10:: with SMTP id n16mr5886296wrr.288.1570864674016; 
 Sat, 12 Oct 2019 00:17:54 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id f83sm18066010wmf.43.2019.10.12.00.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2019 00:17:53 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v29 8/8] target/avr: Add tests
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?B?J0FsZXggQmVubsOpZSc=?= <alex.bennee@linaro.org>,
 'Richard Henderson' <richard.henderson@linaro.org>
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-9-mrolnik@gmail.com> <87mufwz3e0.fsf@linaro.org>
 <6c7f5897-e7ed-b5f3-f167-78073a9e5b67@linaro.org> <87r25755a7.fsf@linaro.org>
 <001b01d55cb9$f5f88df0$e1e9a9d0$@ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0e57fb85-200d-de10-331f-977c9f4246ed@redhat.com>
Date: Sat, 12 Oct 2019 09:17:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <001b01d55cb9$f5f88df0$e1e9a9d0$@ru>
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
Cc: imammedo@redhat.com, thuth@redhat.com, 'Michael Rolnik' <mrolnik@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pavel,

On 8/27/19 11:29 AM, Pavel Dovgalyuk wrote:
>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 8/26/19 2:23 AM, Alex Benn=C3=A9e wrote:
>>>> Are there any compilers available so we can add the multiarch tests =
to "check-tcg"?
>>>
>>> Debian has a gcc-avr package.
>>
>> Looking at the bios "bytes" it should be easy enough to do a simple
>> serial based test. We can add it after it's merged though... is it rea=
dy
>> to go yet?
>=20
> I tried running this series with ASCIITable example from Arduino IDE.
> Everything worked and I've got an ASCII table in the console.

Does that mean we can add your Tested-by tag?

