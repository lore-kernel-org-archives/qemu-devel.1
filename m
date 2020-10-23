Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4740F20780
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmoTRsvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4740F20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW1Ja-0005Ql-0L
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kW1IQ-0004MB-0V; Fri, 23 Oct 2020 13:56:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kW1IL-0004JW-CZ; Fri, 23 Oct 2020 13:56:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id k18so2785279wmj.5;
 Fri, 23 Oct 2020 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8rpt0PAUn6oHPcCaRwOTVjOa1HQtcRNh9LUgalSxSP4=;
 b=DmoTRsvOif8Ed7vqsWBTChcacAyyxPCvE+26EHRrEUdLryRtyWnkG3tv4KJdv/j2wv
 qjnCN3epcFnSJMSFRPu9xniHotNpERn7MVMqONDYbw3tblpUgU6yrNF3uAty4XXWDvLm
 j+w+lAHScXCEU/MTjWVq2DQgQtRh7ZznNYSbLSwTxvouzQChkNfGvXOXebA0KADu5/o3
 pngBKvdELbbhj7qjtu1hp9MfrJYMzMuPX5a1FWsbGDz9G+nzKDeSxdyJTpq9oPNCOfS0
 6RvZzTyyHAKCCdJnJl+HsJnonW/CrQ9/69zZo2Q/1saCbpBw4vAxLyCNco/vpTZwVQH+
 0Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8rpt0PAUn6oHPcCaRwOTVjOa1HQtcRNh9LUgalSxSP4=;
 b=JfvI+aGq/wtZQghRKf72oonI5JsO9WSjhBl1IfVbwfmeIsiAqWzjIxmNaIockrr7wS
 7sdk4sIBmCui+ptDhGJnViGgGbeTsMQXPkfKFf9TEj1DcQLtJDCauQqrTpAPO+An+ISu
 sCXY4E0h6zxlPVFInCyl5i+LV9CQFfH3w+6wm2aN74SKQn+ikxqbY+F4ghTn2bFKqKRb
 qoRE8TW8fpInpHpxtsWgQZajKhLUDySwbNMCAaP12r72EZoL+/YHzX6OnGwxc51vM1ar
 f53GPlEmsUbpti0pcS9LQJhsOuRN2laaR0ThxZQLRvsl8R1ZkTputhuF5U1+458kBIqn
 5F9g==
X-Gm-Message-State: AOAM5312eRHh/XjGX6xCu4MnJB4NROEc4ijVKH+Zy+j9k8auI5H5/BS9
 /NkYk7fVewLbXI1RswQZEmA=
X-Google-Smtp-Source: ABdhPJwBDNnMS73ceTa6q5h5/3Vl6mySWuz//9FTwBlbCg+um3H8tjxpEiLc6d0OuSrfALvVqaVatQ==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr3585908wms.77.1603475763361; 
 Fri, 23 Oct 2020 10:56:03 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id r1sm5205693wro.18.2020.10.23.10.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 10:56:02 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: Bin Meng <bmeng.cn@gmail.com>
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <CAEUhbmWJQHJgdvgjXRy3jzJLQC9w3cCdft40ium0TbjEq=9pQw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e2863605-d90e-5e97-0a9b-35d7c2b15e34@amsat.org>
Date: Fri, 23 Oct 2020 19:56:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAEUhbmWJQHJgdvgjXRy3jzJLQC9w3cCdft40ium0TbjEq=9pQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.108,
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
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 7:42 PM, Bin Meng wrote:
> Hi Philippe,
> 
> On Fri, Oct 23, 2020 at 9:18 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Series meant to help Bin Meng to debug the SD card issue
>> reported by Michael Roth.
> 
> Thank you for the patches.
> 
>>
>> Philippe Mathieu-Daudé (4):
>>    Revert "hw/sd: Fix incorrect populated function switch status data
>>      structure"
>>    tests/acceptance: Allow running Orange Pi test using cached artifacts
>>    tests/acceptance: Extract do_test_arm_orangepi_armbian_uboot() method
>>    tests/acceptance: Test U-Boot/Linux from Armbian 20.08 on Orange Pi PC
>>
>>   hw/sd/sd.c                             |  3 +-
>>   tests/acceptance/boot_linux_console.py | 68 +++++++++++++++++++-------
>>   2 files changed, 50 insertions(+), 21 deletions(-)
> 
> With this series, I used:
> 
> $ ARMBIAN_ARTIFACTS_CACHED=1 AVOCADO_ALLOW_LARGE_STORAGE=1 make check-acceptance
> 
> It looks that the failure still exists? Log below:
> 
> 13-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_arm_orangepi_bionic_20_08/debug.log:
> 
> 01:11:27 DEBUG| => boot
> 01:11:27 DEBUG| unable to select a mode
> 01:11:27 DEBUG| Device 0: unknown device
> 01:11:27 DEBUG| BOOTP broadcast 1
> 01:11:27 DEBUG| DHCP client bound to address 10.0.2.15 (1 ms)
> 01:11:27 DEBUG| *** Warning: no boot file name; using '0A00020F.img'
> 01:11:27 DEBUG| Using ethernet@1c30000 device
> 01:11:27 DEBUG| TFTP from server 10.0.2.2; our IP address is 10.0.2.15
> 01:11:27 DEBUG| Filename '0A00020F.img'.
> 01:11:27 DEBUG| Load address: 0x42000000
> 01:11:27 DEBUG| Loading: *^H
> 01:11:27 DEBUG| TFTP error: 'Access violation' (2)
> 01:11:27 DEBUG| Not retrying...

Have you rebuilt qemu-system-arm with the reverted patch included?

> 
> Regards,
> Bin
> 

