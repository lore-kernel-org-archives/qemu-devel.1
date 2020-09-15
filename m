Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E1FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E182080C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foZoX3V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E182080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIFBe-0007y8-OZ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIF40-0003jT-Jt; Tue, 15 Sep 2020 13:48:20 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIF3y-0007Wa-Pd; Tue, 15 Sep 2020 13:48:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id s13so327014wmh.4;
 Tue, 15 Sep 2020 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fV36Y5r0gmFeQyVZ8gYTumSHHgY8V/1e5xqNYgfi+RI=;
 b=foZoX3V25d1GYg5EfjnPoUJL2q/SL0wmg6pIz0p+0HDbjh/n6oE6fAhsOTfcgEnO+w
 qvFqjN1Ejkba7PDglmgFu7itDbRYc8ZNPa0rW7yfv7DJzNRyflBerZUy5PnnetCKm4Fu
 o8NACTRegvykzEIYc/nq+RQzRfykefOV2AV2wPJ3iYYEatP1PI4lDBXodSPyFNJNd51a
 ZsVQ8jO2VYg6Uhoh5CcHXk5c/tMj9QupSEjLVWS2bJOeOYcUq0SET05wfjtqR24synmu
 DvoQTtl14uJj5NIVlucsfdlsXi2giWSrOO9V6SFt6eeHqdwPt8SpTZNjQU+ChUcvSfE/
 UVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fV36Y5r0gmFeQyVZ8gYTumSHHgY8V/1e5xqNYgfi+RI=;
 b=Nxe07xBxXr79Rs6xd2DPn+j759Q0XrBQgHvdYEf/gn9V2K/OBDbxbNHitG2MapXFZQ
 KkUTCRpYm2qyoxxBPV92QOJH60f8My5ei9md6EJ3/LGht1BLs7wkiqMx3rU6ntkZv3zN
 o/6MnArSaknnfggrM7RAFMsULFoobWWB49usJd5Y27Ax3TFLLdpNg+GzN09yFwvDBfDt
 Zs3svTbAWt+MAsStJ9kdrgDVAtB02SdoJvqjQ+StUWZTdB8O3vbGuMdxQktCj6EKQ/Dl
 qTqJiH9Xb/b+gNow6pmkW6XFNsRVlA9uUwT/C6+r9uGTe8JvBpmGMxHVoT4EcDA/A0zv
 eN5w==
X-Gm-Message-State: AOAM53235unr08GQ3ZnMm5hL2fm1u2fprBON4uTixHZC+iHW90DqP1gJ
 R7S580imAP0ruGo6DSN/Es4=
X-Google-Smtp-Source: ABdhPJyyz93pJbkOE9E9kb81u5D9r035AS3AKBueogEO6PemiuFIwnwwm3OCjAbNAyI/YRvMY9Nq9w==
X-Received: by 2002:a1c:b386:: with SMTP id c128mr525168wmf.82.1600192097000; 
 Tue, 15 Sep 2020 10:48:17 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m10sm528256wmi.9.2020.09.15.10.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:48:16 -0700 (PDT)
Subject: Re: [PATCH v10 15/26] cirrus: Building freebsd in a single short
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200915171234.236-1-luoyonggang@gmail.com>
 <20200915171234.236-16-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2b577bdb-1f92-311a-82d7-d4aa4aa23c68@amsat.org>
Date: Tue, 15 Sep 2020 19:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915171234.236-16-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@FreeBSD.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Typo "single shot" in subject?

On 9/15/20 7:12 PM, Yonggang Luo wrote:
> This reverts commit 45f7b7b9f38f5c4d1529a37c93dedfc26a231bba
> ("cirrus.yml: Split FreeBSD job into two parts").
> 
> freebsd 1 hour limit not hit anymore
> 
> I think we going to a wrong direction, I think there is some tests a stall the test runner,
> please look at
> https://cirrus-ci.com/task/5110577531977728
> When its running properly, the consumed time are little, but when tests running too long,
> look at the cpu usage, the cpu usage are nearly zero. doesn't consuming time.
> 
> And look at
> https://cirrus-ci.com/task/6119341601062912
> 
> If the tests running properly, the time consuming are little
> We should not hide the error by split them
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Ed Maste <emaste@FreeBSD.org>
> ---
>  .cirrus.yml | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 3dd9fcff7f..25fb4add9b 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -1,38 +1,19 @@
>  env:
>    CIRRUS_CLONE_DEPTH: 1
>  
> -freebsd_1st_task:
> +freebsd_12_task:
>    freebsd_instance:
>      image_family: freebsd-12-1
> -    cpu: 4
> -    memory: 4G
> -  install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
> -    bash curl cyrus-sasl git glib gmake gnutls gsed
> -    nettle perl5 pixman pkgconf png usbredir
> +    cpu: 8
> +    memory: 8G
> +  install_script:
> +    - ASSUME_ALWAYS_YES=yes pkg bootstrap -f ;
> +    - pkg install -y bash curl cyrus-sasl git glib gmake gnutls gsed
> +          nettle perl5 pixman pkgconf png usbredir
>    script:
>      - mkdir build
>      - cd build
> -    - ../configure --disable-user --target-list-exclude='alpha-softmmu
> -        ppc64-softmmu ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
> -        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu'
> -        --enable-werror || { cat config.log; exit 1; }
> -    - gmake -j$(sysctl -n hw.ncpu)
> -    - gmake -j$(sysctl -n hw.ncpu) check
> -
> -freebsd_2nd_task:
> -  freebsd_instance:
> -    image_family: freebsd-12-1
> -    cpu: 4
> -    memory: 4G
> -  install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
> -    bash curl cyrus-sasl git glib gmake gnutls gtk3 gsed libepoxy mesa-libs
> -    nettle perl5 pixman pkgconf png SDL2 usbredir
> -  script:
> -    - ./configure --enable-werror --target-list='alpha-softmmu ppc64-softmmu
> -        ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
> -        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu
> -        sparc-bsd-user sparc64-bsd-user x86_64-bsd-user i386-bsd-user'
> -        || { cat config.log; exit 1; }
> +    - ../configure --enable-werror || { cat config.log; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
>      - gmake -j$(sysctl -n hw.ncpu) check
>  
> 


