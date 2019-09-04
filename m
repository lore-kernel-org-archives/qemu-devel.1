Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DA6C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E6321883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E6321883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5UXw-0003UX-IW
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1i5UWl-0002tB-O1
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1i5UWi-0000Zo-Mh
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:36:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1i5UWi-0000YD-Dt
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:36:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9026A30860A5;
 Wed,  4 Sep 2019 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-39.gru2.redhat.com
 [10.97.116.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D46C41001947;
 Wed,  4 Sep 2019 12:36:39 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
References: <20190904005218.12536-1-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <4fab585b-3fc0-9add-534e-0f477370b074@redhat.com>
Date: Wed, 4 Sep 2019 09:36:38 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190904005218.12536-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 04 Sep 2019 12:36:42 +0000 (UTC)
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
Cc: Yash Mankad <ymankad@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

On 09/03/2019 09:52 PM, Cleber Rosa wrote:
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
>   qemu-doc.texi                          |  6 +++---
>   tests/acceptance/boot_linux_console.py | 25 +++++++++++++++----------
>   tests/acceptance/linux_initrd.py       |  5 +++--
>   tests/vm/fedora                        |  2 +-
>   4 files changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 577d1e8376..37795f86fb 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -440,15 +440,15 @@ of <protocol>.
>   
>   Example: boot from a remote Fedora 20 live ISO image
>   @example
> -qemu-system-x86_64 --drive media=cdrom,file=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
> +qemu-system-x86_64 --drive media=cdrom,file=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
>   
> -qemu-system-x86_64 --drive media=cdrom,file.driver=http,file.url=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
> +qemu-system-x86_64 --drive media=cdrom,file.driver=http,file.url=http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
>   @end example
>   
>   Example: boot from a remote Fedora 20 cloud image using a local overlay for
>   writes, copy-on-read, and a readahead of 64k
>   @example
> -qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"http",, "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
> +qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"http",, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
>   
>   qemu-system-x86_64 -drive file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
>   @end example
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 2504ef0150..8a9a314ab4 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -76,8 +76,9 @@ class BootLinuxConsole(Test):
>           :avocado: tags=arch:x86_64
>           :avocado: tags=machine:pc
>           """
> -        kernel_url = ('https://download.fedoraproject.org/pub/fedora/linux/'
> -                      'releases/29/Everything/x86_64/os/images/pxeboot/vmlinuz')
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
> +                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
> +                      '/vmlinuz')
>           kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
> @@ -250,8 +251,9 @@ class BootLinuxConsole(Test):
>           :avocado: tags=arch:aarch64
>           :avocado: tags=machine:virt
>           """
> -        kernel_url = ('https://download.fedoraproject.org/pub/fedora/linux/'
> -                      'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz')
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
> +                      '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
> +                      '/vmlinuz')
>           kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
> @@ -271,8 +273,9 @@ class BootLinuxConsole(Test):
>           :avocado: tags=arch:arm
>           :avocado: tags=machine:virt
>           """
> -        kernel_url = ('https://download.fedoraproject.org/pub/fedora/linux/'
> -                      'releases/29/Everything/armhfp/os/images/pxeboot/vmlinuz')
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
> +                      '/linux/releases/29/Everything/armhfp/os/images/pxeboot'
> +                      '/vmlinuz')
>           kernel_hash = 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
> @@ -318,8 +321,9 @@ class BootLinuxConsole(Test):
>           :avocado: tags=arch:s390x
>           :avocado: tags=machine:s390_ccw_virtio
>           """
> -        kernel_url = ('https://download.fedoraproject.org/pub/fedora-secondary/'
> -                      'releases/29/Everything/s390x/os/images/kernel.img')
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
> +                      '/fedora-secondary/releases/29/Everything/s390x/os/images'
> +                      '/kernel.img')
>           kernel_hash = 'e8e8439103ef8053418ef062644ffd46a7919313'
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
> @@ -360,8 +364,9 @@ class BootLinuxConsole(Test):
>           :avocado: tags=arch:ppc64
>           :avocado: tags=machine:pseries
>           """
> -        kernel_url = ('https://download.fedoraproject.org/pub/fedora-secondary/'
> -                      'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz')
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
> +                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
> +                      '/ppc/ppc64/vmlinuz')
>           kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
> index 23be5a63aa..c61d9826a4 100644
> --- a/tests/acceptance/linux_initrd.py
> +++ b/tests/acceptance/linux_initrd.py
> @@ -54,8 +54,9 @@ class LinuxInitrd(Test):
>           QEMU has supported up to 4 GiB initrd for recent kernel
>           Expect guest can reach 'Unpacking initramfs...'
>           """
> -        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
> -                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
> +                      '/linux/releases/28/Everything/x86_64/os/images/pxeboot/'
> +                      'vmlinuz')
>           kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>           max_size = 2 * (1024 ** 3) + 1
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index e8fa5bf0d2..7fec1479fb 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -23,7 +23,7 @@ class FedoraVM(basevm.BaseVM):
>       name = "fedora"
>       arch = "x86_64"
>   
> -    base = "http://dl.fedoraproject.org/pub/fedora/linux/releases/30/"
> +    base = "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/30/"
>       link = base + "Server/x86_64/iso/Fedora-Server-netinst-x86_64-30-1.2.iso"
>       repo = base + "Server/x86_64/os/"
>       full = base + "Everything/x86_64/os/"

Currently it has just a few test cases that boot a Linux kernel. At this 
point maintain the urls to fetch the files across a few source file is 
manageable but it can get complex as it increases in number of tests. 
While ago I started to work on the introduction of a "kernel provider" 
mechanism to replace this "fetch a kernel" boilerplate. Unfortunately I 
didn't time to complete its implementation, now If you think it is 
valuable then I can manage to resume the work. Find the draft 
implementation here: 
https://github.com/wainersm/qemu/tree/acceptance_boot_linux

An alternate approach would be to extend Avocado by mimic the 
avocado.utils.vmimage module [1], but rather have kernel providers.

[1] 
https://avocado-framework.readthedocs.io/en/71.0/api/utils/avocado.utils.html#module-avocado.utils.vmimage

Anyway, the changes proposed on this patch looks good to me.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Thanks,

Wainer

