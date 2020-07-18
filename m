Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F59EC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 18:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C222076A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 18:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYd6l2Vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C222076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwrW2-000171-H4
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 14:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwrVU-0000b1-BE; Sat, 18 Jul 2020 14:24:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwrVS-0003xK-Pd; Sat, 18 Jul 2020 14:24:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so18667390wmi.3;
 Sat, 18 Jul 2020 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xARqaXKB2Qtak1vPgx/2jadVXbJ4xuOgNkSdM52BZ8U=;
 b=FYd6l2Vm/HbhgrR1z166TdRU5mMfOrhuQWzsQUl7VNH6lJmNICMCCQAEn500u48OLz
 uBsdVwk4CSNMW9KUCRTQvjP79fBe4WJzEYEDxxWCjTfvRlkZGoty2hGEDrhg+HkaE83v
 1zHWuc2ywBpUZLaY3vDhGIEysdxEcyr2eg5y6T5Dn3auPnoZvBHQIA5SHDWN+Mg/Zngn
 dcxN9YYl1NRbn//2tj1Tw4xGwSlYxplAGQr8c4ykCZOdyJUodk/JSImLW6pfiF9fMxTg
 l93TXow/bXYnCqyHqIB1huCkqY1FggTf5kXuNjz0GVhg/f5EnQhuOmiHQIKRzb9yvdx+
 AdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xARqaXKB2Qtak1vPgx/2jadVXbJ4xuOgNkSdM52BZ8U=;
 b=eL9uhs3J9IuozNmZ3B52eH+MpB/bpvUqCuRqBSwvgksuxiPrLTFEavp21KhLsaghCV
 IXLYJILLsQeALNPLgkzU0jmb22lWc8F7uLlPPof6GU5V618JnSC9Q4EprxtiURE9Qpiw
 Y5wUMahHeoKAkVs9mQnj6X2obiXCnJBrBNNwHKt7YQV4uTGQtEGwsQpFOIKSnvjE2TQs
 IUK8ADNsT8rTOzKZPLTacPhCEmAVQxOiUk6q8FFCXVPq4HIHx89Sxvx1K7467a4hJy42
 SIRMoG1e2KmRznMDF8zsEIZS4aThZUG2mGNHcCCBzeUsfvKVXZEItR53qtdgYybg8TQ9
 pnlA==
X-Gm-Message-State: AOAM530irWC1r3s6quLKLkcl0ZzmZhc+QZ4bUV+TAx4G6KcAMlmaqzw/
 UPJ8IN77F/t+1a2g2YXHCzNvd44mn0w=
X-Google-Smtp-Source: ABdhPJyX7LRwb3NSHoRwP+6VbZOnShP8e/b/e/m1Zmo1M5Ac5qTE3sQUoTeuViCLy/xfI3PK9yrWug==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr14272112wmb.53.1595096655985; 
 Sat, 18 Jul 2020 11:24:15 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c136sm21957093wmd.10.2020.07.18.11.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2020 11:24:15 -0700 (PDT)
Subject: Re: [PATCH 0/3] configure: fix forSunOS based systems
To: David CARLIER <devnexen@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <CA+XhMqy95D8X-QvBcEfL=a-Rkgy6aJtheskkqZwQkreru+T_Wg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76137228-71ce-910d-289b-77a0c0e1369a@amsat.org>
Date: Sat, 18 Jul 2020 20:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+XhMqy95D8X-QvBcEfL=a-Rkgy6aJtheskkqZwQkreru+T_Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

Your git-sendemail seems broken... Usually 0/N is for the cover
letter, patches are 1/N to N/N. Also patches are sent as replies
to the cover (as a thread). In your series all patches are posted
as new thread...

On 7/18/20 3:19 PM, David CARLIER wrote:
> From 63a3c9639d708a796abd958607aa6376fc9b99f2 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Sat, 18 Jul 2020 13:27:52 +0100
> Subject: [PATCH 1/3] configure: fix for SunOS based systems.
> 
> local directive make the configure fails on these systems.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index e93836aaae..5d100eba72 100755
> --- a/configure
> +++ b/configure
> @@ -59,7 +59,7 @@ error_exit() {
>  do_compiler() {
>      # Run the compiler, capturing its output to the log. First argument
>      # is compiler binary to execute.
> -    local compiler="$1"
> +    compiler="$1"
>      shift
>      if test -n "$BASH_VERSION"; then eval '
>          echo >>config.log "
> 


