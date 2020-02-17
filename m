Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147DFC7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B8820725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpxjVrJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B8820725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eBg-0001o0-1E
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3eAf-0000k1-D3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3eAe-0003z7-Ft
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:02:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3eAe-0003yk-CT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581937356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9WzfzgZGiEmI8o2jdBf4qLIbCBGrM3Lo6DD7WFUjfs=;
 b=OpxjVrJwS+Oeoxqz7jzMqJBoWv0fFHscI7G2UhKzP08DnXWxoRq+rmQ35qPeaSiUfIAY9K
 yNtrvnbsPa9Xf0eqArjwLmeodhVajGpxIwhWscrw0htCDS+KhoJTWYz/dNtQE6DKz7YMfb
 7H93CZI3V9kqxI60VQHF4RjSDe7LAjM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-GO6gDrMTNgG1AmjP2J8K3w-1; Mon, 17 Feb 2020 06:02:34 -0500
Received: by mail-wr1-f70.google.com with SMTP id t6so8792387wru.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 03:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1lQLOyUOq+vn6pWM9ROP5qYmr26dkzfMlswHdX1kYq4=;
 b=K8FEwGtBe10p3JVpFzFuO/nCxYv2MasqObIay+ZQygNxaXpIssjOxNMyYj1MGa418i
 84XItPyttfrwP75V12O56Feyd9x6iTuEwC39VAyI+6AuqMZsLQUFzwYh34zRGZCdw/5a
 8xJGH5PSKUkBjjw1xIkpCkCfzxMZubYB1qri6DVyzlgCgHWfUqra0NIZCCvJTxWKSRwd
 H4N8I1X4bsRdWge0SB2g9sXfG0EREbcwr0unJ5RoM4dDtpbdyZCLcmAg9aQtFuKqoYOc
 GsEyRjGFPA8jl38n2l+lPGsu0B+TX95zNDivn65BmzerzqkP/2V2vZ5jCYP1lKU6sOa/
 l3tg==
X-Gm-Message-State: APjAAAVl0Myr62ygv2xGq3Tqc8ecFFqGlV/YZPyb7LJktRybJ2nwCGma
 XXEWd6lqZsA8qUlCjTtA8tGiyjJ1oxwmAouDk03ocMPDY7uMkTNbo21SvV6w1JFJEJ2nRz0TbcR
 ADoU7LGenEKh2+wE=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr22662797wrn.124.1581937352038; 
 Mon, 17 Feb 2020 03:02:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwawVswcKCMyVKlk6bUVQYFFVpS/HBWvtWbkH3TPhFLFvGJfkUPPXM3ScbgeSCDQCtumav0tw==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr22662782wrn.124.1581937351896; 
 Mon, 17 Feb 2020 03:02:31 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g25sm29629743wmh.3.2020.02.17.03.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 03:02:31 -0800 (PST)
Subject: Re: [PATCH 3/4] tcg: Tidy tcg-runtime-gvec.c DUP*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200217025957.12031-1-richard.henderson@linaro.org>
 <20200217025957.12031-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <67a254b8-3fe0-8e30-100d-dc2cc7e762cd@redhat.com>
Date: Mon, 17 Feb 2020 12:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217025957.12031-4-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: GO6gDrMTNgG1AmjP2J8K3w-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 3:59 AM, Richard Henderson wrote:
> Partial cleanup from the CONFIG_VECTOR16 removal.
> Replace the DUP* expansions with the scalar argument.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime-gvec.c | 50 +++++++++++-------------------------
>   1 file changed, 15 insertions(+), 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


