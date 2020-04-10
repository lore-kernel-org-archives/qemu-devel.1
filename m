Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF0C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A822078E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6ud53dR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A822078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMrSM-0006uS-3s
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 07:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMrL2-0004EH-Dy
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMrL0-0003bT-Vw
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:56:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMrL0-0003ae-SC
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586516202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SaFtYGCjXLPfPjxDb7OB/4Vn7dtSugdx73n9Ucs8Y4=;
 b=L6ud53dRHoRbOLm5FednHZMSkroz8yh/THTcNWsv//+Kd5X5Nc4ajGLT/335QJl1e8U4/r
 vys++MpZDXng7YzKbluUxizO4EM+oG84AyG3QbU0UOFBSNmPUKDo4cHvvM0k/ddjmPyNlh
 iPJzOZI/Og+YvemcQeniZ+ZiR9g/W2E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-l1Pr6gpZOLWM1mRI3TF5bg-1; Fri, 10 Apr 2020 06:56:40 -0400
X-MC-Unique: l1Pr6gpZOLWM1mRI3TF5bg-1
Received: by mail-ed1-f71.google.com with SMTP id eb6so1803599edb.12
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 03:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BAVLweB6R5UwaGyQBJu7yfQgvnm8za2nkyZt9mVeWYE=;
 b=YpKlVNojqJX3MU+lbIWIGmQRC4nHH9g3w0r2iXlP9kisMDv67HqOBU2FkDwZSXkHHS
 YRORqP2TEf9ZN418mWH7B54DRwSvAp2Nyq7M9PaYWI67eBgvZIR+epLg19nKsaDm2QHT
 hehGMjJXO6FkWRmo767fVmR/IQBXePwJ1e/rLZhrnv8y780mKylYD5e4ThzmtrrlR88n
 oS2Wy4uf+X/wMXTz2nbAvtJOH+xPXGslWvVZRywqJv1mctqMHCI7k/w9MUrNHcEHS7Wb
 udj43Rv0vbENgj1yq4zWvfoYIPS37CqAZSbzUKFhmGzdIlkaW6yEwTTdfA4JJamKzfgB
 micg==
X-Gm-Message-State: AGi0PuaWqJ81RaYksTv/sBVyqQ7BlrI8uwcYVSxKihuj/HxHQqOTPAe+
 e2MtNe88zI2NOuVVRQJs+K0yvsjm7nRZuAPEvOg/UC3YwAr3pHJrLJbi2GEZyTe3J5961omxwp5
 hWv+268IQQVJEe7Y=
X-Received: by 2002:a17:906:258a:: with SMTP id
 m10mr3352837ejb.255.1586516198781; 
 Fri, 10 Apr 2020 03:56:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypLKtlm8WevB7UuTl5VX6UYddy9xxPEL7LAc1dnWycfUJcZKVBqxd2huxskK0dkwkwaOZ7vMAw==
X-Received: by 2002:a17:906:258a:: with SMTP id
 m10mr3352825ejb.255.1586516198590; 
 Fri, 10 Apr 2020 03:56:38 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w3sm98453ejf.21.2020.04.10.03.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 03:56:38 -0700 (PDT)
Subject: Re: [PATCH v1 06/11] configure: redirect sphinx-build check to
 config.log
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8c8e6a7-7c9e-4b9f-2e7c-3cc4135aec39@redhat.com>
Date: Fri, 10 Apr 2020 12:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-7-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:
> Otherwise it's hard to debug whats going on.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 233c671aaa9..a207cce82bc 100755
> --- a/configure
> +++ b/configure
> @@ -4936,7 +4936,7 @@ has_sphinx_build() {
>       # sphinx-build doesn't exist at all or if it is too old.
>       mkdir -p "$TMPDIR1/sphinx"
>       touch "$TMPDIR1/sphinx/index.rst"
> -    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$T=
MPDIR1/sphinx/out" >/dev/null 2>&1
> +    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$T=
MPDIR1/sphinx/out" >> config.log 2>&1
>   }
>  =20
>   # Check if tools are available to build documentation.
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


