Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D031AC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A083920640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A083920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFl9-0002Ru-8T
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFgW-0005Rz-LU
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFgV-0003D3-6o
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:22:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFgU-0003Be-RU
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:22:55 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B838B4ACA5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:22:53 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 4so102279wmj.6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yye+HY6RXT8WK9Asq9jxhIG6sJzLDBrzeXQbFe2+3Xo=;
 b=CVZ4V8u9OsRKLLRpNNLb2JVS3bQnvPYQV5ncceGSwCRMlRqbySTFEPsRNB62A9Nh6G
 Xmgz9KXALEv9jcgxkvtHb+NQlUM1f20VsIn8NQwzokbUESBQcBqEZiusPL5cHtI1KdnR
 fK1JPP4gl857FoLY/eCZcBSJNm7ANen9Q8ASxcGn6f4zSbAVD+wJIrm5q/nDcCKBO1nS
 JnVaPD1hHbcRAWmV67J8O4996QWmn2xOfDBnXXWiZ2YzqdoAmw4sQ7mll5NhJ8YPUN5Q
 rdL9uR5liHXH8Be1B05edlrHElPZLvQYWKg28tsAu909D8txVkpnQWI2DnFc/h0FNhDn
 Vp1w==
X-Gm-Message-State: APjAAAUP31LmPLpfP8roy/cFS49xVoudiJtuDxXK1gJNhp/g+lWVYE0G
 FXOnQM2MMfaU0ok2lmYI2mdC6TIJ76Vxi75r8Sn+KEp4iP7wuFXt0Oj6Lf8u/Wscc64RzctWUFE
 DNc/B6xmWvupb9+Q=
X-Received: by 2002:a1c:a697:: with SMTP id p145mr319426wme.24.1569450172522; 
 Wed, 25 Sep 2019 15:22:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykdCLO0SOrecAOFfyIOT2eU/meSW0NJOqymWT9RbD9MQm6WZjmRrhBdP1IvAJJJtuQGUTkFQ==
X-Received: by 2002:a1c:a697:: with SMTP id p145mr319415wme.24.1569450172322; 
 Wed, 25 Sep 2019 15:22:52 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id q15sm836393wrg.65.2019.09.25.15.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:22:51 -0700 (PDT)
Subject: Re: [PATCH v3 31/33] docker: remove unused debian-sid
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-32-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <99746039-9b57-e082-f415-3395522dbbc4@redhat.com>
Date: Thu, 26 Sep 2019 00:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-32-alex.bennee@linaro.org>
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
> debian-sid is listed as a partial image, so we cannot run tests against=
 it.
> Since it isn't used by any other testable image, remove it for now as i=
t
> is prone to bitrot.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-Id: <20190923181140.7235-6-jsnow@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/docker/Makefile.include              |  2 +-
>  tests/docker/dockerfiles/debian-sid.docker | 35 ----------------------
>  2 files changed, 1 insertion(+), 36 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-sid.docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 053c418d8cd..180e5439ef9 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -5,7 +5,7 @@
>  DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  # we don't run tests on intermediate images (used as base by another i=
mage)
> -DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
> +DOCKER_PARTIAL_IMAGES :=3D debian9 debian10
>  DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-bootstrap
>  DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILE=
S_DIR)/*.docker))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/=
dockerfiles/debian-sid.docker
> deleted file mode 100644
> index 2a1bcc33b24..00000000000
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -#
> -# Debian Sid Base
> -#
> -# Currently we can build all our guests with cross-compilers in the
> -# latest Debian release (Buster). However new compilers will first
> -# arrive in Sid. However Sid is a rolling distro which may be broken
> -# at any particular time. To try and mitigate this we use Debian's
> -# snapshot archive which provides a "stable" view of what state Sid
> -# was in.
> -#
> -
> -# This must be earlier than the snapshot date we are aiming for
> -FROM debian:sid-20190812-slim
> -
> - # Use a snapshot known to work (see http://snapshot.debian.org/#Usage=
)
> -ENV DEBIAN_SNAPSHOT_DATE "20190820"
> -RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [=
check-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNA=
PSHOT_DATE} \2%" /etc/apt/sources.list
> -
> -# Duplicate deb line as deb-src
> -RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/s=
ources.list
> -
> -# Install common build utilities
> -RUN apt update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt install -y --no-install-recommends \
> -        bison \
> -        build-essential \
> -        ca-certificates \
> -        flex \
> -        git \
> -        pkg-config \
> -        psmisc \
> -        python \
> -        texinfo || { echo "Failed to build - see debian-sid.docker not=
es"; exit 1; }
>=20

