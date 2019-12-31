Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E86C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 11:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44BA206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 11:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT+B94ZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44BA206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imFuw-0007To-Qa
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 06:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imFu9-0006uL-Ju
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 06:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imFu7-0005iH-OT
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 06:41:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49581
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imFu7-0005eu-3B
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 06:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577792498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RvyXRVN8X1RUdnsihcJMYirHo2YGnLEsA3LPXm12ho=;
 b=jT+B94ZE4Xc8xsOvtF9j/fN2vmSNmGg2WSAICZlkNv2Sv8D2njIM3BLXLDZZDFR2XxIjIK
 j8EYtnIav3RogKyCzOSuVpY/jKKmcSTrGHGUWSSv7EFnxX+01N5XzuUqFi2vrGK1WALmLF
 fSMYQGNgNtPKxKIk9UwgoZfia9pFW4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-tZ_lIGnAORCaWuy5s8eCqQ-1; Tue, 31 Dec 2019 06:41:32 -0500
Received: by mail-wm1-f71.google.com with SMTP id l11so295050wmi.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 03:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OB0+M/UOk5U9g3VP04qpBqnq+CMtYavMNojlSVI60Cc=;
 b=iW98t6dFcpGQ+KI07JzSwtxeg69nUwNmTH76rTO96C4uq0VvMVBX+ApmEvpkrL2egc
 VyKDMfiH6l5DcO0qbhZ1J8JjS8LgJvJEbB0mKqTt3Dh1jVJqPqKrjeGWgfkjfjJfRveY
 cjNarMEL8y2TIpEclOvryk7HsHM25Xpshi/ILJQvCRbiCjpQUA6C+//iwau+m1IEIiq6
 Mva3q4zxNkrP4sxyztp9yQAtd7YHziYx0xjdtBgveo8ifXiQAPkelBri964hewnYxjCF
 MYwf3jxoHsAKP6avXNqV3drXNljD1f7DeJyybvfUPRezBO/wKd/MPTd1LVbcwvdux1Nh
 swtQ==
X-Gm-Message-State: APjAAAUgW8ZLncpo6BgG7HoL6QvWtud6E4axfstN9CVCABrOp7vytNsw
 Apeh2WaXUGniakSnYx1K/8clLAS3eh8rD8Knlxl3Tye1+kcsPtBQEJRgfv3kDhcnJDDx/vWiwOf
 NuBbMDaBV+OAqTWQ=
X-Received: by 2002:a7b:c416:: with SMTP id k22mr3700410wmi.10.1577792490775; 
 Tue, 31 Dec 2019 03:41:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQQYviqtgrsy6h6Q2nfVIxcS4S8Yk8iib6dfzl65BBEotmjG64G5UJrxGgbIFPIx3ko2J+YA==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr3700389wmi.10.1577792490458; 
 Tue, 31 Dec 2019 03:41:30 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-140-248.w86-222.abo.wanadoo.fr.
 [86.222.91.248])
 by smtp.gmail.com with ESMTPSA id g21sm52605250wrb.48.2019.12.31.03.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 03:41:29 -0800 (PST)
Subject: Re: [PATCH 1/6] tests/boot_linux_console: Add initrd test for the
 CubieBoard
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-2-f4bug@amsat.org>
 <31147d48-2f31-9fce-b8a4-1a270f114a45@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d7abcb92-4405-2ba8-b524-281d5913f980@redhat.com>
Date: Tue, 31 Dec 2019 12:41:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <31147d48-2f31-9fce-b8a4-1a270f114a45@redhat.com>
Content-Language: en-US
X-MC-Unique: tZ_lIGnAORCaWuy5s8eCqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/30/19 9:52 PM, Wainer dos Santos Moschetta wrote:
> On 12/30/19 9:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> This test boots a Linux kernel on a CubieBoard and verify
>> the serial output is working.
>>
>> The kernel image and DeviceTree blob are built by the Armbian
>> project (based on Debian):
>> https://docs.armbian.com/Developer-Guide_Build-Preparation/
>>
>> The cpio image used comes from the linux-build-test project:
>> https://github.com/groeck/linux-build-test
>>
>> If ARM is a target being built, "make check-acceptance" will
>> automatically include this test by the use of the "arch:arm" tags.
>>
>> Alternatively, this test can be run using:
>>
>> =C2=A0=C2=A0 $ avocado --show=3Dconsole run -t machine:cubieboard=20
>> tests/acceptance/boot_linux_console.py
>> =C2=A0=C2=A0 console: Uncompressing Linux... done, booting the kernel.
>> =C2=A0=C2=A0 console: Booting Linux on physical CPU 0x0
>> =C2=A0=C2=A0 console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc=
 version=20
>> 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10=20
>> CET 2019
>> =C2=A0=C2=A0 console: CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7)=
,=20
>> cr=3D50c5387d
>> =C2=A0=C2=A0 console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nona=
liasing=20
>> instruction cache
>> =C2=A0=C2=A0 console: OF: fdt: Machine model: Cubietech Cubieboard
>> =C2=A0=C2=A0 [...]
>> =C2=A0=C2=A0 console: Boot successful.
>> =C2=A0=C2=A0 console: cat /proc/cpuinfo
>> =C2=A0=C2=A0 console: / # cat /proc/cpuinfo
>> =C2=A0=C2=A0 console: processor=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 0
>> =C2=A0=C2=A0 console: model name=C2=A0=C2=A0=C2=A0=C2=A0 : ARMv7 Process=
or rev 0 (v7l)
>> =C2=A0=C2=A0 console: BogoMIPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 832=
.51
>> =C2=A0=C2=A0 [...]
>> =C2=A0=C2=A0 console: Hardware=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : All=
winner sun4i/sun5i Families
>> =C2=A0=C2=A0 console: Revision=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 000=
0
>> =C2=A0=C2=A0 console: Serial=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : 0000000000000000
>> =C2=A0=C2=A0 console: cat /proc/iomem
>> =C2=A0=C2=A0 console: / # cat /proc/iomem
>> =C2=A0=C2=A0 console: 01c00000-01c0002f : system-control@1c00000
>> =C2=A0=C2=A0 console: 01c02000-01c02fff : dma-controller@1c02000
>> =C2=A0=C2=A0 console: 01c05000-01c05fff : spi@1c05000
>> =C2=A0=C2=A0 console: 01c0b080-01c0b093 : mdio@1c0b080
>> =C2=A0=C2=A0 console: 01c0c000-01c0cfff : lcd-controller@1c0c000
>> =C2=A0=C2=A0 console: 01c0d000-01c0dfff : lcd-controller@1c0d000
>> =C2=A0=C2=A0 console: 01c0f000-01c0ffff : mmc@1c0f000
>> =C2=A0=C2=A0 [...]
>> =C2=A0=C2=A0 PASS (54.35 s)
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> =C2=A0 tests/acceptance/boot_linux_console.py | 41 +++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 41 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py=20
>> b/tests/acceptance/boot_linux_console.py
>> index 9c6aa2040a..4643f60e37 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -400,6 +400,47 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.wait_for_con=
sole_pattern('Boot successful.')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # TODO user comma=
nd, for now the uart is stuck
>> +=C2=A0=C2=A0=C2=A0 def test_arm_cubieboard_initrd(self):
>=20
> Unless you have two tests, one with and without initrd (not the case=20
> though) the suffix '_initrd' is useless. So I suggest to remove it.

The next patch adds a SD card test:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg667628.html

If one developer has other tests in progress, but one done, I think it=20
might sense to add the full test name when the first patch is merged, so=20
next tests don't have to modify the first test name.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:arm
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:cub=
ieboard
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_url =3D ('https://apt.ar=
mbian.com/pool/main/l/'
>> +                  =20
>> 'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_hash =3D '1334c29c44d984=
ffa05ed10de8c3361f33d78315'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_path =3D self.fetch_asse=
t(deb_url, asset_hash=3Ddeb_hash)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D self.extract=
_from_deb(deb_path,
>> +                                           =20
>> '/boot/vmlinuz-4.20.7-sunxi')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtb_path =3D=20
>> '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtb_path =3D self.extract_fr=
om_deb(deb_path, dtb_path)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_url =3D ('https://git=
hub.com/groeck/linux-build-test/raw/'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '2eb0a73b5d5a28df=
3170c546ddaaa9757e1e0848/rootfs/'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'arm/rootfs-armv5=
.cpio.gz')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_hash =3D '2b50f1873e1=
13523967806f4da2afe385462ff9b'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_path_gz =3D self.fetc=
h_asset(initrd_url,=20
>> asset_hash=3Dinitrd_hash)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_path =3D os.path.join=
(self.workdir, 'rootfs.cpio')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 archive.gzip_uncompress(init=
rd_path_gz, initrd_path)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_console()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_command_line =3D (sel=
f.KERNEL_COMMON_COMMAND_LINE +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'console=3DttyS0,115200 '
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'usbcore.nousb '
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'panic=3D-1 noreboot')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-kernel', =
kernel_path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-dtb', dtb_path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-initrd', initrd_path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-append', kernel_command_line,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-no-reboot')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.wait_for_console_patter=
n('Boot successful.')
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pa=
ttern(self, 'cat /proc/cpuinfo',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'Allwinner =
sun4i/sun5i')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pa=
ttern(self, 'cat /proc/iomem',
>> +                                               =20
>> 'system-control@1c00000')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pa=
ttern(self, 'reboot',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'reboot: Re=
starting=20
>> system')
>=20
>=20
> I ran this test case with success, so:
>=20
> Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Thanks Wainer!

>=20
> With the comment regarding the _initrd suffix:
>=20
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>=20
>=20
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def test_s390x_s390_ccw_virtio(self):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
arch:s390x
>=20
>=20


