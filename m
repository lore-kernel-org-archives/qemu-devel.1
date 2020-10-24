Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77580C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC41A22276
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6jC4ANA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC41A22276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPsy-0004tr-TN
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWPrh-0003yQ-96; Sat, 24 Oct 2020 16:10:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWPrf-0001nJ-QZ; Sat, 24 Oct 2020 16:10:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id d78so6215062wmd.3;
 Sat, 24 Oct 2020 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MUmH2epfmw9o66zS7lrGrHlb9yh3ChkmdMMlhDv4IEA=;
 b=Z6jC4ANA7Sy+sINiGSlG4s5h1hlYPe/csHd1LF7t4+jwkW6qPhHxG7jiA1o7mVVooi
 46Ga7/rlaZZ9UdPbBUW8ulQzgdTt4UpRRxlphwh5dBAxaKMm1KfcvQJk3YJToVSLCkLs
 ItFGLccLK96zSWsFbvPzsVQSEVXLljY+PX4nJ/iHcpVJeck4JA4/MNqeePUuVlI++GNS
 PrYw8XW6CA9Qs4FTneHzVrHqM53xIbfdEDLiINZ0EE9CmCigK5h4bMaEHo9aSHDi5sO+
 V6AJ3qWVJGwm9eLP/nB8qofveXyrzWtUHu7e4tgfSBqwn/Bd2deSdSTGkgNw4nPZQoRZ
 g6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MUmH2epfmw9o66zS7lrGrHlb9yh3ChkmdMMlhDv4IEA=;
 b=qT+QSwe2VBrEOm88jC8i9Z22Y3uJbmtQhLw9DrbCp++V/pipBgZTRsbH5C7X5Wrofz
 jGlljZrZwpD8gKNfVt+Q5IeA3uaAR9AEbfv7fbJRtpJhzyCm1O8IzPLarcEcpZLfARna
 d3vnbhTAu0584PWGidxqMs3NSjrdqAjVQdrelS2/COZmGL94S5JYe9PLVw0SF/y/XpcE
 l6DdMi3Yfbluekis/NQRtvItIZBl5rwrFfK9YTNsnUY7W26SPna4xXct9MsSU0Ox1+Gi
 iK8txlwBo8Ljx0rlbPDFcw8dTYTj5nZenRMvzE5CfQGoeG1EGZHti44zgxb6rlpv8qdm
 IQHw==
X-Gm-Message-State: AOAM530tS2OV4YXkbOSC5DGKyXOX4S2AH+2UnVTOLw81Ps9tSOqQtuRI
 VXNd2Mi9X7J+4ndnRKNArMjJ6lOV+/w=
X-Google-Smtp-Source: ABdhPJwq4wBz0JsCK69mZ1vZ/FmytBluDGHmLsFnaDF5GXWjwUWD6sELJDQ9hbPbbPwDxNtbG1PVFQ==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr8300759wmc.8.1603570210066; 
 Sat, 24 Oct 2020 13:10:10 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id f6sm12167491wru.50.2020.10.24.13.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 13:10:09 -0700 (PDT)
Subject: Re: [PATCH 2/3] hw/timer/sh_timer: Silence warnings about missing
 fallthrough statements
To: Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20201020153935.54315-1-thuth@redhat.com>
 <20201020153935.54315-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <41f00a68-b0ef-9c2c-6f69-3fe710aea2e4@amsat.org>
Date: Sat, 24 Oct 2020 22:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020153935.54315-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Cc: qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 5:39 PM, Thomas Huth wrote:
> When compiling with -Werror=implicit-fallthrough, gcc complains about
> missing fallthrough annotations in this file. Looking at the code,
> the fallthrough is very likely intended here, so add some comments
> to silence the compiler warnings.
> 

Fixes: cd1a3f6840e ("Stand-alone TMU emulation code")

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/timer/sh_timer.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

