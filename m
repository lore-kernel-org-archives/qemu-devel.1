Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B2EC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DAB2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DAB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvBY-0006zt-Cg
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:24:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53516)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdv4p-0004kc-49
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hduud-0000pT-3b
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:07:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hduuc-0000oy-TJ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:07:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so6673831wmd.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 04:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WJQMIvkjsEv5JDHqFvaBkqpatPZZcRwmjALfdshCWJ0=;
 b=ZG60bwnnSDeNOeN1zG111EnPZETrxHlx8ldu6GbUj/LEczsbCFMk+hBqMIgfSpXHT8
 OsyG0C0N3mfdQK76lL9p8VoqC2deHhtc+o/hwjcJBZZ+iKJWnEI2VixUt7vriZ3O5dU+
 YKYEVoCw1XjjOhDxrQDx9Rapy+aTe2F1e5Mjhjfycl3jDHo9kq3yNZI3V7gxO021X5Es
 D9KFrmfzxssUgk26LYAT95GVrzPWAv3vM2sH+B4QDYr6sy4Faov6fHH/Y4ZaP+DtAd0c
 Wsy098bYTrMJ9P0DN8lHIS0nsHLyHDgE+lJ/S97X2DRgwnKyokYXy247OsCBiy3NZAD8
 RmHg==
X-Gm-Message-State: APjAAAXDdXXfYK4/pzOiIaI3syrMvGtAWsUibThY5I9Yyq6r1uw5m1gF
 7N8kLju72FexaqpEHfCf5ktw8w==
X-Google-Smtp-Source: APXvYqxQVMKL4kXOozPJwENai7B6YTPkezu28ywlU64KIG8In4MJ1WgtTWip7tc6LSh+z957HZC6Hw==
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr2251441wmj.87.1561028845807; 
 Thu, 20 Jun 2019 04:07:25 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id q12sm18238626wrp.50.2019.06.20.04.07.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 04:07:25 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190619194021.8240-1-alex.bennee@linaro.org>
 <20190619194021.8240-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5ae85562-3a47-378b-29eb-2421f3332624@redhat.com>
Date: Thu, 20 Jun 2019 13:07:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619194021.8240-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v1 01/17] tests/vm: avoid extra compressed
 image copy
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
> The image copy is only really needed because xz doesn't know to
> properly decompress a file not named properly.  Instead of
> decompressing to stdout, and having to rely on a shell, let's just
> create a link instead of copying the file.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Message-Id: <20190613130718.3763-2-crosa@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/centos  | 4 ++--
>  tests/vm/freebsd | 4 ++--
>  tests/vm/netbsd  | 4 ++--
>  tests/vm/openbsd | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/vm/centos b/tests/vm/centos
> index 7417b50af4..b00b46a8dc 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -66,8 +66,8 @@ class CentosVM(basevm.BaseVM):
>          cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
>          img_tmp = img + ".tmp"
>          sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
> -        subprocess.check_call(["xz", "-dvf", img_tmp + ".xz"])
> +        subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
> +        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"])
>          subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>          self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
>          self.wait_ssh()
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index b0066017a6..5575c23a6f 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -34,8 +34,8 @@ class FreeBSDVM(basevm.BaseVM):
>          img_tmp_xz = img + ".tmp.xz"
>          img_tmp = img + ".tmp"
>          sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
> +        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 4c6624ea5e..d0508f4465 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -34,8 +34,8 @@ class NetBSDVM(basevm.BaseVM):
>          img_tmp_xz = img + ".tmp.xz"
>          img_tmp = img + ".tmp"
>          sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
> +        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 2105c01a26..87ec982489 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -36,8 +36,8 @@ class OpenBSDVM(basevm.BaseVM):
>          img_tmp_xz = img + ".tmp.xz"
>          img_tmp = img + ".tmp"
>          sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
> +        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> 

