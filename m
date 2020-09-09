Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A760C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBE62080A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL74ijoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBE62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG49B-0000Wi-CG
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG48V-0008Qr-IW
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:43:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG48U-0007K5-0r
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:43:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id a17so3884847wrn.6
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UJ3O3KSkQyYSiDYuTjzedY8qFp1m+H3I6Xbl5r86mf8=;
 b=DL74ijoNBUWH8LavyvoOWzkOujM4wBhFCh1/O7tNsZ1NwxCZnlaXRozWMuFuY/zATH
 FE5ohvITUYHrTCcEq48b8lJT/Y2rd6i56NQVNiAG0IoSDWikSHEbhqnwa+af6+CvL6xr
 gFy9+nBbkK/b0u48JCemr2rY3APpnfSHy/iju1zarcrM2tSKbZoNcL1aYMxSdjroK5A9
 xEDs9vqRMfahWu1dei1SrajX7KWVNUD4iNeQCeXGHO4Sq3GhwlnzNwc5HbymHx+Muuww
 cSMrMnB8MncpNxRbxFxoaPO50z2w/FiNxNc55ezkN60GLQWCi5PzIcKzNd9kxtXMRHTv
 6xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UJ3O3KSkQyYSiDYuTjzedY8qFp1m+H3I6Xbl5r86mf8=;
 b=paBIvyf68LbgKpXoEM/dChPdR8MW7fzVRLgqDnksMdvNRwRSuMBII8MIN4zAoQjoTB
 rSm46O9R4Tk0k8GfSJHzgMamTmF+LiYwYBA/XY0BCpD8X7H7Xs/VTwfI5Hm67vbzCQHb
 xF7LYySDLODDH+/00Ol7AxmBp8y9Ig6rGGNB0ORNEPzAlC9T6MwD2y+FsvU7yNj3n0OY
 eTT1zn4+du30dEjkrt+qGNgv00cwjKToSGc0y0cTYw+sfyubjY9x1PJGgkrhaZl2w+0O
 iaBXTxmEBoPQECCetuE5ZUMPaRGg0R1k/KCNdoYwPCw3VJmXVEmcAuqifsh295EFhV0P
 vFsw==
X-Gm-Message-State: AOAM530nP8kg+xeUR8NYzWOr74DY7m06Xk2/l7x4MxmrwKatlgxfTcOM
 nvmKF/0U3MtgCvNh7G70LfsfAcGYTLo=
X-Google-Smtp-Source: ABdhPJzmfJ4U93Et134sQ0V7v3+O8VU711KU2vp+AzbQ+qQP/EEuXRMsgFYM3boBd7Iq8eLVHJXyXg==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr4973902wrq.59.1599673436303;
 Wed, 09 Sep 2020 10:43:56 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m13sm5037415wrr.74.2020.09.09.10.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 10:43:55 -0700 (PDT)
Subject: Re: [PATCH 02/43] tcg: Drop union from TCGArgConstraint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200909001647.532249-1-richard.henderson@linaro.org>
 <20200909001647.532249-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d0628ee6-c987-ff7b-d022-7d1f35f99623@amsat.org>
Date: Wed, 9 Sep 2020 19:43:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909001647.532249-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 2:16 AM, Richard Henderson wrote:
> The union is unused; let "regs" appear in the main structure
> without the "u.regs" wrapping.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg.h            |  4 +---
>  tcg/tcg.c                    | 22 +++++++++++-----------
>  tcg/aarch64/tcg-target.c.inc | 14 +++++++-------
>  tcg/arm/tcg-target.c.inc     | 26 +++++++++++++-------------
>  tcg/i386/tcg-target.c.inc    | 26 +++++++++++++-------------
>  tcg/mips/tcg-target.c.inc    | 18 +++++++++---------
>  tcg/ppc/tcg-target.c.inc     | 24 ++++++++++++------------
>  tcg/riscv/tcg-target.c.inc   | 14 +++++++-------
>  tcg/s390/tcg-target.c.inc    | 18 +++++++++---------
>  tcg/sparc/tcg-target.c.inc   | 16 ++++++++--------
>  tcg/tci/tcg-target.c.inc     |  2 +-
>  11 files changed, 91 insertions(+), 93 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

