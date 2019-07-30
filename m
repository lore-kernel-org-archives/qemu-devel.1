Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32627C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0635F20693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0635F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRVB-000458-Ax
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38342)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsRUj-0003eM-Kj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsRUi-00016G-GF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:44:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsRUi-000160-A5
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:44:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so45242533wme.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 05:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Kic34jwrMRJKNGGyXXNdWGTyizjP/+FUol/smm5bpE=;
 b=H/qLv+3gxBRelDt4Iy6Fq6LmKK1baHAIZ9I/NetgzTcv6svW4UT6eeEw72ss/ZtSHU
 kusVCoVCvPF8gIEE870IHCNZOhtwio+99jX9Brn4mAZ+9V7XxDVIZEiDUMpdk+iehKA8
 uot1giKMIhOPvJuRA3QSlgotlyigfc7lD0CyUCRgX9J9IJO4bm9uzI+qFJ7BdZQfsopO
 Vq9+rrW47oHfiwJq+KaobLumiPV8x0bQIozkdBSQfdqfHrhA7HwcCHxKL2WeX40/hgnK
 FJ1QHXEggRt4PY7njN2smxSQtT3u+7iMnuVg8sQ52PCfz/vS5ZiBt0/6YL7sRtgGCEXz
 LBXg==
X-Gm-Message-State: APjAAAVI3Zmys/ZACtSehWTQloStWBcg08IyrX5u4LSTJiGAmSqUItcp
 2m7Mw1t3Eb+YtdbxVnYYP/dLhw==
X-Google-Smtp-Source: APXvYqwAkljziPW6Sx72sIC2X5NZvAxm8HIUzwOabItB/TBtDoTjCK9zTHm62qEDio2G+bek0Ycdcw==
X-Received: by 2002:a1c:ac81:: with SMTP id
 v123mr108066365wme.145.1564490682750; 
 Tue, 30 Jul 2019 05:44:42 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id t6sm70391269wmb.29.2019.07.30.05.44.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 05:44:42 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <20190730123759.21723-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ed8416f5-852c-872c-eb05-8850a6aa216d@redhat.com>
Date: Tue, 30 Jul 2019 14:44:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190730123759.21723-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/tcg: cleanup Makefile inclusions
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/19 2:37 PM, Paolo Bonzini wrote:
[...]
> Drop the usage of TARGET_BASE_ARCH, which is ignored by everything except
> x86_64 and aarch64.  Fix x86 tests by using -cpu max and, while
> at it, standardize on QEMU_OPTS for aarch64 tests too.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> --- a/tests/tcg/Makefile.include
> +++ b/tests/tcg/Makefile.qemu
> @@ -2,20 +2,23 @@
>  #
>  # TCG tests (per-target rules)
>  #
> -# This Makefile fragment is included from the per-target
> -# Makefile.target so will be invoked for each linux-user program we
> -# build. We have two options for compiling, either using a configured
> -# guest compiler or calling one of our docker images to do it for us.
> +# This Makefile fragment is included from the build-tcg target, once
> +# for each target we build. We have two options for compiling, either
> +# using a configured guest compiler or calling one of our docker images
> +# to do it for us.
>  #
>  
>  # The per ARCH makefile, if it exists, holds extra information about
>  # useful docker images or alternative compiler flags.
>  
> --include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
> --include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
> +include $(TARGET_DIR)config-target.mak
> +include $(SRC_PATH)/rules.mak
> +include $(wildcard \
> +	$(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include \
> +	$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include)
>  

It is still used here... Else we could clean ./configure way more.

