Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BBFC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05FF208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knOjLBiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05FF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHO4-00075i-QS
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJHMp-0005oJ-Gj
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:28:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJHMl-0001zP-0E
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:28:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id d4so5527716wmd.5
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F5C00gZJtS+9ak5BSS8EiAYBAOPbq1WOn4e1VDSe/dQ=;
 b=knOjLBiISqQD6q5AnpIRBJAm1z67M1J93fLzTmr2VJf6E1VEs2yOUo67vgxxuOhT6K
 fDS3mJ4SnSBdEF9HjDLWldyuYGxICeaalRPG7tjP7XSABWincLpcZaoNWuPWCdPekP2a
 XwuGsJi7MlYftdNYKU2o4VRJFi61+NgS23hhekLq2iSEb/1lGfI12C+m95/1h1nYoN1Q
 eHXuS0CK4weawWBuSUTYISFyNJdFuqBMoxIuEEcvc5wWSfdTboZGhnpMf1xvGELEadyi
 ZuU2Mx0jvinUoJ6fPTmtazV1+R31h9Zxw4ZR6zcNVmcZ/NonBtFB4jJeYTwkLCFPtX83
 LWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F5C00gZJtS+9ak5BSS8EiAYBAOPbq1WOn4e1VDSe/dQ=;
 b=lERDYgdR0wRqQs9IZmWh8Lgks0Qg6kZByxGjesrvDIdMNDJGdZOMkMjINUAWM0txGv
 BLZ6Y/eOA5UPQcPclrMDL7HhpTOTrYBIWNywhP689T0z7pkxTwoI1QU7/n5h0CoYLfZY
 R3UzYYCp+eRiiw21Q52ziT8qFx+UlgsSFiPuIZ0hJojNPyJC7kiO2Z2QrV4xuTOl80Ir
 Hee4UU149KNs2zh2TT5CrED8Na9ndS8oa0gyQWpX8MVYh6D1Qpac2Wbtta1gUPjyynyl
 DKHlXsHSay7iyrIkFEkOba4spS2kuZN0FNRq/h7YAUkuo/9v4AHHq/6T3n+cRoVQ5/os
 G/XA==
X-Gm-Message-State: AOAM531806hJZ9FJ05Sck31fYVkqJNYuaqfWSbq9q6BYXljYMIe94leG
 2+lwmXI4F6Z/Zdm+MBYfusE=
X-Google-Smtp-Source: ABdhPJxXbPHk4ya0n/tqsnY78C1k+cSBktcXA9cBcNXAV7Ikk1K2yvUs8wOoWKXoOHbSv0jwN23yAA==
X-Received: by 2002:a1c:2441:: with SMTP id k62mr15805065wmk.178.1600439274250; 
 Fri, 18 Sep 2020 07:27:54 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a81sm5502627wmf.32.2020.09.18.07.27.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 07:27:53 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance: Reduce quanta-gsj U-boot+Linux test time
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200918142344.150749-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <55648bee-46e6-4055-104d-0c82e8fcfe64@amsat.org>
Date: Fri, 18 Sep 2020 16:27:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918142344.150749-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-1.869,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/20 4:23 PM, Philippe Mathieu-Daudé wrote:
> The 'arm_quanta_gsj_initrd' test is timeouting on GitLab CI:
> https://gitlab.com/philmd/qemu/-/jobs/745483978#L846
> 
> Use the same trick from the 'arm_quanta_gsj' test to reduce the
> systemd services started and get quicker to the shell prompt.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 4a366ce93e4..7748febbf54 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -638,6 +638,9 @@ def test_arm_quanta_gsj_initrd(self):
>  
>          self.vm.set_console()
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'initcall_blacklist=npcm_i2c_bus_driver_init '
> +                               'systemd.mask=systemd-random-seed.service '
> +                               'systemd.mask=dropbearkey.service '
>                                 'console=ttyS0,115200n8 '
>                                 'earlycon=uart8250,mmio32,0xf0001000')
>          self.vm.add_args('-kernel', kernel_path,
> 

Bah unfortunately this is still not enough :(

