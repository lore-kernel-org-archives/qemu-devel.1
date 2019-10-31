Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB78FCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9110C2087F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9110C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQBGU-0002m4-KR
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 10:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQB6a-0004Mc-5S
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQB6Y-0002ep-W7
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:07:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQB6Y-0002bh-Q1
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:07:14 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1A995C5
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 14:07:13 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id f8so571718wrq.6
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 07:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tgXzP2hh55ZnXngXoY2LDwrNgo5s8cHfbgK5/wSrCus=;
 b=PUFhU/DO9rDmWgNlbo92yMdbrTCC3jCFEDwdn31sKJhRcr+ZTp0jylrUDE34b2umHk
 4jaeOpCa4I+smgk+NJtOAwniYg/Xyg6emvTguUEuxw+Ce9etda/0/DlEdPXXfcpxSYWS
 7rXt3eisvSsShAukh1Q1pborkhOP/BxFmZqNqQa8umrgWy1JzTlgFIUfcVGKPQU8Be7j
 AX+du1M79zZ/iOBZrwk/CAviNARiKsVFiGXH5e+Q3wDKgXhtg0r2m4CPxVuribMgUD0w
 01cp/YnY80h3USZ8+5ytieaGk24qYUrNfSHdQTPgeVXawSQz967L6Vx9sinp5vpnCraa
 /e4A==
X-Gm-Message-State: APjAAAXQJz3Fnc8jYyJrYiQEaOFphRXA3E9iTga8cKSPSYNDCb7yI41t
 B16WGhOrTvZZmy6+RfVOBb46oSz3H57jQivulVKAvFo6UWlvn2aJGTWoIa7wCKDOBn4o4HwarCG
 gUd4hHaFsVZcOeWI=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr1173833wru.52.1572530832240;
 Thu, 31 Oct 2019 07:07:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwDTgWlDj66qEqDDB9s4jeHsGyB4NEPbeWyMdGT/8vppEJSEgqNB1NVUUK2yEr7risMxQHqGg==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr1173817wru.52.1572530832074;
 Thu, 31 Oct 2019 07:07:12 -0700 (PDT)
Received: from [172.20.51.145] ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id t134sm4073073wmt.24.2019.10.31.07.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2019 07:07:11 -0700 (PDT)
Subject: Re: [PATCH v6 4/4] tests/vm: update netbsd to version 8.1
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20191031085306.28888-1-kraxel@redhat.com>
 <20191031085306.28888-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8e4ef5c2-f80f-35da-f843-a26649d0ceb9@redhat.com>
Date: Thu, 31 Oct 2019 15:07:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031085306.28888-5-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

On 10/31/19 9:53 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/vm/netbsd | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index d1bccccfd0..33779402dd 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -22,7 +22,7 @@ class NetBSDVM(basevm.BaseVM):
>       name =3D "netbsd"
>       arch =3D "x86_64"
>  =20
> -    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetB=
SD-8.0-amd64.iso"
> +    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.1/images/NetB=
SD-8.1-amd64.iso"
>       size =3D "20G"
>       pkgs =3D [
>           # tools
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

