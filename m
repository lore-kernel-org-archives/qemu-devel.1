Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354BCC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6218820795
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhdXTGgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6218820795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGpm-0000os-JW
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJGpC-0000Ny-8s
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJGpA-0005kl-9p
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600437195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6e58dfMIO8kOFZZjNV67cR3RSvPC4c8YOTVaSOJP61U=;
 b=QhdXTGgtn+4LKXYPCoGopMsuYizjPH12cgREV8aWULUmW6T2HN66VH/KGcGJu5+b2lBHLl
 25IESAHJRGNFLSlnNW21g/xf9GRfxjLFL9sFRKSZK7iwweaabiZ29Nc2nkwyUdp4Damgad
 HHfMKtvJHNBIRx21f6TI3TpYZTDsTmw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-exdnB2mUM4eWZ17SNRebyQ-1; Fri, 18 Sep 2020 09:53:05 -0400
X-MC-Unique: exdnB2mUM4eWZ17SNRebyQ-1
Received: by mail-oi1-f199.google.com with SMTP id j20so2630537oig.15
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6e58dfMIO8kOFZZjNV67cR3RSvPC4c8YOTVaSOJP61U=;
 b=AYJu8l9Fv6TqKlJm01jbSwEQHa1Aerhp7m8eDK3V+MnCCx1uxIb6QQ2WF4usalZSyb
 m0YsXpQuwnM4bA57s0yjFZnhBKkSlgu6x6RLReBIZ6RiOmbKU7YLGbmvlTLXtkdG4H+l
 dScTHyI7O2rKd39CFxIVz08FHJcUU4IeCITlssnjEdkfSJSPaH1H+9jXC3/EHfIMeOR2
 qQwMJeuKhHlBNA8J96BRgfMJyxBlRdd9Ka+lr95xPiXQG7cVX/YfMchpInlzjQsmXfFA
 9alDacDuR7y8wFldckTvVrhF3k+TzlIrzdn1i5glsp2C2u7q9mHemr/PeFqwUK3JDvvq
 mqkg==
X-Gm-Message-State: AOAM531A5Mod+cPQQNIY5lN9ehM4MysUKduzuz0RausdiSFmKGTYvdgx
 AyynSOeTlc+aDiXqphy8QJ4ZNkM7PZpfFWVSRczecwa+WV7hqYgmORkpXSFlhwau46Jr7loxlB3
 BNrOewSAipXd/pgJpviDTkdclUQENW4I=
X-Received: by 2002:a05:6830:1d5:: with SMTP id
 r21mr24768548ota.244.1600437185145; 
 Fri, 18 Sep 2020 06:53:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdF+MeiGy0ScrKirs2ImLFx7z0ixJ3kH9WpLjLzCPuECPuhcgYWJ8lQSr3kVOV3HLfAtOackFdzpMk8DB0m2w=
X-Received: by 2002:a05:6830:1d5:: with SMTP id
 r21mr24768532ota.244.1600437184904; 
 Fri, 18 Sep 2020 06:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200914140641.21369-1-peter.maydell@linaro.org>
 <20200914140641.21369-33-peter.maydell@linaro.org>
In-Reply-To: <20200914140641.21369-33-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 18 Sep 2020 15:52:54 +0200
Message-ID: <CAP+75-XNAKE8n7MffAsSJFO1EVzAmTZsv4COyZoFWKEOELOO5A@mail.gmail.com>
Subject: Re: [PULL 32/36] tests/acceptance: console boot tests for quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>,
 Cleber Rosa Junior <crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Havard,

On Mon, Sep 14, 2020 at 5:47 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> From: Havard Skinnemoen <hskinnemoen@google.com>
>
> This adds two acceptance tests for the quanta-gsj machine.
>
> One test downloads a lightly patched openbmc flash image from github and
> verifies that it boots all the way to the login prompt.
>
> The other test downloads a kernel, initrd and dtb built from the same
> openbmc source and verifies that the kernel detects all CPUs and boots
> to the point where it can't find the root filesystem (because we have no
> flash image in this case).
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> Message-id: 20200911052101.2602693-15-hskinnemoen@google.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
[...]
> +    def test_arm_quanta_gsj_initrd(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:quanta-gsj
> +        """
> +        initrd_url =3D (
> +                'https://github.com/hskinnemoen/openbmc/releases/downloa=
d/'
> +                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.xz=
')
> +        initrd_hash =3D '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
> +        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinitrd=
_hash)
> +        kernel_url =3D (
> +                'https://github.com/hskinnemoen/openbmc/releases/downloa=
d/'
> +                '20200711-gsj-qemu-0/uImage-gsj.bin')
> +        kernel_hash =3D 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +        dtb_url =3D (
> +                'https://github.com/hskinnemoen/openbmc/releases/downloa=
d/'
> +                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
> +        dtb_hash =3D '18315f7006d7b688d8312d5c727eecd819aa36a4'
> +        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200n8 '
> +                               'earlycon=3Duart8250,mmio32,0xf0001000')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0=
')
> +        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0'=
)
> +        self.wait_for_console_pattern(
> +                'Give root password for system maintenance')

This test is failing (timeout) on our CI:
https://gitlab.com/philmd/qemu/-/jobs/745483978#L857


