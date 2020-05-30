Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED0C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E9520723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUUJSwat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E9520723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jewSs-0005Cr-6x
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 04:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jewSG-0004GP-H7
 for qemu-devel@nongnu.org; Sat, 30 May 2020 04:02:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jewSD-0001Ar-Up
 for qemu-devel@nongnu.org; Sat, 30 May 2020 04:02:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id u13so6019674wml.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RId/V9E10XfD9eu91CAoNJ+No5yJB8NKzqB1bY2T1yY=;
 b=LUUJSwattsHebyPaEdGZk5SMOpRu6QSrInpeYcT8SN9SJHvgbrBIcrm5BVEMXRlCfZ
 rSubC6gsHTGnaOJcUnQgB/7zJd1aenhVasCEjs/rbOlsgfSmSBy7wsXt9WBgpzC2cY4+
 U+bDd163xGcVw5DDj4BL5hLtIdSzoWa5VE/jucNKgQEHPG3N3bqlyC+bRmAqrxZb8m05
 CeBCqY2CI3L4qsklz57xs/pZtby2WJci38gg5xVjh1bQex66N2KBLp2oKI/pltYH8BU7
 zOeB/KqmTwcj31zZTtzuh0CbtqyMjVlA3SuwOlh5COj0ghlD3oTpokTlByYVjqgklNTj
 ZXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RId/V9E10XfD9eu91CAoNJ+No5yJB8NKzqB1bY2T1yY=;
 b=XDytysG9/N6HpLBiEtZGYD0emGCsyAa2Nm7CQn/+pz17KP7j2QNpTWBssk5ru0RZx7
 KIE5cXMhahyJA6q8K4otXIz8n4YmI24gBqwfZC7KIXaFzJpX58gkd6WKKj0+6A5hRx9T
 kjxUyW80bw4PJIgeIs7UFSVFYmREPardnyVBgqoKnir/PKLfZoheJ+VqBhVTXcJmdn+L
 Xh0ESuVu56D9hdnMOT/zrasaxVLy44G3tBkYq8Q75wFkuruyDWjSLWtjDBjOC0ZRxmRZ
 7PPXG1v9K80bOW95St3qWLeExZuqZb02aWbugVxLRnxHkgPGw1kcI4HPfNrJfr3PCGkm
 XkNA==
X-Gm-Message-State: AOAM532xfvJnP6AdhScCH1m7hK2m65iXcfEJZhC6gxdPDxHj67bnteuB
 43rZ3lPDP7pXNxfHuq9f6Fs=
X-Google-Smtp-Source: ABdhPJwyR0OODyG9Uyg74i7AJoODr2bVJIgBAQCPLh2tDRJFcSa8pBvO2iVWzfi28efHFcrZuPN0zA==
X-Received: by 2002:a05:600c:2147:: with SMTP id
 v7mr12222250wml.101.1590825772113; 
 Sat, 30 May 2020 01:02:52 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z206sm2872848wmg.30.2020.05.30.01.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2020 01:02:51 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for sh4 QEMU advent
 calendar image
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200515164337.4899-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cf291a37-2467-4297-42af-17194889a9d6@amsat.org>
Date: Sat, 30 May 2020 10:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200515164337.4899-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 6:43 PM, Thomas Huth wrote:
> Now that we can select the second serial console in the acceptance tests
> (see commit 746f244d9720 "Allow to use other serial consoles than default"),
> we can also test the sh4 image from the QEMU advent calendar 2018.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  I've split my original patch that also added yet another mips64 test...
>  I hope it's easier to review/ack/merge this way this only addresses sh4 here.
> 
>  .travis.yml                            |  2 +-
>  tests/acceptance/boot_linux_console.py | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index fe708792ca..84b7f83ac4 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -291,7 +291,7 @@ jobs:
>      - name: "GCC check-acceptance"
>        dist: bionic
>        env:
> -        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
> +        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>          - TEST_CMD="make check-acceptance"
>          - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
>        after_script:
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index c6b06a1a13..0653c8c1bf 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -826,12 +826,12 @@ class BootLinuxConsole(Test):
>          console_pattern = 'No filesystem could mount root'
>          self.wait_for_console_pattern(console_pattern)
>  
> -    def do_test_advcal_2018(self, day, tar_hash, kernel_name):
> +    def do_test_advcal_2018(self, day, tar_hash, kernel_name, console=0):
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day' + day + '.tar.xz')
>          file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
>          archive.extract(file_path, self.workdir)
> -        self.vm.set_console()
> +        self.vm.set_console(console_index=console)
>          self.vm.add_args('-kernel',
>                           self.workdir + '/day' + day + '/' + kernel_name)
>          self.vm.launch()
> @@ -905,6 +905,15 @@ class BootLinuxConsole(Test):
>          self.vm.add_args('-M', 'graphics=off')
>          self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
>  
> +    def test_sh4_r2d(self):
> +        """
> +        :avocado: tags=arch:sh4
> +        :avocado: tags=machine:r2d
> +        """
> +        tar_hash = 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
> +        self.vm.add_args('-append', 'console=ttySC1')
> +        self.do_test_advcal_2018('09', tar_hash, 'zImage', console=1)
> +
>      def test_sparc_ss20(self):
>          """
>          :avocado: tags=arch:sparc
> 


