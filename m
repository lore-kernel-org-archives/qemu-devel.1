Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11483C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEE8206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5QkpnSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEE8206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k316C-0004Mp-5E
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k312h-0002Hs-FO
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:48:03 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:34331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k312f-0003WE-U5
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:48:03 -0400
Received: by mail-ej1-x644.google.com with SMTP id o23so15957714ejr.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cnvBgZ8L+Ixd0+0jaXIONjMTIh5vIKhIerjjydk6iNQ=;
 b=B5QkpnSo9Ebwu0p3jmvPBPOj0GNAjRyktJDSGU1CBj1QB2aFywewhEXEE/5QlCSgjy
 o/OjNRySjkJM8tAFZAU+LL8rsQ5mCZAH62hOIXlt/zL6s7KB1OKo6jFceDpP24c0MVih
 T4n33TYXhiyYCznEV0LCf0MZmyxlcDb6xt4nw06ghyRftya+n0ZDuzf7iSpkE8VxsU20
 PBuj1891t5hLIJxXaLh7pW8gkCp4FJX2A7y0GTBewFFyJCnzAy2L+Yp4GLqUYQlMaZ83
 Md2jUZ0ruwbcSL6kZlRM1lLUtcLCxVJufGMwBY52y7b/uvbvWbSp1aoetd2ZfhLEiwxu
 wSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cnvBgZ8L+Ixd0+0jaXIONjMTIh5vIKhIerjjydk6iNQ=;
 b=rL5xGoH9gig1aRqfaPRCNgsQVW109GedZHIxlJk5gF02i75jJI1Wb437Ax/zlEU0OA
 UiPUpz/UvnyiklWi69jQOdAPdMOamoT57XRqk9x8yXvQQJDfFL2Qd/PPKlhdvCPFItbX
 P+KomWI2sMTTYQw/Tovr5681afujd29x9yiQvtaK+NSS/N1t9SnrFCrIK5PqCozENPj3
 hpb2jkzv969MNOgVgWEKVjIutBDt5syOorXBmr2I36ozXwdZk4b3ZpIYLWtfwNxVufQ/
 sJUgwL113MPoyvvwtM/xzWq+KzvN2qCilowKxZAcSyAeEPcjOGb0p//MZsUsQArtP/fV
 W8Lg==
X-Gm-Message-State: AOAM533/0/869lef0rYz3p9eQYtAIHfcIDQZrrWRvWS6Fo19G4GtqPff
 jMUqCAGVQUdPEzFqgYeQKQuR1gUk
X-Google-Smtp-Source: ABdhPJx8s/MuaaCI9DVFs9OACcU0OHCV3MVXmq/KzUd1hbQbhpFSHBO7+6MIBJmTB1kamZE6fnJsMQ==
X-Received: by 2002:a17:906:2e09:: with SMTP id
 n9mr24103892eji.0.1596563279353; 
 Tue, 04 Aug 2020 10:47:59 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id k24sm2449905ejz.102.2020.08.04.10.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 10:47:58 -0700 (PDT)
Subject: Re: [PATCH 10/11] configure: Allow automatic WHPX detection
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-11-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <038e7827-1d6b-fc42-2c41-8b7dce49aa81@amsat.org>
Date: Tue, 4 Aug 2020 19:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200804170055.2851-11-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 7:00 PM, Thomas Huth wrote:
> The whpx variable is currently initialized to "no" which causes the WHPX
> check to skip the detection unless the user specified --enable-whpx.
> Since the detection code should be able to figure it out correctly, let's
> initialized the variable to "" on MinGW-builds for proper auto-detection
> instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configure b/configure
> index 2acc4d1465..f44e428c91 100755
> --- a/configure
> +++ b/configure
> @@ -809,6 +809,7 @@ case $targetos in
>  MINGW32*)
>    mingw32="yes"
>    hax="yes"
> +  whpx=""
>    vhost_user="no"
>    audio_possible_drivers="dsound sdl"
>    if check_include dsound.h; then
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


