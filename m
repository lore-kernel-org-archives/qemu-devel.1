Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C97CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49EE20650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49EE20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFAa-0006H3-Lc
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEnU-0004Oj-WB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEnU-0007Wq-1q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEnT-0007Va-NK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:27:24 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C172D4ACA5
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:27:22 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 92so5434611wro.14
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ePuC57VwSKpSQ2wXoLmJq2KLCqJrItXgLd5Kjve1l64=;
 b=dGNpiGXzGaSzyIh/xpLfEqPip9JD0VmMvJbPME2zPCry6alLwo5nIKowioE5QAyXiq
 Gz0XLbJdoCJXps75mcijgCLXgJkrhf6qkDGwdL80Jawt+UBTXvtoU07s8N5fMS+tNQt7
 ZylO/Ou2s9evD3ZrAs1Cbl1WVUoA4R4a9E2wNRUR0m2z2eZCfz/lffzWvxR3lrsHi9PQ
 1c886BubHNL7ZDNlqtU/S9V2Hd01xTiYz57ie/NDKT4P/m8/yGiGN7aMG2bvYwoNQuCK
 rS1KJQ0iU56sC3XoN/a3mXVxTjwrhiTvUWTswlYAP3ehi799OYZRcY3ID0NdNuw0EwD7
 oQtw==
X-Gm-Message-State: APjAAAW6ab5yUIur7DXHATuIw9HJv0z9FnsBpawVipu7Frm6NXfw27In
 ww3x+sLhzDRcKMFsNg0f5dKeNbzik2PUavrdbNamH4wQPU1T4ZhJi0u4qhYtvQURmJRthGkIUa/
 +wMyAk0Z40XPUOtE=
X-Received: by 2002:a5d:464f:: with SMTP id j15mr7920705wrs.366.1571830041485; 
 Wed, 23 Oct 2019 04:27:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyk5D9g0pgy3/IGWg1Tga/sCh5bRkcu0TvNBfh/+vHLJDOhrsgvS8/3y5xxTVYrY8NqxZHZog==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr7920678wrs.366.1571830041126; 
 Wed, 23 Oct 2019 04:27:21 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id l5sm3837937wmj.44.2019.10.23.04.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 04:27:20 -0700 (PDT)
Subject: Re: [PATCH v1 05/19] travis.yml: Fix the ccache lines
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191022191704.6134-1-alex.bennee@linaro.org>
 <20191022191704.6134-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <182668f2-ba8d-0c32-6968-659cf9a29614@redhat.com>
Date: Wed, 23 Oct 2019 13:27:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022191704.6134-6-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 9:16 PM, Alex Benn=C3=A9e wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> The "command -v ccache && ccache ..." likely were supposed to test
> the availability of ccache before running the program. But this
> shell construct causes Travis to abort if ccache is not available.
> Use an if-statement instead to fix this problem.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20191009170701.14756-5-thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   .travis.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index e65e53f3d7e..7e0d4ad2b31 100644
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

