Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FC7C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A7F2467F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XL7OEEJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A7F2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaY5-0003Dx-IH
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBaX7-0002m1-K9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBaX6-0004Mw-CR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:46:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBaX6-0004MH-97
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583829995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkhVZ6lOZC5W2OaKc+FZBHjLhOZpp3lnkHPbDAGvK7s=;
 b=XL7OEEJANxGMThMC4n1sOoa3W31MeRHNLka9NbDnP9f0yZcCDZcbD4UQ7zuP3WJaE39ebJ
 ZU4w0Og3JSuuq0dvaVFLxDQM6N8ZyemytOZUGvoiBiaZXsA1IuX+Ri/MSg2klGJehlQmxq
 /gWHVXCPT9hB39nkRZ4ljB6QeoY2z/U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-8LvsNkN2OGeqRPWC2g960g-1; Tue, 10 Mar 2020 04:46:34 -0400
X-MC-Unique: 8LvsNkN2OGeqRPWC2g960g-1
Received: by mail-wm1-f69.google.com with SMTP id g26so109873wmk.6
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 01:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JNg0Cj7XpG1fVxEtNs2E/EGeKTKYzDrUj9+lhQ53ImE=;
 b=rS2wH9/F9xcWY88gtqPBHQwWWHRF7mY3BdoUWI1pQl65B24Kd0P0krvdOPex+ThiJU
 rApMQqRfOSaXerKaxEnhTFMojYbfuC9O/Zj0HK2uaQaGjhrTJV0bzsF6y5rlrCcKxEpk
 klHcB9xp95K6ZjxrpQ3KwC4n2bL6FiI+h0r8Rtgm2mR52Flxcsy7PkkCVBxTdiUg8krz
 ojcSdpCnSgtYrglSEqjlAIwbrR75CalIIgW5fOLGsuOTHFNyzGqm2DaxkJgWS8nynhB4
 VgDQOCw4HW+PXxbGnI48V3x6QTqLvTAQojPDz0ZCw9aLU66uYxAYR6jdBAS8cDT7UnHS
 kcSg==
X-Gm-Message-State: ANhLgQ30k17qspkQoVaJTxKWn/ZgejV7W8AKEmOYzPr5GrY8bQYAsKuW
 jC0SKFyHBtp6SrE8wWgKI0Qxo/2TtFgQGv5CU8bJfH/TCGMpupGI26/iFsStBnRA3tJMtSiPED9
 VEXQVFwSBJ4byeqI=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr993002wmj.137.1583829992707; 
 Tue, 10 Mar 2020 01:46:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtMaB5/54v65JAxZjAFfDFKyrKdmK/F26RxHmcaRXQ+9aiHE5rS7m6UirMEAG4Hl1fdsbaM0w==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr992978wmj.137.1583829992390; 
 Tue, 10 Mar 2020 01:46:32 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id 2sm29957593wrf.79.2020.03.10.01.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 01:46:31 -0700 (PDT)
Subject: Re: [PATCH 2/4] tests/vm: move vga setup
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6446a10d-6670-41bc-3392-e27a2a6b052c@redhat.com>
Date: Tue, 10 Mar 2020 09:46:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310083218.26355-3-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/10/20 9:32 AM, Gerd Hoffmann wrote:
> Move '-device VGA' from basevm.py to the guests, so they have
> the chance to opt out and run without display device.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/vm/basevm.py   | 1 -
>   tests/vm/fedora      | 1 +
>   tests/vm/freebsd     | 1 +
>   tests/vm/netbsd      | 1 +
>   tests/vm/openbsd     | 1 +
>   tests/vm/ubuntu.i386 | 5 ++++-
>   6 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index c53fd354d955..cffe7c4600ed 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -179,7 +179,6 @@ class BaseVM(object):
>  =20
>       def boot(self, img, extra_args=3D[]):
>           args =3D self._args + [
> -            "-device", "VGA",
>               "-drive", "file=3D%s,if=3Dnone,id=3Ddrive0,cache=3Dwritebac=
k" % img,
>               "-device", "virtio-blk,drive=3Ddrive0,bootindex=3D0"]
>           args +=3D self._data_args + extra_args
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index 4843b4175e07..bd9c6cf295c1 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -82,6 +82,7 @@ class FedoraVM(basevm.BaseVM):
>           self.boot(img_tmp, extra_args =3D [
>               "-bios", "pc-bios/bios-256k.bin",
>               "-machine", "graphics=3Doff",
> +            "-device", "VGA",
>               "-cdrom", iso
>           ])
>           self.console_init(300)
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 86770878b67b..58166766d915 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -92,6 +92,7 @@ class FreeBSDVM(basevm.BaseVM):
>           self.boot(img_tmp, extra_args =3D [
>               "-bios", "pc-bios/bios-256k.bin",
>               "-machine", "graphics=3Doff",
> +            "-device", "VGA",
>               "-cdrom", iso
>           ])
>           self.console_init()
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 55590f460152..f3257bc245a3 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -86,6 +86,7 @@ class NetBSDVM(basevm.BaseVM):
>           self.boot(img_tmp, extra_args =3D [
>               "-bios", "pc-bios/bios-256k.bin",
>               "-machine", "graphics=3Doff",
> +            "-device", "VGA",
>               "-cdrom", iso
>           ])
>           self.console_init()
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index ab6abbedab57..0b705f494527 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -82,6 +82,7 @@ class OpenBSDVM(basevm.BaseVM):
>           self.boot(img_tmp, extra_args =3D [
>               "-bios", "pc-bios/bios-256k.bin",
>               "-machine", "graphics=3Doff",
> +            "-device", "VGA",
>               "-cdrom", iso
>           ])
>           self.console_init()
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 3266038fbde5..157077533532 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -36,7 +36,10 @@ class UbuntuX86VM(basevm.BaseVM):
>           img_tmp =3D img + ".tmp"
>           subprocess.check_call(["cp", "-f", cimg, img_tmp])
>           self.exec_qemu_img("resize", img_tmp, "50G")
> -        self.boot(img_tmp, extra_args =3D ["-cdrom", self.gen_cloud_init=
_iso()])
> +        self.boot(img_tmp, extra_args =3D [
> +            "-device", "VGA",
> +            "-cdrom", self.gen_cloud_init_iso()
> +        ])
>           self.wait_ssh()
>           self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
>           self.ssh_root_check("apt-get update")
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


