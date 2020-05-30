Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7282074A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruMuULfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7282074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jexGq-0003zO-J4
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 04:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jexG3-0003La-Au
 for qemu-devel@nongnu.org; Sat, 30 May 2020 04:54:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jexG2-0000m4-2z
 for qemu-devel@nongnu.org; Sat, 30 May 2020 04:54:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id x6so6384148wrm.13
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CRmzcX4rRZM74fmsK/kW9fgNGLGIjfoZFbMjMhb217w=;
 b=ruMuULfRjLMDcnfy+2DVzONDg9wdW9LBNaeQm7fu4YEKLIDLQlXoWZmYVNbaBISsYk
 XZ5E7SZCxogpOD8SPQbtq0MEKPLqJU+SbWJAoiJVcM2l5NHnP7Si57ezP3FAS+oXVADt
 87c4Myv3NjRW57JUB3CH6sUBMNQhjFMwoQqAoOWYs1/X+GnBlxq4XxxFD1EQc4tbIElQ
 5/a67/u4JcwwzS8xb5I4006lEYUTq/eH5NTBmozfk23INU5RblTZyS/M5w5yQ35zq+xl
 NT9JW45+h8XGfoTSIdcxrRXgylgUsbjzW6GWHhyjU9rEvWyZfWClje2wBQeS5VflpGa1
 KDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CRmzcX4rRZM74fmsK/kW9fgNGLGIjfoZFbMjMhb217w=;
 b=n6XvvPRYpgLwXwAn2ZCehzhxCo9BMwjCdFwGB7xvmOLcTIgq3nlc1jup8/O6WsKB9d
 57lOk/FD6SRh1ExQ0JQDTHHmY2rOBEjMnAXQTidMdnL5nK/2neW8wlVuDiggmt2E1FbA
 Ky4GbrzYkdBc1JtO1e/1mrwOBHzIvzhTXlG82SBbaZpSNT2Kvm5kt3tBsdoT859iBqAh
 l+5e66KejSZC/nF7RjQC9vn6qFe9mAm4RDPdrZB9DuD59rjaiQmhm6EjQy7AVkxheqsL
 +qm0cfrVCy+gcLDkBQ7M4O8X4/BtPYnwqxB7C4mAEB9VYIBx7+sre/+XAsBJqW6L5p3l
 sXtQ==
X-Gm-Message-State: AOAM531vGV6wt5VMMhudbZ53CP70o8JJvpHSvVTGRn4GxtA4v3gBtOMZ
 y1MinMqPmwVaSNiUgocQniG9aL5Iaeje+eIrSfU=
X-Google-Smtp-Source: ABdhPJzwLQlf6tUjbQ50jUmrpcDgd1LnbqbyoNw8kOVvI/17g/aRmatocmTeAXkcQ9VuHNVq4rSRglvWAhHdx0ETBNs=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr9593317wrv.162.1590828859892; 
 Sat, 30 May 2020 01:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200515164337.4899-1-thuth@redhat.com>
In-Reply-To: <20200515164337.4899-1-thuth@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 30 May 2020 10:54:05 +0200
Message-ID: <CAHiYmc72cA9Va_JCbzq+E0M3wUuxedH2=BdE-YqAqWF8DBD_kA@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Add boot tests for sh4 QEMU advent
 calendar image
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000017a80f05a6d9b599"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000017a80f05a6d9b599
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

18:44 Pet, 15.05.2020. Thomas Huth <thuth@redhat.com> =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Now that we can select the second serial console in the acceptance tests
> (see commit 746f244d9720 "Allow to use other serial consoles than
default"),
> we can also test the sh4 image from the QEMU advent calendar 2018.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I've split my original patch that also added yet another mips64 test...
>  I hope it's easier to review/ack/merge this way this only addresses sh4
here.
>

It makes sense to me, Thomas. If I were you, I would do the same.

But, sorry, do you intend to send mips64 counterpart in future, or it is
already sent, but I somehow missed it?

Thanks in advance!
Aleksandar

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
> -        - CONFIG=3D"--enable-tools
--target-list=3Daarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,micr=
oblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc=
-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-so=
ftmmu"
> +        - CONFIG=3D"--enable-tools
--target-list=3Daarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,micr=
oblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc=
-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softm=
mu,xtensa-softmmu"
>          - TEST_CMD=3D"make check-acceptance"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
>        after_script:
> diff --git a/tests/acceptance/boot_linux_console.py
b/tests/acceptance/boot_linux_console.py
> index c6b06a1a13..0653c8c1bf 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -826,12 +826,12 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'No filesystem could mount root'
>          self.wait_for_console_pattern(console_pattern)
>
> -    def do_test_advcal_2018(self, day, tar_hash, kernel_name):
> +    def do_test_advcal_2018(self, day, tar_hash, kernel_name, console=3D=
0):
>          tar_url =3D ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day' + day + '.tar.xz')
>          file_path =3D self.fetch_asset(tar_url, asset_hash=3Dtar_hash)
>          archive.extract(file_path, self.workdir)
> -        self.vm.set_console()
> +        self.vm.set_console(console_index=3Dconsole)
>          self.vm.add_args('-kernel',
>                           self.workdir + '/day' + day + '/' + kernel_name=
)
>          self.vm.launch()
> @@ -905,6 +905,15 @@ class BootLinuxConsole(Test):
>          self.vm.add_args('-M', 'graphics=3Doff')
>          self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
>
> +    def test_sh4_r2d(self):
> +        """
> +        :avocado: tags=3Darch:sh4
> +        :avocado: tags=3Dmachine:r2d
> +        """
> +        tar_hash =3D 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
> +        self.vm.add_args('-append', 'console=3DttySC1')
> +        self.do_test_advcal_2018('09', tar_hash, 'zImage', console=3D1)
> +
>      def test_sparc_ss20(self):
>          """
>          :avocado: tags=3Darch:sparc
> --
> 2.18.1
>
>

--00000000000017a80f05a6d9b599
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">18:44 Pet, 15.05.2020. Thomas Huth &lt;<a href=3D"mailto:thu=
th@redhat.com">thuth@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Now that we can select the second serial console in the acceptance tes=
ts<br>
&gt; (see commit 746f244d9720 &quot;Allow to use other serial consoles than=
 default&quot;),<br>
&gt; we can also test the sh4 image from the QEMU advent calendar 2018.<br>
&gt;<br>
&gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thu=
th@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0I&#39;ve split my original patch that also added yet another mip=
s64 test...<br>
&gt; =C2=A0I hope it&#39;s easier to review/ack/merge this way this only ad=
dresses sh4 here.<br>
&gt;</p>
<p dir=3D"ltr">It makes sense to me, Thomas. If I were you, I would do the =
same.</p>
<p dir=3D"ltr">But, sorry, do you intend to send mips64 counterpart in futu=
re, or it is already sent, but I somehow missed it?</p>
<p dir=3D"ltr">Thanks in advance!<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; =C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br=
>
&gt; =C2=A0tests/acceptance/boot_linux_console.py | 13 +++++++++++--<br>
&gt; =C2=A02 files changed, 12 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/.travis.yml b/.travis.yml<br>
&gt; index fe708792ca..84b7f83ac4 100644<br>
&gt; --- a/.travis.yml<br>
&gt; +++ b/.travis.yml<br>
&gt; @@ -291,7 +291,7 @@ jobs:<br>
&gt; =C2=A0 =C2=A0 =C2=A0- name: &quot;GCC check-acceptance&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0dist: bionic<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0env:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 - CONFIG=3D&quot;--enable-tools --target-=
list=3Daarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-so=
ftmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,=
ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu&quo=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 - CONFIG=3D&quot;--enable-tools --target-=
list=3Daarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-so=
ftmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,=
ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa=
-softmmu&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- TEST_CMD=3D&quot;make check-accept=
ance&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CACHE_NAME=3D&quot;${TRAVIS_BRANCH=
}-linux-gcc-acceptance&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0after_script:<br>
&gt; diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py<br>
&gt; index c6b06a1a13..0653c8c1bf 100644<br>
&gt; --- a/tests/acceptance/boot_linux_console.py<br>
&gt; +++ b/tests/acceptance/boot_linux_console.py<br>
&gt; @@ -826,12 +826,12 @@ class BootLinuxConsole(Test):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0console_pattern =3D &#39;No filesyst=
em could mount root&#39;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_for_console_pattern(consol=
e_pattern)<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 def do_test_advcal_2018(self, day, tar_hash, kernel_nam=
e):<br>
&gt; +=C2=A0 =C2=A0 def do_test_advcal_2018(self, day, tar_hash, kernel_nam=
e, console=3D0):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar_url =3D (&#39;<a href=3D"https:/=
/www.qemu-advent-calendar.org">https://www.qemu-advent-calendar.org</a>&#39=
;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&#39;/2018/download/day&#39; + day + &#39;.tar.xz&#39;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file_path =3D self.fetch_asset(tar_u=
rl, asset_hash=3Dtar_hash)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0archive.extract(file_path, self.work=
dir)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console(console_index=3Dconso=
le)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.add_args(&#39;-kernel&#39;,<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 self.workdir + &#39;/day&#39; + day + &#39;/&#39; + ke=
rnel_name)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.launch()<br>
&gt; @@ -905,6 +905,15 @@ class BootLinuxConsole(Test):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.add_args(&#39;-M&#39;, &#39;=
graphics=3Doff&#39;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.do_test_advcal_2018(&#39;15&#39=
;, tar_hash, &#39;invaders.elf&#39;)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 def test_sh4_r2d(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:sh4<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:r2d<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tar_hash =3D &#39;fe06a4fd8ccbf2e27928d64=
472939d47829d4c7e&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-append&#39;, &#39;=
console=3DttySC1&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_advcal_2018(&#39;09&#39;, ta=
r_hash, &#39;zImage&#39;, console=3D1)<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0def test_sparc_ss20(self):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Darch:sparc<br>
&gt; -- <br>
&gt; 2.18.1<br>
&gt;<br>
&gt;<br>
</p>

--00000000000017a80f05a6d9b599--

