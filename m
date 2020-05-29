Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E1DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAF12077D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spHjqyDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAF12077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jehgw-0000EM-Ej
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jehfP-0007qT-Me; Fri, 29 May 2020 12:15:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jehfO-0002dp-Kl; Fri, 29 May 2020 12:15:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id h4so4020694wmb.4;
 Fri, 29 May 2020 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=56skEWDk5MuyNktK9SF2FuTYRB3ePorisxcBU9HiDU0=;
 b=spHjqyDUggsvprADniidmmLGKrmbNTNiuipbl7R3lceWbz12VlauhuVmjG/03u+j5l
 CLNL+kjMGZziVFdyP6mLa9TFKPBvoE+1HY3EFzAfX46S3cKmnnRZZAE25suQf4teGJho
 P2Qjyc1NJezvFlQXCPkFEz2FkuGR+dqJuxRpnR+Sdnr/vRbjiN+GT4ssoE6/m7eRCogn
 +Rd+UqYdN2xROyaAcxj2NBeMbSMGdDL6HGCrQXBiN0edWDu+msMAn+TYun/71/U1oGgF
 /WOPNLuZaWNSY0EU5jnlFfkxMS4ICS5u2glGABFocETlJ2Fcgz3DdN1zRrX179woJJa7
 W+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=56skEWDk5MuyNktK9SF2FuTYRB3ePorisxcBU9HiDU0=;
 b=Qa7+O8H2BYsGuqd/LxYmbEprKguAhUvF06UYFDVqfLSv48DYnQszK9UiT+3u5gFZ7S
 Ny3eBYrUNEB8ogxNo+2RQGwCqVcrr1VmmdRiAnUiznK835u98pBxt3AeBhklKzCOLbG7
 xSMyJTP8jlw4dfq/LvN3Pg+hS9D2J3V8ixa3r0qPhkp9RdwnwJrZHzM8rQkY6mDHLiWp
 1iWUeSby5Ng12SRLkQQJfgovJyRTdNG46rU9SnBIOkY9z+/FoohsqrsSCKdqZpFQEk2i
 yiXOqPBi16Ttx7tS/Zh7kjsb85x7jRT47P6M1GYoIXzVlOFj7+SH7ishjjkC1DnZJUc7
 voZg==
X-Gm-Message-State: AOAM533gxQkEhFsy/hzMmQ0y4LE00CVEsf8oSMjOTPBOI9z8gtTovK2y
 8kjF9+fidFduhnSmmuUpbAI=
X-Google-Smtp-Source: ABdhPJytn+VkZ9zT2D0pfqviRQ1oq6aNjSOby+57FUoc1UCCuzEOBLUSozvpDRl+v7D8uxjMScwAzA==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr8949470wmh.29.1590768925094;
 Fri, 29 May 2020 09:15:25 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z7sm10529022wrt.6.2020.05.29.09.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 09:15:23 -0700 (PDT)
Subject: Re: [PULL 00/21] Vga 20200528 patches
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
 <CAFEAcA98OyyyC6gs34e3U03=dXz8GkDn5qf38UaO_XBB679V+g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bf43132b-71c2-d411-7cf3-e9a00066ccdc@amsat.org>
Date: Fri, 29 May 2020 18:15:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98OyyyC6gs34e3U03=dXz8GkDn5qf38UaO_XBB679V+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 5/29/20 12:29 PM, Peter Maydell wrote:
> On Thu, 28 May 2020 at 13:36, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> The following changes since commit 06539ebc76b8625587aa78d646a9d8d5fddf84f3:
>>
>>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-hw-next-20200526' into staging (2020-05-26 20:25:06 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://git.kraxel.org/qemu tags/vga-20200528-pull-request
>>
>> for you to fetch changes up to fa0013a1bc5f6011a1017e0e655740403e5555d9:
>>
>>   sm501: Remove obsolete changelog and todo comment (2020-05-28 11:38:57 +0200)
>>
>> ----------------------------------------------------------------
>> hw/dispaly/sm501: bugfixes, add sanity checks.
>> hw/display: use tracepoints, misc cleanups.
>>
> 
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> for any user-visible changes.
> 
> Could somebody send a followup patch to fix the indentation
> error checkpatch notices, please?

If this is part of your scripts, this is a nice feature :)

> 
> 5/21 Checking commit 97f369f2479d (hw/display/cirrus_vga: Use
> qemu_log_mask(ERROR) instead of debug printf)
> ERROR: suspect code indent for conditional statements (16, 12)
> #34: FILE: hw/display/cirrus_vga.c:1038:
>                 if (s->cirrus_blt_pixelwidth > 2) {
> +            qemu_log_mask(LOG_GUEST_ERROR,

I explained on the patches:

  False positive.
  Checkpatch is confused by the mis-indented code
  previous to this line.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg706364.html

> 
> -- PMM
> 


