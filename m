Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C15C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E94E2078E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwn+ovUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E94E2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEB6S-0003ZJ-Ml
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEB5N-0002Jj-4T
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:44:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEB5L-0006xj-GA
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:44:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id e17so5977119wme.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TG4EdToXQO9WUptOHGwl2YsMT558TXxgUCCdV/nmXfM=;
 b=Zwn+ovUOfDkYkrDNK80BDGMggPaAi7CtrTwbIWP7kNBr904PqjLL89vrUTGkmT99fo
 vn/t5duAz8XAdkUyoc33xS0Dbluh9Nm8vD03soGrz6Rv/0PiF/CpmHvTNfJWZlgn4gPW
 pbmAqCvNnMGdsjWzibhnXXdviRC+/EFA51J+0pvLMkCdQ6Po6t3BUIM9UzFyNnHeknch
 XOLPg+QVZ82cPOewvM18+c/KF2bWeHaMDzQE54HQ3BmaUnwTWz14cYk2Pc8lJRr/oCZI
 MHU++VMwgncMNwZR/yTrd8qcaOoeNY0qo7ASEq87NvIOCQctptFYhjDJ9iuWss4eborg
 QPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TG4EdToXQO9WUptOHGwl2YsMT558TXxgUCCdV/nmXfM=;
 b=mCgLxftVFWazOsi4HIWLQ0mVhpvii+b7/w1niv4KFXWgqA36LP8dsRa3yPamkXsOEU
 sNuInGmnx4y2hnG9smQon8hJtYlXbyKNU5qKp5eWba/u/w+kX78Lc6hORzLFJIM8dxgC
 4ysfsQUMlTG3KpGCKQtpWaCrEa/jx7HhMI2Qf+HiN6eovtz/WTvP7KbaWbv5ABGmP5G/
 3ynZ48lGJRXlO1jb9nFPiF4dADBoh/8dpD+GwzUfXyn8TgvcknZ4DVUaoZsMCQJqSgnX
 hYmWs/hJdYd/9Ryli36hbxj44Qemyjahxwz3gB8HaXbbfuDaYWGOHKx4DcKugP1tjzbW
 Zf9A==
X-Gm-Message-State: AOAM5302usNDz6rTcPly1oDmU0+Qp12QLCP+1ajwEuFCw8AwRBdbauwf
 fpsplNUVk9RNqbe1HntnIuJjrE7sJRI=
X-Google-Smtp-Source: ABdhPJxXj43atwaBJ5L58Yo9WoB0F1F5J07zn0PLY+ImpeC+VtfWlc/jpom5yVoUm3/pe9yQK4eEqQ==
X-Received: by 2002:a1c:7d0c:: with SMTP id y12mr7418170wmc.103.1599223493983; 
 Fri, 04 Sep 2020 05:44:53 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q12sm11291582wrp.17.2020.09.04.05.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 05:44:53 -0700 (PDT)
Subject: Re: [PATCH v2 06/12] target/microblaze: Rename DISAS_UPDATE to
 DISAS_EXIT
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
 <20200903072650.1360454-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e83cdca-1dd5-81c6-e5a9-ddf8e8a1b817@amsat.org>
Date: Fri, 4 Sep 2020 14:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903072650.1360454-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.107,
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
Cc: edgar.iglesias@xilinx.com, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 9:26 AM, Richard Henderson wrote:
> The name "update" suggests that something needs updating, but
> this is not the case.  Use "exit" to emphasize that nothing
> needs doing except to exit.
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/translate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

