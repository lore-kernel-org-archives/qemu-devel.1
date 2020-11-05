Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC904C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 10:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899CB206E3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 10:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBN0PfaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899CB206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kacev-000185-Fe
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 05:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kacdi-0000Y7-Eo
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 05:37:10 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kacdg-0006Y9-Kx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 05:37:10 -0500
Received: by mail-wr1-x442.google.com with SMTP id e6so1152981wro.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 02:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dbwsPypmmUiKjy7BxOBscuZfezC/mOC0uTFc2KwwLI8=;
 b=wBN0PfaNnsPa1ijlzNlj0EJA9gcx3sGNczEeNzY9tQWa0YZOsmv1Aa6LYtuJH7Tjcx
 jPZYc3MQ+H73HmIH3s07oK+kJBP5RWoQKfOd9wI+CvOqC1hcsSR4tr4Lcv5Xs5vpWf4+
 XIPjRyyXRcoWTyiLDEaYepvtzPCQbJXGTtOCAFgx5xNL/0e828c3f92LeheWyiRWNfDn
 fYWaaVo02fIWMcaQ8kGelmSYnG+Tc+bfQkJN+wzAqRYdQdjl65nvuj6fGQ8UcbIKIC8H
 5b0rNT8NX3HrmHfj1kugUFeNqbv4aZ8C1fpk5IV4zNKlZxI49xEC3n0h90jjEx8sVJM+
 W4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dbwsPypmmUiKjy7BxOBscuZfezC/mOC0uTFc2KwwLI8=;
 b=O10sL4Dm+KPeFqwzD4z6OhOOgqR3ky+FskQRVyQerAW5TSdz0PmR/B23IGRwxXbLrQ
 9hR3geSIF9xgcM2KmOjad5nr3hCVk14MgyDw6H5gJ8Ry7TKJ2HZx8JYd0RSH4XmPxPxv
 qJ8GOWeEVCmH6TvwDAQFr3H755a43IXtwOjmdH8Sn9rVX12iIFSzxtx0BNSvrAR5EMtf
 B5rh/ZcTU12CghkzIMHj9CKM+uObe08iTvOsyPjiaHmeU1JH8TwWCgkl41SdOz6S8q10
 DKlg8i/acvK5Iw/UGV2z9PULalTHEHSNyGMeX38nUKK4pWV+dhKZ780p8g6BTpigrGqa
 859Q==
X-Gm-Message-State: AOAM533IUOzSTpdWYz90qT9KSLqanNUm5Pu5R0JhYdJHmwj9WpIV/Z0i
 LA7LBLJm9q64XEktwstvJmFZ8Q==
X-Google-Smtp-Source: ABdhPJxi7T/2JRVVAwEZo5qR3+iSWBVoENKOTuFPkJgBhCV+QFwKd8VzV4viqP4jhhMd4yT3umuwXQ==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr2026644wrj.328.1604572626707; 
 Thu, 05 Nov 2020 02:37:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c64sm1940276wmd.41.2020.11.05.02.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 02:37:05 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 91D051FF7E;
 Thu,  5 Nov 2020 10:37:04 +0000 (GMT)
References: <5F9975E7.6030509@huawei.com> <5FA3A17C.30108@huawei.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: AlexChen <alex.chen@huawei.com>
Subject: Re: [PATCH 1/2] plugins: Fix resource leak in connect_socket()
In-reply-to: <5FA3A17C.30108@huawei.com>
Date: Thu, 05 Nov 2020 10:37:04 +0000
Message-ID: <87ft5oay3z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org, mjt@tls.msk.ru,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 zhengchuan@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


AlexChen <alex.chen@huawei.com> writes:

> Kindly ping.

Ahh sorry I missed these. Was there a cover letter for the series?

>
> On 2020/10/28 21:45, AlexChen wrote:
>> Close the fd when connect() fails.
>>=20
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: AlexChen <alex.chen@huawei.com>
>> ---
>>  contrib/plugins/lockstep.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
>> index a696673dff..319bd44b83 100644
>> --- a/contrib/plugins/lockstep.c
>> +++ b/contrib/plugins/lockstep.c
>> @@ -292,6 +292,7 @@ static bool connect_socket(const char *path)
>>=20
>>      if (connect(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0=
) {
>>          perror("failed to connect");
>> +        close(fd);
>>          return false;
>>      }
>>=20


--=20
Alex Benn=C3=A9e

