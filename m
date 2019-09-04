Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C79C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51472073F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51472073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5NhZ-0005h2-Sg
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 01:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ymankad@redhat.com>) id 1i5Ngo-0005HZ-Bd
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ymankad@redhat.com>) id 1i5Ngl-0001ZL-MN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ymankad@redhat.com>) id 1i5Ngl-0001YW-Dz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:18:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB2354E924;
 Wed,  4 Sep 2019 05:18:37 +0000 (UTC)
Received: from apollo.usersys.redhat.com (ovpn-123-158.rdu2.redhat.com
 [10.10.123.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A31485C207;
 Wed,  4 Sep 2019 05:18:28 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
References: <20190904005218.12536-1-crosa@redhat.com>
From: Yash Mankad <ymankad@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ymankad@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFecwEYBCAC7QUnuTKRrz39gLumVG+KNB8XmHqHKypYPMkdJNLx33LAhmDVEeBEB6Zyn
 ryVtNClL4GVrmDOROp53kIkJh4uSAeu71w3/RJLrrHIs/NlFZ1cH3hEAwShLKYkXoVfqBN3m
 zhbqyndmPy8fviOIDcyzEBEIDbgsLgMebJTAto/ihLgEeG9dMF4qUuCcb3sWIao/WHSr9XHB
 OtZnvVUGueIM3DqEC2g5BN8025riOOL3UGRmIctJR+2dM+j0aCIbARGv1B66o300gJfjxm24
 /CbD/I6Wt2PHrNv/d4nXjfNElaBCiVw9513m2maFJeFaSPJpAGZjyDN/niNcpvxg6XaLABEB
 AAG0P1lhc2ggTWFua2FkIChTb2Z0d2FyZSBFbmdpbmVlciBhdCBSZWQgSGF0KSA8eW1hbmth
 ZEByZWRoYXQuY29tPokBNwQTAQgAIQUCV5zARgIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIX
 gAAKCRBjP1s2LzTrMJhfB/9mRNS3eMAy17wRSjnR1/AtNZ2qwBbyjnor0+Q7UfYUXKvFBNJo
 LnX6zphFJ/fZMqIM5BrE7T90Mm5Qy3qoK1c0QibN97OECrPn9epGPKiiI+1WZrIX9S3crCui
 hyIS4IuOOmgtVJx+akWCbfYPaybNsTPLBFJZ0+aATSe9Nbeb4XUS3RAqlRUEdejNGxxtKLtZ
 xgXsmL/il6Fp4EX53H1+d83Rk4V+S2KvMfrFEB+mxF7JFUv0E071br42po/EDnYj2wLM/STh
 Fgp5LO4qTPrwD8mllibLSF6ZCrjNYW1EctJF7oYbfFXwPUh9LWh0opKwzo8ne5ZN/4hzexHU
 4MnquQENBFecwEYBCACnrkQgxRis8b1DRRIWu+Gxxp4Xv85c19A3IyNudvihSNSSV8mSZ+ei
 9Xev80IhgExf+1MeTPvuWmD1FogqC5Pi6bEs29ZZvSde+DH1BeVoKVn4zY+rCSqyrlRfx8Zd
 xJXIICfOgfDRjDf0nKPiI14ujdT0zMOPJHQ8wf267kMWmS32eQPTLJmemhl9WhEett+i1WLq
 84DjbEhtkTO6FdboEcTN1fMSpkXz+jgfvgCCZIfJJ+AI/V/VjBBn264VdDdOE/AFfc6B1QYf
 6X3npdUmXjlE5QIadoaOHf6e+qMSEchKfMa9ban0dH1THVAm2Z8Ji+l0tNYJ/e3mndXcVJv7
 ABEBAAGJAR8EGAEIAAkFAlecwEYCGwwACgkQYz9bNi806zAlVwgAj0auI5iVWxdCEnxGDAFC
 7uuZeBfiRGUwnaeRLcs2N6zLdN7Y9aoLv0RMrQhTP1DiIOi2xuCiUeGAY533fIpQOtE+AHgY
 fFqUG9gwK9Web5Tec+SNOBXeULRd8flo3RIkKMUR6RBynHkvEt2WbGRfr4gP6RuYzwBL1EWv
 nigkhVXsLA+hyut5C8OMXcxG61vbat2duyBgqROV0UbMau9Nr+t5w2isusgHe3fia1h5uwsh
 3UDO4xAD/Il16hZqcPbgKW3+S7uR3V2LKwCqX0S/9gYwaIfiBgvEt7EAbj2YZfYvcWjbBwDu
 stjeTrSRCejEli4lN7PsSM6/NaLsIPKMgQ==
Message-ID: <1c64a595-252f-6a39-00db-84c94116637f@redhat.com>
Date: Wed, 4 Sep 2019 01:18:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904005218.12536-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 04 Sep 2019 05:18:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/3/19 8:52 PM, Cleber Rosa wrote:
> The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
> from tests/acceptance/linux_initrd.py, is currently failing to fetch
> the "vmlinuz" file.  The reason for the failure is that the Fedora
> project retires older versions from the "dl.fedoraproject.org" URL,
> and keeps them in "archives.fedoraproject.org".  As an added note,
> that test uses a Fedora 28 image, because of the specific Linux kernel
> version requirements of the test.
>
> For the sake of stability, let's use URLs from the archived and
> supposedely ever stable URLs.  The good news is that the currently
> supported versions are also hosted on the later.  This change limits
> itself to change the URLs, while keeping the fetched files the same
> (as can be evidenced by the unchanged hashes).
>
> Documentation and the "vm tests" fedora definition were also updated.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  qemu-doc.texi                          |  6 +++---
>  tests/acceptance/boot_linux_console.py | 25 +++++++++++++++----------
>  tests/acceptance/linux_initrd.py       |  5 +++--
>  tests/vm/fedora                        |  2 +-
>  4 files changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 577d1e8376..37795f86fb 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -440,15 +440,15 @@ of <protocol>.
> =20
>  Example: boot from a remote Fedora 20 live ISO image
>  @example
> -qemu-system-x86_64 --drive media=3Dcdrom,file=3Dhttp://dl.fedoraprojec=
t.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64=
-20-1.iso,readonly
> +qemu-system-x86_64 --drive media=3Dcdrom,file=3Dhttps://archives.fedor=
aproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live=
-Desktop-x86_64-20-1.iso,readonly
> =20
> -qemu-system-x86_64 --drive media=3Dcdrom,file.driver=3Dhttp,file.url=3D=
http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedo=
ra-Live-Desktop-x86_64-20-1.iso,readonly
> +qemu-system-x86_64 --drive media=3Dcdrom,file.driver=3Dhttp,file.url=3D=
http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Li=
ve/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
>  @end example
> =20
>  Example: boot from a remote Fedora 20 cloud image using a local overla=
y for
>  writes, copy-on-read, and a readahead of 64k
>  @example
> -qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"http=
",, "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20=
/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":=
"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
> +qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"http=
",, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linu=
x/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "fil=
e.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
> =20
>  qemu-system-x86_64 -drive file=3D/tmp/Fedora-x86_64-20-20131211.1-sda.=
qcow2,copy-on-read=3Don
>  @end example
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 2504ef0150..8a9a314ab4 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -76,8 +76,9 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Darch:x86_64
>          :avocado: tags=3Dmachine:pc
>          """
> -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora=
/linux/'
> -                      'releases/29/Everything/x86_64/os/images/pxeboot=
/vmlinuz')
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archiv=
e/fedora'
> +                      '/linux/releases/29/Everything/x86_64/os/images/=
pxeboot'
> +                      '/vmlinuz')
>          kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
>          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> =20
> @@ -250,8 +251,9 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Darch:aarch64
>          :avocado: tags=3Dmachine:virt
>          """
> -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora=
/linux/'
> -                      'releases/29/Everything/aarch64/os/images/pxeboo=
t/vmlinuz')
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archiv=
e/fedora'
> +                      '/linux/releases/29/Everything/aarch64/os/images=
/pxeboot'
> +                      '/vmlinuz')
>          kernel_hash =3D '8c73e469fc6ea06a58dc83a628fc695b693b8493'
>          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> =20
> @@ -271,8 +273,9 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Darch:arm
>          :avocado: tags=3Dmachine:virt
>          """
> -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora=
/linux/'
> -                      'releases/29/Everything/armhfp/os/images/pxeboot=
/vmlinuz')
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archiv=
e/fedora'
> +                      '/linux/releases/29/Everything/armhfp/os/images/=
pxeboot'
> +                      '/vmlinuz')
>          kernel_hash =3D 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
>          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> =20
> @@ -318,8 +321,9 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Darch:s390x
>          :avocado: tags=3Dmachine:s390_ccw_virtio
>          """
> -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora=
-secondary/'
> -                      'releases/29/Everything/s390x/os/images/kernel.i=
mg')
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archiv=
e'
> +                      '/fedora-secondary/releases/29/Everything/s390x/=
os/images'
> +                      '/kernel.img')
>          kernel_hash =3D 'e8e8439103ef8053418ef062644ffd46a7919313'
>          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> =20
> @@ -360,8 +364,9 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Darch:ppc64
>          :avocado: tags=3Dmachine:pseries
>          """
> -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora=
-secondary/'
> -                      'releases/29/Everything/ppc64le/os/ppc/ppc64/vml=
inuz')
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archiv=
e'
> +                      '/fedora-secondary/releases/29/Everything/ppc64l=
e/os'
> +                      '/ppc/ppc64/vmlinuz')
>          kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc77'
>          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> =20
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_=
initrd.py
> index 23be5a63aa..c61d9826a4 100644
> --- a/tests/acceptance/linux_initrd.py
> +++ b/tests/acceptance/linux_initrd.py
> @@ -54,8 +54,9 @@ class LinuxInitrd(Test):
>          QEMU has supported up to 4 GiB initrd for recent kernel
>          Expect guest can reach 'Unpacking initramfs...'
>          """
> -        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/28=
/'
> -                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archiv=
e/fedora'
> +                      '/linux/releases/28/Everything/x86_64/os/images/=
pxeboot/'
> +                      'vmlinuz')
>          kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
>          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
>          max_size =3D 2 * (1024 ** 3) + 1
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index e8fa5bf0d2..7fec1479fb 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -23,7 +23,7 @@ class FedoraVM(basevm.BaseVM):
>      name =3D "fedora"
>      arch =3D "x86_64"
> =20
> -    base =3D "http://dl.fedoraproject.org/pub/fedora/linux/releases/30=
/"
> +    base =3D "https://archives.fedoraproject.org/pub/archive/fedora/li=
nux/releases/30/"
>      link =3D base + "Server/x86_64/iso/Fedora-Server-netinst-x86_64-30=
-1.2.iso"
>      repo =3D base + "Server/x86_64/os/"
>      full =3D base + "Everything/x86_64/os/"

Thanks for the fix Cleber.

Reviewed-by: Yash Mankad <ymankad@redhat.com>


