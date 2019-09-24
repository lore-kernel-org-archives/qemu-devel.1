Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC33C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37542214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37542214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnEo-0003Mp-Un
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCmOG-0000WL-IU
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCmOF-0005dG-4U
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:06:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCmOE-0005cv-TJ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:06:07 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 04853C057F31
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:06:06 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m16so152868wmg.8
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5GrKHgwC7MPF6vl/k0hik56GzjrrH1PAc/VolB5/h1o=;
 b=IeKN1xIE3Ll29WzmQsVF1fWTZFYSONfz+2t0FQ685pq/hbpuswJYbuyTIKWYrNuI9p
 apW2+p7F83XBGtaUDqYAFrrY9yKs6Nd8AjJ9yWZpkrx7mEaMeBtkF/Yn2ibK7A8AtY/+
 aeQSueduXVG5x90suSynSqIUw6GclsOQNATXgmGq+XtR2mSkjzDGMtZWXxuC0P15uMAG
 tbH/qwc6iuk+NAtKMDAiAIxoi+B5qQ5p7jlTr7WdAe97jY4mbFouu+wiJmac7vLUJIUb
 syC4H2s+DZ3iDrYyx+v5kdRfUZG+BbKGbF0BG8nFkNidV3uRo07QGMG043X/DyzDvIZb
 71+A==
X-Gm-Message-State: APjAAAVH2II3EVwIPhL9Weo76jNN/tYS/JTipa9ExfsFJfWPyp42TGcr
 vbBVZUymRwsYkHFH7bvWQvgBXBKn+hnhmceAMjTElPOArby56Y4FCqP3bgTw4f9tAhj8/XOFoAo
 EO1xwZp7j7w+z7ac=
X-Received: by 2002:a5d:490f:: with SMTP id x15mr2678360wrq.375.1569337564771; 
 Tue, 24 Sep 2019 08:06:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwR0rpBrvvnBB+Cjs/YAJEPC95kkgCPKcydGHZgpzr0C9ZKdYN+9Y/Lddrk1HYa87RIMzuxA==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr2678335wrq.375.1569337564563; 
 Tue, 24 Sep 2019 08:06:04 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a7sm1839613wra.43.2019.09.24.08.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 08:06:03 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] docker: remove unused debian-sid
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190923181140.7235-1-jsnow@redhat.com>
 <20190923181140.7235-6-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <33eb952f-8627-d7bf-ab13-b9d44e6a1972@redhat.com>
Date: Tue, 24 Sep 2019 17:06:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190923181140.7235-6-jsnow@redhat.com>
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
> debian-sid is listed as a partial image, so we cannot run tests against=
 it.
> Since it isn't used by any other testable image, remove it for now as i=
t
> is prone to bitrot.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/Makefile.include              |  2 +-
>  tests/docker/dockerfiles/debian-sid.docker | 35 ----------------------
>  2 files changed, 1 insertion(+), 36 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-sid.docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 7bcd97101e..d7b1082b5b 100644
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
> index 2a1bcc33b2..0000000000
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

Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

