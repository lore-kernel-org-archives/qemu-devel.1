Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D06ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5A420B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5A420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIjJ-000592-97
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIHGj-0005ID-7G
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIHGg-00008k-Sj
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:05:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIHGg-00007k-K3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:05:02 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 65B55C057F2E
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:05:01 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id m16so1033213wmg.8
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fZevVsxzXhOCPGe8MtXXjC7elpbRGfmSBcvOoW6m+ug=;
 b=hx6W0GvLP7HKc9QLu+tydZU2aUPEf2+Gc2Ow8XwlJLASm+X/t7U2nxqFwdjn1lxUzS
 ohzzciuF6kD1CUWW9GjBvRlaUZbfTOAVi/2DoGzoam/wrfioFrMcQ0KJD/ER4z6VburS
 AvORZXEs6oyFpXMRB+FPpVnO7ZLmuu4NJEvKCkFU05Ly3xEZunRD9PDLC6/iA0RkdmHS
 qZ+5Oq0w1TuD45Mrb04L52MsXWmULUIOAzwIPLKX0STPcIplEQ/jlgCld4yIFipNhqen
 XujqOD0h2y84AR6y2LvRIjNFdx73F7DZelCjxyRElGJqNpRh/YULNa8o84dfsS6YzSFp
 XrJQ==
X-Gm-Message-State: APjAAAXpI7KW/bAYBsMQOmRWycl3CB7gA9NO9m1UN7EsvzKki3cvHkzl
 ywGAXT5JSkZqCUyGXdJYwD4FNCs8CC0C20yp2z3+3H1SSDPZh9RkmgMJPMGk7YfEIZhjhyMMG/A
 3aPYIDY/Or+tXA5c=
X-Received: by 2002:a1c:f011:: with SMTP id a17mr3746613wmb.18.1570647900087; 
 Wed, 09 Oct 2019 12:05:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyDSne4qyALPEdVgtZ1SB+s7ovt9Cve7VWHCDI2ndO61XflXGlcOSLXCeCCbtCU2MJnMD7sdA==
X-Received: by 2002:a1c:f011:: with SMTP id a17mr3746597wmb.18.1570647899841; 
 Wed, 09 Oct 2019 12:04:59 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id n8sm4061935wma.7.2019.10.09.12.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 12:04:59 -0700 (PDT)
Subject: Re: [PATCH 4/5] travis.yml: Fix the ccache lines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191009170701.14756-1-thuth@redhat.com>
 <20191009170701.14756-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <910285f7-d470-cf0b-85b2-a2264cf23ea3@redhat.com>
Date: Wed, 9 Oct 2019 21:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009170701.14756-5-thuth@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 7:07 PM, Thomas Huth wrote:
> The "command -v ccache && ccache ..." likely were supposed to test
> the availability of ccache before running the program. But this
> shell construct causes Travis to abort if ccache is not available.

Oops.

Why can't you install ccache if these are Ubuntu systems?
It is even more wanted if the arm64 machine are slow...

> Use an if-statement instead to fix this problem.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 616e59867a..0c88e8757b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -91,13 +91,13 @@ git:
>  =20
>   before_script:
>     - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ] ; then export PATH=3D"/usr/=
local/opt/ccache/libexec:$PATH" ; fi
> -  - command -v ccache && ccache --zero-stats
> +  - if command -v ccache ; then ccache --zero-stats ; fi
>     - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>     - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log=
 && exit 1; }
>   script:
>     - make -j3 && travis_retry ${TEST_CMD}
>   after_script:
> -  - command -v ccache && ccache --show-stats
> +  - if command -v ccache ; then ccache --show-stats ; fi
>  =20
>  =20
>   matrix:
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

