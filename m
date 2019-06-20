Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E93C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2AF204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2AF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdupk-0001hF-77
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:02:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45284)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hduf6-00026z-CH
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hduVs-0004P7-BT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:41:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hduLt-0001RI-20
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:31:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so2431679wre.12
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 03:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vQoUdEH61If0Pq81bafTFkTW2ztqIAPEZj5V/OXxaYU=;
 b=XkvbxvJKbohmVC55VTVzF3Zgk4y3DoRXP+C2VA6XAT6x296Oa+dtjyFYplr+SCD80U
 UnUxadkb1UCDyIdEBDgq3TLyu983D6cmz5D25qrF6WloXmBrYY6O8S4d1xopihIEjHsC
 AnrH4NjtHD+gQvmJWZPlXgVeYECt5GGKOX07v5KwHhduHdfIEs2Xtlbpz9/y6L/mGfRD
 owwMsXObhGcLFSvXzjMT5Z1q+OCInXAhmT9TW5lam1ZPrJ/NryoCjnuTvmeoivI9dcZc
 jwf3X+bMhxReovqO8zrQxE1tUEZiccfDw6KlFLnhODhII6noLdEUQnvsvFMtxeYKG7Ff
 2Jeg==
X-Gm-Message-State: APjAAAWUETqSCY7HEls+cp+5xygBh/1zZW2j1JJnQ2aP5Vs0z+tpJB9z
 nAuQwBoyiW9AR54vpaExKi/SAw==
X-Google-Smtp-Source: APXvYqwyK0QB0nEV1pw+1mNkFUENJXx9sfExQH++Td3gWqaIdXQKv3qYr2LoRwJau7g06wFxK16xJw==
X-Received: by 2002:adf:de02:: with SMTP id b2mr14410600wrm.349.1561026692068; 
 Thu, 20 Jun 2019 03:31:32 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id v4sm5493742wmg.22.2019.06.20.03.31.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 03:31:31 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190619194021.8240-1-alex.bennee@linaro.org>
 <20190619194021.8240-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <10404d37-eb8c-e2f9-d1f8-9e5984c95a93@redhat.com>
Date: Thu, 20 Jun 2019 12:31:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619194021.8240-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1 03/17] tests/vm: pin ubuntu.i386 image
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
> It's a good practice to always have the same components used in tests.
> According to:
> 
>    https://cloud-images.ubuntu.com/releases/16.04/
> 
> New images are released from time to time, and the "release/"
> directory points to the latest release.  Let's pin to the latest
> available version, and while at it, set a hash for verification.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Message-Id: <20190613130718.3763-4-crosa@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/ubuntu.i386 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 12867b193f..7017e6d388 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -61,7 +61,9 @@ class UbuntuX86VM(basevm.BaseVM):
>          return os.path.join(cidir, "cloud-init.iso")
>  
>      def build_image(self, img):
> -        cimg = self._download_with_cache("https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-i386-disk1.img")
> +        cimg = self._download_with_cache(
> +            "https://cloud-images.ubuntu.com/releases/16.04/release-20190605/ubuntu-16.04-server-cloudimg-i386-disk1.img",
> +            sha256sum="e30091144c73483822b7c27193e9d47346dd1064229da577c3fedcf943f7cfcc")
>          img_tmp = img + ".tmp"
>          subprocess.check_call(["cp", "-f", cimg, img_tmp])
>          subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
> 

