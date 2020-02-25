Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5925C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E87421556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heVOrsH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E87421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YDt-0000LN-On
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6YCp-0007xP-1G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6YCl-0006kY-IC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:16:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6YCl-0006ik-Ex
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582629406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BnY+u7s79rAmYLt+X2g5zqRZ/vhE6dNcKt11EC2/4E=;
 b=heVOrsH/fE/LOHo9rei3rKHCNgd5b8XzPbMfs1jwUvJjn+mb7BWuIIg09spM7IwzDGDLrV
 wtREqeThCHTFaMkC/6oHrSKvWG1OliI0gX1YOzKpB0ciVZXjlOUVkmzH9z25npdh5tSf5h
 Tk9ulE5E2RLLjZX+5obPr+HETfMUy48=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-8ijIKFoiP7SU5Ay0omzqCQ-1; Tue, 25 Feb 2020 06:16:44 -0500
X-MC-Unique: 8ijIKFoiP7SU5Ay0omzqCQ-1
Received: by mail-wm1-f70.google.com with SMTP id g138so715300wmg.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mybTY2JMYN6zflQVzeyGn4UvK2wvHyf2BrGcCFX1Jl8=;
 b=clv8wOolYnbC3czijHTcsILbtKXJIvQ4s/fjYrWmXnjiibWYZxbd9bzezK+yTQkUAa
 oL3UqUeHHMI854rmEfr8GdVkfu6bX2hhT2KzE5+Cw07Mfr7WKkVxlznd1CB2WdsK1/eN
 rgB+BVO1ITrP99quaSXQM142bhVVF7nEbz7RSvZLpowmKYwjUxMqhDVtDEBGgzFDcv48
 YLbEopU0+ZDEE2sWvy54MHUmssMPpO3D+b2Cn7Nccyhpf+aMA4Bab5xXCEZFjcsXyui7
 qVv7X/73BP4S9RUlhdXTUi/taO+/N4qRNwaGxHgdEXnWtbw1fqLf4vazCiAD0f399ppC
 QVDA==
X-Gm-Message-State: APjAAAWgTk7HW6einQ/bXyxZsTkjRXMnSCT1WLMyBFsqF+3uVI9wnbt9
 06aTBvPxldrduGQKU6YtHeqMNemYLUG3BuQQpCA25Axc3GvMCD5xxLfUwgklzaH/a1kkabJKWlb
 GJt25fd2oGHxiyaY=
X-Received: by 2002:adf:c445:: with SMTP id a5mr1777298wrg.14.1582629403733;
 Tue, 25 Feb 2020 03:16:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjIQfd/kPRxuwRCkxqYF8ia2cNean9hsKYlHTZi9oRlrGSkzkDFOUkfllGF0zTOSJpl7TYIA==
X-Received: by 2002:adf:c445:: with SMTP id a5mr1777273wrg.14.1582629403547;
 Tue, 25 Feb 2020 03:16:43 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r6sm23898793wrq.92.2020.02.25.03.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:16:42 -0800 (PST)
Subject: Re: [PATCH 1/2] hw/arm/gumstix: Simplify since the machines are
 little-endian only
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200223231044.8003-1-philmd@redhat.com>
 <20200223231044.8003-2-philmd@redhat.com>
 <CAFEAcA_H7aWjtoky=o2uKpNjZnebuskn-fFUMXbq=Gja5vyaBA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9ac5c707-c34f-b374-d910-e5d73ba8c327@redhat.com>
Date: Tue, 25 Feb 2020 12:16:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_H7aWjtoky=o2uKpNjZnebuskn-fFUMXbq=Gja5vyaBA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 12:12 PM, Peter Maydell wrote:
> On Sun, 23 Feb 2020 at 23:10, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> As the Connex and Verdex machines only boot in little-endian,
>> we can simplify the code.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>=20
>>   static void gumstix_machine_init(void)
>>   {
>> +    if (target_words_bigendian()) {
>> +        return;
>> +    }
>=20
> I don't think we really need to do this, do we? We don't
> in any of the other arm boards that just assume little-endian.
> I think TARGET_WORDS_BIGENDIAN will only be true on Arm for
> the BE linux-user targets, never for softmmu.
>=20
> Also, there's a warning comment in the header file for
> the declaration of target_words_bigendian() that says
> you probably don't want to use it...

Yes you (and the comment) are right, we should not use this call in=20
target-specific code.

>=20
> If you drop this, then otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

>=20
> thanks
> -- PMM
>=20


