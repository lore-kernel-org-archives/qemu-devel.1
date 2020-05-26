Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD197C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD932073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6CFotiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD932073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcRl-00028q-Qn
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcQo-0001C5-Bk; Tue, 26 May 2020 12:27:58 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcQn-0001Vi-Cu; Tue, 26 May 2020 12:27:58 -0400
Received: by mail-io1-xd42.google.com with SMTP id o5so22648071iow.8;
 Tue, 26 May 2020 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5tBqtXYJu6MqQ0/JHvw/YkqqhCbb5FSWfs4YssNy1Zc=;
 b=Y6CFotivyIi96bMAYu+TXDwKNnLse7bKJHnwPCcR+8QYXUqmyQRrwgr6dkucalx+Eh
 IVrUu77YIg/ygGkZeXY0mw8UfmXpL6zojBWtZaA5X2y3etNLejxYOxJx2h5+pyPVO1Xv
 JJMUfsD23mNvObApIPJ5bhPmMElLu7ohAUnaMoLEkB3MlASIG27BIt2V2K0w3P89++Ip
 u89EKAGW6D1nJpYcAJKl3vBrKFuZEh8eI8N5XxDhwyDSMC7gyJck0Cj5E3zRnenquYmh
 mnBFydMwLsQotFwoPXwk/9Rdy0KYNg3hRt65VPPA5xvNcqkZ3GLFnAjVCr1Yzp8Sx6x5
 UdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5tBqtXYJu6MqQ0/JHvw/YkqqhCbb5FSWfs4YssNy1Zc=;
 b=Or8wDMCf5zM0Q/nflK9zs+Djhd1Pz3mfiuzI2m9W+FgD6RAoZppBHrgTeh9L5EZVyI
 UmamzrF35s/O0dShJOOgWX+/EdvwXiQ5RfTUdGc+UQBAZt1R8ZnNkSu/I7tdY1RdLo3O
 qK7LNhmizkUj0+tYeKeP3VQFCbdpOWDyrpUuHSMPjfqXX3K8/+jyqymAZKlnM920rNko
 dfxRMDjK5UpGMVAtp/7OphXJE6jpSE2TiO2q+s0OrpBObbN/W+niewK/TDo/EWWE85mo
 NFeRHsDm6wwh3crzs31X4CbPnpuCJ2hVS6cinZRdbnNuUfWdrTiGlKU4wgtXhwV+AWiF
 yYBg==
X-Gm-Message-State: AOAM532jIXMyh/mdInrHnLAsJ9VrSCSgZYHUxKiUJXJCtCvGbpEZOWZ9
 MkJfixlYwULBYkXtPgEZyTyhoYVz3ueg34exkFY=
X-Google-Smtp-Source: ABdhPJzTq6yUuhSRFiMxFuFmyy/qrAoEhYAPPkpFqRgao0mDhO9CzjBNq8biqiNDcedGGZSLh/Cu/42jkRkDRxbGRjE=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr18128397iol.105.1590510476036; 
 Tue, 26 May 2020 09:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200525141237.15243-1-thuth@redhat.com>
In-Reply-To: <20200525141237.15243-1-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:18:57 -0700
Message-ID: <CAKmqyKMLezOO+EsjhpDO5RPM9pJFxtnZ7XcA3POeyjNb4yAEtQ@mail.gmail.com>
Subject: Re: [PATCH v2] tests/acceptance: Add a boot test for the
 xlnx-versal-virt machine
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 7:13 AM Thomas Huth <thuth@redhat.com> wrote:
>
> As described by Edgar here:
>
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg605124.html
>
> we can use the Ubuntu kernel for testing the xlnx-versal-virt machine.
> So let's add a boot test for this now.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  v2: Added "tags=3Ddevice:pl011" and "tags=3Ddevice:arm_gicv3"
>
>  tests/acceptance/boot_linux_console.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 0653c8c1bf..965272387c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -307,6 +307,32 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
>
> +    def test_aarch64_xlnx_versal_virt(self):
> +        """
> +        :avocado: tags=3Darch:aarch64
> +        :avocado: tags=3Dmachine:xlnx-versal-virt
> +        :avocado: tags=3Ddevice:pl011
> +        :avocado: tags=3Ddevice:arm_gicv3
> +        """
> +        kernel_url =3D ('http://ports.ubuntu.com/ubuntu-ports/dists/'
> +                      'bionic-updates/main/installer-arm64/current/image=
s/'
> +                      'netboot/ubuntu-installer/arm64/linux')
> +        kernel_hash =3D '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +
> +        initrd_url =3D ('http://ports.ubuntu.com/ubuntu-ports/dists/'
> +                      'bionic-updates/main/installer-arm64/current/image=
s/'
> +                      'netboot/ubuntu-installer/arm64/initrd.gz')
> +        initrd_hash =3D 'd385d3e88d53e2004c5d43cbe668b458a094f772'
> +        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinitrd=
_hash)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-m', '2G',
> +                         '-kernel', kernel_path,
> +                         '-initrd', initrd_path)
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Checked W+X mappings: passed')
> +
>      def test_arm_virt(self):
>          """
>          :avocado: tags=3Darch:arm
> --
> 2.18.1
>
>

