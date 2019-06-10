Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B880C4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227DB206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227DB206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49434 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haQWI-0008F5-Cm
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 16:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1haQVK-0007n6-G4
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1haQVJ-0003yi-Ab
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:02:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1haQVJ-0003yU-2D
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:02:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 236C830B46F1;
 Mon, 10 Jun 2019 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-147.rdu2.redhat.com
 [10.10.123.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 725BC1001B11;
 Mon, 10 Jun 2019 20:02:42 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-5-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <aca0a208-9f6f-5d68-eedb-e10377eefdae@redhat.com>
Date: Mon, 10 Jun 2019 17:02:39 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190607152223.9467-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 10 Jun 2019 20:02:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/8] Boot Linux Console Test: add a test
 for ppc64 + pseries
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
Cc: Fam Zheng <fam@euphon.net>,
 "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Caio Carrara <ccarrara@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

On 06/07/2019 12:22 PM, Cleber Rosa wrote:
> Just like the previous tests, boots a Linux kernel on a ppc64 target
> using the pseries machine.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   .travis.yml                            |  2 +-
>   tests/acceptance/boot_linux_console.py | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 9f8e73f276..5592e458ab 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -224,7 +224,7 @@ matrix:
>  =20
>       # Acceptance (Functional) tests
>       - env:
> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-=
softmmu,alpha-softmmu"
> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-=
softmmu,alpha-softmmu,ppc64-softmmu"
>           - TEST_CMD=3D"make check-acceptance"
>         after_failure:
>           - cat tests/results/latest/job.log
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index d5c500ea30..a196636367 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -217,3 +217,22 @@ class BootLinuxConsole(Test):
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
>           self.wait_for_console_pattern(console_pattern)
> +
> +    def test_ppc64_pseries(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:pseries
> +        """
> +        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora=
-secondary/'
> +                      'releases/29/Everything/ppc64le/os/ppc/ppc64/vml=
inuz')
> +        kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc77'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> +
> +        self.vm.set_machine('pseries')
> +        self.vm.set_console()
> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'con=
sole=3Dhvc0'
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
> +        self.wait_for_console_pattern(console_pattern)

I'm refactoring the acceptance tests which boot a Linux Kernel so that=20
they can share common functions. My latest implementation [1] was=20
re-based on this patch, and it would help manage my contribution if we=20
could merge this very soon.

Anyway, tested this patch on my Fedora 30 x86_64 machine. Passed.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

[1]=C2=A0 https://github.com/wainersm/qemu/tree/acceptance_boot_linux

