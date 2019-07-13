Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7758BC742D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 15:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D71D20830
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 15:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D71D20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmJXj-0006Pg-QX
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 11:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmJXW-000612-BJ
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmJXM-0003FI-BZ
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:02:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmJXC-0002rA-3F
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:02:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so11151901wme.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 08:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pNTcqyOPquY+hS25yXG47H1KC2X2Jv4tteHhZC1XHuk=;
 b=FVfFU2NTP77gV+lsajMWTidoUHmtSh+4DWOCLakLDgLS0IiKymKEEHnMg/IuJ2gx/k
 NSv+39W9FMSW5hmtujrp+oS7Rl6KvjipmYcIGUOhIvNIPJjaK/cNxzV2el64t8lOspRB
 N28CZS/YZ/zOz+xrfHWjLb6S0jTyzhh/ZiTwdfozZbRKVpSJT8I4IPcMTRpOf3KtMOSI
 cFcJ/hUEgximeHnEy4z1ejLeySbKldHmqwfLNOdDbVB5HVLequI7YvKJ6dBAaOUzlcxg
 +2mdQcRU8oNJrrdD5gOZY88mUJHToodIk2O25PoaM0bX/NjeuaRRdVZ2dpAogB72tklh
 b8Xg==
X-Gm-Message-State: APjAAAVEsW2bT7FiOpYBC5mWh/6nm9iOKTqEa6wVHDYdhNxXAXChDnqQ
 X5woTD0xClAEpb+34IJ4eTzqZR1hOB0=
X-Google-Smtp-Source: APXvYqwFEv+qPIqLNuvF8zd1IKHtP2g+oSPjYDai7op73yofYf71/6CH+UIcIi4kYALUD+v1++lTwQ==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr15944137wmc.154.1563030080690; 
 Sat, 13 Jul 2019 08:01:20 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id j17sm10204442wrb.35.2019.07.13.08.01.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 13 Jul 2019 08:01:20 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190712111849.9006-1-alex.bennee@linaro.org>
 <20190712111849.9006-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <18c04017-7908-c4d1-5414-cae79ba82fc3@redhat.com>
Date: Sat, 13 Jul 2019 17:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712111849.9006-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v1 7/7] shippable: re-enable the windows
 cross builds
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
Cc: Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 1:18 PM, Alex Bennée wrote:
> The pkg.mxe.cc repo has been restored.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .shippable.yml | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/.shippable.yml b/.shippable.yml
> index f2ffef21d11..f74a3de3ffd 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -7,11 +7,10 @@ env:
>    matrix:
>      - IMAGE=debian-amd64
>        TARGET_LIST=x86_64-softmmu,x86_64-linux-user
> -    # currently disabled as the mxe.cc repos are down
> -    # - IMAGE=debian-win32-cross
> -    #   TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
> -    # - IMAGE=debian-win64-cross
> -    #   TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
> +    - IMAGE=debian-win32-cross
> +      TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
> +    - IMAGE=debian-win64-cross
> +      TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
>      - IMAGE=debian-armel-cross
>        TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
>      - IMAGE=debian-armhf-cross
> 

Builds now take ~25min longer. The win32 build is definitively helpful
and should catch most of the errors the win64 could find. I suggest we
build the docker image but not cross-compile on win64. Anyway this can
be improved later.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

