Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47515C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 10:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F61E2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 10:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F61E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdujO-00066T-Pm
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 06:55:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hduf2-00027V-Di
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hduX9-0004xl-49
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:43:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hduJp-0000qr-1t
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:29:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so2491529wrl.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 03:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E9K8U46Tv7i3luZF5m/IZbdPgBNHFrmDElYReTL1Oyw=;
 b=jVIdwtd2SPcWmCjFNEWomJQkWdXYF7p8YYzzmDXzK1/LDBRSrviWHSnVFoXfvmO4VF
 T95VRLqMfUeuzSU7TAc89Tj7XBPMxsYQ9Ns34HjJFHxQNEonhcno8opOBMDctNgos5gF
 He+6C7lp/aJypPyndPabcdGftC1NZgI5sARZNryMkctKg9dkFN53f8zwdt4oYB3sJYbh
 EUTjGzW9i4AG8m7t2w8GbSsqVtVL6T1j9WubyklbW3iPymQ4y1IWm2PlKWNnSrS5P0Ds
 9qf9AZ7dRXUmrRxcgh0pBkSbdzPudlfwPuKNQNIdNY04iU7CmFe+k+GyCnAI1Uq5hkbF
 tVdg==
X-Gm-Message-State: APjAAAVve4toAQamQo3P0XF6wo7Jl3bPg97vkc4dTJEYcyfl3HARremg
 8EjOEmTXg6YLyQpo8vtzLnTUrA==
X-Google-Smtp-Source: APXvYqx1szbTQeFunYZviIIZ7R2SGJ3NXbzA42kkpqdUKtJmjtapc/v3jKeU+dyCxHaH+YrigVEGNA==
X-Received: by 2002:adf:f28a:: with SMTP id k10mr9156607wro.343.1561026560709; 
 Thu, 20 Jun 2019 03:29:20 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id o185sm4524655wmo.45.2019.06.20.03.29.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 03:29:20 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190619194021.8240-1-alex.bennee@linaro.org>
 <20190619194021.8240-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f07129f7-2813-e7e9-79ae-94a026495ab9@redhat.com>
Date: Thu, 20 Jun 2019 12:29:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619194021.8240-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1 02/17] tests/vm: avoid image presence
 check and removal
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
Cc: Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 9:40 PM, Alex Bennée wrote:
> From: Cleber Rosa <crosa@redhat.com>
> 
> Python's os.rename() will silently replace an existing file,
> so there's no need for the extra check and removal.
> 
> Reference: https://docs.python.org/3/library/os.html#os.rename
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Message-Id: <20190613130718.3763-3-crosa@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/centos      | 2 --
>  tests/vm/freebsd     | 2 --
>  tests/vm/netbsd      | 2 --
>  tests/vm/openbsd     | 2 --
>  tests/vm/ubuntu.i386 | 2 --
>  5 files changed, 10 deletions(-)
> 
> diff --git a/tests/vm/centos b/tests/vm/centos
> index b00b46a8dc..53976f1c4c 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -77,8 +77,6 @@ class CentosVM(basevm.BaseVM):
>          self.ssh_root_check("systemctl enable docker")
>          self.ssh_root("poweroff")
>          self.wait()
> -        if os.path.exists(img):
> -            os.remove(img)
>          os.rename(img_tmp, img)
>          return 0
>  
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 5575c23a6f..091be1a065 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -36,8 +36,6 @@ class FreeBSDVM(basevm.BaseVM):
>          sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
>          subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
> -        if os.path.exists(img):
> -            os.remove(img)
>          os.rename(img_tmp, img)
>  
>  if __name__ == "__main__":
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index d0508f4465..ee9eaeab50 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -36,8 +36,6 @@ class NetBSDVM(basevm.BaseVM):
>          sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
>          subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
> -        if os.path.exists(img):
> -            os.remove(img)
>          os.rename(img_tmp, img)
>  
>  if __name__ == "__main__":
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 87ec982489..28c7d25e29 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -38,8 +38,6 @@ class OpenBSDVM(basevm.BaseVM):
>          sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
>          subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
> -        if os.path.exists(img):
> -            os.remove(img)
>          os.rename(img_tmp, img)
>  
>  if __name__ == "__main__":
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index a22d137e76..12867b193f 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -80,8 +80,6 @@ class UbuntuX86VM(basevm.BaseVM):
>          self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
>          self.ssh_root("poweroff")
>          self.wait()
> -        if os.path.exists(img):
> -            os.remove(img)
>          os.rename(img_tmp, img)
>          return 0
>  
> 

