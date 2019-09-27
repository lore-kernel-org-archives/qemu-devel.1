Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B93C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B30207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B30207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmeu-0005G2-9l
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDmcE-0003Xd-5V
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDmcC-0001kS-Rr
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDmcB-0001er-5I
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:32:40 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 937FAC059B6F
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:32:35 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id n3so776795wrt.9
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DwpJhusv19Kf7uW/6SoPIovbTqqjFa9/hPT2GzD2GuI=;
 b=M4nNQKT+0G9QHIhaIY1lunO+XRz8Yo2I/49mRsjsAHurUh+wOLrULtI2qxqcOsvlJY
 C6yi/y2S0aS3kU+OsU9sdqt3SQcRZ58CMPSVl7PPKeZr/VMt7SKblamFv1cvaTkcZ+jo
 L1ZLmLetD354L02SPzaj8hVZ5DnmoUNw2unDhX5uxxqz4eOBGtzOYy1+vchspiD1S+xG
 96lXkgR3a+tXHJ+Q+734MjjwyfuEbmVEobCB/XCFfj04j2mbrT4xtCJp3Wutiw72m9Ey
 ukOOC8fCt+oOwfKIJTkgayGTxhrScMoRBwpgHsk/OJBS3IFqWD3zGUXphJ08EsWvB4pX
 Ipqg==
X-Gm-Message-State: APjAAAVCbbaBCT3N1CBD1cJSYaLTsMjqUCLsyhW1iR0JkvxW1XDeMXPr
 PsPaDWevDEd5vfeDVGKzjlgraZ3Krc1PyHiPseE0ZBwDRrD+rwHchl7d5OarPaX8uh2zA3YkS8V
 3qAlsA3xegy/5cyI=
X-Received: by 2002:a1c:4945:: with SMTP id w66mr6306619wma.40.1569576754296; 
 Fri, 27 Sep 2019 02:32:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWJDiWsnrCMIF9ZS+aY0tt36mVtCm2chLSZbHGD9ps9GDY8qehpnBOQYrH72QxmSQIv3W9bA==
X-Received: by 2002:a1c:4945:: with SMTP id w66mr6306576wma.40.1569576754012; 
 Fri, 27 Sep 2019 02:32:34 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c10sm2967411wrf.58.2019.09.27.02.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2019 02:32:33 -0700 (PDT)
Subject: Re: [PATCH v13 0/9] hw/m68k: add Apple Machintosh Quadra 800 machine
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190927090453.24712-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <93f44eff-bcb5-8dde-0b71-b3e3a8e8aacf@redhat.com>
Date: Fri, 27 Sep 2019 11:32:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190927090453.24712-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 11:04 AM, Laurent Vivier wrote:
> I'm rebasing some of these patches for seven years now,
> too many years...
>=20
> if you want to test the machine, I'm sorry, it doesn't boot
> a MacROM, but you can boot a linux kernel from the command line.
>=20
> You can install your own disk using debian-installer, with:
>=20
>     ...
>     -M q800 \
>     -serial none -serial mon:stdio \
>     -m 1000M \
>     -net nic,model=3Ddp83932,addr=3D09:00:07:12:34:57 \
>     -append "console=3DttyS0 vga=3Doff" \
>     -kernel vmlinux-4.16.0-1-m68k \
>     -initrd initrd.gz \
>     -drive file=3Ddebian-10.0-m68k-NETINST-1.iso,media=3Dcdrom \
>     -drive file=3Dm68k.qcow2,format=3Dqcow2 \
>     -nographic
>=20
> If you use a graphic adapter instead of "-nographic", you can use "-g" =
to set the
> size of the display (I use "-g 1600x800x24").
>=20
> You can get the ISO from:
>=20
> https://cdimage.debian.org/cdimage/ports/10.0/m68k/iso-cd/debian-10.0-m=
68k-NETINST-1.iso
>=20
> and extract the kernel and initrd.gz:
>=20
> guestfish --add debian-10.0-m68k-NETINST-1.iso --ro \
>           --mount /dev/sda:/ <<_EOF_
> copy-out /install/cdrom/initrd.gz .
> copy-out /install/kernels/vmlinux-4.16.0-1-m68k .
> _EOF_
>=20
> The mirror to use is: http://ftp.ports.debian.org/debian-ports/
> when it fails, continue without boot loader.
>=20
> In the same way, you can extract the kernel and the initramfs from the =
qcow2
> image to use it with "-kernel" and "-initrd":
>=20
> guestfish --add m68k.qcow2 --mount /dev/sda2:/ <<_EOF_
> copy-out /boot/vmlinux-4.16.0-1-m68k .
> copy-out /boot/initrd.img-4.16.0-1-m68k .
> _EOF_
>=20
> and boot with:
>=20
>    ...
>    -append "root=3D/dev/sda2 rw console=3DttyS0 console=3Dtty \
>    -kernel vmlinux-4.16.0-1-m68k \
>    -initrd initrd.img-4.16.0-1-m68k
>=20
> NOTE: DHCP doesn't work but you can assign a static IP address.

Series:
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
(on x86 host)

