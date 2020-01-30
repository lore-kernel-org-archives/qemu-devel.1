Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF25C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A022083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adp276Ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A022083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixIyo-0007N5-GK
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixIxn-0006cW-RZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixIxm-0005Bv-0N
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:11:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58853
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixIxl-0005BI-TK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580425865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGYgBklM21RGCI4ogN6CiAlVDJv+ayxsnimdT5Pw9BE=;
 b=adp276OtFi1k8IK76n9n35vW3NcFDHAJQoi5K/bFdGx+9w7LGGIE84ZfzAdYJwDIFpDq8S
 fFnDgSsojYCcreOSnqrcCMhh+oh5nO/DVKUUzvAQ8DMp80sQpfCTsY4rSrdTVBe14//9Pf
 rR/0Fln25fUj5EMnBjp0AYla7YHRKH8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-FazIMy1oNQqupYoI3M8_zA-1; Thu, 30 Jan 2020 18:11:00 -0500
Received: by mail-wm1-f70.google.com with SMTP id m18so1346872wmc.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 15:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iGYgBklM21RGCI4ogN6CiAlVDJv+ayxsnimdT5Pw9BE=;
 b=d+Lh7S1mLPPzwOZY275F0pSDbjrX3nm4e3XmQmAwxWh3pJeKgyv+n/uT35vsSV7hLg
 HvytUgOa+VehhsH6AVQE7z+f8mpkN0gff5AaVYpGEv63Sh2P2DUpq9aEovot/46nZhAP
 C8VIcq3svgTbLf2A5/vB7UbgzoNSHMzVV8UAJjPYarVzcxQGApPOvL75KCWLpw4V5SC7
 ZDjXT1IgFv6s2XbZqFJ0hlnxuw80IwOwPfX0l5CjztszmQsl1YsDs6MKK2GtK3EUoWVw
 jHKKq3LZnwlEzcWFgGAsgv9pkfUp7XGB4NuurGm82S7HxYrVxjkotlttHrKeIl5aJXyR
 XSMQ==
X-Gm-Message-State: APjAAAVfBxoF8XJH1XT0rF+sMnzzpVNC6/VAyixGgVzWtjCAxlH1Wale
 NOmKrg78E9/x8yUV7nth5QFphw4cnTmWkm6o8LTHlPfQGWwCAzfqCZ9YRm+rsRtCo8DBHKvo2Wt
 T1UBldLgPbjdCa7M=
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr7914447wmg.86.1580425858406;
 Thu, 30 Jan 2020 15:10:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwgHMRYbV5VkTZS1PAnCszQHNt6GTjhHOZdLx3Q7ClFNKWEG7e30g9ligjaIb/2I2fuwTSYTQ==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr7914429wmg.86.1580425858179;
 Thu, 30 Jan 2020 15:10:58 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z11sm9245907wrt.82.2020.01.30.15.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 15:10:57 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200124170325.30072-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2e4ed23c-01f4-3bb5-d7c2-d1b74751ecf1@redhat.com>
Date: Fri, 31 Jan 2020 00:10:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124170325.30072-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: FazIMy1oNQqupYoI3M8_zA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 6:03 PM, Thomas Huth wrote:
> The 2018 edition of the QEMU advent calendar 2018 featured Linux images
> for various non-x86 machines. We can use them for a boot tests in our
> acceptance test suite.
> 
> Let's also make sure that we build the corresponding machines in Travis,
> and while we're there, drop the superfluous --python parameter (python3
> is now the only supported version anyway).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml                            |  2 +-
>   tests/acceptance/boot_linux_console.py | 96 ++++++++++++++++++++++++++
>   2 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 6c1038a0f1..73ca12c921 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -268,7 +268,7 @@ matrix:
>   
>       # Acceptance (Functional) tests
>       - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
> +        - CONFIG="--target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>           - TEST_CMD="make check-acceptance"
>         after_script:
>           - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index e03add2989..f7ac2a3a59 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -584,3 +584,99 @@ class BootLinuxConsole(Test):
>           self.wait_for_console_pattern(console_pattern)
>           console_pattern = 'No filesystem could mount root'
>           self.wait_for_console_pattern(console_pattern)
> +
> +    def do_test_advcal_2018(self, day, tar_hash, kernel_name):
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day' + day + '.tar.xz')
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        archive.extract(file_path, self.workdir)
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel',
> +                         self.workdir + '/day' + day + '/' + kernel_name)
> +        self.vm.launch()
> +        self.wait_for_console_pattern('QEMU advent calendar')
> +
> +    def test_arm_vexpressa9(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:vexpress-a9
> +        """
> +        tar_hash = '32b7677ce8b6f1471fb0059865f451169934245b'
> +        self.vm.add_args('-dtb', self.workdir + '/day16/vexpress-v2p-ca9.dtb')
> +        self.do_test_advcal_2018('16', tar_hash, 'winter.zImage')
> +
> +    def test_m68k_mcf5208evb(self):
> +        """
> +        :avocado: tags=arch:m68k
> +        :avocado: tags=machine:mcf5208evb
> +        """
> +        tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
> +        self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
> +
> +    def test_microblaze_s3adsp1800(self):
> +        """
> +        :avocado: tags=arch:microblaze
> +        :avocado: tags=machine:petalogix-s3adsp1800
> +        """
> +        tar_hash = '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
> +        self.do_test_advcal_2018('17', tar_hash, 'ballerina.bin')
> +
> +    def test_or1k_sim(self):
> +        """
> +        :avocado: tags=arch:or1k
> +        :avocado: tags=machine:or1k-sim
> +        """
> +        tar_hash = '20334cdaf386108c530ff0badaecc955693027dd'
> +        self.do_test_advcal_2018('20', tar_hash, 'vmlinux')
> +
> +    def test_nios2_10m50(self):
> +        """
> +        :avocado: tags=arch:nios2
> +        :avocado: tags=machine:10m50-ghrd
> +        """
> +        tar_hash = 'e4251141726c412ac0407c5a6bceefbbff018918'
> +        self.do_test_advcal_2018('14', tar_hash, 'vmlinux.elf')
> +
> +    def test_ppc64_e500(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:ppce500
> +        """
> +        tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
> +        self.vm.add_args('-cpu', 'e5500')
> +        self.do_test_advcal_2018('19', tar_hash, 'uImage')
> +
> +    def test_ppc_g3beige(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:g3beige
> +        """
> +        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> +        self.vm.add_args('-M', 'graphics=off')
> +        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
> +
> +    def test_ppc_mac99(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:mac99
> +        """
> +        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> +        self.vm.add_args('-M', 'graphics=off')
> +        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
> +
> +    def test_sparc_ss20(self):
> +        """
> +        :avocado: tags=arch:sparc
> +        :avocado: tags=machine:SS-20
> +        """
> +        tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
> +        self.do_test_advcal_2018('11', tar_hash, 'zImage.elf')
> +
> +    def test_xtensa_lx60(self):
> +        """
> +        :avocado: tags=arch:xtensa
> +        :avocado: tags=machine:lx60
> +        """
> +        tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
> +        self.vm.add_args('-cpu', 'dc233c')
> +        self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.elf')
> 

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


