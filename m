Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A45C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A642072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0OSRM6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A642072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1dp-00010Z-CS
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 11:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jK1cm-0000Dt-VD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jK1ck-0001pd-OC
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:19:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35157
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jK1ck-0001pH-KW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585840757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tXxonJR2Ro79pzA5pkgCU1QexH3x9D1Q0Te5iDDl1Y=;
 b=P0OSRM6oREeACop6j/d+h0CyIXB3+y67gT1855ZwUzHdS1n2lZMSrtmtRzlSpRkfGSzvUP
 LKB1GGdgWFuyLOjOxojh3UiU0jicL0IJXDiC09L16qe2Y2sHMPA5oQjuftLyKtxAF5lLz+
 11/Zg9WtCi/yQVKaDhvjk2Dmvhgx6Xs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-dDm3B-8ZMMWK8nQaX1zD_w-1; Thu, 02 Apr 2020 11:18:50 -0400
X-MC-Unique: dDm3B-8ZMMWK8nQaX1zD_w-1
Received: by mail-ed1-f69.google.com with SMTP id q29so3000107edc.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 08:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0DZFoKTZ16EbBxq9bBcIfbD8y0qqkXPsUVNaVNpbDTY=;
 b=kUQ2vWJJuz2vkwgEP+af8wFNivyjkOQ6AH1h8Vbe/aaKODXQZ57tKLPV8nA+7vrg63
 PfAw5CZEY68GycdLBen5hVSCQSrZbV1webfDNSvyl2bA3mgDu+nXOj9gyUsPwUXdNFLB
 0D8EritUJKlT0yqDCL+GnJwuezuQRKyv98Qppd9RDPpjtNPMA0mS1Rv+C62r9RZsI5kg
 FvhGXyRsy27ksPfh3NHyTuAKaNm22BnHdY9U1wOm270aUs6akdkd1XxK/2eibYviZeaa
 0ZWRSveaP53EdRtMRdRhTBS6J01RjalCwhu+aBeYQ9DhKyVnwcFYfxFq6lrZ/jTAGIPE
 NNGQ==
X-Gm-Message-State: AGi0PuZPhea4imwXCOv2s/enqR/PP69o16CogQ9BsMSIe0xNXJOSu4is
 WZSVyKUrAYpg1Xzz5Ssy/k4gSQGtzU6CwyhYH1L2vUW+5ysNBQ9g7pXE8JyRJBzU6E39Lw19GVu
 gYxTOs2cFJ3t4EgU=
X-Received: by 2002:a17:906:314e:: with SMTP id
 e14mr3802970eje.82.1585840729260; 
 Thu, 02 Apr 2020 08:18:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypJlQZnI0aux52yylg+sqdNtScuUfdpcKhWIeUPRetyzMQn1IXSaWrFTVy6nVNVaWACGw5MyKQ==
X-Received: by 2002:a17:906:314e:: with SMTP id
 e14mr3802931eje.82.1585840728828; 
 Thu, 02 Apr 2020 08:18:48 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id i5sm1002117ejs.76.2020.04.02.08.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 08:18:48 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
To: Willian Rampazzo <wrampazz@redhat.com>
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
 <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
 <e5384733-7812-1e05-fdf1-92c08c457c4f@redhat.com>
 <CAKJDGDaE_OjqigaxXSJRkv7wfouLV-tsDQaXnWJXpn4F8DkPwQ@mail.gmail.com>
 <96219ba3-c114-0cec-8ace-bc19b254077a@redhat.com>
 <CAKJDGDbXeDrDWgxoZ=+LwPmexestnXJxqD5Mcrq9C4Aiy9x3dg@mail.gmail.com>
 <d52e1d9d-f892-f760-6bca-e37689cff362@redhat.com>
 <581e054a-b3a0-fe3c-fc09-f9dcab7f08c7@redhat.com>
 <CAKJDGDZz+rzvrTbHDVY1ibgfq-7kpQXFJfqub5-Y-2s96nBQ4g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <482ba0fb-31f9-8cd1-7246-2e4dd969b87b@redhat.com>
Date: Thu, 2 Apr 2020 17:18:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKJDGDZz+rzvrTbHDVY1ibgfq-7kpQXFJfqub5-Y-2s96nBQ4g@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 3:25 PM, Willian Rampazzo wrote:
> On Thu, Apr 2, 2020 at 8:08 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>
>> This issue persists, OTOH the good news is caching is working:
>>
>> https://travis-ci.org/github/philmd/qemu/builds/670078763#L1626
>>
>=20
> Philippe, do you have a way to clean up the Travis cache and try it
> again? Last week, when I was investigating the previous problem you
> reported, I had the same issue as you are having now. The problem just
> disappeared without any action. I could not reproduce the problem now
> on an empty cache using the same command you used. I suspect the
> previous bug left some inconsistencies in the cache.

I dropped the cache but it still failed, then I used travis_retry which=20
succeeded:

https://travis-ci.org/github/philmd/qemu/jobs/670166259#L1711

avocado.test: Fetching=20
https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/NetBSD-7.1.2-prep.iso ->=20
/home/travis/avocado/data/cache/by_location/5fb821f368ac26c2d9eb044aef3eb70=
f5a956e92/NetBSD-7.1.2-prep.iso.hfxinpfu
Failed to fetch P12H0456.IMG.
/home/travis/build/philmd/qemu/tests/Makefile.include:910: recipe for=20
target 'fetch-acceptance-assets' failed
make: *** [fetch-acceptance-assets] Error 4

The command "make fetch-acceptance-assets DEBUG=3D1" failed. Retrying, 2 of=
 3.

   AVOCADO tests/acceptance
avocado.test: Asset not in cache, fetching it.
avocado.test: Fetching=20
ftp://ftp.boulder.ibm.com/rs6000/firmware/7020-40p/P12H0456.IMG ->=20
/home/travis/avocado/data/cache/by_location/9234e55550fdde347e2a4604c133fa2=
c8d9e9291/P12H0456.IMG.4_uenut0
The command "${TEST_CMD}" exited with 0.

FYI as of v5.0.0-rc1 Avocado cache takes 1985.15MB.

>=20
> [wrampazz@wrampazz qemu.philippe]$ avocado --config ../avocado.conf
> assets fetch tests/acceptance/*.py
> Fetching assets from tests/acceptance/boot_linux_console.py.
>    File https://archives.fedoraproject.org/pub/archive/fedora/linux/relea=
ses/29/Everything/x86_64/os/images/pxeboot/vmlinuz
> fetched or already on cache.
>    File http://snapshot.debian.org/archive/debian/20130217T032700Z/pool/m=
ain/l/linux-2.6/linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb
> fetched or already on cache.
>    File http://snapshot.debian.org/archive/debian/20130217T032700Z/pool/m=
ain/l/linux-2.6/linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb
> fetched or already on cache.
>    File http://snapshot.debian.org/archive/debian/20160601T041800Z/pool/m=
ain/l/linux/linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb
> fetched or already on cache.
>    File https://github.com/groeck/linux-build-test/raw/8584a59ed9e5eb5ee7=
ca91f6d74bbb06619205b8/rootfs/mips/rootfs.cpio.gz
> fetched or already on cache.
>    File https://github.com/philmd/qemu-testing-blob/raw/9ad2df38/mips/mal=
ta/mips64el/vmlinux-3.19.3.mtoman.20150408
> fetched or already on cache.
>    File https://github.com/groeck/linux-build-test/raw/8584a59e/rootfs/mi=
psel64/rootfs.mipsel64r1.cpio.gz
> fetched or already on cache.
>    File https://archives.fedoraproject.org/pub/archive/fedora/linux/relea=
ses/29/Everything/aarch64/os/images/pxeboot/vmlinuz
> fetched or already on cache.
>    File https://archives.fedoraproject.org/pub/archive/fedora/linux/relea=
ses/29/Everything/armhfp/os/images/pxeboot/vmlinuz
> fetched or already on cache.
>    File https://raw.githubusercontent.com/Subbaraya-Sundeep/qemu-test-bin=
aries/fa030bd77a014a0b8e360d3b7011df89283a2f0b/u-boot
> fetched or already on cache.
>    File https://raw.githubusercontent.com/Subbaraya-Sundeep/qemu-test-bin=
aries/fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin
> fetched or already on cache.
>    File http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-fir=
mware/raspberrypi-kernel_1.20190215-1_armhf.deb
> fetched or already on cache.
>    File https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/=
main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
> fetched or already on cache.
>    File https://github.com/groeck/linux-build-test/raw/2eb0a73b5d5a28df31=
70c546ddaaa9757e1e0848/rootfs/arm/rootfs-armv5.cpio.gz
> fetched or already on cache.
>    File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-imag=
e-dev-sunxi_5.75_armhf.deb
> fetched or already on cache.
>    File https://github.com/groeck/linux-build-test/raw/2eb0a73b5d5a28df31=
70c546ddaaa9757e1e0848/rootfs/arm/rootfs-armv5.cpio.gz
> fetched or already on cache.
>    File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-imag=
e-dev-sunxi_5.75_armhf.deb
> fetched or already on cache.
>    File https://github.com/groeck/linux-build-test/raw/2eb0a73b5d5a28df31=
70c546ddaaa9757e1e0848/rootfs/arm/rootfs-armv5.ext2.gz
> fetched or already on cache.
>    File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-imag=
e-dev-sunxi_5.75_armhf.deb
> fetched or already on cache.
>    File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-imag=
e-dev-sunxi_5.75_armhf.deb
> fetched or already on cache.
>    File https://github.com/groeck/linux-build-test/raw/2eb0a73b5d5a28df31=
70c546ddaaa9757e1e0848/rootfs/arm/rootfs-armv7a.cpio.gz
> fetched or already on cache.
>    File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-imag=
e-dev-sunxi_5.75_armhf.deb
> fetched or already on cache.
>    File http://storage.kernelci.org/images/rootfs/buildroot/kci-2019.02/a=
rmel/base/rootfs.ext2.xz
> fetched or already on cache.
>    File https://dl.armbian.com/orangepipc/archive/Armbian_19.11.3_Orangep=
ipc_bionic_current_5.3.9.7z
> fetched or already on cache.
>    File http://snapshot.debian.org/archive/debian/20200108T145233Z/pool/m=
ain/u/u-boot/u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb
> fetched or already on cache.
>    File https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/bina=
ry/gzimg/armv7.img.gz
> fetched or already on cache.
>    File https://archives.fedoraproject.org/pub/archive/fedora-secondary/r=
eleases/29/Everything/s390x/os/images/kernel.img
> fetched or already on cache.
>    File http://archive.debian.org/debian/dists/lenny/main/installer-alpha=
/current/images/cdrom/vmlinuz
> fetched or already on cache.
>    File https://archives.fedoraproject.org/pub/archive/fedora-secondary/r=
eleases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz
> fetched or already on cache.
>    File https://snapshot.debian.org/archive/debian-ports/20191021T083923Z=
/pool-m68k/main/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb
> fetched or already on cache.
> Fetching assets from tests/acceptance/boot_linux.py.
> Fetching assets from tests/acceptance/cpu_queries.py.
> Fetching assets from tests/acceptance/empty_cpu_model.py.
> Fetching assets from tests/acceptance/linux_initrd.py.
>    File https://archives.fedoraproject.org/pub/archive/fedora/linux/relea=
ses/18/Fedora/x86_64/os/images/pxeboot/vmlinuz
> fetched or already on cache.
>    File https://archives.fedoraproject.org/pub/archive/fedora/linux/relea=
ses/28/Everything/x86_64/os/images/pxeboot/vmlinuz
> fetched or already on cache.
> Fetching assets from tests/acceptance/linux_ssh_mips_malta.py.
> Fetching assets from tests/acceptance/machine_arm_integratorcp.py.
>    File https://github.com/zayac/qemu-arm/raw/master/arm-test/kernel/zIma=
ge.integrator
> fetched or already on cache.
>    File https://github.com/zayac/qemu-arm/raw/master/arm-test/kernel/arm_=
root.img
> fetched or already on cache.
>    File https://github.com/torvalds/linux/raw/v2.6.12/drivers/video/logo/=
logo_linux_vga16.ppm
> fetched or already on cache.
> Fetching assets from tests/acceptance/machine_arm_n8x0.py.
>    File http://stskeeps.subnetmask.net/meego-n8x0/meego-arm-n8x0-1.0.80.2=
0100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
> fetched or already on cache.
> Fetching assets from tests/acceptance/machine_m68k_nextcube.py.
>    File http://www.nextcomputers.org/NeXTfiles/Software/ROM_Files/68040_N=
on-Turbo_Chipset/Rev_2.5_v66.BIN
> fetched or already on cache.
> Fetching assets from tests/acceptance/machine_mips_malta.py.
>    File https://github.com/philmd/qemu-testing-blob/raw/a5966ca4b5/mips/m=
alta/mips64el/vmlinux-4.7.0-rc1.I6400.gz
> fetched or already on cache.
>    File https://github.com/torvalds/linux/raw/v2.6.12/drivers/video/logo/=
logo_linux_vga16.ppm
> fetched or already on cache.
> Fetching assets from tests/acceptance/machine_sparc_leon3.py.
>    File http://www.helenos.org/releases/HelenOS-0.6.0-sparc32-leon3.bin
> fetched or already on cache.
> Fetching assets from tests/acceptance/migration.py.
> Fetching assets from tests/acceptance/pc_cpu_hotplug_props.py.
> Fetching assets from tests/acceptance/ppc_prep_40p.py.
>    File ftp://ftp.boulder.ibm.com/rs6000/firmware/7020-40p/P12H0456.IMG
> fetched or already on cache.
>    File https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/NetBSD-4.0/prep/=
installation/floppy/generic_com0.fs
> fetched or already on cache.
>    File https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/NetBSD-7.1.2-prep.iso
> fetched or already on cache.
> Fetching assets from tests/acceptance/version.py.
> Fetching assets from tests/acceptance/virtio_check_params.py.
> Fetching assets from tests/acceptance/virtio_version.py.
> Fetching assets from tests/acceptance/vnc.py.
> Fetching assets from tests/acceptance/x86_cpu_model_versions.py.
> [wrampazz@wrampazz qemu.philippe]$
>=20


