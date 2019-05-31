Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1D4C28CC2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3280C2644C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3280C2644C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWawg-0002Oh-9V
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 02:23:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWavQ-0001jf-IE
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWavP-0007Zn-FX
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:22:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWavP-0007XT-9C
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:21:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so5661009wrv.2
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 23:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=t1lqshxQBx03IPMD2sBARikXXbldsexADMpKuosEnKc=;
	b=oEMy7NiLCEbKkYIB3drpCEPTPLY04FHhI2FoP8SY6elFQC9mitvJpSh6OEQIu9ZXEr
	YWYunf2fdbXOWr3XzktiKCbn7UhaZBXHkLNaxGYdbYL4RgsB2KhkP0FtQxZ1kRPHRDJN
	EeAplycwGm3YHU4vFW15mzuTf8sT9mF1bsZqC9aHOOE3AJzJ4G8REUdi3OLW255dg06A
	vy0p1vBASVlRkvPQ6lmmO/CKJ7Zhj6XlBZeW3svmupquEVyRxp1AGTReGFZ6KVPA1YJX
	O0AX8DG42torBoqvYfg1ELl0wFqRtJU5GTKMZlhLaZVoUsr/K7kewH33zolAuxI6dAHW
	EudQ==
X-Gm-Message-State: APjAAAVKyzIAoYIpzM0OQ4lxkNtAz0yoTgJhkNDXywCiwmGrs6VMjT/0
	TM7qfqglkkoFoh8Df+24SPJDpw==
X-Google-Smtp-Source: APXvYqxtJCacgSLs4O5a9RA/eIQCtZ09l+pVQfwSdA8NPQSP4fYnsYPkZZOO8YLKGLeXebVc5q8n4A==
X-Received: by 2002:a5d:4310:: with SMTP id h16mr5414145wrq.331.1559283718244; 
	Thu, 30 May 2019 23:21:58 -0700 (PDT)
Received: from [192.168.1.43] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id c2sm906661wrf.75.2019.05.30.23.21.56
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 23:21:57 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <63f83710-a043-ae3e-ddb3-f515facc82ac@redhat.com>
Date: Fri, 31 May 2019 08:21:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v1 08/26] .travis.yml: add clang ubsan job
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 12:15 PM, Alex Bennée wrote:
> We document this on our wiki and we might as well catch it in our CI
> rather than waiting for it to be picked up on merge:
> 
>   https://wiki.qemu.org/Testing#clang_UBSan
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index f0aa37f2d12..2f1658602ed 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -152,6 +152,13 @@ matrix:
>        compiler: clang
>  
>  
> +    - env:
> +        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
> +      compiler: clang
> +      before_script:
> +        - ./configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
> +
> +
>      - env:
>          - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
>        compiler: clang
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

