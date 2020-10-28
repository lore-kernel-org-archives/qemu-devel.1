Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF861C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F108A246A7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPA2FxlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F108A246A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXiQ5-0007UY-Sj
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXiPK-0006sb-6V; Wed, 28 Oct 2020 06:10:18 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:33754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXiPG-0000dj-NZ; Wed, 28 Oct 2020 06:10:17 -0400
Received: by mail-ej1-x642.google.com with SMTP id 7so1826895ejm.0;
 Wed, 28 Oct 2020 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QEAzeUyNs1F1/pvHzDxAem6fMq+K4gGbZFMucbeBMLo=;
 b=cPA2FxlRT8QANVB+FnbXw8bx6PrRntzlQlP7Usp3EWPZacEPm1HbgU6Pp600RA6Poo
 KNcMLu+19TmRd0wQKmGTsYLR8Z5djVJVaHdi8QoOF/z6X7UJdMWZeFu3jsrJNzzGKhY/
 76Z2wrynkQUcgT4Srz5P2Wm30Vw5M5pnwZbjwmkFWku4YNm51ZD1MKUMHFhQW0J/Ccsj
 yVw5PH9KNj/htMZMN1pH2SWLjOvxhb9M7Jt4+XV12q/H1lZZlXZEFJEfWbNnZTYrtFjO
 h2y/7a75izJcQb5yM9RXZOzi/en4s9uCWWEW+g6wr0vvBvWCmZMkKg3YdXrsL2O6fY6x
 hnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QEAzeUyNs1F1/pvHzDxAem6fMq+K4gGbZFMucbeBMLo=;
 b=VastoQa3+DRf6odOhWIFjeX+WJkZA3MznbX2/v8lJvR1MxFIrNjGFYbN382+8FkXoG
 Xjcm17WqmpPD9IWutXGqkOWeBK7r5wTxBlu6r8jvtJN85GA4DiWXzmEltRWmP0ywmAfq
 YAcSHP+Hk33R3KyxScwPaavWJX5JlkBYHBw9oCsTpORH9xsI86v7g6SsVHbPFGcJUckJ
 nWW40SHRhvWDJC2RpAoG7uBXfPehdVH3oH84YySoaA4Zz7BX/KgzNP75UIsV90KP4H9s
 6+TiQuKeUx81+uoD43a3bN9uzVsZCR6G3KJaPegHx4drjmbZzlUbg7AOHxmUUKpdJWLE
 tzGg==
X-Gm-Message-State: AOAM531ObAxxYQyy4R5PAv/qQw2F9Hg+FpUXZPoO9I7vQclRI+6DpM2R
 uHHdj9yFFbxkDYOIetUGzDVnSv6X8JI=
X-Google-Smtp-Source: ABdhPJynLeD2VoMMb3SlFX9L6ZGK0zS+H/2vvp6hOvNe25IhGpSkQjE26nrRmkaCIHSuziQ2op1Fiw==
X-Received: by 2002:a17:906:4306:: with SMTP id
 j6mr7005265ejm.523.1603879812076; 
 Wed, 28 Oct 2020 03:10:12 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id j24sm2549765edq.29.2020.10.28.03.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 03:10:11 -0700 (PDT)
Subject: Re: [PATCH] hw/sd: Zero out function selection fields before being
 populated
To: Bin Meng <bmeng.cn@gmail.com>, Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20201024014954.21330-1-bmeng.cn@gmail.com>
 <1e4c44aa-7d2a-e773-fe8e-47b858137896@amsat.org>
 <CAPan3WqM1VGRB_K4AsBynrhzm-+DN9x2G7oOKHujSj-A1yH3Sg@mail.gmail.com>
 <CAEUhbmV_z1mtK2PCVjrXhQtg48HgeAhuJAxdEoms+wFttLeg6g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <422514ca-27e9-8fea-bf10-e3d5a11525fd@amsat.org>
Date: Wed, 28 Oct 2020 11:10:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAEUhbmV_z1mtK2PCVjrXhQtg48HgeAhuJAxdEoms+wFttLeg6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 2:36 AM, Bin Meng wrote:
> Hi Niek,
> 
> On Wed, Oct 28, 2020 at 3:55 AM Niek Linnenbank
> <nieklinnenbank@gmail.com> wrote:
>>
>> Hello Philippe, Bin,
>>
>> Thanks for your support on this. I've just tried this patch and unfortunately it doesn't seem to
>> resolve the issue, at least on my machine. This is the output that I get when running the avocado test for NetBSD9.0:
>>
>>  (5/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9: |console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
>> console: DRAM: 1024 MiB
>> console: Failed to set core voltage! Can't set CPU frequency
>> console: Trying to boot from MMC1
>> console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner Technology
>> console: CPU:   Allwinner H3 (SUN8I 0000)
>> ...
>> console: [   1.2957642] sdmmc0: SD card status: 4-bit, C0
>> console: [   1.3094731] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
>> console: [   1.3159383] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 bytes/sect x 2097152 sectors

Same problem as before.

>> console: [   1.3763222] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
>> console: [   2.0592109] WARNING: 4 errors while detecting hardware; check system log.
>> console: [   2.0693403] boot device: ld0
>> console: [   2.0798960] root on ld0a dumps on ld0b
>> console: [   2.0994141] vfs_mountroot: can't open root device
>> console: [   2.0994141] cannot mount root, error = 6
>> <FREEZE>
>>
>> When starting NetBSD 9.0 manually, it shows clearly that the SD card is recognized with 1GiB size, also from U-Boot:
>> $ qemu-system-arm -M orangepi-pc -nographic -nic user -sd ./armv7.img
>> WARNING: Image format was not specified for './armv7.img' and probing guessed raw.
>>          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
>>          Specify the 'raw' format explicitly to remove the restrictions.
>>
>> U-Boot SPL 2020.07-00610-g610e1487c8 (Jul 11 2020 - 22:31:58 +0200)
>> DRAM: 1024 MiB
>> Failed to set core voltage! Can't set CPU frequency
>> Trying to boot from MMC1
>>
>> U-Boot 2020.07-00610-g610e1487c8 (Jul 11 2020 - 22:31:58 +0200) Allwinner Technology
>>
>> CPU:   Allwinner H3 (SUN8I 0000)
>> Model: Xunlong Orange Pi PC
>> DRAM:  1 GiB
>> MMC:   mmc@1c0f000: 0
>> ...
>> Hit any key to stop autoboot:  0
>> => mmc info
>> Device: mmc@1c0f000
>> Manufacturer ID: aa
>> OEM: 5859
>> Name: QEMU!
>> Bus Speed: 50000000
>> Mode: SD High Speed (50MHz)
>> Rd Block Len: 512
>> SD version 2.0
>> High Capacity: No
>> Capacity: 1 GiB
>> Bus Width: 4-bit
>> Erase Group Size: 512 Bytes
>> =>
>> => boot
>> 8846552 bytes read in 931 ms (9.1 MiB/s)
>> ...
>> [   1.3447558] sdmmc0: SD card status: 4-bit, C0
>> [   1.3546801] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
>> [   1.3647790] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 bytes/sect x 2097152 sectors
>> [   1.4150230] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
>> [   2.0800893] WARNING: 4 errors while detecting hardware; check system log.
>> [   2.0800893] boot device: ld0
>> [   2.0900792] root on ld0a dumps on ld0b
>> [   2.1004160] vfs_mountroot: can't open root device
>> [   2.1004160] cannot mount root, error = 6
>> [   2.1004160] root device (default ld0a):
>> <FREEZE>
>>
>> Note that the image has been resized to 2GiB with qemu-img:
>> $ ls -alh armv7.img
>> -rw-rw-r-- 1 user user 2,0G okt 28 22:45 armv7.img
>>
>> The previous patch proposed by Bin did resolve the error ("hw/sd: Fix 2GiB card CSD register values" ):
>>  https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg07318.html
> 
> Correct. The patch above has not been applied yet, and only this patch
> is now in mainline, so you will still see errors in the NetBSD 9.0
> test.

Yesterday was "feature freeze" but we still have time to do more testing
and fix bugs :)
I didn't want to rush and squeeze this fix too quickly. I kept it for
the next pull request so I have time to review and think about it more.

Thanks for the testing!

> 
>>
>> Although I see that this patch is now in master (89c6700fe7eed9195f10055751edbc6d5e7ab940),
>> can you please confirm that the issue is still present when testing this on your machine as well?
>>
> 
> Regards,
> Bin
> 

