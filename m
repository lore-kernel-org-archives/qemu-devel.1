Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0553CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8D92064A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8D92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45967 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfa2-0007Pz-6y
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNeEx-0002UK-NA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNeEw-00048z-Do
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNeEw-000483-85
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:37:26 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FB93C057F2C
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:37:24 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k10so3950892wrl.22
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cnruebhk2bEkaOp5RS8eQI4qOWVz71S4chgMKsYhcdk=;
 b=nHh3RxkEX8kKGSx3TKqvGOpS8/1/j2Z3sfHIdG8EWrFb/3MsQWfQgUMZk3fWu68gec
 u+z9pgB+xeW/U7QloMum8gTYxk3X3jhwiyP4gv89811vTGnDVrz8XaGVkgjIUwMRKb0f
 9ZFb5H35a2H/YzYbB13E9N7HYGbpj/jK1aN+dly4H2YhdooOPQ0BcN6gbkwovVNsB7rY
 Xe7PzSz1sEzWTbcItxdT47cE/OqIV+jzaHmCsfbcQeWQvTtQtHu8mmd0BV5QXISh6l15
 VPnmvU0DTuzdVbmrvyuyhHcuCga11YTzZN2KVtHJaEvFtkFSIp5DFNNBupVTcbZlGczy
 ZuIA==
X-Gm-Message-State: APjAAAWUVffAj0d7d1HGRDBJu4VVVg75HVc3S3g5mvdaelwQ7a4ZfOq5
 2Ypu/f3Ll1UBOVQ7pYVegUI2mID1IhkhfDZwAwKfsAwkPOXLjybR4+uOQknIpk0PcIwGAHnjIJe
 MRkmxL57wMYPODGw=
X-Received: by 2002:a7b:c7c8:: with SMTP id z8mr5244720wmk.29.1571927843066;
 Thu, 24 Oct 2019 07:37:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAfmemB4jOrWw1iM4fciFCtqZXBT7POXvWOXuZlu/kZIkkBwTi/zjcENYZnhXaYVzzWxv7vg==
X-Received: by 2002:a7b:c7c8:: with SMTP id z8mr5244694wmk.29.1571927842845;
 Thu, 24 Oct 2019 07:37:22 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id s14sm2858541wmh.18.2019.10.24.07.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:37:22 -0700 (PDT)
Subject: Re: [PATCH v2 02/17] travis.yml: Add libvdeplug-dev to compile-test
 net/vde.c
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191024102240.2778-1-alex.bennee@linaro.org>
 <20191024102240.2778-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c93b408-83a3-3358-b0a5-8e0666310510@redhat.com>
Date: Thu, 24 Oct 2019 16:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024102240.2778-3-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 12:22 PM, Alex Benn=C3=A9e wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> This library is needed to compile the VDE network backend.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20191009170701.14756-2-thuth@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 7d90b87540f..7be2a9949f5 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -46,6 +46,7 @@ addons:
>         - libssh-dev
>         - liburcu-dev
>         - libusb-1.0-0-dev
> +      - libvdeplug-dev
>         - libvte-2.91-dev
>         - sparse
>         - uuid-dev
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

