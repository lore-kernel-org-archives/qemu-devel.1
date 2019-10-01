Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7BDC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6650920842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6650920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIld-0008VD-B7
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFIj7-0006IT-49
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFIj5-000604-SZ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:02:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFIj5-0005zZ-MZ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:02:03 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB09110B78
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 14:02:02 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id i15so6031969wrx.12
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 07:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gF6sUf0oxP8/XWEBIJxMyY0QTyr1DP3aLoGgm1yr+Oo=;
 b=FcLwhlJVcRt+Vg/C1J/q0RyM/rPuuaUE11YrfeCe1OKGaMhS5c3x/CEnkaHPM2g6Tu
 K+nC+Hn+tRuviEo3voQkKQpBows4P1hdl/jN1+46QXkCNAjes6PX4FMgz8H6dJNdnm/2
 qknMO1foxu79bayYRTJ0To/QyeDjTBYMrcZmET61j0IneSM8Oyro6arMnLGuoeuJG9WN
 pYWmCaqM/8kRX9OEzoW5utv/EpFn4mttNTnmKsbF32TSl5ozv7CuK2Pj1+cuM3QiXQoK
 Iwge2aCgdEgI2v588Dg5iD4E742iaJ9XHmEe2gNBdgBcJhdI9StYMHvX9SfFiwX4CyXF
 loBA==
X-Gm-Message-State: APjAAAUx/t4k28/OTaCuJpeukITK+oe0Z1ocmF7rUMaNC1cbBTEbxwkE
 BGPU5YLRTY3ClNA9KD2nF4pRW6hAYxM4UZxhL/sgxrrTwV1b3VgU4Hl/bjFjj/84yPlNXnbh+Ne
 9eyLGY8zNqSa8x5k=
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr1187942wrn.249.1569938521145; 
 Tue, 01 Oct 2019 07:02:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHx2vvLLFaIWnnvaLrb8z82RJV4hxWy5iYCWX8+nYNqVRXJaNVEaJEfM6j1YAWNTeEhkYGiA==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr1187926wrn.249.1569938520999; 
 Tue, 01 Oct 2019 07:02:00 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a18sm24467067wrh.25.2019.10.01.07.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 07:02:00 -0700 (PDT)
Subject: Re: [PATCH 2/8] microblaze: fix leak of fdevice tree blob
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
 <1569936988-635-3-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5948b4bd-e7cb-bcdb-1666-8b0edb7a2be0@redhat.com>
Date: Tue, 1 Oct 2019 16:01:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569936988-635-3-git-send-email-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 3:36 PM, Paolo Bonzini wrote:
> The device tree blob returned by load_device_tree is malloced.
> Free it before returning.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/microblaze/boot.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
> index bade4d2..d1d7dfb 100644
> --- a/hw/microblaze/boot.c
> +++ b/hw/microblaze/boot.c
> @@ -100,6 +100,7 @@ static int microblaze_load_dtb(hwaddr addr,
>       }
>  =20
>       cpu_physical_memory_write(addr, fdt, fdt_size);
> +    g_free(fdt);
>       return fdt_size;
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

