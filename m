Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62CAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC40C20657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC40C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZjGo-0001T0-Qe
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 18:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jZjG7-0000nO-9w
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:56:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jZjG6-0007sd-Cd
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:56:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A9E75ABC2;
 Fri, 15 May 2020 22:56:49 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] tests/vm: Remove flex/bison packages
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200515163029.12917-1-philmd@redhat.com>
 <20200515163029.12917-3-philmd@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <7f1d8f52-0612-c608-8f91-b4fb3c39c4c7@suse.de>
Date: Sat, 16 May 2020 00:56:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200515163029.12917-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:48:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 6:30 PM, Philippe Mathieu-Daudé wrote:
> QEMU does not use flex/bison packages.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: use 'does not', removed bison in OpenBSD VM (Claudio)
> ---
>  tests/vm/fedora      | 1 -
>  tests/vm/freebsd     | 1 -
>  tests/vm/netbsd      | 1 -
>  tests/vm/openbsd     | 1 -
>  tests/vm/ubuntu.i386 | 2 +-
>  5 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index bd9c6cf295..a9195670f4 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -32,7 +32,6 @@ class FedoraVM(basevm.BaseVM):
>      pkgs = [
>          # tools
>          'git-core',
> -        'flex', 'bison',
>          'gcc', 'binutils', 'make',
>  
>          # perl
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 298967fe9c..f87db2b126 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -38,7 +38,6 @@ class FreeBSDVM(basevm.BaseVM):
>          "bash",
>          "gmake",
>          "gsed",
> -        "flex", "bison",
>  
>          # libs: crypto
>          "gnutls",
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index b10c9d429d..cdac502dad 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -36,7 +36,6 @@ class NetBSDVM(basevm.BaseVM):
>          "bash",
>          "gmake",
>          "gsed",
> -        "flex", "bison",
>  
>          # libs: crypto
>          "gnutls",
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 0b705f4945..13e7f9a6d5 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -35,7 +35,6 @@ class OpenBSDVM(basevm.BaseVM):
>          "bash",
>          "gmake",
>          "gsed",
> -        "bison",
>  
>          # libs: usb
>          "libusb1",
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 1570775335..24527cc78c 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -52,7 +52,7 @@ class UbuntuX86VM(basevm.BaseVM):
>          self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
>          self.ssh_root_check("apt-get update")
>          self.ssh_root_check("apt-get build-dep -y qemu")
> -        self.ssh_root_check("apt-get install -y libfdt-dev flex bison language-pack-en")
> +        self.ssh_root_check("apt-get install -y libfdt-dev language-pack-en")
>          self.ssh_root("poweroff")
>          self.wait()
>          os.rename(img_tmp, img)
> 
Reviewed-by: Claudio Fontana <cfontana@suse.de>

