Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655F6C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE4E2051A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3plIFcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE4E2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUUdq-0003nh-5C
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUd5-0003Bk-Ff
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUd3-0001Cp-Vw
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:18:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35023
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jUUd3-00017X-FS
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588335531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+mZ9AqPrrVunWNOjxXjmV0VoqxHBUxkv1IUrcPz8Bw=;
 b=H3plIFcSZVsYsJg1BqcM/ik0DI90hL27LYIMF0u7XzlH3kT3K+RsPUHIXi3U3QN6gPVrvG
 A0aWrJvvC8FXd7Ic/agxmKFQ+MOTpvA84oHXecYxRepxP0ZPp4XEbGfzX6vAZfmHSUGTKp
 5o2nODtIItNCc86q6aDTQa5L83fWzpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Is_CC28EMTWwOV7BzCTUUA-1; Fri, 01 May 2020 08:18:47 -0400
X-MC-Unique: Is_CC28EMTWwOV7BzCTUUA-1
Received: by mail-wm1-f71.google.com with SMTP id j5so2598495wmi.4
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 05:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=amdxJJPHoEm7JjAVfwGFyTz//iiZ8LXBERaohBiRMaU=;
 b=Rx6B5I9lLgYHlnxMgxcey190No6fcoJBRTyM6OgRZyXNDrUu61omkN28+joPUB5urm
 KW1vkXwpdxaUoy431batTTIypiNtcgchkQV1grJezMyIiuLcc+WqCQnXB1NDTkx7Iqt9
 zx9XNH073G4MYHgIAiZWNT6/2Ng4AjxM7+9jqcq8dBfsecH5AuSO0/Pefg89OLzBmCgl
 AbGtM9bOMDCxw+HmNS/ir5I5P6sYbizkXr5BLrl6KoNW0SVQhlTrviBv5+j2d3dUqrL0
 acCX5BqVY4vXsR8NJngJLaq4oSJCU/m2qXTCVr8hG4o7Ht5qzxZOROc/I5+7oqIZRaKE
 icKA==
X-Gm-Message-State: AGi0PubUzNUT9HOcwF3sVRAjAuZvXnKucC4RUfaolFAo2O0i7ZnHqbzg
 UNd5SjgAZWmRAsN/FFnC9vRYVyY1fZ3Mj3/UwwrWeesv7lzFAozxpgK5hO9/ePGj5DRNf3eTGUF
 yLLsNDobcrXP6Yq4=
X-Received: by 2002:a1c:f312:: with SMTP id q18mr3716271wmq.175.1588335526295; 
 Fri, 01 May 2020 05:18:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypIc8gZRnEcUXSfePAasG4fkZOYI6AltclwmB+RH2X5i0aJtgCH0wB39E/iKloCnKZMQ4gQ+Ew==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr3716253wmq.175.1588335526056; 
 Fri, 01 May 2020 05:18:46 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id n2sm3987345wrt.33.2020.05.01.05.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 05:18:45 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] .travis.yml: show free disk space at end of run
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <690326b3-552e-af65-fbad-ff6ad52fef73@redhat.com>
Date: Fri, 1 May 2020 14:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200501111505.4225-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:18:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 1:15 PM, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 2fd63eceaa..a4c3c6c805 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -113,6 +113,7 @@ script:
>           $(exit $BUILD_RC);
>       fi
>   after_script:
> +  - df -h
>     - if command -v ccache ; then ccache --show-stats ; fi
>  =20
>  =20
>=20

Already reviewed:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg697747.html

Again:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


