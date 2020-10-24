Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5A3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 07:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98ADE20936
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 07:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyXmLVK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ADE20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWE5U-00071E-ND
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 03:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWE4U-0006Of-GX; Sat, 24 Oct 2020 03:34:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWE4S-0007lt-Ri; Sat, 24 Oct 2020 03:34:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so5066199wru.12;
 Sat, 24 Oct 2020 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IDaICsrG3YBkuHE+yPFMcyxf9tU7Tofo56BhDZM53dg=;
 b=hyXmLVK7tVIkbfXBrAkMN5MSxdUY5IWeScc6QrP0WtfozK3JYh5GHvoqN3OrXBQejE
 rF1sUidQ16gNBOrvgMgntXjz18KJE64YTddlNpYH5sUP664qPNnwCe7Hb+Lo2LogAYY+
 GQlXfem4OabhLuo9d1sXF6NlgItauJwcXlMFrwFBAEGj2XpvhM8TBPXXCmpuj6UiKEpY
 cMdbF7GlRuPQ6mn28U4rMXF9LYZAkRrO4MAqklpc18MHvr1aINe34nH9SY2ZykzPKLgi
 NaK63ibv1Jr8BvR76C0oYeUNh7GVQT1gHP+9097o7bAAhVXJKLZAhQz0hh48ku62zKbH
 V6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IDaICsrG3YBkuHE+yPFMcyxf9tU7Tofo56BhDZM53dg=;
 b=M2j+3vcxZRANEYw96mJYFyRnXgKcE4ZfmiPdv975Ia4KQDO1xPX1dCOdE/yJ4jMVGM
 9iNHMxbVSIYrtD7+Akm+bIUsi4AEuBAphYEHJG1Iv1bIETlb8yTzRohuGvMnEnT4cGDI
 +ZeOTWS7akgo5L9UVncjYOQFL9lIr5uFO37oyUByy1YdpZ885l17bwb7vr/58zJTcL3n
 xzc36MS16iTcnjsSOW6pL26ECuNPcE91k4SB+/4fibGOQXfOAvaj17OadlDWpX4sC8su
 d6GzaYsgMX7SH4cRSfCLsu1XOP78ob6RNakMbOwlSigA1c6DO2GzxRrkObxtAKwWA9Tb
 q0VQ==
X-Gm-Message-State: AOAM533mc+nDmpyrvXZ6CvRgVaOreQ3pCfLoWu6oNq+nwmF0pYva2k/W
 avFm28m6/AsyD4fsVh3NDtE=
X-Google-Smtp-Source: ABdhPJzzDp9JeBqt2evEZZGPGfliNKczo8PioFP0Po5uXFDNqxTgq0rF3/IJEdkD9jZGyvxgmYJx9A==
X-Received: by 2002:adf:a1cb:: with SMTP id v11mr6129220wrv.86.1603524874979; 
 Sat, 24 Oct 2020 00:34:34 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 24sm8061502wmg.8.2020.10.24.00.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 00:34:34 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: Bin Meng <bmeng.cn@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <CAEUhbmWJQHJgdvgjXRy3jzJLQC9w3cCdft40ium0TbjEq=9pQw@mail.gmail.com>
 <e2863605-d90e-5e97-0a9b-35d7c2b15e34@amsat.org>
 <CAEUhbmXX9RH12_EuUd-HmipOFMWH1_2gvCjL_RRqXiOqvzzU=Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fca4287e-37fb-dda0-784f-a053f0ad0cbc@amsat.org>
Date: Sat, 24 Oct 2020 09:34:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAEUhbmXX9RH12_EuUd-HmipOFMWH1_2gvCjL_RRqXiOqvzzU=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/20 3:06 AM, Bin Meng wrote:
> Hi Philippe,
> 
> On Sat, Oct 24, 2020 at 1:56 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 10/23/20 7:42 PM, Bin Meng wrote:
>>> Hi Philippe,
>>>
>>> On Fri, Oct 23, 2020 at 9:18 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> Series meant to help Bin Meng to debug the SD card issue
>>>> reported by Michael Roth.
>>>
>>> Thank you for the patches.
>>>
>>>>
>>>> Philippe Mathieu-Daudé (4):
>>>>     Revert "hw/sd: Fix incorrect populated function switch status data
>>>>       structure"
>>>>     tests/acceptance: Allow running Orange Pi test using cached artifacts
>>>>     tests/acceptance: Extract do_test_arm_orangepi_armbian_uboot() method
>>>>     tests/acceptance: Test U-Boot/Linux from Armbian 20.08 on Orange Pi PC
>>>>
>>>>    hw/sd/sd.c                             |  3 +-
>>>>    tests/acceptance/boot_linux_console.py | 68 +++++++++++++++++++-------
>>>>    2 files changed, 50 insertions(+), 21 deletions(-)
>>>
>>> With this series, I used:
>>>
>>> $ ARMBIAN_ARTIFACTS_CACHED=1 AVOCADO_ALLOW_LARGE_STORAGE=1 make check-acceptance
>>>
>>> It looks that the failure still exists? Log below:
>>>
>>> 13-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_arm_orangepi_bionic_20_08/debug.log:
>>>
>>> 01:11:27 DEBUG| => boot
>>> 01:11:27 DEBUG| unable to select a mode
>>> 01:11:27 DEBUG| Device 0: unknown device
>>> 01:11:27 DEBUG| BOOTP broadcast 1
>>> 01:11:27 DEBUG| DHCP client bound to address 10.0.2.15 (1 ms)
>>> 01:11:27 DEBUG| *** Warning: no boot file name; using '0A00020F.img'
>>> 01:11:27 DEBUG| Using ethernet@1c30000 device
>>> 01:11:27 DEBUG| TFTP from server 10.0.2.2; our IP address is 10.0.2.15
>>> 01:11:27 DEBUG| Filename '0A00020F.img'.
>>> 01:11:27 DEBUG| Load address: 0x42000000
>>> 01:11:27 DEBUG| Loading: *^H
>>> 01:11:27 DEBUG| TFTP error: 'Access violation' (2)
>>> 01:11:27 DEBUG| Not retrying...
>>
>> Have you rebuilt qemu-system-arm with the reverted patch included?
> 
> Oops, I took it for granted that the `make check-acceptance` will
> automatically rebuild the QEMU binary, which is not the case. Should
> we enforce the rebuild before testing in Makefiles?

Well I'm not sure, because I don't want to have to rebuild all
targets before rerunning a single test, but this is a Meson issue
that could be fixed soon. I'll let Cleber/Paolo decide.

Does that mean I can add your "Tested-by: Bin Meng
<bin.meng@windriver.com>" to the test patches btw?

> 
> Regards,
> Bin
> 

