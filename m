Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F6DC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C7920736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGOrBash"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C7920736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiT1-000297-4L
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiRj-00012C-Pp
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiRj-0007yP-5U
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:27:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44369
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiRi-0007y8-Ce
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQct0pwx3JfGqar2KIqYJDVyz6Fj01QYnz9MGugPYcc=;
 b=WGOrBashJjI6yiziqVHqIytidPaPSbo3eMJFoVRtOrAH9o2RjC3qKfHyuf5RTndUStoorM
 JVGCk7JNWyaLeEMLazt404mfVxpRJiib4SPuOXGw1Ob3EduNZQo56wr6g1WsqK7zNT8eXk
 c3lpFBivrD+Xc2ZSlFgDLmsM9nhtlOQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-G7S2rl2cPEWcNQ-NYjBYGg-1; Thu, 23 Apr 2020 16:27:39 -0400
X-MC-Unique: G7S2rl2cPEWcNQ-NYjBYGg-1
Received: by mail-wr1-f72.google.com with SMTP id x15so3428006wrn.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y0v4wJNHMwTtP9V72XYJxG2CitATSXoE85yjjnLIW3w=;
 b=sdzQ5K+D2tmD5UewuUymTq0L6vWHSf2fI7xPUwiEadboXcxvjfP1LvUyssInMpDY6P
 ihlaqrFfWVEN8Hz0+Yh+ifciQNLxndw1lcmW++LiOV4duLulVdI+WiyR8FianxI9onTa
 09/KqqM9BTxksvGkf/51H0PCiPU0exFflxDYfXV9RBtzYKhf9StFMQDaBpgd1+/7jAe4
 LZgSYh3DAuKGFoC0fF+Ta4uUtSeJKKWmwFjY8pSl6h/gQjE36/Er1zQuMka6+g60dJeP
 shlN7R3c1tOCFzoINLkk9RwftudLoThFL2iUR3V8PM3p6PnD0q3ki8fEWQj6h3hRl6mK
 NeEg==
X-Gm-Message-State: AGi0PuYWNO/9L7uYHxjrWavZ8tUNilFUsCyXRJV/74ZmP6yqF8jpnoxD
 Zq3VwCg03R1iiskiLva+KbE/YqpF93QomE4B2vAbb6U07Um7nlR4Uqh5GkICxlce8RdvU71vkum
 dRmX801+k9IuHpEM=
X-Received: by 2002:a7b:c858:: with SMTP id c24mr6339753wml.51.1587673658000; 
 Thu, 23 Apr 2020 13:27:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfvC17Jb8r/3aZrankHxqTYcUDoeGYqGCIMzZgw22qswndHtlpAwslGaibQrEB9GAKog/3Lg==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr6339732wml.51.1587673657786; 
 Thu, 23 Apr 2020 13:27:37 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s9sm5653186wrg.27.2020.04.23.13.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 13:27:37 -0700 (PDT)
Subject: Re: [PATCH v1 13/14] .travis.yml: show free disk space at end of run
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200423170557.31106-1-alex.bennee@linaro.org>
 <20200423170557.31106-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2288595c-d747-c076-875a-7934f292fbc2@redhat.com>
Date: Thu, 23 Apr 2020 22:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200423170557.31106-14-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 16:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 7:05 PM, Alex Benn=C3=A9e wrote:
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

Well, I suppose it helps to realize we didn't break the runner, it was=20
already dying...

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>     - if command -v ccache ; then ccache --show-stats ; fi
>  =20
>  =20
>=20


