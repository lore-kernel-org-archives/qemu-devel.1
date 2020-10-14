Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CB7C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498482078A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvjJVuoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498482078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSUaH-0007tj-8l
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 20:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSUZE-000755-IH
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 20:22:56 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSUZC-0003Oq-F5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 20:22:56 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a1so532843pjd.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=65+6ooOer5CQ9EkRpp80f/dtqKCF955CB3NqCSi4Mtk=;
 b=pvjJVuoFYM8lfGbvUVqHlPZjI5sfgUvyifHMxbdijZp+OJA4lcSF1uSbmey9e9dEsU
 KL+F+JI4G2ntYdqdgW5EKXUn+nJft3AInOSIrgQXPPZrsy2XETcwevRzezMLnc2fdrTx
 yzPPkYI/wfoZBvIZFnunc0T4qGhz8eS46Oq697ggibfCAlNtttNBuKg1uDznxEFOqUcc
 VlNFpcPKMfHFwNsFJgJx2BkHAlfMWSVTd5wFgfGRNVug9UvkpNG9oFCEINuiDmruc0c9
 6S1uEYnlLc+GAQyOJbBhYBhhonbIxwtyRIC7zI9tv9521RJu8OzluTjOXT3MCoQKJXU9
 4kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=65+6ooOer5CQ9EkRpp80f/dtqKCF955CB3NqCSi4Mtk=;
 b=Y+MP0SV1tfHOSQ7h/9iJH3Szf/lhp9H2unv3qp7sTLoAv5Z5M03emDSusOeCljKcMC
 +Te6uATL1C4wtftqvwwiKiZMMreZQ/Wnhn+8QqGTLu+6QtVkGv4H/WxY6WVe2wjkVRfk
 h0sN4bfIbgufaEmuVQOSkbUEwcy1AP+tSRdQFe5T9p+gXdS+gfF0VmWpfmfQnAn639dX
 fZMzDt+74XHj7bkBcm4OIBkNPHxY1x5pLzU+4DpgoQ8nsqZEsHerzVaR++dr37kufbLa
 v71voW9aBI73ChhbldhpOyPlDFnAWzfiFPiP60Pjy47vUjz4VCV9E2Q3xlK53mLmoQCR
 PrWg==
X-Gm-Message-State: AOAM530MUOV3hICgkhlJPV2gJZ9BIyeQCuf7Zr1CZtF66di0Ec/pxgw2
 z/6DVgjwB7PWluwkKGZsVW3cOA==
X-Google-Smtp-Source: ABdhPJxjT/cE8LF7UFElQTbsnQFf1T0A+E64N8O2nIxxH3IKwsbJY+tTqOwYV6QsKtX5JntpjmHuxg==
X-Received: by 2002:a17:90a:a111:: with SMTP id
 s17mr904214pjp.28.1602634972820; 
 Tue, 13 Oct 2020 17:22:52 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s186sm859614pfc.171.2020.10.13.17.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 17:22:52 -0700 (PDT)
Subject: Re: [PATCH] linux-user/elfload: Avoid leaking interp_name using GLib
 memory API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
References: <20201003174944.1972444-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fa879040-c7cd-cc49-9daa-89f3d498503c@linaro.org>
Date: Tue, 13 Oct 2020 17:22:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201003174944.1972444-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 10:49 AM, Philippe Mathieu-Daudé wrote:
> Fix an unlikely memory leak in load_elf_image().
> 
> Fixes: bf858897b7 ("linux-user: Re-use load_elf_image for the main binary.")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/elfload.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks, looks good.  I'll pull this into my bti patch set, in which you noticed
the problem.


r~

