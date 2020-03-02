Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C86C3F2D4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 08:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56FF246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 08:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cncm+BiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56FF246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8gVn-0002Ix-4A
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 03:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8gUq-0001lS-Vy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8gUp-0005fY-U2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:32:16 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8gUp-0005f2-Ll
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:32:15 -0500
Received: by mail-wr1-x442.google.com with SMTP id y17so11366029wrn.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 00:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+/esAd3rTsyYEC9JcW/pfHjjcfdaslwGsH3PMyp5Xxw=;
 b=cncm+BiKYaXDJtFMOTWQmqQnvAxg9eAgUqdVd+lcn9/IoIeeXYh5Q2TTRvHWIBkGx8
 9XRNLuxJw0iC+DNYbaMZBlG//6pWSSISPtljl7x+vJmKo6bfXC8kMI/IV5a3lb54VIsG
 8PaQg8vBHauE2OJa2IPRl4sSm8RqFNTxPJ4L1rwVJxoTxG/7c4C72ZARaFgpptlA7+6j
 ItMn3RL6fe9Q09g42gg8TaIyRFeHROA5VSWXFudN4MNu+hp5wyk1nWdbO07mCARWYfpS
 F68O+AT/IqsxgeLkMsow/oBMRnhtLu/9OFkbQM2gf1TPpdeBYDWpiUH4niWnhwgVrP99
 MK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+/esAd3rTsyYEC9JcW/pfHjjcfdaslwGsH3PMyp5Xxw=;
 b=DOZR9WcIWc4Tiwz2bRjvoMs8otwAd/lU5U5Iv/e1+tuauUiUeWKzKq3qkb1J2mfcRg
 Ry6oITRZbNllZDMMYvCWBcGr21QYFMiuorrAmtbT6yKjO1CUpGV8czdO4q0cGtxWijTp
 ERAxnuUGZ4bGNpMtU0NBE/kp3MUP8men5ekNzp4OnE/ZqeBHIcR+8BobFRu6YqM68vqP
 rcVJcUjgsnXUrpKEnenNdtiKhdFY2CrlAhtpPRtyEWD5GJcu8KlBiHCfr9CGh36yWi+f
 Ow0c32Oe7sAJR1it0WQQ5Ro5803JZBWg1oRfq5+B8smx03CjKoHle/PK8RYNbfmZhrxO
 lb7w==
X-Gm-Message-State: ANhLgQ1oMIL3HWrOTQ/PX22htGhN0B8qRSo9eVNRPWFJmcVde3cNe4I2
 NHr7r5r3n6uc+j1HIoUym/srcQ==
X-Google-Smtp-Source: ADFU+vtizs2f5KpxOG/ZxQA0FutKMwtA4tDpC1xulNydo3pfhpn4ueaJOHeN9qOAuevJ9ycEiwAtNA==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr7826435wrw.337.1583137934389; 
 Mon, 02 Mar 2020 00:32:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t133sm16014595wmf.31.2020.03.02.00.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 00:32:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 269561FF87;
 Mon,  2 Mar 2020 08:32:12 +0000 (GMT)
References: <20200228092420.103757-1-quintela@redhat.com>
 <20200228092420.103757-7-quintela@redhat.com>
 <CAFXwXr=9R9FZ5wD5Lk=cbP=Qt93KOokrcOjxj_JKevmso9qdgg@mail.gmail.com>
 <878skj1908.fsf@secure.laptop>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: quintela@redhat.com
Subject: Re: [PULL 06/15] configure: Enable test and libs for zstd
In-reply-to: <878skj1908.fsf@secure.laptop>
Date: Mon, 02 Mar 2020 08:32:12 +0000
Message-ID: <87zhcz40oj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "open
 list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org
 Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Juan Quintela <quintela@redhat.com> writes:

> Richard Henderson <richard.henderson@linaro.org> wrote:
>>> +##########################################
>>> +# zstd check
>>> +
>>> +if test "$zstd" !=3D "no" ; then
>>> +    if $pkg_config --exist libzstd ; then
>>
>> The option is spelled --exists.  This is generating an error during conf=
igure.
>
> Ooops, you are right.
>
> Sending a patch.  Just wondering why I didn't saw that error :-(

I was only noticing when re-directing output - otherwise you miss it in
a fairly long scrollback.

>
> Thanks, Juan.


--=20
Alex Benn=C3=A9e

