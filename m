Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E45C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B23F21848
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 11:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B23F21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Yrf-0003ex-9K
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 07:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6YoN-0001a3-E8
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6YoM-0000lI-Do
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6YoL-0000kk-TM
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 07:23:22 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DBCD936887
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 11:23:20 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id x12so3909231wrs.0
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 04:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3nJNeMWcgu2z2n/WEBss0LWNJrejhuvn0PuGz3OKyYQ=;
 b=A3IQnZDsYgnz6zxARsdPXJ5vZordkXfJvbc8n3jZl2oSfe4DGHbWLvn5b/zVchhGNL
 Gb0cve280yRPzE3dT4+N+XwyEY6sc9qVNpajOjN/0lWIc98M50eyqPPkgBCV+xf43WSy
 o+8i/cKpjQMmwhhlgfeeoaJV4eFpPxf/bR0fdptuAtBbDSIEvMjGx6bJxBFPYfXdde8E
 QETE8ohqju31a0iOHxEvhOJ5Dn9F1LJCC6Is5eqU4nd6FvBdGQTQxUSVNN+GinsUcSjx
 fsDDVU880asIrrfKPyWyJmj/SYN4DRlPJR5KVq2+cRmuSwYuV/+PBNKYMSm8jOmy8ZCO
 Zwdg==
X-Gm-Message-State: APjAAAWGGx4khgLCmhtd5k33J1hurTOBbPEV+aFzyNq0RXIl5irg4K81
 9K/CmyF3XPu3+JDVWoSl8JzxjVm6YtA8UQK9G0VQfT69GdNJkezEuiFkvlghG6lftLVKD7cq1oi
 TKc2slgT0T8nRjBQ=
X-Received: by 2002:a1c:f518:: with SMTP id t24mr10579789wmh.98.1567855399630; 
 Sat, 07 Sep 2019 04:23:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjIuDp4/qsc/e/FwD3g6x501xUWzkvKOgwwVN+Wk3pQYwohwzYNBO0zr8ovjaoj84S8Zl+9Q==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr10579783wmh.98.1567855399467; 
 Sat, 07 Sep 2019 04:23:19 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id z189sm13073254wmc.25.2019.09.07.04.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 04:23:18 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6dcb4d53-b217-f1ce-924c-89f4cf1dce3c@redhat.com>
Date: Sat, 7 Sep 2019 13:23:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 13/42] tests/docker: move our Alpha
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
>  tests/docker/Makefile.include                      | 2 +-
>  tests/docker/dockerfiles/debian-alpha-cross.docker | 7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 7c1ff677a13..e7379f1d732 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -98,10 +98,10 @@ docker-image-debian-s390x-cross: docker-image-debia=
n9
>  docker-image-debian-win32-cross: docker-image-debian9-mxe
>  docker-image-debian-win64-cross: docker-image-debian9-mxe
> =20
> +docker-image-debian-alpha-cross: docker-image-debian10
>  docker-image-debian-arm64-cross: docker-image-debian10
>  docker-image-debian-powerpc-cross: docker-image-debian10
> =20
> -docker-image-debian-alpha-cross: docker-image-debian-sid
>  docker-image-debian-hppa-cross: docker-image-debian-sid
>  docker-image-debian-m68k-cross: docker-image-debian-sid
>  docker-image-debian-sh4-cross: docker-image-debian-sid
> diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests=
/docker/dockerfiles/debian-alpha-cross.docker
> index 23444342f03..74bcabfdb12 100644
> --- a/tests/docker/dockerfiles/debian-alpha-cross.docker
> +++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
> @@ -1,13 +1,12 @@
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
>      apt install -y --no-install-recommends \
>          gcc-alpha-linux-gnu \
> -        libc6.1-dev-alpha-cross || { echo "Failed to build - see debia=
n-sid.docker notes"; exit 1; }
> +        libc6.1-dev-alpha-cross
>=20

