Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EECC49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D1A208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D1A208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBbI4-0005GR-SI
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 05:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBbGW-0004JO-UI
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBbGV-00035A-Gl
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBbGV-00034s-8x
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:01:15 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 784622A09C5
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 09:01:14 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 190so2789581wme.4
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 02:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dt+vom0gNDHWDu70/V9CuYIRUR0+MmePEWJ3F1LY2Yk=;
 b=NGEwlUOP2KyMz3ItIcksYFlUdeGtO0vv0JWaDK3y6cL70FcB/9YuqBwh8XpNbTHPFQ
 PFx3q1+IwnUdwAlJxLBIEglw7Ffp9QNvac3oncobRC0RBzpuExF+lTt9vP5Xc+dEAN5r
 uzVY+H1YRSysivQCM8DAbW7q8m9lSxPE4GnJ4/SWXUMeeYTz6OolLE/1WHzSkYLHrcul
 ixBb1vzhbM6IYCcCWcduvyn0lnHWAE0xAzZUcy05pulhXqi1GFo7ZlPzsRIwKC71Mhld
 TbKLdBE6bNalBG7Y1ZuahGrapvLeHmrlREq6xhoTBYOmQrOrW1k6zLda4LiPFoMNSc8N
 UpcQ==
X-Gm-Message-State: APjAAAVTKR+04AeFPmvqylfhxAfHil3+W5EonB1/LlRxHL3slDClLV76
 GHNXm/g/IzoHNSbC8XnW8VwY5FUfuURJ0LRAVk872U4pJLtTbSzmqn7Yq7EcEappbIeGzNRpR1u
 VQ5FnA+XshyVTM0A=
X-Received: by 2002:a05:600c:254f:: with SMTP id
 e15mr6368750wma.163.1569056473216; 
 Sat, 21 Sep 2019 02:01:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcl2nrPV3n+hj5rdncsuCif1OkWgPQ88p4gmNy1URdJZ6r7CHc34+LRdDCdeFBZSblTO+loA==
X-Received: by 2002:a05:600c:254f:: with SMTP id
 e15mr6368742wma.163.1569056473057; 
 Sat, 21 Sep 2019 02:01:13 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id n1sm5172393wrg.67.2019.09.21.02.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 02:01:12 -0700 (PDT)
Subject: Re: [PATCH 4/7] exec: Restrict TARGET_PAGE_BITS_VARY assert to
 CONFIG_DEBUG_TCG
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190919232952.6382-1-richard.henderson@linaro.org>
 <20190919232952.6382-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fdf66be9-a070-22e7-f2f7-16cc2aea1d69@redhat.com>
Date: Sat, 21 Sep 2019 11:01:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919232952.6382-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 1:29 AM, Richard Henderson wrote:
> This reduces the size of a release build by about 10k.
> Noticably, within the tlb miss helpers.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index a53b761b48..b11ee1f711 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -215,7 +215,11 @@ typedef struct {
>      int bits;
>  } TargetPageBits;
>  extern const TargetPageBits target_page;
> -#define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bit=
s)
> +# ifdef CONFIG_DEBUG_TCG
> +#  define TARGET_PAGE_BITS (assert(target_page.decided), target_page.b=
its)
> +# else
> +#  define TARGET_PAGE_BITS target_page.bits
> +# endif
>  #else
>  #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
>  #endif
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

