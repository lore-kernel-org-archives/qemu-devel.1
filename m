Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F3C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10AE215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt9hITLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10AE215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzv2-0000WV-Ns
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFztj-0007lB-Qa; Wed, 09 Sep 2020 09:12:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFzth-0003Da-J5; Wed, 09 Sep 2020 09:12:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id b79so2300458wmb.4;
 Wed, 09 Sep 2020 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yMNfO6Ifjppp7FTgsUFJZEU6/PAgLcrsTQHNziogWRY=;
 b=Tt9hITLxYZNY6uo+EwWqk7An+fzNzjwS+p3fi1Zm5zuRNKDP8alJEu3LG8F3ZQ5+EM
 IWe0ogmWeBLSzPQL6OF/xjg5h1G8TBDnsNEeT4g98s5T+F0cCH0IDus/qH5scGNB5/xl
 SzWUXK8Zp2+PqcIMux31aeZz1P1+o9z2ZavhRcAY245XpFlB/5qb78s0B9ADirKUtRFj
 VsYf7ZbkGSGNbkNvv6ZR9zbqczJDX/EToDb31AS1zorfMTCw4yJXiT9ph9N6Irvz9Qy+
 D5jVrss+esDz8Cz5TOr/bH8zI2DADJ/iPQhkJ3sY6f3GNBY1vCFUw9HYvF3vhGunpbVN
 bUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yMNfO6Ifjppp7FTgsUFJZEU6/PAgLcrsTQHNziogWRY=;
 b=G8BrgWA60FxgwNYlkJeza5NFFVXwtjAE9zVzu/FB2gs7jsN947e589bGGMsrchpA4F
 6UNrb00K9GE+BmIxnc1FyYLP07HJ4wN26wLT25CP1Je1U1kdCS802ISf0E4R5MReBjZ1
 QU6U9xEBuvjgasDUMDf1VVSqNLuHYOx9DiHc5Zf/EllfpqTQx6ZJZcYLhHHCoE7/0Hni
 GFmaAmGhNvS6At2PuocDvTJYQJNdPZi5ofUqmmyCOj67S+T823I2NH7obc5/Oaj8nWUm
 tTE4LiyeceD8ulqs/+3WFQ1fAkL4OnIPdUkojjDoK8dakOzZzb+iVAtnUmE9bnkV8QGk
 Y4rw==
X-Gm-Message-State: AOAM533+lK2bYVMhZ+OVHb91RZvK0diEiRXQ3yPADiyzvyon/lw58NFK
 C6+vnB4aQMMCJJm7cMnFMVA=
X-Google-Smtp-Source: ABdhPJyXNJLdXLQ3RrUTPCqnX7mPasrn5RrZKW57xdXeF1rfrE13UERLmyE1gb21/OLg8urJwinbYQ==
X-Received: by 2002:a05:600c:2109:: with SMTP id
 u9mr3318197wml.147.1599657143155; 
 Wed, 09 Sep 2020 06:12:23 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id g186sm4051072wmg.25.2020.09.09.06.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 06:12:22 -0700 (PDT)
Subject: Re: [PATCH v3 14/21] cirrus: Building freebsd in a single short
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200909100842.1442-1-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19e0f886-8308-1848-7953-99561a00a67e@amsat.org>
Date: Wed, 9 Sep 2020 15:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909100842.1442-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 12:08 PM, Yonggang Luo wrote:
> freebsd 1 hour limit not hit anymore
> 
> I think we going to a wrong direction, I think there is some tests a stall the test runner,
> please look at
> https://cirrus-ci.com/task/5110577531977728
> When its running properly, the consumed time are little, but when tests running too long,
> look at the cpu  usage, the cpu usage are nearly zero. does't consuming time.
> 
> And look at
> https://cirrus-ci.com/task/6119341601062912
> 
> If the tests running properly, the time consuming are little
> We should not hide the error by split them
> 

Can you add:

This reverts commit 45f7b7b9f38f5c4d1529a37c93dedfc26a231bba
("cirrus.yml: Split FreeBSD job into two parts").

(no need to repost right know, let other review your patches.)

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  .cirrus.yml | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 49335e68c9..b0004273bb 100644
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


