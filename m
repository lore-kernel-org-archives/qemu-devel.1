Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6723CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C44207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoQrydC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C44207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j437q-0006VA-Do
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4378-0005j9-8o
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4377-0007Ix-6h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:40:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4377-0007Ig-2q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582033236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZouKSL42nVgIUkLtgJ65SsCYW8y4Zu+F20jcHYFcgw0=;
 b=ZoQrydC2mrjofZZaqTcfyxopsjnpjP0g3O2AeWwYfjxPaNxPHyuC8uR5rBbFh2v0TbXsqw
 rrNDvIOuwCUECznXOoMvSN5PjPB5QwSkmNyImxXEqWz5YbX4wQ0KvZQIvrnRzrcJYpgD17
 UmcNbUqiWybZMe/3w3uCf/W3RZeHL28=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-bvIB9TJ0O8eK90Ky4jePVg-1; Tue, 18 Feb 2020 08:40:34 -0500
Received: by mail-wr1-f72.google.com with SMTP id u8so10837531wrp.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 05:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W6Q4XZLGqSzbZ63dhOe/UAwSV/H6nZjQzAzd1VdnuJA=;
 b=Nyzri92N53drksA6kJ3N2O3oIjGZLoZT1yn6d4c77glI7oFQyGW8Jer5CFDmw1oNyK
 gVBFKAnIIUf53OqDjIT+xIH40mvVnziX8TC+lStqjlnbt/IbfEAYvbStOrDCkUPR76sk
 UYH8rNarp/gwA4RiHaxdS2y5+iTCEFmtUEWhvEMgAg4R0nnCQ/y6IRV+89VL3ZH9N3Eh
 fRrpK2eO5iHOm07MzT2ucinNqNJiJaGpC1hKFSivet2m/VS0yEjAUrkDDAfjJ8Wq8xwE
 0VaorSfpeGLAX8d+JD9f2ZK6MsRIdIAOI7Gucr+nOkroDQlSx0WZZLKtEExoH9esVcAq
 4KIg==
X-Gm-Message-State: APjAAAW6kswogD1Jt8WZO4MLWML/Lp9hWDisvK4vC/1T97srcats9XUr
 ILLMlpoMPwqDEY4pYFXPOjZIM/xF2aVWZAE8Mv5qwRf5MWcXEG4ThjDMnNQzxsLbiJ/DGCq9Dcw
 /dm2O+Uzs6vKhLwo=
X-Received: by 2002:adf:f484:: with SMTP id l4mr30389306wro.207.1582033233382; 
 Tue, 18 Feb 2020 05:40:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqya1N68l1Jcrj/plfPbJh1E16qW4thQMXiqOE37ImS2OgtY/A0RxcobfzBcLuHezxTeiPpPNg==
X-Received: by 2002:adf:f484:: with SMTP id l4mr30389284wro.207.1582033233223; 
 Tue, 18 Feb 2020 05:40:33 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a9sm6236443wrn.3.2020.02.18.05.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 05:40:32 -0800 (PST)
Subject: Re: [PATCH 0/3] travis-ci: Improve OSX coverage
To: qemu-devel@nongnu.org
References: <20200218133755.26400-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <47de3e95-db96-694a-8baf-5afdb9f141ac@redhat.com>
Date: Tue, 18 Feb 2020 14:40:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218133755.26400-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: bvIB9TJ0O8eK90Ky4jePVg-1
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 2:37 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add more packages on the Mojave OSX job (Xcode 10),
> and duplicate the job to build on Catalina (Xcode 11).
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

Series killed again...

   $ git publish
   Sent [PATCH 0/3] travis-ci: Improve OSX coverage
   Sent [PATCH 1/3] .travis.yml: Expand OSX code coverage
   4.3.0 Temporary System Problem.  Try again later (10).=20
c13sm6377395wrn.46 - gsmtp


