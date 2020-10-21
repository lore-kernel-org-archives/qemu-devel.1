Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD3FC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BEC22454
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4J9X+34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BEC22454
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVGp2-0005Nb-62
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVGmL-00044u-TM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:15:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVGmK-0003Aa-0v
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:15:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id y12so3746124wrp.6
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0p6R/xh9sq6v4kHBx5QB6Is0bNfQ/u+ywP0ESl/GvdM=;
 b=M4J9X+34/TzfwBI0KD/9uZyoRK1bvxkifGSTPlXZbX+ruZZVry66AA1mmtyz5hX1Z2
 JP4chLr03/uVZSerkHzeKBwSrBtq2WBZGafLoyonHeAZBnt2f2OYaoJz5yja2CyYRVy2
 8LIq8yciMMQSBB++SkEX5+Rc236rhnbF8vmWUtXGBm/b/s0oRFTbdEmYwqsiZOcwseMP
 vQoh4tAwOmD6HrfiD7ObMoz6DxbUZjmpgzn97ysUUv/UQ0mv0UN6ZgsFa6/KaDuEKKyo
 oT7Znm6c6d5hXz3ycUtE/qirMF/E4/KF76VM0kb4KeblQ5h9UZbR77d/L/obawiBCaVz
 Tryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0p6R/xh9sq6v4kHBx5QB6Is0bNfQ/u+ywP0ESl/GvdM=;
 b=bg24EgwDuLhOf52KA/6uYFRqsa1XNDlQGMw1Yj6ptXjIo6P6+2SZEWIurA4KxorWjy
 Q76q26dRYUp4B4BWBn6ClwUDed+BkuihVlw3MRL4LSH5WGBv3UcijyQvBfIljZiCzrdr
 bbp2L7Cm2fWKX9RlKUVtxj+mbS6R7DMQZIGdj+3UlrvBxrS/GRVZRzhAqKgn8WaPAzv+
 cNuVlfAiYEUtuNB5/JlwQd64RnerzH3h2khVTC3R0KwzS5bcERMhTb0OR9vsFZdCY/Sm
 b/FhaCg91YA0RTRopI2EXCF3E01GzQwIUGIgtyNz71XK+GVa9NZcd3sPJ5NLXZLLfLLw
 yc8w==
X-Gm-Message-State: AOAM532tTZJmv1q8G9k88k5+K0QBB8T0Bu8gcnlsB+sEhSbSiFZs1+LE
 P0o35Y0C7jKIWTeNuvUnzDE0ow==
X-Google-Smtp-Source: ABdhPJxZKPxNgsGOgkYSoIYGbX+3GG9lgdZ1osaqdgZZho/XOBeq/gtZD6dKhX614u5ARcPT7ghejg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr6046478wro.392.1603296953149; 
 Wed, 21 Oct 2020 09:15:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n5sm4599967wrm.2.2020.10.21.09.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 09:15:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D178D1FF7E;
 Wed, 21 Oct 2020 17:15:50 +0100 (BST)
References: <20201021072308.9224-1-thuth@redhat.com>
 <e7ac0344-24d1-d53f-7e7f-798be452adcb@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] tests/docker/dockerfiles/centos: Use SDL2 instead of SDL1
In-reply-to: <e7ac0344-24d1-d53f-7e7f-798be452adcb@redhat.com>
Date: Wed, 21 Oct 2020 17:15:50 +0100
Message-ID: <873627wo5l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 10/21/20 9:23 AM, Thomas Huth wrote:
>> We do not support SDL1 in QEMU anymore. Use SDL2 instead.
>>=20
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/docker/dockerfiles/centos7.docker | 2 +-
>>   tests/docker/dockerfiles/centos8.docker | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dock=
erfiles/centos7.docker
>> index 8b273725ee..6f11af1989 100644
>> --- a/tests/docker/dockerfiles/centos7.docker
>> +++ b/tests/docker/dockerfiles/centos7.docker
>> @@ -31,7 +31,7 @@ ENV PACKAGES \
>>       perl-Test-Harness \
>>       pixman-devel \
>>       python3 \
>> -    SDL-devel \
>> +    SDL2-devel \
>>       spice-glib-devel \
>>       spice-server-devel \
>>       tar \
>> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dock=
erfiles/centos8.docker
>> index 585dfad9be..f86931f955 100644
>> --- a/tests/docker/dockerfiles/centos8.docker
>> +++ b/tests/docker/dockerfiles/centos8.docker
>> @@ -2,7 +2,7 @@ FROM centos:8.1.1911
>>=20=20=20
>>   RUN dnf -y update
>>   ENV PACKAGES \
>> -    SDL-devel \
>> +    SDL2-devel \
>>       bzip2 \
>>       bzip2-devel \
>>       dbus-daemon \
>
> I wonder if we are having docker image caching issues...
>
> build-system-centos job passed but then in check-system-centos:
>
> FAILED: libcommon.fa.p/ui_sdl2-input.c.o
> ui/sdl2.h:7:10: fatal error: SDL.h: No such file or directory
>   #include
>            ^~~~~~~
>
> And then in acceptance-system-centos:
>
> ./qemu-system-x86_64: error while loading shared libraries:=20
> libSDL2-2.0.so.0: cannot open shared object file: No such file or
> directory

Hmm weird it passes for me.

--=20
Alex Benn=C3=A9e

