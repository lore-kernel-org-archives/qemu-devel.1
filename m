Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A80C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 20:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3A02178F
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 20:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3A02178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6gvz-0005wg-0E
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 16:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6gvC-0005Y4-0A
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 16:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6gv9-0008O7-CE
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 16:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6gv9-0008MU-46
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 16:02:55 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8BFF48BA02
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2019 20:02:52 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t16so4393400wro.3
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 13:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qIBrxJvdW6A2Vzn47AcTxhnhgp6JiAJsNMrW3E0j7HY=;
 b=a/mvpy4/AL8HeR4SazjTQmOpbiSbIo4LQJ7RB1tCdrM5FBLyZ4bKlGS3NHtJTgyT4P
 BA6W/XoQfEAYoPeIkNibfAjkY/MHRGEgUvMbJyEYI6vsDOPN9XMOjVm8TukEUtfKlNQc
 ohdKw63OlR3e7fWkrCm35RtNdOPK8nnqKikbFeKnpdczO7zyC0Mk88h3L0LSSUU1hNY2
 m9QbbkSGobQ5Pim+hyWAL/h5FVjayFKQP9lNvBFkN8cUE16DJvAxnZHuW8/hF9Uhx/9a
 +i8TlpHIF9Yh8lGq8vuTA7nQ69zD3UOBFqxagrtTm95HmMmcwuB3LQtZ84pypzb721h6
 vO0A==
X-Gm-Message-State: APjAAAXWKN4qhUBDr5GjKppPIJkJ4uFIBW4QbSFPRhLEf+dPwdDxnx2B
 mLo8b1GhlELUkDq9NvJ/zxiRhE5ay3vtM80YzECWBHRQ+LcoUkG0YGbhRQ1v6US0SN9CKq0ldHY
 J1CezznMF4xiUmQE=
X-Received: by 2002:a1c:6c19:: with SMTP id h25mr11755959wmc.64.1567886571279; 
 Sat, 07 Sep 2019 13:02:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyPYqtx4b/h8A2VpEPpQg9AYfaAPNrlCnK+KIgW+wd4VwYg3+OVJZsYQg8ByHRc10li9lJD1Q==
X-Received: by 2002:a1c:6c19:: with SMTP id h25mr11755937wmc.64.1567886571056; 
 Sat, 07 Sep 2019 13:02:51 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id v4sm16600738wrg.56.2019.09.07.13.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2019 13:02:50 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-22-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6aeb08e3-fe22-e72c-e0dd-78d6faee57e3@redhat.com>
Date: Sat, 7 Sep 2019 22:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 21/42] tests/docker: drop debian-sid
 image
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
> Debian Sid was only ever a stop gap and thanks to the much better
> cross compiler in the Buster release we don't need it any more. Send
> it on its merry way.

I'm not sure about this one... Why not update and keep it?

-- >8 --
-FROM debian:sid-20181011-slim
+FROM debian:sid-20190812-slim

 # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20181030"
+ENV DEBIAN_SNAPSHOT_DATE "20190820"
---

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include              |  2 +-
>  tests/docker/dockerfiles/debian-sid.docker | 41 ----------------------
>  2 files changed, 1 insertion(+), 42 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-sid.docker
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index b6c04059502..59fbebbe2e6 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -6,7 +6,7 @@ DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  DOCKER_DEPRECATED_IMAGES :=3D debian
>  # we don't run tests on intermediate images (used as base by another i=
mage)
> -DOCKER_PARTIAL_IMAGES :=3D debian debian8 debian9 debian10 debian8-mxe=
 debian-ports debian-sid debian-bootstrap
> +DOCKER_PARTIAL_IMAGES :=3D debian debian8 debian9 debian10 debian8-mxe=
 debian-ports debian-bootstrap
>  DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(n=
otdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/=
dockerfiles/debian-sid.docker
> deleted file mode 100644
> index 513459ca7f8..00000000000
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -#
> -# Debian Sid Base
> -#
> -# A number of our guests exist as ports only. We can either use the
> -# ports repo or get everything from Sid. However Sid is a rolling
> -# distro which may be broken at any particular time. If you are
> -# unlucky and try and build your images while gcc is in the process of
> -# being uploaded this can fail. Your only recourse is to try again in
> -# a few hours when the repos have re-synced. Once built however you
> -# won't be affected by repo changes unless the docker recipies are
> -# updated and trigger a re-build.
> -#
> -
> -# This must be earlier than the snapshot date we are aiming for
> -FROM debian:sid-20181011-slim
> -
> -# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
> -ENV DEBIAN_SNAPSHOT_DATE "20181030"
> -RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [=
check-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNA=
PSHOT_DATE} \2%" /etc/apt/sources.list
> -
> -# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
> -ENV DEBIAN_SNAPSHOT_DATE "20181030"
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

