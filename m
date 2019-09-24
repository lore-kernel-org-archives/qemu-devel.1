Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783C5C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD7A214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD7A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnG1-00041M-Qc
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCmO8-0000M4-1g
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCmO6-0005Zs-EF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCmO6-0005ZW-6Q
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:05:58 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 366DBC04BD48
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:05:57 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id t11so697983wro.10
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0EU726n0MfhysZe5DhzvUk/QLFtMuQwQ/Nk4aNSFXdc=;
 b=lVeddKIXy+xBifjRCb1aEkTJVXH83KC+Hu12ZgU1/qTlI2G9GZfqSGeminqHz0FG9W
 lQvk1vvFCYCWJ80UwQcY+mW8PQaM8IlqB0OYL+IkhHZFUZJr0hXS3quKAOmsGxbwVDkV
 r84qVyKqWcksiFqXXMD1zU65QHZEhv0OV/tucsyLomNlTHuHRgtlqcnOuSn9uLp/NqwN
 35fOvCC6MC6hVWIJeVe+s8ZwOFOl1JmfC97ScxpY6dOMoHmj9Rq+Ig99g2x+hV5ObxHw
 mJmNYvs6BwrNob+18kdHvXmKkW5YUz5q7FGf73gGV4pj4sPTSc0ds/Tv935yXSXDlKuh
 aOzQ==
X-Gm-Message-State: APjAAAXbg6/0knqCtRoyQQOha0jhgKEEwSonDyjGZT8bghT1SrZ086X9
 Vuk4oY/Kpl7R44YxtouCgnXyw3aHQAvGCrIZ3I1aOfWUnEN8d6ueCFmGgmlWF/Gr023RF2Tn5Vi
 xP7VAmsSLRv/XZMM=
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr2721656wrw.174.1569337555887; 
 Tue, 24 Sep 2019 08:05:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzOYq6XVaZDz0UDkkEQ2DPdtqwYrnVMcdFzDSr7CJGFRe2skgz8Beh2A0pEu2JTL8BaA91JcQ==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr2721640wrw.174.1569337555697; 
 Tue, 24 Sep 2019 08:05:55 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id u25sm360509wml.4.2019.09.24.08.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 08:05:55 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] docker: remove unused debian-ports
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190923181140.7235-1-jsnow@redhat.com>
 <20190923181140.7235-5-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <233b25a0-ec8b-96c6-84e7-6c28dfa332fa@redhat.com>
Date: Tue, 24 Sep 2019 17:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190923181140.7235-5-jsnow@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 8:11 PM, John Snow wrote:
> debian-ports is listed as a partial image, so we cannot run tests again=
st it.
> Since it isn't used by any other testable image, remove it for now as i=
t
> is prone to bitrot.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/Makefile.include                |  2 +-
>  tests/docker/dockerfiles/debian-ports.docker | 36 --------------------
>  2 files changed, 1 insertion(+), 37 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 983224ad96..7bcd97101e 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -6,7 +6,7 @@ DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  # we don't run tests on intermediate images (used as base by another i=
mage)
>  DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
> -DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
> +DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-bootstrap
>  DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILE=
S_DIR)/*.docker))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
> diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docke=
r/dockerfiles/debian-ports.docker
> deleted file mode 100644
> index 61bc3f2993..0000000000
> --- a/tests/docker/dockerfiles/debian-ports.docker
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#
> -# Docker multiarch cross-compiler target
> -#
> -# This docker target is builds on Debian Ports cross compiler targets
> -# to build distro with a selection of cross compilers for building tes=
t binaries.
> -#
> -# On its own you can't build much but the docker-foo-cross targets
> -# build on top of the base debian image.
> -#
> -FROM debian:unstable
> -
> -MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> -
> -RUN echo "deb [arch=3Damd64] http://deb.debian.org/debian unstable mai=
n" > /etc/apt/sources.list
> -
> -# Duplicate deb line as deb-src
> -RUN cat /etc/apt/sources.list | sed -ne "s/^deb\ \(\[.*\]\ \)\?\(.*\)/=
deb-src \2/p" >> /etc/apt/sources.list
> -
> -# Setup some basic tools we need
> -RUN apt-get update && \
> -    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt-get install -y --no-install-recommends \
> -        bison \
> -        build-essential \
> -        ca-certificates \
> -        clang \
> -        debian-ports-archive-keyring \
> -        flex \
> -        gettext \
> -        git \
> -        pkg-config \
> -        psmisc \
> -        python \
> -        texinfo \
> -        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cu=
t -d\  -f2)
>=20

Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

