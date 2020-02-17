Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F94C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC89F20725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKDCf8Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC89F20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3e9x-0000Aw-Vk
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3e9D-00089V-9B
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3e9C-0001H9-83
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:01:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3e9C-0001GG-4X
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581937265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7+NfogcZkANHG0yhuVlYms+OusxjIqCDYMd6/KQgW4=;
 b=SKDCf8PiII3lSovDkMX1HQZ5xKrQjUsSbj26eU/6mbKtQu5Xym5xO/tBQZufpyac4DkT5x
 3A8B/kWB+XZueEpzPn42FafCnQRgmqvtukQDxgHPj6low0gyRFzy9hxWn72MAO/o2SidHR
 zLuuSIsUdb/kgzyS5S5cwrXYEXaJrZg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-kztJqnr3OTKFN6JbPsmOqw-1; Mon, 17 Feb 2020 06:00:57 -0500
Received: by mail-wr1-f71.google.com with SMTP id m15so8696873wrs.22
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 03:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xnhDSewh6JRTbai6G1JghRrla7NaILareloMuVFI7tM=;
 b=qwuN8+i0espxYZy1Qvj27rHoqixqd51UUZzmyGLn6b5JinD4tUcexzndeIrWXUDz15
 5xvs77G7CLRtZciKZSOdG3oaVgOLVEVgJITbLLOMWQN3cw8XBYUbb1QhAdipKgxESlh4
 mmvKpK/g8g1xKwrVcEyZqsVA+Y9LDlHYnJSvKpOq7axmFteQOMilVMm7vf0grL8xKChL
 LjJunqQ8k61+uZ2vIIdPK8o781aLCkV5XbXa5pEBwTGjq0Wd8FAm48TVsqCzs7/AwqX8
 NLjEuTlaA7C3Pt1EOLC9oZEz9G28Cv+0MiVU9mBLGa19x5nKfxrOamqZv2Qx6MQ9gSvX
 hP8A==
X-Gm-Message-State: APjAAAVtrGmX8Xo9hfIqZctjt9qOnxjRZWWRxMVGWlgR3BpHWXhKx2JU
 v9yLpxb+be9XvqtWDKjh62AwsJ76rA3u8CAm53Cxnn5QpQsIIuuWB+4gdLPTi0lmrINzIxsPWtO
 JAS2Ll/J1jvlILDQ=
X-Received: by 2002:a1c:490b:: with SMTP id w11mr20642762wma.96.1581937256248; 
 Mon, 17 Feb 2020 03:00:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKWhhrpO3nG79z2aKjyR9hZZcMVMmgRg0dM9gZ/0Lxjt/waG3F6+DqmqxPPFsrSN3Ns+OzlQ==
X-Received: by 2002:a1c:490b:: with SMTP id w11mr20642739wma.96.1581937256008; 
 Mon, 17 Feb 2020 03:00:56 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id j65sm143476wmb.21.2020.02.17.03.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 03:00:55 -0800 (PST)
Subject: Re: [PATCH 2/4] tcg: Tidy tcg-runtime-gvec.c types
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200217025957.12031-1-richard.henderson@linaro.org>
 <20200217025957.12031-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <73641276-cbcd-83ae-98a9-8a9c4eba0cef@redhat.com>
Date: Mon, 17 Feb 2020 12:00:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217025957.12031-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: kztJqnr3OTKFN6JbPsmOqw-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 3:59 AM, Richard Henderson wrote:
> Partial cleanup from the CONFIG_VECTOR16 removal.
> Replace the vec* types with their scalar expansions.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime-gvec.c | 270 +++++++++++++++++------------------
>   1 file changed, 130 insertions(+), 140 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


