Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7376CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 19:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4080E207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 19:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBS978pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4080E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDC6J-0005Ip-Cw
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 15:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDC5l-0004oq-H6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 15:37:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDC5j-0007FQ-Q3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 15:37:17 -0400
Received: by mail-wm1-x344.google.com with SMTP id u18so2255168wmc.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rthAm+JHl6cNIqFyciWQw+aqXoK9/BxqIKqPd4aKZRg=;
 b=MBS978pdtdtMN3aZqlvAtuCrh3VFUS4duflCCBWf2eW3eTh1gUtrH5VD7pKFsBNv0f
 RjduwkAEr9fbN88KqS7iLRnnsAyuuACxZy4+gs1l1BHMImkeuGNwXt13zc28NFhxsbzl
 emhvzcFmxwgUGICMYD1RdugS558zSHt81oMNO8YACHivF2gV1C9j99pfpyEBhVQlKhDH
 siMp1P+1c3n9O1G+dtGXJzxXc+1Q67MMjEO/+Lgt7588B3B9bfJe5wRD1+/DeBUUtZvw
 3lTGL2RwBV3MkkLL46+bn5sO09MZyU+ctTV4B9E4E1r9OPZvkgO3FpRDyUp+UxIb0ip5
 Me5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rthAm+JHl6cNIqFyciWQw+aqXoK9/BxqIKqPd4aKZRg=;
 b=Ph0+bvrCzkEST+zb1Ejm4uOJBRP+gfFbn27VcDVg6LUPn41+YhbQShDRhkBlXns2l1
 ad951m/3u2NQHjtf6FQzdGRHZ6MDfKX47Azen1cnMqt7qbF+oQfIj9l9iLd6czAAdKBS
 1TX7bekuzMnlcWA2cZX3A6u+aIZi0+JflprdzOU032LPUQjEXh3RmMBaUgER4z8ml2sa
 gfapqAQaTjkzO9BwrAJyGHo5gG1ADqeQnwbft4P/nxJyCc5/GvXLZvkvC1p8unCqrNm5
 Xysz9ql7Mmh1B7YmRZiMd3xy3Y4DUfg09uiR75x5qA/GzAJJcpgKOKPcS25WkmLR6P23
 Aulw==
X-Gm-Message-State: AOAM532GvGEOwOOZRna8ecfds9IyoOb1IWBCpjo4N3pWXCR71zxGt1+J
 sA6FRnK3kaL9tYZDzp9AK7U=
X-Google-Smtp-Source: ABdhPJzAU4K7jtyx6nlPBK5nqy/M/hchcjEyhuBkhUWpgLFNawijcMlFw8M4r8OhAICqx39PO9BOGQ==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr3396363wmd.72.1598989034184; 
 Tue, 01 Sep 2020 12:37:14 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id l8sm3721510wrx.22.2020.09.01.12.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 12:37:09 -0700 (PDT)
Subject: Re: [PATCH 0/7] hppa power button support, graphics updates and
 firmware fixes
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <232d08f3-c759-c0b4-1080-1382dda7a81b@amsat.org>
Date: Tue, 1 Sep 2020 21:37:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901183452.24967-1-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Helge,

On 9/1/20 8:34 PM, Helge Deller wrote:
> Add emulation for a power button on hppa,
> fix quite some bugs in seabios-hppa firmware for artist graphics card
> fix boot with old Linux installation CDs.

I started to review the version you sent last week and took few notes,
are there big changes in this version (is it a REPOST or a v2)?
(I think you just appended 2 extra patches posted separately).

Thanks,

Phil.

> 
> Helge Deller (7):
>   seabios-hppa: Update SeaBIOS to hppa-qemu-5.2-2 tag
>   hw/hppa: Make number of TLB and BTLB entries configurable
>   hw/hppa: Store boot device in fw_cfg section
>   hw/hppa: Inform SeaBIOS about fw_cfg port address
>   hw/hppa: Add power button emulation
>   hw/display/artist: Fix artist screen resolution
>   target/hppa: Fix boot with old Linux installation CDs
> 
>  hw/display/artist.c       |  37 +++++++++++++++----------
>  hw/hppa/hppa_hardware.h   |   3 +-
>  hw/hppa/machine.c         |  56 +++++++++++++++++++++++++++++++++++++-
>  pc-bios/hppa-firmware.img | Bin 783192 -> 785696 bytes
>  roms/seabios-hppa         |   2 +-
>  target/hppa/cpu.h         |   5 +++-
>  target/hppa/insns.decode  |  10 +++----
>  7 files changed, 89 insertions(+), 24 deletions(-)
> 
> --
> 2.21.3
> 
> 


