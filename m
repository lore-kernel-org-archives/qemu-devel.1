Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F1C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B992205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B992205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFje-0000wH-EN
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFhd-0006tE-B9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFhc-0004mG-4C
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:24:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFhb-0004jt-S7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:24:04 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D9A34ACA5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:23:59 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s25so111456wmh.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tus9LpLQZVhv93SX8Mqgj1l4LTDH4fDz9FVmI5Vr9u4=;
 b=rsfMI6Hp0ounbsM+jCVbcM2clybyj5rQMDuDCfI75ae0lYe9K3PRYnco7nL46lZ5Sg
 HADGKf7A6ysoFVtWGClerxirZc7aE8/X/RgjfMHYkDLGcLHwbM/nLqAXLbbxk40PbwSY
 a+E+8rsR3hwI3iifHRJtFu6iNmEbvOKj4NJ74uLqgQ1PTZ2Tn6ljp75OiGbl8LKhj90U
 dKwT8H6ONb2OJVsQPPH/UMNSSsSJK0Jx2dhHV5aXZSuBKfyQXRCdsBRzcDYOLceUx3IU
 0XgDo4hfzjDnew108gpWHjGjc6uOgOAf0L5xjATpDoGsg1oMM4HY4f4bYcNw7tfA8iUw
 bZFw==
X-Gm-Message-State: APjAAAUzgveklBjzHpXHc7WCfJWsnEdtMGIZgEQhrG7kBTdJ3Gzi/qnn
 /+JAASd9sc9Tt2zrouwAMjEdGYtcU5B9Gr1CyWjlC4yAqlXaf2pyHwz/qb73LzNM9SXmYD7QlqB
 v75b4o+TQzj/Z4Zw=
X-Received: by 2002:a05:600c:238a:: with SMTP id
 m10mr348001wma.51.1569450238032; 
 Wed, 25 Sep 2019 15:23:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxAEKH4lM+A6+1wIwWQ9TBpjs9CNYzApz2HO+uz6LnkCDuRYd3iddvwZtAQKnRzwYsHJUmpsQ==
X-Received: by 2002:a05:600c:238a:: with SMTP id
 m10mr347989wma.51.1569450237858; 
 Wed, 25 Sep 2019 15:23:57 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id e30sm841301wra.48.2019.09.25.15.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:23:57 -0700 (PDT)
Subject: Re: [PATCH v3 29/33] docker: remove 'deprecated' image definitions
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-30-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <95fcc08f-d2f1-edf7-0203-d867d297ac9f@redhat.com>
Date: Thu, 26 Sep 2019 00:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>, jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:01 PM, Alex Benn=C3=A9e wrote:
> From: John Snow <jsnow@redhat.com>
>=20
> There isn't a debian.dockerfile anymore,
> so perform some ghost-busting.

Won't we deprecate other images in the future?

> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-Id: <20190923181140.7235-4-jsnow@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 82d5a8a5393..fd6f470fbf8 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -4,11 +4,10 @@
> =20
>  DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
> -DOCKER_DEPRECATED_IMAGES :=3D debian
>  # we don't run tests on intermediate images (used as base by another i=
mage)
> -DOCKER_PARTIAL_IMAGES :=3D debian debian9 debian10 debian-sid
> +DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
>  DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
> -DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(n=
otdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
> +DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILE=
S_DIR)/*.docker))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
>  DOCKER_CCACHE_DIR :=3D $$HOME/.cache/qemu-docker-ccache
> @@ -160,7 +159,7 @@ docker-image-debian-powerpc-user-cross: docker-binf=
mt-image-debian-powerpc-user
>  DOCKER_USER_IMAGES +=3D debian-powerpc-user
> =20
>  # Expand all the pre-requistes for each docker image and test combinat=
ion
> -$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(D=
OCKER_DEPRECATED_IMAGES)), \
> +$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>  		$(eval .PHONY: docker-$t@$i) \
>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>=20

