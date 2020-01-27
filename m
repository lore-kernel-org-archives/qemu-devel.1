Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC68CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9652F207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSPVWkRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9652F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8Fq-0007Ud-Pk
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iw8FB-0006tD-LV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iw8FA-0006Kz-1v
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:32:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iw8F9-0006Ka-Ve
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580146331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kve6WsScH6Rw3zz2OWiy/XhVgL6ADMEkxm2nkppv0G0=;
 b=cSPVWkRIaO/wZ4BUm+tjQnmFo0KVA5IXO+fL0yqrAxxyktbAYrfXadu4Dc8fk8w5A/+mFu
 Y8mau9O0vi60a2iOWHzmqYUUsldpfbD52JB9K9vSutHPKRzg6AJztJXszV4b62PdqOoQMc
 IdynCWilcG41FqY0Qa7I2IfWTGIDid0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-Eb8UangBOa-TbFkKVMk48Q-1; Mon, 27 Jan 2020 12:31:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A77D107B7DD;
 Mon, 27 Jan 2020 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC7071084381;
 Mon, 27 Jan 2020 17:31:51 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200124170325.30072-1-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <555bf60c-0d72-3ea3-f095-8c6c7a621deb@redhat.com>
Date: Mon, 27 Jan 2020 15:31:50 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200124170325.30072-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Eb8UangBOa-TbFkKVMk48Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/24/20 3:03 PM, Thomas Huth wrote:
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
>  =20
>       # Acceptance (Functional) tests
>       - env:
> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-soft=
mmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
> +        - CONFIG=3D"--target-list=3Daarch64-softmmu,alpha-softmmu,arm-so=
ftmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-s=
oftmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x=
86_64-softmmu,xtensa-softmmu"
>           - TEST_CMD=3D"make check-acceptance"
>         after_script:
>           - python3 -c 'import json; r =3D json.load(open("tests/results/=
latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["stat=
us"] not in ("PASS", "SKIP")]' | xargs cat
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index e03add2989..f7ac2a3a59 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -584,3 +584,99 @@ class BootLinuxConsole(Test):
>           self.wait_for_console_pattern(console_pattern)
>           console_pattern =3D 'No filesystem could mount root'
>           self.wait_for_console_pattern(console_pattern)
> +
> +    def do_test_advcal_2018(self, day, tar_hash, kernel_name):
> +        tar_url =3D ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day' + day + '.tar.xz')
> +        file_path =3D self.fetch_asset(tar_url, asset_hash=3Dtar_hash)
> +        archive.extract(file_path, self.workdir)
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel',
> +                         self.workdir + '/day' + day + '/' + kernel_name=
)
> +        self.vm.launch()
> +        self.wait_for_console_pattern('QEMU advent calendar')
> +
> +    def test_arm_vexpressa9(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:vexpress-a9
> +        """
> +        tar_hash =3D '32b7677ce8b6f1471fb0059865f451169934245b'
> +        self.vm.add_args('-dtb', self.workdir + '/day16/vexpress-v2p-ca9=
.dtb')
> +        self.do_test_advcal_2018('16', tar_hash, 'winter.zImage')
> +
> +    def test_m68k_mcf5208evb(self):
> +        """
> +        :avocado: tags=3Darch:m68k
> +        :avocado: tags=3Dmachine:mcf5208evb
> +        """
> +        tar_hash =3D 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
> +        self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
> +
> +    def test_microblaze_s3adsp1800(self):
> +        """
> +        :avocado: tags=3Darch:microblaze
> +        :avocado: tags=3Dmachine:petalogix-s3adsp1800
> +        """
> +        tar_hash =3D '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
> +        self.do_test_advcal_2018('17', tar_hash, 'ballerina.bin')
> +
> +    def test_or1k_sim(self):
> +        """
> +        :avocado: tags=3Darch:or1k
> +        :avocado: tags=3Dmachine:or1k-sim
> +        """
> +        tar_hash =3D '20334cdaf386108c530ff0badaecc955693027dd'
> +        self.do_test_advcal_2018('20', tar_hash, 'vmlinux')
> +
> +    def test_nios2_10m50(self):
> +        """
> +        :avocado: tags=3Darch:nios2
> +        :avocado: tags=3Dmachine:10m50-ghrd
> +        """
> +        tar_hash =3D 'e4251141726c412ac0407c5a6bceefbbff018918'
> +        self.do_test_advcal_2018('14', tar_hash, 'vmlinux.elf')
> +
> +    def test_ppc64_e500(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:ppce500
> +        """
> +        tar_hash =3D '6951d86d644b302898da2fd701739c9406527fe1'
> +        self.vm.add_args('-cpu', 'e5500')
> +        self.do_test_advcal_2018('19', tar_hash, 'uImage')
> +
> +    def test_ppc_g3beige(self):
> +        """
> +        :avocado: tags=3Darch:ppc
> +        :avocado: tags=3Dmachine:g3beige
> +        """
> +        tar_hash =3D 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> +        self.vm.add_args('-M', 'graphics=3Doff')
> +        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')

Hi Thomas, let me check one thing...

The VM will be launched as:

----

ppc-softmmu/qemu-system-ppc -display none -vga none -chardev=20
socket,id=3Dmon,path=3D/tmp/tmpvdokyvs3/qemu-41146-monitor.sock -mon=20
chardev=3Dmon,mode=3Dcontrol -machine g3beige -chardev=20
socket,id=3Dconsole,path=3D/tmp/tmpvdokyvs3/qemu-41146-console.sock,server,=
nowait=20
-serial chardev:console -M graphics=3Doff -kernel=20
/tmp/avocado_g3uccfo5/avocado_job_61gglyz3/02-tests_acceptance_boot_linux_c=
onsole.py_BootLinuxConsole.test_ppc_g3beige/day15/invaders.elf

----

Note that it passes '[..] -machine g3beige [...] -M graphics=3Doff [...]'.=
=20
I suspect you wanted '-machine g3beige,graphics=3Doff'. am I right? or=20
QEMU will interpret the -M option as a parameter of the already set=20
machine type? or the -M overwrites -machine, and because=C2=A0 g3beige is t=
he=20
default type it just works?

Anyway, It happens that avocado_qemu will automatically convert the=20
':avocado: tags=3Dmachine:g3beige' into QEMU's '-machine g3beige', but=C2=
=A0=20
`self.vm.add_args('-M', 'graphics=3Doff')` doesn't actually append=20
'graphics=3Doff` to '-machine' (i.e. `add_args` appends to QEMU's=20
parameters list instead). So if you want '-machine g3beige,graphics=3Doff'=
=20
you should overwrite its value with:

self.vm.set_machine('-machine g3beige,graphics=3Doff')

Thanks,

Wainer

> +
> +    def test_ppc_mac99(self):
> +        """
> +        :avocado: tags=3Darch:ppc
> +        :avocado: tags=3Dmachine:mac99
> +        """
> +        tar_hash =3D 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> +        self.vm.add_args('-M', 'graphics=3Doff')
> +        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
> +
> +    def test_sparc_ss20(self):
> +        """
> +        :avocado: tags=3Darch:sparc
> +        :avocado: tags=3Dmachine:SS-20
> +        """
> +        tar_hash =3D 'b18550d5d61c7615d989a06edace051017726a9f'
> +        self.do_test_advcal_2018('11', tar_hash, 'zImage.elf')
> +
> +    def test_xtensa_lx60(self):
> +        """
> +        :avocado: tags=3Darch:xtensa
> +        :avocado: tags=3Dmachine:lx60
> +        """
> +        tar_hash =3D '49e88d9933742f0164b60839886c9739cb7a0d34'
> +        self.vm.add_args('-cpu', 'dc233c')
> +        self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.elf=
')


