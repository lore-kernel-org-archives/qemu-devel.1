Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAD6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7465820729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8f1MCIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7465820729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyFjI-0003p8-Pm
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 10:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyFif-0003Oj-32
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:27:41 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyFid-0001Lp-I0
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:27:40 -0400
Received: by mail-ej1-x643.google.com with SMTP id l4so2381206ejd.13
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CyZqkwUuytCxo5hIOpXE0SUzx38ijcV1MiGcqB1hJ1E=;
 b=T8f1MCIBccjNzrBd0pKZxKKMoLb6lS7GP+y3oDBCYa1EXwlyT/MXj4BGQBMvbsLK6e
 Cd4Pfp4GoFjV3BJxjnTGDCVDHciCiUvyVk9gP5KqMqE7z8y8QPLy/qhijkHaooNDh6VK
 THzeukqXgxCNyogSfD3ApLizN6pml9dzvs2H4vWTS4j8uDlJK9I8VmGya6zeqskdYKUs
 hmgaTcAdg/eEmBtnDGHBVbQeqy5lQs8G3xBFY0x6zFxt+VNHYNal+05C0omSNokMod9d
 CJV22Jy3Tw6BsfqSHDQpoRDClawdn/36HYWkVxxqDSITHtAWo98oDTQIRL3T7NYNinzx
 gt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CyZqkwUuytCxo5hIOpXE0SUzx38ijcV1MiGcqB1hJ1E=;
 b=APpJcVkqBCekzLeniyXEUqx79rc4xPm8lGPM0aWLZIwY+GJlyLMUrORuK5ad0a50RV
 jxhnP8XUBjgjXt9nLuGJSdB0lyP8qUCcvtlQujpc2lTPV2roRTRcjuAP2Y814+12nFRI
 RmNJGSFutOzmxNeL26d+vJa+/Zgqyu5IBS9G+G6yDMZ3/6kpocm+VZolzwx0lg+f71Bu
 nNbPngS1/ts6tscDspOgJA2TQtNllJDQrwN1Agou67NIEXmn7YQDirYVdbwRpc8P83aF
 zOCxjGLSdPtlmsHzYs4IfjvVnZzemNUUwagTSk8c1yPXPS0saWXwdc7mbpzhrnE8i6al
 zodg==
X-Gm-Message-State: AOAM533TKAbZlVluHfylCoE0LjAoe6ySEmenFL9ThpC5jVUTSzZNx1Tc
 6HKSdl18zCmmI+VVGSaaU+0=
X-Google-Smtp-Source: ABdhPJz7jJBpEotvEowMyYorMM7y/Ob5beaE9BburWhzvnX6duW+mZwBC0HwhTrdu/4qynP9r45tjA==
X-Received: by 2002:a17:906:c7c3:: with SMTP id
 dc3mr31962351ejb.376.1595428057514; 
 Wed, 22 Jul 2020 07:27:37 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id b3sm23171edm.53.2020.07.22.07.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 07:27:36 -0700 (PDT)
Subject: Re: [PATCH v2 11/12] tests/docker: add support for DEB_KEYRING
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f710ccff-7cc4-3c19-e3b0-50c56f78dc0b@amsat.org>
Date: Wed, 22 Jul 2020 16:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200722062902.24509-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 8:29 AM, Alex Bennée wrote:
> For installing stuff from sid or ports you may need to manually
> specify the location of the keyring. You can even import keys into
> your personal keyring and point it there, e.g.:
> 
>   gpg --keyserver keyring.debian.org --recv-keys 84C573CD4E1AFD6C
>   make docker-binfmt-image-debian-sid-hppa DEB_TYPE=sid DEB_ARCH=hppa \
>       DEB_URL=http://ftp.ports.debian.org/debian-ports/ \
>       EXECUTABLE=./hppa-linux-user/qemu-hppa V=1 \
>       DEB_KEYRING=${HOME}/.gnupg/pubring.kbx
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-bootstrap.pre | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
> index c164778c302..35c85f7db8a 100755
> --- a/tests/docker/dockerfiles/debian-bootstrap.pre
> +++ b/tests/docker/dockerfiles/debian-bootstrap.pre
> @@ -79,6 +79,13 @@ else
>      fi
>  fi
>  
> +#
> +# Add optional args
> +#
> +if [ -n "${DEB_KEYRING}" ]; then
> +    DEBOOTSTRAP="${DEBOOTSTRAP} --keyring=${DEB_KEYRING}"
> +fi
> +
>  #
>  # Finally check to see if any qemu's are installed
>  #
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

