Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08E6C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996EF2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996EF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46404 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvBr-0007fi-Pj
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:25:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdv4p-0004ex-Df
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hduts-0000dm-0U
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:07:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hdutr-0000dX-Ny
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:06:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so2731783wmm.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 04:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mmLDngDHszLUVUiZNs2ONhNZvlJP9Gva3wFf5XCqezs=;
 b=QNnHWYEL3v0UIjvh8N2LRaR0/Kv/7MwrS2E6qIICVTtFiniRFPL6dA8qKNHQAVJ0GO
 l/cHuMrPXEfNfRNMqNcaDorOL/HNrpJ5DLZI2EAKa4u55Y8jE60KF9kZM2wnKDaD0Z8t
 ZKdBlf7ztCdKxIq6ESsOjrIn9onWGBx9ahtnzKVEpc9Pyw2e9ak2Snaplg3TF213ISaM
 FmUcQMLb6lS0TcG2TXU8xcX1WD2jr8AgsPSCSWon34jBcuv1LA8qKsuB6xy47mxcmBfi
 /psMq/waGYyC64FbTLwdOVJ84vydKlcvKFGmDzzf2q1+yujJuTxWjTruEZgmHkQwM6Qc
 Xy/A==
X-Gm-Message-State: APjAAAW1DB5AQI4euEr6jeb2OSFFgUG2HAdC81ZRiCuSS9HXQ1k1/fO7
 F4i/Z+9txN2tFr1Ho2IMPWvZSw==
X-Google-Smtp-Source: APXvYqwX1knxFXcf/tLDXjQ/KmbI95NkqcknO0Gn+Gig7c6p33o/IK0iXxHBEXqAz27bd/yVp5MkCQ==
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr2367661wmc.128.1561028797810; 
 Thu, 20 Jun 2019 04:06:37 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id f197sm6160050wme.39.2019.06.20.04.06.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 04:06:37 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190619194021.8240-1-alex.bennee@linaro.org>
 <20190619194021.8240-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8daaafb8-4d5d-16b2-d1d5-7eead85245cb@redhat.com>
Date: Thu, 20 Jun 2019 13:06:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619194021.8240-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v1 04/17] tests/vm: add source repos on
 ubuntu.i386
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
> Possibly because of different behavior on the newly update
> cloud-image, trying to run 'apt-get build-dep' results in:
> 
>    E: You must put some 'source' URIs in your sources.list
> 
> This enables all source repos (even though some are not
> needed) for simplicity sake.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Message-Id: <20190613130718.3763-5-crosa@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/ubuntu.i386 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 7017e6d388..3ea459ee20 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -77,6 +77,7 @@ class UbuntuX86VM(basevm.BaseVM):
>          time.sleep(5)
>          self.wait_ssh()
>          # The previous update sometimes doesn't survive a reboot, so do it again
> +        self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
>          self.ssh_root_check("apt-get update")
>          self.ssh_root_check("apt-get build-dep -y qemu")
>          self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
> 

