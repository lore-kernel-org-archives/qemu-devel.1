Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64837ECE58D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1BB206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1BB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJ0Z-0006Q3-Tc
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIHI0-0006n5-SK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIHHz-0000so-I2
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:06:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIHHz-0000sH-6v
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:06:23 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4F98DC010C13
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:06:22 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n3so1543239wrt.9
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aUHQTGoW+DLiD3JmhdC2DfW/K6c2z/OD2h44lO7HZqE=;
 b=SgYWr+45Ubl50nbnA9veIY8limjh/ZHu8DnMuB/pWfcG75NhOVbt03ENWqRPjRqqCw
 VfwDGJ3+t76xJpbckZEu4XA1kZ8n1Mz1BrWwwUhTu3GMLXdwQ+C9PIX60o+FL6EJLDo7
 6d2CELbhxPoz4C0js6TR9yTsJJ5QNDTbevXsZ5drooITK8akGiU2i9d7tN1g3zjqwrte
 yBJZUn7QFkBSo7wfP8Fc/Lho/YdtC6Fha6vA6n/CesroKFFYT9zo2ptkgjljCvzoB5dO
 WaCTNDCNAGLEtXy8cPil3NGJ4PxAeKOtGjmmEm2RebbRLbThGectY4Wx0F9+FRqIwpVz
 1xEw==
X-Gm-Message-State: APjAAAVwpmJ2j2ZULAJ/QE1hcemZ4XDULR9TnK7IkWIEuyseNb2Q0oT1
 9K+jsODovanmNv7d5c4zDjssaBLBKsviDEDPHVLs3a3VCCmNM2SmKf4ZH13f7TzYZmPvimo9pfj
 6UoY4+JR+11uXA60=
X-Received: by 2002:adf:db4e:: with SMTP id f14mr4178577wrj.7.1570647981096;
 Wed, 09 Oct 2019 12:06:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQRqQItG8fr8dDENC5lgJtC/oXCVzlyLUEde+pqfGq80Ciz/PbRQKfIcmZm5gbe3uQIE2hxQ==
X-Received: by 2002:adf:db4e:: with SMTP id f14mr4178559wrj.7.1570647980885;
 Wed, 09 Oct 2019 12:06:20 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id b62sm4068908wmc.13.2019.10.09.12.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 12:06:20 -0700 (PDT)
Subject: Re: [PATCH 5/5] travis.yml: Compile on arm64, too
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191009170701.14756-1-thuth@redhat.com>
 <20191009170701.14756-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2238ed71-5811-c98f-03c8-f8804e480f9d@redhat.com>
Date: Wed, 9 Oct 2019 21:06:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009170701.14756-6-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 7:07 PM, Thomas Huth wrote:
> Travis now features an arm64 build host, so let's check compilation
> there, too.
> 
> Unfortunately, there are some quirks:
> - block/ssh.c does not compile properly in this environment, so we have
>    to use --disable-libssh until that problem is fixed.
> - test-util-filemonitor fails, so we can not run the unit tests there
> - The file system size seems to be very limited, so the iotest tests
>    can't be used and the hd-geo-test fails (thus we can't compile
>    x86_64-softmmu here and run "check-qtest" afterwards)
> - Compiling seems to be quite a bit slower than on the x86 builders,
>    so we better limit the target list to some few architectures.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 0c88e8757b..357ca02890 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -342,3 +342,9 @@ matrix:
>           - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
>           - TEST_CMD="make -j3 check-tcg V=1"
>           - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
> +
> +    # Non-x86 builds:
> +    - env:
> +        - CONFIG="--disable-libssh --target-list=aarch64-softmmu,ppc64-softmmu,s390x-softmmu,x86_64-linux-user"

Is aarch64 on aarch64 interesting?

Do you know if we can use KVM there?

> +        - TEST_CMD="make check-qtest check-softfloat -j3 V=1"
> +      arch: arm64
> 

