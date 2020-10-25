Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C67C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D6822281
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMs4SIiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D6822281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWTyw-0001lQ-2N
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 20:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWTwJ-0000Ny-SK; Sat, 24 Oct 2020 20:31:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWTwH-0003iR-3A; Sat, 24 Oct 2020 20:31:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id t9so7897700wrq.11;
 Sat, 24 Oct 2020 17:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wj5e/GEvC7oFiW4Dk62/WYRCxwYvdCiwhNP4IDBTK50=;
 b=sMs4SIiXoy8a74nkTwtCzbc8CdC+H6DRUVJgfjCGiCAe8yRFBnf2mi/rnNT5SPp/3y
 bDQM8j0B3X6PGHSvwuXO6LdVbGkV+UxIxPEKCasBnLb6mHMK9oDFrwLdkiIC7m5vKzfG
 iyTVUDTvWzfXdyqC3ifdDXN3b4ZxpP2J4zIjzmNuIsAAeCwzvezlAqB2LvBmp6CEpBtJ
 /Ue6eNy5kdlgbLmtjlKDzTYK295ku/uMxAsE6tt2mQFZPqhKo+eAtqWy2RrjxC3vnv0k
 72vClB+GGfuIQY37wefM75lDWVQ+0yNNcareoslUu3Xi+B1N18oZqNJIC3pxvRsFeMv0
 632A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wj5e/GEvC7oFiW4Dk62/WYRCxwYvdCiwhNP4IDBTK50=;
 b=qDaTGcQnzHoPO4JOdIr/EtWtIX+Skk6Ui3b+bduxR6NbxeNxok4bSzC+X+ac5/pUDl
 Xta+jn5CujKmKE6LzM/G8T7d/cLyT1rcehErxv2PBQQQ3S2G9wUwpMecUjgIMiP1TlxY
 JaNlHbs2KDgBC70vPwxUSrP7pG3jhb9ArNv8kul2OFDfJuQvOTkGgxWsLtPgR/gEqDPr
 zS8NRr9v8H106sD/AQERWv63HbIFfpD2gmYR1WMMUH1NOh3rVbCBP5WTpuEtI0lQD9zQ
 017FVUqITZTDrKbeeYEbB9qOmKTPDb09z9WIWEX4Kk46rQ5z76UgSqbHMgHSey4gzLRD
 pXwg==
X-Gm-Message-State: AOAM532LwclJUMRLPWLMCe8toWxfR4dmmEEcaVLv6YQlBtUrjaMtvHAO
 EVfiBcDGr1QjAsgMxWJ1JJg=
X-Google-Smtp-Source: ABdhPJzulTTTgTLUEsMdvJXhEJ+/F82LRQi2+5fdLoFU+/k0aUek1wvb4bmldYSmdTDuKiJLZxXaQw==
X-Received: by 2002:adf:fa8a:: with SMTP id h10mr9969268wrr.336.1603585871082; 
 Sat, 24 Oct 2020 17:31:11 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i10sm15573267wrq.27.2020.10.24.17.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 17:31:10 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance: expand Orange Pi PC SD images for
 NetBSD, Armbian above nearest power of two
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org,
 Bin Meng <bin.meng@windriver.com>
References: <20201024215200.494209-1-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd949ad0-f7fd-561e-33d8-57133a9afd31@amsat.org>
Date: Sun, 25 Oct 2020 02:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201024215200.494209-1-nieklinnenbank@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Niek,

On 10/24/20 11:52 PM, Niek Linnenbank wrote:
> The acceptance tests for the Orange Pi PC need to expand the SD card images
> to a size which is a power of two. As Qemu uses the size of the SD image file
> as well for the size of the emulated SD card, this can sometimes give problems
> for guests that assume a certain minimum size of the SD card.
> 
> This commit resolves the following acceptance test error for the NetBSD 9.0 test
> of the Orange Pi PC by increasing the size of the expanded SD card image to two times
> the nearest power of two:
> 
>     (5/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9: |console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
>    console: DRAM: 1024 MiB
>    console: Failed to set core voltage! Can't set CPU frequency
>    /console: Trying to boot from MMC1
>    console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner Technology
>    ...
>    console: Starting kernel ...
>    console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
>    ...
>    console: [   1.3300167] sdmmc0: SD card status: 4-bit, C0
>    console: [   1.3300167] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>

The test has this comment:

    # This test download a 304MB compressed image and expand it to 2GB

Once uncompressed the image is ~1.2GB before rounding to 2GB.

>    console: [   1.3430678] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 bytes/sect x 2097152 sectors

Why the card appears as 1GB??     ^^^^^^^

Can you try reverting commit 6d2d4069c47?
("sd: Correct the maximum size of a Standard Capacity SD Memory Card")

>    console: [   1.4102580] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
>    console: [   2.0674392] WARNING: 4 errors while detecting hardware; check system log.
>    console: [   2.0674392] boot device: ld0
>    console: [   2.0775401] root on ld0a dumps on ld0b
>    console: [   2.0977679] vfs_mountroot: can't open root device
>    console: [   2.0977679] cannot mount root, error = 6
>    INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Based-on: ("[RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian 20.08 on Orange Pi PC")
> ---
>   tests/acceptance/boot_linux_console.py | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

