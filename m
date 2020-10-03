Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E10DC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 18:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE07B206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 18:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9DyCjA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE07B206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlr1-0000y7-LN
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 14:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlpN-00006z-CZ
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 14:00:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlpH-0005R4-9x
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 14:00:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id l15so3201084wmh.1
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2NcpWIQ/LeY0/RNkUyopJ7xIREHsbXILeVtRsWqvjMo=;
 b=o9DyCjA56cdTrEPbJdggd4fMPLPZB0zfSt7bFgOR3wYvfACQRG+Z2IhsrC+2PsKBU6
 ySHSwaUaHenG71aRK0ueJNff/+3ajWzfASRQVLiOOtSlfymKx3Nh1eA/vtWGOLyPe46h
 FM8nuREyxMnGdLf2MKQ8hoWc2wPGQh9JODaK1BkQvV9l1hqfjHAmnNWRQhDQPu0YDcqB
 NZamwLhrB4PEM/vq1DzfuJE867gbELfT24KpDjU8V2Xwya+rnk4rhZgiZX890SyPYeI6
 yIUTOltT2HrKl/LvMlFSzkqDsAf8E//CPR4XqoIXqjGEy3sWj4mxjKHpmdvP2/1PGfSs
 mWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2NcpWIQ/LeY0/RNkUyopJ7xIREHsbXILeVtRsWqvjMo=;
 b=ifIVG2inUbiRsIc1+/10y2skSO6U2HmR8VYobLrOSBzs4C1CqZKRCXtuUXTLS1kah9
 V0pShIpeMuEWnt1wm1Xs3C6D6OB8MLj1a0+YP2QG6pX7v2P0YkgGvob5ztBhro77IqB6
 fS/L9mBilFr4z7UF/oZdrFY5ZfVzBAJeM9TdrooJWaYHRUxPpnjF0AXE3X4HhFBI59rv
 vMgQcEMPQTE4ZbKZgl9/5yXzNMfBbHRu7gPCXB+OdvNZXBLnRoxDTkgl0o8xQu4cLwg0
 lgSSw02ekMBDRtk4ZJXsQy6Ia7AIqUDwpVoA98WD6XhKVwnXizE2+nGG+HVa8uMIqgmE
 dWYQ==
X-Gm-Message-State: AOAM533/WbjkhgadwQlDXFj43lUWw7FHz8Zp/82GxRI8wKrAyDIKY0Vv
 V2sO5EH0HTEE5Y31xdYAVeHBRKFmm1c=
X-Google-Smtp-Source: ABdhPJymYEi3FTxBEG+JVe5JkXofI8Z+KdgtakAXzmBwYoqVS8e44IdEhMeq1sej0igNvTx5JnoVSA==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr8664359wmc.35.1601748005879;
 Sat, 03 Oct 2020 11:00:05 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l8sm6117269wrx.22.2020.10.03.11.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 11:00:04 -0700 (PDT)
Subject: Re: [PATCH] dockerfiles: add diffutils to Fedora
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201003085054.332992-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48dd90e6-c5fe-5749-ac0a-5128c0496ea9@amsat.org>
Date: Sat, 3 Oct 2020 20:00:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003085054.332992-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.252,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 10:50 AM, Paolo Bonzini wrote:
> For some reason diffutils is not included in the Fedora containers anymore,
> causing the build to fail.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 71e4b56977..ec783418c8 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -11,6 +11,7 @@ ENV PACKAGES \
>      cyrus-sasl-devel \
>      dbus-daemon \
>      device-mapper-multipath-devel \
> +    diffutils \
>      findutils \
>      gcc \
>      gcc-c++ \
> 

What about tests/docker/dockerfiles/fedora-cris-cross.docker
and tests/docker/dockerfiles/fedora-i386-cross.docker?

