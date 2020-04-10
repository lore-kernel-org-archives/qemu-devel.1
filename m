Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E36C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B572078E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce/P+nn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B572078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMrTo-00089M-VN
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 07:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMrMd-0004gj-38
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMrMX-0004rg-Nn
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:58:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMrMX-0004rB-K7
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586516297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pa6FI2Gv1z36NGz6y0X8/IW0tvqzA2+GbTYJ9WvUQDo=;
 b=ce/P+nn4gCqUrbpbPDD9GPSd8Az+tTLlnoZz1GqhbM+GWTLfm5FC3hWUTkIuRYdiGqnRIZ
 hLoxJOTnnjRZ6ebFDN4e8w16XN22vTnTlmAOxojwNvEhgTEs6lWI6xjH6Mn12K9se0aUHU
 LZbUEvg4kxxAfHM57diY3DbCU+RZIaQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-W_4v4ML3Mye5Hj2MIAH_xA-1; Fri, 10 Apr 2020 06:58:13 -0400
X-MC-Unique: W_4v4ML3Mye5Hj2MIAH_xA-1
Received: by mail-ed1-f69.google.com with SMTP id w8so1839866ede.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 03:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=en8luydTtqH5FIyueeclYjrK+YGJs5BpjtMiu5ZJDd8=;
 b=sWjon/6HsQAvVFs5OUF/KU751A3a5kg0UmcDh5+nxV8klum11Ak/7Y2AWVv8sgINhP
 CrZDIPIn/CX4kIqs0VBvdKX48wg43ifHNMcwGe4ff7L4bTeqII9tGsIq5AG1BJdlA3Bl
 AUwGv2C979rOgZRwzMFh0gPwS4Lx+9iqtJd+tCysQLWxO39E7R2jniR14b60RFy49L9L
 s6m0yUk2agTnO0lkdgabcjovLtxQXAPfSQy1NE0tcCGlsGrCUcXKSUzZDAD5GZXrFC1K
 hN9IyYsOCZfoEPwnb2nlcfJZYM2jo2JyHH2vaExhAK/d6hUT93gAWQGzr/KINALyKQ6z
 NU+Q==
X-Gm-Message-State: AGi0PuZ8e1J9nS3WMoi4cyhKnYAf42FB/J2Ilg4s9wgL/PnwPopC0o1M
 LS4JLXCzgKTGdAvx/ZAlVJmPfOKjXbJY3hn48bPu/RRPUin6NJrPJd9h6eUG0YcUyLqA8I+9Jcj
 hJA5Vfn6hU5nwPEg=
X-Received: by 2002:aa7:d4c4:: with SMTP id t4mr4161942edr.181.1586516291452; 
 Fri, 10 Apr 2020 03:58:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypKcjle0HiMgRaBALygtf49hTzs8lVIRiU3v1KrktJkDZOsYgURVX3Dzw6AxmGt82F1KGgkWAw==
X-Received: by 2002:aa7:d4c4:: with SMTP id t4mr4161934edr.181.1586516291250; 
 Fri, 10 Apr 2020 03:58:11 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z13sm80973edj.0.2020.04.10.03.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 03:58:10 -0700 (PDT)
Subject: Re: [PATCH v1 05/11] tests/docker: add docs FEATURE flag and use for
 test-misc
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a4e31a27-cca3-2742-719b-a9ff8a300394@redhat.com>
Date: Fri, 10 Apr 2020 12:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-6-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:
> The test-misc docker test fails on a number of images which don't have
> the prerequisites to build the docs. Use the FEATURES flag so we can
> skip those tests.
>=20
> As the sphinx test fails to detect whatever feature we need to get
> hxtool to work we drop them from debian9 so the windows build doesn't
> attempt to build the docs.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian10.docker   | 2 ++
>   tests/docker/dockerfiles/debian9.docker    | 2 --
>   tests/docker/dockerfiles/fedora.docker     | 2 +-
>   tests/docker/dockerfiles/travis.docker     | 2 +-
>   tests/docker/dockerfiles/ubuntu.docker     | 2 +-
>   tests/docker/dockerfiles/ubuntu1804.docker | 2 +-
>   tests/docker/test-misc                     | 2 ++
>   7 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dock=
erfiles/debian10.docker
> index 2fcdc406e83..0769700a416 100644
> --- a/tests/docker/dockerfiles/debian10.docker
> +++ b/tests/docker/dockerfiles/debian10.docker
> @@ -34,3 +34,5 @@ RUN apt update && \
>           python3-sphinx \
>           texinfo \
>           $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut=
 -d\  -f2)
> +
> +ENV FEATURES docs
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/docke=
rfiles/debian9.docker
> index 92edbbf0f48..08cc970feb1 100644
> --- a/tests/docker/dockerfiles/debian9.docker
> +++ b/tests/docker/dockerfiles/debian9.docker
> @@ -30,6 +30,4 @@ RUN apt update && \
>           pkg-config \
>           psmisc \
>           python3 \
> -        python3-sphinx \
> -        texinfo \
>           $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut=
 -d\  -f2)
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 4bd2c953af8..179575ecaaa 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -103,4 +103,4 @@ ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
>   RUN dnf install -y $PACKAGES
>   RUN rpm -q $PACKAGES | sort > /packages.txt
>   ENV PATH $PATH:/usr/libexec/python3-sphinx/
> -ENV FEATURES mingw clang pyyaml asan
> +ENV FEATURES mingw clang pyyaml asan docs
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/docker=
files/travis.docker
> index e8eb48dccfd..591282561bc 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -13,5 +13,5 @@ RUN apt-get -y install device-tree-compiler python3 pyt=
hon3-yaml dh-autoreconf g
>   # Travis tools require PhantomJS / Neo4j / Maven accessible
>   # in their PATH (QEMU build won't access them).
>   ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4j=
-3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/local=
/clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/b=
in
> -ENV FEATURES clang pyyaml
> +ENV FEATURES clang pyyaml docs
>   USER travis
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/docker=
files/ubuntu.docker
> index b6c7b41dddd..eeb3b22bf20 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -68,4 +68,4 @@ ENV PACKAGES flex bison \
>   RUN apt-get update && \
>       DEBIAN_FRONTEND=3Dnoninteractive apt-get -y install $PACKAGES
>   RUN dpkg -l $PACKAGES | sort > /packages.txt
> -ENV FEATURES clang pyyaml sdl2
> +ENV FEATURES clang pyyaml sdl2 docs
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/do=
ckerfiles/ubuntu1804.docker
> index 1efedeef995..f66b06f4cff 100644
> --- a/tests/docker/dockerfiles/ubuntu1804.docker
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -54,7 +54,7 @@ ENV PACKAGES flex bison \
>   RUN apt-get update && \
>       DEBIAN_FRONTEND=3Dnoninteractive apt-get -y install $PACKAGES
>   RUN dpkg -l $PACKAGES | sort > /packages.txt
> -ENV FEATURES clang pyyaml sdl2
> +ENV FEATURES clang pyyaml sdl2 docs
>  =20
>   # https://bugs.launchpad.net/qemu/+bug/1838763
>   ENV QEMU_CONFIGURE_OPTS --disable-libssh
> diff --git a/tests/docker/test-misc b/tests/docker/test-misc
> index d480afedca7..cc94a738dd0 100755
> --- a/tests/docker/test-misc
> +++ b/tests/docker/test-misc
> @@ -14,6 +14,8 @@
>  =20
>   . common.rc
>  =20
> +requires docs

TIL 'requires' macro. Clean fix.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
>   cd "$BUILD_DIR"
>  =20
>   # build everything else but QEMU
>=20


