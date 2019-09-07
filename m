Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC6C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A4821848
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A4821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6YtY-00058q-U1
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 07:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6Ypg-0002XS-Lz
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6Ypf-0001Gh-OE
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:24:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6Ypf-0001G9-GI
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:24:43 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AED7793E5
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 11:24:42 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 124so3162455wmz.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 04:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v+UsSyJ5HySEyRFX80vuwudnSILo5MOPAct6eCBgr8w=;
 b=pzADyeSIarxW+HDs08duY/ShLMuFZIv+nH5aue8XraoeXJgFduL96dn0MNDhjpB2Bd
 7sFne0auGpwMhoM/k0pwuq3Y5hh3t8wMPd5euYTM/mkqzDB/QeqIgEB0c3UQ1p/5tnlb
 cBdxI0VarnrP0HhkAjRuX0+lBAh0/Rd5IvVA00EgqXyETlcxDxyCtLTeBogznnRXxYRt
 hgQGerSRPjEYV2qvm4I9hMVB/Bex2SnDxUjyyjzzWEt4gErQLkKNLWHEDz8n0fkil1rh
 VkplsAtsEa6qKbzXLBddnTKF7QFbNYfn9qruPRk9wG2XI280hnl+MP2vC8OtylzOxxYt
 SEpQ==
X-Gm-Message-State: APjAAAXkXXx3IDnSX7H6uIQuhrtYLV+PEMMC/W9/bZ0SLhX4fE+QibfG
 Z4jAFYzAwju1lhj7ed56TdFOHeFZKCTPKGudpMRrwAlVGg1H4xkdboQ9KVE92K17Yd2bvi6Fg4y
 eqU8rDQJbLipRD9s=
X-Received: by 2002:a5d:448a:: with SMTP id j10mr10528113wrq.82.1567855481310; 
 Sat, 07 Sep 2019 04:24:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXRYX+sp6ErZdNvN2VPGiLOamo0J4g1YpF+/MCJZlR2Kdr8nttacXHXKIU2xpJts/xSJmbIQ==
X-Received: by 2002:a5d:448a:: with SMTP id j10mr10528100wrq.82.1567855481149; 
 Sat, 07 Sep 2019 04:24:41 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id s1sm12105969wrg.80.2019.09.07.04.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 04:24:40 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-20-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <99fd99d0-0cca-f716-25cf-72f664ca932f@redhat.com>
Date: Sat, 7 Sep 2019 13:24:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 19/42] tests/docker: move our riscv64
 cross compile to Buster
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
>  tests/docker/Makefile.include                        | 2 +-
>  tests/docker/dockerfiles/debian-riscv64-cross.docker | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 896c1c5a601..93190b1e2a2 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -104,10 +104,10 @@ docker-image-debian-hppa-cross: docker-image-debi=
an10
>  docker-image-debian-m68k-cross: docker-image-debian10
>  docker-image-debian-mips64-cross: docker-image-debian10
>  docker-image-debian-powerpc-cross: docker-image-debian10
> +docker-image-debian-riscv64-cross: docker-image-debian10
>  docker-image-debian-sh4-cross: docker-image-debian10
>  docker-image-debian-sparc64-cross: docker-image-debian10
> =20
> -docker-image-debian-riscv64-cross: docker-image-debian-sid
>  docker-image-debian-ppc64-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=3D1
> =20
> diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tes=
ts/docker/dockerfiles/debian-riscv64-cross.docker
> index 221697f9d11..5e2d6ddb600 100644
> --- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
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

