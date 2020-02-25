Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BD7C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14C821744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boj7K4Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14C821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WNj-0004BH-2o
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6WMO-0003WM-MH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6WMN-0004PY-JJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:18:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6WMN-0004PO-Fx
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582622314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTuxIqYSmbyx1o0KLauMg23JOJ2HaSxD0uAOP9Ha4dM=;
 b=boj7K4Y9h9E+dJcd3tlfxdwftU/2YyUIXD5s2wsZ5zCVasDjTJId/i/ZOwdmabCf8tAz2W
 dYQCO2yGaChC7S8PbwNM31QS3v0mzvE5tFrLlbM7iZvRK3oO76jTJcesXmZbEyJrye1yha
 HyrYcHq1a90zjsrPjXxTPpRao9ZEZFQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-HTnm_-8qN9q0b1OASdLxeQ-1; Tue, 25 Feb 2020 04:18:28 -0500
X-MC-Unique: HTnm_-8qN9q0b1OASdLxeQ-1
Received: by mail-ed1-f72.google.com with SMTP id cy24so8615548edb.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 01:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1d8bSQXlMGbJ+Rx1GkY8Xorkfq0pf9AamsT0KV+emUo=;
 b=ErP9v0IiRlH0RpZtkTOxXpLuUGCixz/TMjeFohVA9FApiMj90SA3itWgW7CQ9f/HiA
 adfJbaagWmBFYdqqMAmLHvla/R49q+DoKKvj72z6vx+AFFvj0KhxbnDcMe8bE41AnT11
 hOOYsDgZRdoxUfobmnvbfaIt9bWjCWSHcsQ8G7H4fee2fScJcnWcLfZgqYIEu1vxhsQH
 1QMOUOhE1FfpYtbHpvh84Q4yo0wFiDZR1uf5//ZR2wjhC/6nICfsjRk56VIgSsjePEQQ
 ZXqRgqBtyAE+vjrpTkbbfIxe2Ugg/EHRNt3YaLcJAuvTq4Tihv5K9BW2e4wcNzXTtmxM
 f2Pg==
X-Gm-Message-State: APjAAAXV4EelKt4lJLfQJpSHmVzgD1Go7i7McuDIr3VT4p8MiC0RCEHE
 GDHL8VRW80Xt6wU9T6B3r/nRysnoX17AW2Md+Ex8mgjZSfuchZPgGAjFnGPeDBz65Fo/zqnfP2J
 NwnpitRNibU1grPI=
X-Received: by 2002:a05:6402:142b:: with SMTP id
 c11mr48143224edx.316.1582622307505; 
 Tue, 25 Feb 2020 01:18:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTMufPqsQl8/Gr/gNlUziBbGfG0K10WvM1uYltNCVCl/YT2Yl+nukEGCJTl9xTuDF7wq7AZw==
X-Received: by 2002:a05:6402:142b:: with SMTP id
 c11mr48143214edx.316.1582622307303; 
 Tue, 25 Feb 2020 01:18:27 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u9sm929515ejj.49.2020.02.25.01.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 01:18:26 -0800 (PST)
Subject: Re: [PATCH RESEND 0/3] travis-ci: Improve OSX coverage
To: qemu-devel@nongnu.org
References: <20200218142018.7224-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b97d2a79-bb0b-02b9-13a8-b45bc7475442@redhat.com>
Date: Tue, 25 Feb 2020 10:18:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218142018.7224-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 3:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add more packages on the Mojave OSX job (Xcode 10),
> and duplicate the job to build on Catalina (Xcode 11).

ping?

>=20
> Each job takes ~34min:
> https://travis-ci.org/philmd/qemu/builds/651473221
>=20
> Philippe Mathieu-Daud=C3=A9 (3):
>    .travis.yml: Expand OSX code coverage
>    .travis.yml: Build with ncurses on OSX
>    .travis.yml: Test building with Xcode 11.3
>=20
>   .travis.yml | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 46 insertions(+), 2 deletions(-)
>=20


