Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97BCC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACF0217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACF0217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB2ts-0002YY-TR
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 16:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iB2t0-0001r3-NY
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iB2sy-0001ZO-Pw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iB2sy-0001ZE-Ix
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:18:40 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B17EC028323
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 20:18:39 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f11so1416592wrt.18
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 13:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2hwPCRQYX473OxTQlM1L/+a6vhIFAQWyWJ+LS3CKTFA=;
 b=GfVpeOnw/a1WKLIuSq97XGCj3ysdYaHPcJV9pmIWuN6xyi+lisk6jOAiUoNX1KDfCo
 hW9rsfUQKKbrknafs2BMQtPuc91yh9bZsynhA24bQWZzpjRhuegbqQYfOw+gq6mOvj3+
 ai1OHeVkvHAu8UtcjPXbvuiRJn90AgMZWkVXJQGfIK02tqzoTl/meNL1nBIVCRvrvKBK
 U+BcKeD4LbdKfw+PW52JwuNerjOonVq0ycBqIUOvcgo93QatY/nXs6TmqTBOL2VKK6pv
 0cNT0bdvvALF0V9IJPgUlF1lJQBbWbLighh+4PBxroCVqhMCUm15WoUOh6gWftvE+F7k
 tjEw==
X-Gm-Message-State: APjAAAVkrJfOJWU2pfE2fuEAMeoebe9/U3pSkZjcRQIT0d5qkmQ7cawm
 iYr/Sg2AqQ3saQUc/l+CCDrunu+H8IxQYHDH3z1C/GAWw4umjEkTqkUufLKQTLWq7/UMxFsCrBZ
 +RjV7xAdSS2okx/0=
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr4385243wmc.140.1568924318276; 
 Thu, 19 Sep 2019 13:18:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzde8dcQ+UB2Jh+cYlV4Aib8bfBvBJs7DKEltWHqahnPM1K+sxP26dfTfbGXjzj3M96tTW1pA==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr4385234wmc.140.1568924318093; 
 Thu, 19 Sep 2019 13:18:38 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id o19sm13246693wro.50.2019.09.19.13.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 13:18:36 -0700 (PDT)
Subject: Re: [PULL 31/45] tests/docker: add more images to PARTIAL_IMAGES when
 not on x86_64
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20190910084349.28817-1-alex.bennee@linaro.org>
 <20190910084349.28817-32-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <984feb48-31a9-2fc0-e1e7-e9d7a78b706f@redhat.com>
Date: Thu, 19 Sep 2019 22:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190910084349.28817-32-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 9/10/19 10:43 AM, Alex Benn=C3=A9e wrote:
> This prevents us trying to do builds which we can't complete.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 7df8dbe1a17..50a400b573a 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -106,6 +106,15 @@ docker-image-debian-s390x-cross: docker-image-debi=
an9
>  docker-image-debian-win32-cross: docker-image-debian9-mxe
>  docker-image-debian-win64-cross: docker-image-debian9-mxe
> =20
> +# For non-x86 hosts not all cross-compilers have been packaged
> +ifneq ($(ARCH),x86_64)
> +DOCKER_PARTIAL_IMAGES +=3D debian-mips-cross debian-mipsel-cross debia=
n-mips64el-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-ppc64el-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-s390x-cross
> +DOCKER_PARTIAL_IMAGES +=3D debian-win32-cross debian-win64-cross
> +DOCKER_PARTIAL_IMAGES +=3D fedora travis
> +endif
> +
>  docker-image-debian-alpha-cross: docker-image-debian10
>  docker-image-debian-arm64-cross: docker-image-debian10
>  docker-image-debian-hppa-cross: docker-image-debian10
>=20

I wanted to run the Travis tests locally (per
docs/devel/testing.rst:364) but I got:

$ make docker-travis@travis
  LD      docker-travis@travis.mo
cc: fatal error: no input files
compilation terminated.
make: *** [rules.mak:118: docker-travis@travis.mo] Error 1

Bisected to this patch:

e5389e44147e4c8d652006ed086c48f74684726a is the first bad commit
commit e5389e44147e4c8d652006ed086c48f74684726a
Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Date:   Thu Aug 15 19:40:48 2019 +0000

    tests/docker: add more images to PARTIAL_IMAGES when not on x86_64

    This prevents us trying to do builds which we can't complete.

Removing 'travis' from this list we get it working again.

Regards,

Phil.

