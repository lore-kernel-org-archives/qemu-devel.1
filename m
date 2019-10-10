Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F3C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D69206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D69206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWS2-0002yy-JG
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIWQu-0002TU-7i
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIWQr-0005zw-Ul
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:16:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIWQr-0005wu-Oo
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:16:33 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC32D83F3D
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:16:30 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id w8so2617654wrm.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2MH5h46mPvBMjw+J5NAtEdBomg2sKQwi9/FAKuvHKUk=;
 b=ha2HxItUD2CjebllvbEWtzEDoM8Kp40wC8vfam4QEiZcFVy+x9TDChRoa4BHGV8mVO
 ffY05h+kxj49OXmt2Qoi1/GIXia7yhnBcH+qFdBYRx4c2mPW8W6LnnqcF4K0xjeRZdcj
 3Wd1aWpBjreVfi8CY+Gy4aPTrTfDQY05t/x3tydC2XA3QywhDGCiwdITccuuW2ZQiIc4
 qvPkKJe+WYGfjKUQgICNxcboNME629VU7brFG5Fb6VdnnMBV9CM6UwooDSozIy6Lr6a+
 NMQlue4Tzs4qraja1s+wzuvF6G/2w+7oZgN3von3CYyaSJIbqOlak6sQscDRoPgS3PZi
 XsEA==
X-Gm-Message-State: APjAAAX7hHuUeDxbkykTuLPiQBU6tkfhF6uEoE6tbMRDPhs73TyM/B9x
 V8Qerj8FoErYxRAJjMw1l9lO8F/wGsr4VgcUp9LwTDCCzNt08kh7WE1qNYxTORso9c1Jiu2Esfq
 x+CeRxQCCabYKCmw=
X-Received: by 2002:a7b:cd19:: with SMTP id f25mr7493137wmj.154.1570706189755; 
 Thu, 10 Oct 2019 04:16:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyuTWqccaPFILS2rChNDMayA3N1UyHJWbS0TgiPzYUOR1zyv2Yzb6hc5bBOVpjOjSJ6ZgNMIg==
X-Received: by 2002:a7b:cd19:: with SMTP id f25mr7493121wmj.154.1570706189525; 
 Thu, 10 Oct 2019 04:16:29 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o70sm7424031wme.29.2019.10.10.04.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 04:16:28 -0700 (PDT)
Subject: Re: [PATCH 4/5] travis.yml: Fix the ccache lines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191009170701.14756-1-thuth@redhat.com>
 <20191009170701.14756-5-thuth@redhat.com>
 <910285f7-d470-cf0b-85b2-a2264cf23ea3@redhat.com>
 <1ab2f569-a256-9627-0725-e54f52ce8c81@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <815ae506-7dec-52c4-0401-d48fb884b3e0@redhat.com>
Date: Thu, 10 Oct 2019 13:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1ab2f569-a256-9627-0725-e54f52ce8c81@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 11:38 AM, Thomas Huth wrote:
> On 09/10/2019 21.04, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/9/19 7:07 PM, Thomas Huth wrote:
>>> The "command -v ccache && ccache ..." likely were supposed to test
>>> the availability of ccache before running the program. But this
>>> shell construct causes Travis to abort if ccache is not available.
>>
>> Oops.
>>
>> Why can't you install ccache if these are Ubuntu systems?
>> It is even more wanted if the arm64 machine are slow...
>=20
> I just tried to add "ccache" to the list of packages that should be
> installed, but I don't see a difference in the runtime.
>=20
> First run with ccache enabled:
>=20
>   https://travis-ci.com/huth/qemu/jobs/244117945
>=20
> Second run where I'd expect a speedup:
>=20
>   https://travis-ci.com/huth/qemu/jobs/244124599
>=20
> The statistics at the end say that it had only 1 cache hit. Any ideas
> what might be wrong here?

Looking there and your following commit=20
(https://github.com/huth/qemu/commit/eaf80e7851) I see you already=20
figured this out :)

