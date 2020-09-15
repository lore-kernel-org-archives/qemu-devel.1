Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDA820936
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tz1ktJlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDA820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF9t-0005NC-Vt
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIF2o-000299-Hv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:47:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIF2m-0007Ls-VS
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:47:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id d4so319474wmd.5
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=siH6VMr9bJQnoxd2/4qU6eCgPVq8ukZ9jCEOUhV2C8A=;
 b=tz1ktJloWi/kaccqhHr0qhsfmfY1b/x4lGj97pIYPn+5lvi7R7aaZtu7mA2PyTTzOl
 FW0Wo5F/6g3P6LSunPUw7vL4uzK6Fq/fFCaFj8IZSnoZhijr3GU1/+EGiofLVidHScRv
 kop0jRD3I9VfYPMxveK/19/OEKOmMhidJbSuZS60NtbZB8detRSvPGMcmT3g99XwT5+D
 Pnf/P4hZEgBPh4CGUCbCNElRQfb7IiNHFHfWyIFBbxVZ9Zmf0PH7kYFiKELcwmulFpwn
 zoxBGyCtPkruPmYnNeSouS+0NxTN1PX/iZUdf7l7IwWVquHvGGH0fWq4yz+RLrg8H1oQ
 dmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=siH6VMr9bJQnoxd2/4qU6eCgPVq8ukZ9jCEOUhV2C8A=;
 b=lsHPC6Odga6GsDOKdmlySFoY1pv0zDbfnUlDrmlPEpZAA5UpGmFyHNYX02Y4KkBlic
 EgtBvey0gV34JDDkHWIWOKwcFks5pV08It4HKOQJXQVm6WteiJb4eJVUDs5+YApA/0aa
 JpA/EI8qZU0Soer8Bg2OzB8DA3OPncNJg7M8CIgGrtO/5/WA2CR5XL13aa4WXOgmbjZ9
 Zp6ZZNyrOSEhSRN3epgJr5CDvPvQnGL6lAwmV5U4S3VfmFqA9N+btKErCzKbmATq3JkQ
 g9KiRA0bRMX3crojXLmKi/CK0J5b/I/4wTwi5ot+eB3s5s/ik/lnRySudNCyKspGR8Oj
 xWQA==
X-Gm-Message-State: AOAM531NwJwVas3R1nyH0/OaRfNsFH2eqBmybUXniTLHzK68cHrUWMBG
 LpT5DbNlA0FnR1dI9BusmbEFBZuB4uM=
X-Google-Smtp-Source: ABdhPJwsoYwIBKaKvPMx1r64eSDBxeYVtXFV/R/IlGpL1KUwmJ8SR1vttDXVyDFB80mlz0zM9KSCeg==
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr518313wmj.72.1600192023133;
 Tue, 15 Sep 2020 10:47:03 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id x16sm27566065wrq.62.2020.09.15.10.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:47:02 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] configure: include tilegx-linux-user in the
 deprecation logic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e9f3b80c-3ca5-dfa0-eae1-d8b1225aa2e6@amsat.org>
Date: Tue, 15 Sep 2020 19:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915134317.11110-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 3:43 PM, Alex Bennée wrote:
> The target is already marked as deprecated in the documentation.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 58be974065c8..dfd7f18dcb24 100755
> --- a/configure
> +++ b/configure
> @@ -280,7 +280,7 @@ supported_whpx_target() {
>      return 1
>  }
>  
> -deprecated_targets_list=ppc64abi32-linux-user
> +deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user
>  deprecated_features=""
>  
>  supported_target() {
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


