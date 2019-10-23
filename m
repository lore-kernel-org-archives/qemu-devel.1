Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D66BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14C32086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14C32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFYx-0003WO-Qm
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNFWy-0002ZL-Tb
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNFWw-0000SI-5r
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:14:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNFWw-0000R6-0D
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:14:22 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA185C056808
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 12:14:20 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v7so8958930wrf.4
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 05:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dEij+SvigyC3yn1CUgby1y1pvbIfyJud3/tGu/K0MDw=;
 b=qvl1Fyg7nOXxavfkPgLMYWqBf4GIe7a5EF7cLoUWSPC6uS8c6HV1OpvPnDdybbWvwJ
 nn0XaBi3DkdQPDkN8ljEm+75OGO+qhcp4yE/iZKHkV9ZlcxmxYj+7X53p1qEYAuVIx48
 v0BAHZX/v0U2Spg7ckjLLqxH2PZiHScNT3GVVeGTzGutlOV1pM9plbztQF4ZHGaGouvL
 BGiJ9PuxmxsVIlKtPfLUrGlsUWvFfiac+Ohn5ICQJorA3Wd73RREzhwBwCH4iJA9wq3U
 i1qKpmU9Bl7MnuSTqj2sq8z2mNTfyrtZu68WAe33NnqvcVYU3YQLWDyPrIeq7AvL3uXB
 vCtA==
X-Gm-Message-State: APjAAAUXCiC9PXxGH0G+1veEbCICq5ZvILLf/F+J4a0MGlOy/67ETxbA
 0KUXmM2ltqzw9Uyd6E1IIC7QijYCSor3UMAQkFOhDLCaY59Ute1VGTstDoTrQ/w2uqMrkTnBANe
 f1spTY3Opa88MAUI=
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr7534882wmc.128.1571832859417; 
 Wed, 23 Oct 2019 05:14:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzt62MaXqNdgKvc08o6r5HgbiW1x2x3lpoFOE7gpRLNAj+21meigcVgYkkhf4AsDMGPruGNwQ==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr7534861wmc.128.1571832859215; 
 Wed, 23 Oct 2019 05:14:19 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x2sm20412678wrn.81.2019.10.23.05.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 05:14:18 -0700 (PDT)
Subject: Re: [PATCH v1 13/19] travis.yml: cache the clang sanitizer build
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191022191704.6134-1-alex.bennee@linaro.org>
 <20191022191704.6134-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <19a22c53-aada-6e45-313a-2b8b317fb7cb@redhat.com>
Date: Wed, 23 Oct 2019 14:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022191704.6134-14-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 9:16 PM, Alex Benn=C3=A9e wrote:
> Hopefully we'll see the same benefits as the other builds.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index da6a2063fca..c43597f1331 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -189,6 +189,7 @@ matrix:
>  =20
>       - env:
>           - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS} "
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-sanitize"
>         compiler: clang
>         before_script:
>           - ./configure ${CONFIG} --extra-cflags=3D"-fsanitize=3Dundefi=
ned -Werror" || { cat config.log && exit 1; }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

