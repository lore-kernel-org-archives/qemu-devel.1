Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB134C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A3F20738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuoWWlby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A3F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8JLs-0003HT-SO
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k8JKt-0002fg-JR
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:20:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53669
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k8JKq-0000sD-SQ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597825239;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GOwYWB4fmX4oh0+K2uW+k0ttXGmG+9xOGII/7ihbv4k=;
 b=BuoWWlby30iFtoybniD/7JeIgxW1ThgMPO29ec4ZF977FarywEtJ3p4R72Jcg87A6FjWEQ
 yD7gNdHssKGWnnFzpcLhq+5pov5+GcUvS3jjZ47Dsz1a4q/KBPbaihvuPI3Y6Dgi506at3
 SCvlXhcdbE8pP9s28GFGrXUxMPfpyYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-xuFUdEI7MvWkR1dOv_Ck8g-1; Wed, 19 Aug 2020 04:20:20 -0400
X-MC-Unique: xuFUdEI7MvWkR1dOv_Ck8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90FFF81F021;
 Wed, 19 Aug 2020 08:20:19 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33C175DEB5;
 Wed, 19 Aug 2020 08:20:16 +0000 (UTC)
Date: Wed, 19 Aug 2020 09:20:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests: docker: support mxe-based mingw builds
Message-ID: <20200819082013.GB69261@redhat.com>
References: <20200819080206.27423-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200819080206.27423-1-pbonzini@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 04:02:06AM -0400, Paolo Bonzini wrote:
> This can be run with docker-test-mingw@ubuntu1804-mxe, and is the setup
> that Peter uses to test cross-compilation.

We already have docker containers with MXE based on Debian:

  debian-win32-cross.docker
  debian-win64-cross.docker

your image uses a different naming convention, and puts both
32 and 64 bit in the same image.

I feel like we should have the Ubuntu variant follow the same
structure and naming as the Debian variant for consistency.

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/common.rc                        | 18 ++++++-
>  .../docker/dockerfiles/ubuntu1804-mxe.docker  | 54 +++++++++++++++++++
>  tests/docker/test-mingw                       | 11 +++-
>  3 files changed, 80 insertions(+), 3 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/ubuntu1804-mxe.docker
> 
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index ebc5b97ecf..402f6603b6 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -15,10 +15,26 @@
>  # overriden by TARGET_LIST if the user sets it.
>  DEF_TARGET_LIST=${DEF_TARGET_LIST:-"x86_64-softmmu,aarch64-softmmu"}
>  
> +has()
> +{
> +    echo "$FEATURES" | grep -wq -e "$1"
> +}
> +
> +requires_any()
> +{
> +    for c in $@; do
> +        if has "$c"; then
> +            return
> +        fi
> +    done
> +    echo "None of prerequisites '$*' is present, skip"
> +    exit 0
> +}
> +
>  requires()
>  {
>      for c in $@; do
> -        if ! echo "$FEATURES" | grep -wq -e "$c"; then
> +        if ! has "$c"; then
>              echo "Prerequisite '$c' not present, skip"
>              exit 0
>          fi
> diff --git a/tests/docker/dockerfiles/ubuntu1804-mxe.docker b/tests/docker/dockerfiles/ubuntu1804-mxe.docker
> new file mode 100644
> index 0000000000..91895db80d
> --- /dev/null
> +++ b/tests/docker/dockerfiles/ubuntu1804-mxe.docker
> @@ -0,0 +1,54 @@
> +FROM ubuntu:18.04
> +ENV PACKAGES \
> +    ccache \
> +    gcc \
> +    gettext \
> +    git \
> +    gnupg \
> +    gnupg2 \
> +    make \
> +    nsis \
> +    python3-yaml \
> +    python3-sphinx \
> +    python3-setuptools \
> +    texinfo
> +RUN apt-get update && \
> +    DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
> +
> +ENV MXE_PACKAGES \
> +    mxe-i686-w64-mingw32.shared-bzip2 \
> +    mxe-i686-w64-mingw32.shared-curl \
> +    mxe-i686-w64-mingw32.shared-glib \
> +    mxe-i686-w64-mingw32.shared-gcc \
> +    mxe-i686-w64-mingw32.shared-glib \
> +    mxe-i686-w64-mingw32.shared-gmp \
> +    mxe-i686-w64-mingw32.shared-gnutls \
> +    mxe-i686-w64-mingw32.shared-gtk3 \
> +    mxe-i686-w64-mingw32.shared-libjpeg-turbo \
> +    mxe-i686-w64-mingw32.shared-libpng \
> +    mxe-i686-w64-mingw32.shared-nettle \
> +    mxe-i686-w64-mingw32.shared-nsis \
> +    mxe-i686-w64-mingw32.shared-pixman \
> +    mxe-i686-w64-mingw32.shared-pkgconf \
> +    mxe-i686-w64-mingw32.shared-sdl2 \
> +    mxe-x86-64-w64-mingw32.shared-bzip2 \
> +    mxe-x86-64-w64-mingw32.shared-curl \
> +    mxe-x86-64-w64-mingw32.shared-gcc \
> +    mxe-x86-64-w64-mingw32.shared-glib \
> +    mxe-x86-64-w64-mingw32.shared-gmp \
> +    mxe-x86-64-w64-mingw32.shared-gnutls \
> +    mxe-x86-64-w64-mingw32.shared-gtk3 \
> +    mxe-x86-64-w64-mingw32.shared-libjpeg-turbo \
> +    mxe-x86-64-w64-mingw32.shared-libpng \
> +    mxe-x86-64-w64-mingw32.shared-nettle \
> +    mxe-x86-64-w64-mingw32.shared-nsis \
> +    mxe-x86-64-w64-mingw32.shared-pixman \
> +    mxe-x86-64-w64-mingw32.shared-pkgconf \
> +    mxe-x86-64-w64-mingw32.shared-sdl2
> +
> +RUN echo "deb http://pkg.mxe.cc/repos/apt bionic main" > \
> +   /etc/apt/sources.list.d/mxeapt.list && \
> +   apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C6BF758A33A3A276 && \
> +   apt-get update && \
> +   DEBIAN_FRONTEND=noninteractive apt-get install -y $MXE_PACKAGES
> +ENV FEATURES mxe
> diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
> index c30eb654eb..9e2fadb11a 100755
> --- a/tests/docker/test-mingw
> +++ b/tests/docker/test-mingw
> @@ -13,11 +13,18 @@
>  
>  . common.rc
>  
> -requires mingw dtc
> +requires dtc
> +requires_any mingw mxe
>  
>  cd "$BUILD_DIR"
>  
> -for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
> +if has mingw; then
> +  prefixes='x86_64-w64-mingw32- i686-w64-mingw32-'
> +else
> +  prefixes='x86_64-w64-mingw32.shared- i686-w64-mingw32.shared-'
> +  export PATH=/usr/lib/mxe/usr/bin:$PATH
> +fi
> +for prefix in $prefixes; do
>      TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
>          build_qemu --cross-prefix=$prefix \
>          --enable-trace-backends=simple \
> -- 
> 2.26.2
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


