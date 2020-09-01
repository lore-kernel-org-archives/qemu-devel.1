Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6351AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E072083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkCGWcUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E072083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2wJ-0005Xj-8W
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2ir-0005lr-K9; Tue, 01 Sep 2020 05:37:01 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2iq-0001WV-2U; Tue, 01 Sep 2020 05:37:01 -0400
Received: by mail-wm1-x341.google.com with SMTP id u18so467405wmc.3;
 Tue, 01 Sep 2020 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ALob3r9bFnYkN7EHAZCiCAj+Y+B16qSRzKe+iBuntqo=;
 b=DkCGWcUhkNv/jbB5Fb6kbxXQMN7BaA0qx+eq966uT5luSrkvOH+9SM9XOGxnf+OmUx
 qTdPWIwiG0c6xU67duW2D/N/h0B0+ARx8qNkwuPrenttexO8zC0fTcvFoXNxkHjEQsGV
 zpHnR+rJFY2aBXdmZFapV+9DJQbXdD3+onGh2U2ao54yemmT0h2ldHrlwUvi32/uf/zZ
 wtrzCOPkw+Yy2eYQFUGde+1r8cNHd6Tz3TD/OPeMjMuBQRJT5O5ZM8GicWQqlSOg1Dx+
 sN181MFWQiIVrugqs/L4BXMEoOlVkefFLV0QVbrW4WTpYAMDUd+2pErKMNw/FDOXNsJJ
 qQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ALob3r9bFnYkN7EHAZCiCAj+Y+B16qSRzKe+iBuntqo=;
 b=ctrioyPguwu/KeLyafDkrsbTcRxddKANB5122OyBxqB7lDFvBLlECpZ9UMxdJ6RrRQ
 xXs0KMM6Qii0OLTePkRz+gEJ39OkakXLUxa8X1sIMR6eMGqufdL9V2cFlKPZ3MPNO+fs
 79WfUEx+xa2jcBKbwZQgcFNuEsMtMRQTkAbvyKo9T1sjx51O0DE3EgstiBnCCU0ri+J8
 aUrOwON9PsV24XmVdWtpTY6ZqqBslNy7bpQraLl+eOMuGW8kgZTaZEdtnQMptyCdcuWY
 7Vf60Ppr/S5S5gPYKggrjT5ko11nBb/NW/2qPuLNKxcGED9N0tc+PyWkbz/AZGKhVQS5
 HrWg==
X-Gm-Message-State: AOAM532yHF9GD7roFzElQ9bZlaK7NJDjB2I3ytuR3gbeR1qDX9/8wKYx
 SpZYSWknkctZR+xWYRa8PhY=
X-Google-Smtp-Source: ABdhPJzaPjXt9c3PuMzsZkVKhW5rlspsuRG+Ua/2DviniWFA6abaRL77aMoiiyxwESV+aX14Z1VD3w==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr891944wmb.44.1598953018312;
 Tue, 01 Sep 2020 02:36:58 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id f1sm1451725wrt.20.2020.09.01.02.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:36:57 -0700 (PDT)
Subject: Re: [PATCH v3 01/16] target/riscv: cpu: Add a new 'resetvec' property
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-2-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7f36f344-28a4-79fa-e68c-5e6e667b48f4@amsat.org>
Date: Tue, 1 Sep 2020 11:36:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598924352-89526-2-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:38 AM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> Currently the reset vector address is hard-coded in a RISC-V CPU's
> instance_init() routine. In a real world we can have 2 exact same
> CPUs except for the reset vector address, which is pretty common in
> the RISC-V core IP licensing business.
> 
> Normally reset vector address is a configurable parameter. Let's
> create a 64-bit property to store the reset vector address which
> covers both 32-bit and 64-bit CPUs.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> 
> (no changes since v1)
> 
>  target/riscv/cpu.h | 1 +
>  target/riscv/cpu.c | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


