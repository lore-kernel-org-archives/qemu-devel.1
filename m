Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55844C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2159320714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oxqisnk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2159320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TSE-00075U-9I
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 06:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1j1TRH-0006Al-VA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1j1TRG-0005nG-Ja
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:10:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37940
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1j1TRG-0005lv-Ei
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581419445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=LF3iZY2+FyjgrZp1dewSUjRwYUz2q83j/GcnUSbaX2o=;
 b=Oxqisnk9ryZi31sKboOqLiwH351zLMbzLgcCAxRcjHPlA3fJwvrgU8gjl5t2WpE5aHaWwz
 BQhmrOWrY2bWEZjV5NF+MjDK9efpIbwXJfElEvQjqIoybHsvZCCG0bbVDa2WX4itSSCnwJ
 UwSRLFDy0WHKf8hq2hroku0a+2zLmpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-2qSJPQnqNAOCQL9IHGBB-Q-1; Tue, 11 Feb 2020 06:10:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AFADDB76;
 Tue, 11 Feb 2020 11:10:39 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-131.ams2.redhat.com [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EA115C1D6;
 Tue, 11 Feb 2020 11:10:28 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for sh4 and mips64 QEMU
 advent calendar images
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20200211094239.20725-1-thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b94d0be7-c87f-ae16-b98d-46a9da6d6666@redhat.com>
Date: Tue, 11 Feb 2020 12:10:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200211094239.20725-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 2qSJPQnqNAOCQL9IHGBB-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/02/2020 10.42, Thomas Huth wrote:
> Now that we can select the second serial console in the acceptance tests
> (see commit 746f244d9720 "Allow to use other serial consoles than default"),
> we can also test the sh4 image from the QEMU advent calendar 2018.
> 
> And another recent commit (ec860426dfbe "Fix handling of LL/SC instructions")
> fixed a problem with qemu-system-mips64, so the mips64 from the advent
> calendar now works again and can be used for acceptance testing, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml                            |  2 +-
>  tests/acceptance/boot_linux_console.py | 23 +++++++++++++++++++++--
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 5887055951..71a0097878 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -313,7 +313,7 @@ matrix:
>      # Acceptance (Functional) tests
>      - name: "GCC check-acceptance"
>        env:
> -        - CONFIG="--target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
> +        - CONFIG="--target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>          - TEST_CMD="make check-acceptance"
>        after_script:
>          - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 34d37eba3b..a38ee004b1 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -591,12 +591,12 @@ class BootLinuxConsole(Test):
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
> @@ -670,6 +670,25 @@ class BootLinuxConsole(Test):
>          self.vm.add_args('-M', 'graphics=off')
>          self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
>  
> +    def test_mips64_malta(self):
> +        """
> +        :avocado: tags=arch:mips64
> +        :avocado: tags=machine:malta
> +        :avocado: tags=endian:big
> +        """
> +        tar_hash = '81b030201ec3f28cb1925297f6017d3a20d7ced5'
> +        self.vm.add_args('-hda', self.workdir + '/day22/' + 'ri-li.qcow2',
> +                         '-append', 'root=/dev/hda')
> +        self.do_test_advcal_2018('22', tar_hash, 'vmlinux')

It's maybe nicer to place the malta test alphabetically earlier ... I'll
send a v2...

> +    def test_sh4_r2d(self):
> +        """
> +        :avocado: tags=arch:sh4
> +        :avocado: tags=machine:r2d
> +        """
> +        tar_hash = 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
> +        self.do_test_advcal_2018('09', tar_hash, 'zImage', console=1)
> +
>      def test_sparc_ss20(self):
>          """
>          :avocado: tags=arch:sparc
> 

 Thomas


