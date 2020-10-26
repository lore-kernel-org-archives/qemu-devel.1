Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A5E2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVvEhSWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A5E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7yE-0008NQ-DF
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX7sF-00043T-Rt
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:09:43 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX7sE-0007BV-3V
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:09:43 -0400
Received: by mail-ed1-x543.google.com with SMTP id l16so10651759eds.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u6MiLiQX0pj3lh5bhUYLDut1DBwIn+mRUsrxaUTHu5I=;
 b=gVvEhSWlRQwATuai0jsyzRXPbmEL82p0WXFQ6cNIuGYlSSqS0u7tk1686uPFipK386
 VMhHXTpAWw0rHCfLQ9BHM+jxf8lPJ4+pUEeW+pwgh+z67/v8SdzKriTYvELUCI8X0jxR
 y/H0i7E2ZhEh2vYUKd9FVpp0tJG8Rpil5xMaohbf9JT6gRL6ujcmUtjhH8czJRSUxUev
 8OQezWdKdTHb8l3XsGPDNEZ+UiD7FS9Esp+GA+SZ68J6etPph9zmbo7deearRDvnYwmG
 HLIJ/v0IDGaxCyrtqwtH59fsMqNxb8ZTdk3zRAHN/eOpf0PgkFwKebrZS70GtrG4vKbK
 o+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u6MiLiQX0pj3lh5bhUYLDut1DBwIn+mRUsrxaUTHu5I=;
 b=E/CsKwG1j0h5bCtZv24fgNEHZPyRm5IaTMgE3adyaFdfjdB+6A8dZHQg65y0k85BWu
 nNSrL0E2yvOTPbBJ7nv0zlr62e2QyQVMp4QD1SthKEIVKkLEUt6KmSeWos+0QJBlLsa6
 J0YflWsqNhiFmUyt1jZY7mDjHv1mPCSw07sQAu8D8p+jj7WqsbFFyGJBHmGByydrdIb8
 EF+t4StUh9eD4Zns3wgV3QYyuNlbDsXORi2RfQ6wh8XdHO5jDpr/yCVRjapju7ZAMAlr
 Jwwb4BFSNhRRmzDQjqBWmxzSrXEw6blh6PM+ayYG/ZHx/q/GtknVSqka9QiDJbqIwLjk
 JRgw==
X-Gm-Message-State: AOAM532PpQ3ukkn8HoEU8hbV67GtpqMuH9MmuqWMiR82r+SUkT7kuwPU
 buOkBqNSqgitRVEuC5RdWcZ/BmjT+Rs=
X-Google-Smtp-Source: ABdhPJyFb2NzGkGL2hhwTmVEUzYsBEqi6PtDuFd/7Ve0FwM7H96ioX/im0Svtr4cNDCOY6HbYe0j3w==
X-Received: by 2002:a05:6402:1b1e:: with SMTP id
 by30mr7619387edb.369.1603739380160; 
 Mon, 26 Oct 2020 12:09:40 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id k22sm5700951edr.12.2020.10.26.12.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 12:09:39 -0700 (PDT)
Subject: Re: [PATCH v2] rx: move BIOS load from MCU to board
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026190540.3106013-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6e5e6d0-ad35-d698-2560-10d91d069030@amsat.org>
Date: Mon, 26 Oct 2020 20:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026190540.3106013-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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

On 10/26/20 8:05 PM, Paolo Bonzini wrote:
> The ROM loader state is global and not part of the MCU, and the
> BIOS is in machine->firmware.  So just like the kernel case,
> load it in the board.
> 
> Due to the ordering between CPU reset and ROM reset, the ROM
> has to be registered before the CPU is realized, otherwise
> the reset vector is loaded before the ROM is there.
> 
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/rx/rx-gdbsim.c | 10 ++++++++++
>   hw/rx/rx62n.c     |  9 ---------
>   2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

