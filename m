Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB0AC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A4821848
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A4821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Yor-0001bw-2o
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 07:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6YnN-00019T-2w
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6YnK-0008W2-Da
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6YnK-0008US-5L
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:22:18 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7BF732A09AD
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 11:22:16 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j3so3891783wrn.7
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 04:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y7UIIX3JjqpEM9XPBEPecwWVXhSgy1HcDoqjlb18H4c=;
 b=p7Bl9BIkmSW1tLfyzro10GnclcPwSHnTWLqkFQo1Xb6TaLFhd3bvabchlgpUjfCk48
 9dXS4BQsnbCauvK6DXGL22rTKsKdcLdIjHetSFqdutOZCR2caWRm45/GLxPT011HnzBS
 VogBasm+kiYS8kUp2pinWJiaHTffUgaLlDTLmr7emx2p74uGGIvzefg2GwAsOn9JzMPj
 HQlFEyVEbLjRojnL49geGGap0mqgxyS3FPuVAUtJ4hdj2HqpmvZ2y+ACIHunniRt7MKv
 WXLbXggQPSf+WnIasB8IW9pTWh6/FP7a4i5O63AW+mB6f3+E396SjYBL/gPPVEGAVCmr
 dqlA==
X-Gm-Message-State: APjAAAW6YzIPDgrek8+p3yKrp++PxqnBbg7Nwb9QQ++DMeDIcfDPibo4
 lCXmr4huLAMWsZpCk72bP+7xenmcNi2q1Xht0+CEHss1eNop3rVbIaRmxOckjQFYD33eS1ekAB3
 9SsHprabHGatFMWU=
X-Received: by 2002:a05:600c:2151:: with SMTP id
 v17mr11291557wml.69.1567855335250; 
 Sat, 07 Sep 2019 04:22:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmiUWWPnh8gxjZKuHTB+8GMytrqz9ce6eKX6aMxpxBe1Hszx75ds2W1qsltqLFoL64BePWaA==
X-Received: by 2002:a05:600c:2151:: with SMTP id
 v17mr11291534wml.69.1567855335067; 
 Sat, 07 Sep 2019 04:22:15 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id u18sm5791921wmj.11.2019.09.07.04.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 04:22:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-15-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <21991a0a-06ee-9a84-a88b-337fcf367f1a@redhat.com>
Date: Sat, 7 Sep 2019 13:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 14/42] tests/docker: move our HPPA cross
 compile to Buster
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

On 9/4/19 10:29 PM, Alex Benn=C3=A9e wrote:
> Now Buster is released we can stop relying on the movable feast that
> is Sid for our cross-compiler for building tests.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/docker/Makefile.include                     | 2 +-
>  tests/docker/dockerfiles/debian-hppa-cross.docker | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index e7379f1d732..ba5a624eaec 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -100,9 +100,9 @@ docker-image-debian-win64-cross: docker-image-debia=
n9-mxe
> =20
>  docker-image-debian-alpha-cross: docker-image-debian10
>  docker-image-debian-arm64-cross: docker-image-debian10
> +docker-image-debian-hppa-cross: docker-image-debian10
>  docker-image-debian-powerpc-cross: docker-image-debian10
> =20
> -docker-image-debian-hppa-cross: docker-image-debian-sid
>  docker-image-debian-m68k-cross: docker-image-debian-sid
>  docker-image-debian-sh4-cross: docker-image-debian-sid
>  docker-image-debian-sparc64-cross: docker-image-debian-sid
> diff --git a/tests/docker/dockerfiles/debian-hppa-cross.docker b/tests/=
docker/dockerfiles/debian-hppa-cross.docker
> index ee6d9a24ce8..5c68b2d3304 100644
> --- a/tests/docker/dockerfiles/debian-hppa-cross.docker
> +++ b/tests/docker/dockerfiles/debian-hppa-cross.docker
> @@ -1,10 +1,9 @@
>  #
>  # Docker cross-compiler target
>  #
> -# This docker target builds on the debian sid base image which
> -# contains cross compilers for Debian "ports" targets.
> +# This docker target builds on the debian Buster base image.
>  #
> -FROM qemu:debian-sid
> +FROM qemu:debian10
> =20
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>=20

