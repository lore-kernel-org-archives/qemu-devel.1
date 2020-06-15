Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4452068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPpC6iN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4452068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkkUA-0002te-FX
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 04:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkkTR-0002PG-VT; Mon, 15 Jun 2020 04:28:09 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkkTQ-0007FL-9g; Mon, 15 Jun 2020 04:28:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id e1so16142607wrt.5;
 Mon, 15 Jun 2020 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NJm1y6hJu4PtiHUecZ2poJ8OayfnBD1kpuOrtq+Ivfg=;
 b=iPpC6iN4+SFaKd96LIY/XZzS+SZiV9FZp88ekgoOGbwWIsdNTfpoQBUJUziokKdGfb
 x4reo+EGVeHW+e6+cpZw2Y8jF9bv4Nzsvyye2D2DkET1+GAa7dcTuykeoYePX4zQzLb9
 A3/YJQDTNW/9p4i8Pph+XZSXUu9Nzh/ENgnZYM3qFZqCBgkPfNjnAFFT1gy3mp2USIA/
 vNSEmTFvIKUs0ngsXTlP/4pOOkkuEFqoLzqGCEaw9nv0FWAw3FXM7wJeRiYj+x2RlMNx
 +ksGAAGgaDeRAvfwUlhSBG/6cXKjEcO8WBbcWuXloJ+ExeLx2ZzPEh06sSfFXq/p9IP2
 YRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NJm1y6hJu4PtiHUecZ2poJ8OayfnBD1kpuOrtq+Ivfg=;
 b=k+c7IbLf+5FN99g3g58qW7ToRsn2teMVX/YYH3yGPON8keV4XRBnWXGiRpnLOnqPpo
 erj54oohkrKNGCqEfwQDAQxYwMThJP99GSc5dG5cldEAuGfRqaQc8b6DK2Hmwvey3f++
 QlIJwWR69R697g28NAM444Ehc0XcGbInktXE4ZuunyiecvBhycnswsFZ4AQpZ8f+1L5A
 AQTd++fyMyeTss5iSh2y+OXxmFOg3a9Di2sjU664ffb22q6K9yb9fcorhBnrTqAoKfXs
 i3CFMjUj+Wn5M9YRG4LC2xqbftfgki1MUF3StSrScANDtSS+QBpU8wdgiL/tG67gRDUU
 mn7A==
X-Gm-Message-State: AOAM53382LdzZd/PhrK+lXRPf2bM80+M61SbP2fImMRR5aZeAIvY63Kq
 4QdbBITwydxiB4m/1ydO6KA=
X-Google-Smtp-Source: ABdhPJxQnOl7vJrzgJXPTh1IhG+0ljRo+I1Kbr5NDjO6gJdrmQObzwSNd+woFZ9AR2AWEYAeRGiMuA==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr26430180wrs.87.1592209686312; 
 Mon, 15 Jun 2020 01:28:06 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id e15sm22147394wme.9.2020.06.15.01.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 01:28:05 -0700 (PDT)
Subject: Re: [PATCH v3] configure: Let SLOF be initialized by
 ./scripts/git-submodule.sh
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200615074919.12552-1-f4bug@amsat.org>
 <e25444d6-d3b0-21b4-8bb8-b30a012f745a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <34f70bf7-69ef-da9a-37aa-e002ee7939c9@amsat.org>
Date: Mon, 15 Jun 2020 10:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e25444d6-d3b0-21b4-8bb8-b30a012f745a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 10:13 AM, Thomas Huth wrote:
> On 15/06/2020 09.49, Philippe Mathieu-Daudé wrote:
>> The git-submodule.sh script is called by make and initialize the
>> submodules listed in the GIT_SUBMODULES variable generated by
>> ./configure.
>>
>> SLOF is required for building the s390-ccw firmware on s390x, since
>> it is using the libnet code from SLOF for network booting.
>>
>> Add it to the GIT_SUBMODULES when buildint the s390-ccw firmware,
> 
> s/buildint/building/
> 
>> to fix:
>>
>>   $ ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>>   Submodule 'roms/SLOF' (https://git.qemu.org/git/SLOF.git) registered for path 'roms/SLOF'
>>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>>   Failed to clone 'roms/SLOF'. Retry scheduled
>>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>>   Failed to clone 'roms/SLOF' a second time, aborting
>>   The command "( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )" exited with 1.
> 
> I still somehow doubt that this will really fix the issue that you've
> seen here (why should it matter where the submodule is checked out?),

Yeah I still don't understand why the previous checkouts succeeded.

Is git.qemu.org cached by a CDN?

Maybe we can reduce the pressure by adding a 'prepare-sources' step,
then pass it as artifact within Travis-CI premises:
https://docs.travis-ci.com/user/build-stages/#specifying-stage-order-and-conditions

Alex, what do you think?

> but the patch is a good idea anyway, so:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 
>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  configure   | 5 +++++
>>  .travis.yml | 1 -
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index bb7fd12612..927e4a3d06 100755
>> --- a/configure
>> +++ b/configure
>> @@ -6533,6 +6533,11 @@ if test "$cpu" = "s390x" ; then
>>    write_c_skeleton
>>    if compile_prog "-march=z900" ""; then
>>      roms="$roms s390-ccw"
>> +    # SLOF is required for building the s390-ccw firmware on s390x,
>> +    # since it is using the libnet code from SLOF for network booting.
>> +    if test -e "${source_path}/.git" ; then
>> +      git_submodules="${git_submodules} roms/SLOF"
>> +    fi
>>    fi
>>  fi
>>  
>> diff --git a/.travis.yml b/.travis.yml
>> index ec6367af1f..220855c1f0 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -496,7 +496,6 @@ jobs:
>>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
>>          - UNRELIABLE=true
>>        script:
>> -        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>>          - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
>>          - |
>>            if [ "$BUILD_RC" -eq 0 ] ; then
>>
> 

