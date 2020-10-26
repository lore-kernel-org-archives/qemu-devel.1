Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21082C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B34206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZyV926C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B34206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXB2W-0002r3-Lz
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXApI-0008UV-Rh
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:18:52 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:41448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXApH-0007QD-24
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:18:52 -0400
Received: by mail-ed1-x541.google.com with SMTP id l24so11329829edj.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2LlLySCA6Qbm1gB6rd8wGTNDIdS0m+sDATuCX6JpgHs=;
 b=hZyV926CCdDRhkAz/YCoXPn104eDte/hRYi1u3mBUfHVqz25bqXiuXG0HQQspP7IYS
 Jb1hTviFKtcXKDPtb4DtYxW4g+dDv2AP5AbrERYiLTjAIVwW+07uVDsIKkeD9rIcn1k1
 41N8dXFTRYboRsSfYNAwfnQtwNA3mM7frFLtTjKNheDJOGlPTXY4KepMTC8vkOugd3iP
 Eh329ww9E2lxQnsleIJ65U+Bi5TvoQQR0hYV0Q8PO5/3HXusgVgxyrQunwFTD23NBdbR
 U1jCQ0eix8wCTz4603Wq5BugIflPU32dbF3BVyiyXFKY9W3aN35PqNDCV6EyJe/V6cLt
 Lc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2LlLySCA6Qbm1gB6rd8wGTNDIdS0m+sDATuCX6JpgHs=;
 b=LTgPUY41VHTH4OJatzILTGI1XxFA8SuFibxc/r2JVp1S5SS6YHeY+N0ntlDelwLxDv
 9kAWiLkf4Te58lbA84Ndwg7NN/R35Ror400n7uFp3X4uwY7GEGz/QEGsQdq+ls0pLB1r
 WZ6ZdvCxi3wORQOeGhyd9AJXchZyXg5mHIafq7Ybvf7xwAwtB2oal8a5kDGdbRAh8xW7
 mup/EH4Nza03WqDffAaStf0sYwWWPPfh2v3ga9auOwJT4PooCZpTny6ijVbD91AFCZT5
 YOfaD4oulelg2m34nZmQTcBOMqa5p/hNwGuaicanqfV+KZRYPmE6BhBWOlPQAXXFXmUn
 FQ/w==
X-Gm-Message-State: AOAM531ciARs1a5+o0IgKf4rgMxJ2I6AetppD5vTJd+px9o6NjwREY/L
 h8sqpKHbvrx7pOjRtX7ZMN65C5yGgRA=
X-Google-Smtp-Source: ABdhPJxbxFdaIk/YEjHnyhLoHCDUa1rGf7Fb7A/2PLJ43CcXU2sw550XMUGck4eMh1JdNgWicKqeEA==
X-Received: by 2002:aa7:dcc2:: with SMTP id w2mr18081096edu.121.1603750729325; 
 Mon, 26 Oct 2020 15:18:49 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id rl1sm6609674ejb.36.2020.10.26.15.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 15:18:48 -0700 (PDT)
Subject: Re: [PATCH 1/1] include/elf.h: Add EM_RX.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200814131438.28406-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1a217ab5-4ced-b694-b218-c3554c7bc1a3@amsat.org>
Date: Mon, 26 Oct 2020 23:18:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200814131438.28406-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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

On 8/14/20 3:14 PM, Yoshinori Sato wrote:
> RX's ELF machine not defined elf.h.
> Added it.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   include/elf.h | 2 ++
>   1 file changed, 2 insertions(+)

Thanks, applied to renesas-next.

