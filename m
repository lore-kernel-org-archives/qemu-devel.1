Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC15BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9164120684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9164120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfTL-0002Jc-Dl
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNe9v-0003mi-8a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNe9t-0001IF-3N
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:32:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNe9s-0001HQ-UD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:32:13 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 895BE2A09B9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:32:11 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z24so1080135wmk.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bRGU8lvoPPPSueBcqxJwyv/EOCH2Ddw03qNJc4MFFew=;
 b=XemF4ow6iKeXduYhdtE4BkWxZMGt6RgbYQ/HqDkb0VrgDUaph6t7uaDCm62ktBmkDK
 eH3xY4eB39BzbtduC3pGWhaEbRj2rn6tplO9yYxiBmTgC4Qa1FQTAjM9ts1/6Cp8LN74
 kB/LIenia6D9nDInDDXmkkf0gtx5ECPm+Fvkc94+1UNu1XzKO6k8/AZp9Xi6uAzUaAcO
 B1aDmyNQ9VolltG41E/cOb1USYk6fhfl1gXmpDdkRKfPBkIwG6+fqmfRy76wp99U9mZP
 nJW0QAOusdSMb2n8Q2kqG92PDP5IVBT1X1w90SsBYebt+5CIAQc3n6BeDD5HVNrk796h
 8Yyw==
X-Gm-Message-State: APjAAAVgJ/jZVRHpemWAmOdUHqpEWdOZRZgWDZOmKO0uC4tSuOSI4b/3
 skm/TCsci258ZJXhKl2ZFPXro7VsJvPeLfIFZF08t2uobTGZUJrDO71jFp306ZcVQbaqcJQ8C6m
 uN7+s3+qQEOrd7Jg=
X-Received: by 2002:a05:600c:c7:: with SMTP id
 u7mr5396883wmm.141.1571927530331; 
 Thu, 24 Oct 2019 07:32:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy/2wn1Jp16RXME/OdTE/mqotBBVKkTCKOI3IAugHTFhwEokA8wNPDUpHFa5tcpYSflEkIgCA==
X-Received: by 2002:a05:600c:c7:: with SMTP id
 u7mr5396859wmm.141.1571927530144; 
 Thu, 24 Oct 2019 07:32:10 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id v20sm2294085wml.26.2019.10.24.07.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:32:09 -0700 (PDT)
Subject: Re: [PATCH v2 08/17] travis.yml: bump Xcode 10 to latest dot release
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191024102240.2778-1-alex.bennee@linaro.org>
 <20191024102240.2778-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3e811695-0bfe-3759-42a4-9e7142df6a51@redhat.com>
Date: Thu, 24 Oct 2019 16:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024102240.2778-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 12:22 PM, Alex Benn=C3=A9e wrote:
> According to:
>=20
>    https://docs.travis-ci.com/user/reference/osx/#macos-version
>=20
> we have 10.3 available so lets use it. I don't know what Apple's
> deprecation policy is for Xcode because it requires an AppleID to find
> out.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index f2b679fe701..da6a2063fca 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -247,7 +247,7 @@ matrix:
>       - env:
>           - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-so=
ftmmu,m68k-softmmu,x86_64-softmmu"
>         os: osx
> -      osx_image: xcode10.2
> +      osx_image: xcode10.3
>         compiler: clang
>  =20
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

