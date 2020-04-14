Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA9CC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59501206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJ0I7z56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59501206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKDW-0004Jb-Gs
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 07:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOKCr-0003uZ-RZ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOKCp-0000tQ-FD
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:58:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39598
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOKCp-0000tB-66
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586865498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ahh4SgZ1t3Yeg7g6PXvw8P66D7M0+JYQFfZS3XsO024=;
 b=gJ0I7z56iycGRSrUv+BnzogZ+U8af2eMe5bO6klx+hiqKKE26f8/MSuCZiJ4gzZMCI6Tsr
 2KY10VwrVsgvj6Gi4kOCopPOTDarWud9ZofvniKujnKTewwXnp8bW6/GHenuLkZViRJvkA
 J1eDYNNMwjnYhDOHSihswEAH+PhwVWw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-SuIdX5ZfMyWTimyxzhxvvg-1; Tue, 14 Apr 2020 07:58:14 -0400
X-MC-Unique: SuIdX5ZfMyWTimyxzhxvvg-1
Received: by mail-wr1-f72.google.com with SMTP id f2so103331wrm.9
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 04:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FneldBgWzZDDw/ZaAywdVFZZ9esIKt//bz14A72mJXY=;
 b=f0w47nqJra646YQSAIBno6p35VBF+I90BJE7zydhwxSALGij1p4q0B5skQh7L0aQcb
 7k4/XgOCM4DZX3wa8IlqyV3P+hnTdqH1ay4gYalpq7YrrbhhCBfIqvxEp4dv+hXevEep
 Yq4mVSNkhbpdnly2V9MIKdlRWG7zERHJ8yn+zmGOGjDtrzaQ51xyh9BTGfe8GAX/p98u
 0wHSl4BDth3lXMLTuj2jCVBRvDxPG/CyZrEhdnYVsf+s9t92VnibFmYrupI/WPRLc6jb
 mB2gjN8IMaX8LZgy389YMbfLTQkqtFb4F1a3fN2zDoQTzRX9zsbCg6vPAhwRmEfBlDtb
 WAMg==
X-Gm-Message-State: AGi0PuY/idBWHGQX/oE3+c6oLnssOD8TSD4nHMLGKDv4YCf3HD02Q52d
 SYKncToLnFmQ8v+NHIzNWUkWzQ0Ba0iMDLKFgXWAYdNDgvwzxX3F+N8xyCsVvR1ZLszKNQnHMtr
 Wy7uLn885JvGe0r0=
X-Received: by 2002:a5d:6143:: with SMTP id y3mr23034358wrt.242.1586865493539; 
 Tue, 14 Apr 2020 04:58:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypJxmeByd04fDJCPnAjAG2to+56CFiyuf+ZyIHdnnjU8wSBGyVEi3hKLGB1ptA3Q5iGgGJYCuA==
X-Received: by 2002:a5d:6143:: with SMTP id y3mr23034332wrt.242.1586865493197; 
 Tue, 14 Apr 2020 04:58:13 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id y10sm14347992wma.5.2020.04.14.04.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 04:58:12 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] scripts/coverity-scan: Add Docker support
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5012c7e4-c1ec-79e7-ac0a-f15e2eb1fd6e@redhat.com>
Date: Tue, 14 Apr 2020 13:58:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319193323.2038-7-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 8:33 PM, Peter Maydell wrote:
> Add support for running the Coverity Scan tools inside a Docker
> container rather than directly on the host system.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2:
>   * various bug fixes
>   * added --src-tarball rather than putting the whole source
>     tree in the 'secrets' directory
>   * docker file package list updated
> ---
>   scripts/coverity-scan/coverity-scan.docker | 131 +++++++++++++++++++++
>   scripts/coverity-scan/run-coverity-scan    |  90 ++++++++++++++
>   2 files changed, 221 insertions(+)
>   create mode 100644 scripts/coverity-scan/coverity-scan.docker
>=20
> diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverit=
y-scan/coverity-scan.docker
> new file mode 100644
> index 00000000000..a4f64d12834
> --- /dev/null
> +++ b/scripts/coverity-scan/coverity-scan.docker
> @@ -0,0 +1,131 @@
> +# syntax=3Ddocker/dockerfile:1.0.0-experimental
> +#
> +# Docker setup for running the "Coverity Scan" tools over the source
> +# tree and uploading them to the website, as per
> +# https://scan.coverity.com/projects/qemu/builds/new
> +# We do this on a fixed config (currently Fedora 30 with a known
> +# set of dependencies and a configure command that enables a specific
> +# set of options) so that random changes don't result in our accidentall=
y
> +# dropping some files from the scan.
> +#
> +# We don't build on top of the fedora.docker file because we don't
> +# want to accidentally change or break the scan config when that
> +# is updated.
> +
> +# The work of actually doing the build is handled by the
> +# run-coverity-scan script.
> +
> +FROM fedora:30
> +ENV PACKAGES \
> +    alsa-lib-devel \
> +    bc \
> +    bison \
> +    brlapi-devel \
> +    bzip2 \
> +    bzip2-devel \
> +    ccache \
> +    clang \
> +    curl \
> +    cyrus-sasl-devel \
> +    dbus-daemon \
> +    device-mapper-multipath-devel \
> +    findutils \
> +    flex \
> +    gcc \
> +    gcc-c++ \
> +    gettext \
> +    git \
> +    glib2-devel \
> +    glusterfs-api-devel \
> +    gnutls-devel \
> +    gtk3-devel \
> +    hostname \
> +    libaio-devel \
> +    libasan \
> +    libattr-devel \
> +    libblockdev-mpath-devel \
> +    libcap-devel \
> +    libcap-ng-devel \
> +    libcurl-devel \
> +    libepoxy-devel \
> +    libfdt-devel \
> +    libgbm-devel \
> +    libiscsi-devel \
> +    libjpeg-devel \
> +    libpmem-devel \
> +    libnfs-devel \
> +    libpng-devel \
> +    librbd-devel \
> +    libseccomp-devel \
> +    libssh-devel \
> +    libubsan \
> +    libudev-devel \
> +    libusbx-devel \
> +    libxml2-devel \
> +    libzstd-devel \
> +    llvm \
> +    lzo-devel \
> +    make \
> +    mingw32-bzip2 \
> +    mingw32-curl \
> +    mingw32-glib2 \
> +    mingw32-gmp \
> +    mingw32-gnutls \
> +    mingw32-gtk3 \
> +    mingw32-libjpeg-turbo \
> +    mingw32-libpng \
> +    mingw32-libtasn1 \
> +    mingw32-nettle \
> +    mingw32-nsis \
> +    mingw32-pixman \
> +    mingw32-pkg-config \
> +    mingw32-SDL2 \
> +    mingw64-bzip2 \
> +    mingw64-curl \
> +    mingw64-glib2 \
> +    mingw64-gmp \
> +    mingw64-gnutls \
> +    mingw64-gtk3 \
> +    mingw64-libjpeg-turbo \
> +    mingw64-libpng \
> +    mingw64-libtasn1 \
> +    mingw64-nettle \
> +    mingw64-pixman \
> +    mingw64-pkg-config \
> +    mingw64-SDL2 \
> +    ncurses-devel \
> +    nettle-devel \
> +    nss-devel \
> +    numactl-devel \
> +    perl \
> +    perl-Test-Harness \
> +    pixman-devel \
> +    pulseaudio-libs-devel \
> +    python3 \
> +    python3-sphinx \
> +    PyYAML \
> +    rdma-core-devel \
> +    SDL2-devel \
> +    snappy-devel \
> +    sparse \
> +    spice-server-devel \
> +    systemd-devel \
> +    systemtap-sdt-devel \
> +    tar \
> +    texinfo \
> +    usbredir-devel \
> +    virglrenderer-devel \
> +    vte291-devel \
> +    wget \
> +    which \
> +    xen-devel \
> +    xfsprogs-devel \
> +    zlib-devel
> +ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
> +
> +RUN dnf install -y $PACKAGES
> +RUN rpm -q $PACKAGES | sort > /packages.txt
> +ENV PATH $PATH:/usr/libexec/python3-sphinx/
> +ENV COVERITY_TOOL_BASE=3D/coverity-tools
> +COPY run-coverity-scan run-coverity-scan
> +RUN --mount=3Dtype=3Dsecret,id=3Dcoverity.token,required ./run-coverity-=
scan --update-tools-only --tokenfile /run/secrets/coverity.token
> diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-s=
can/run-coverity-scan
> index d40b51969fa..2e067ef5cfc 100755
> --- a/scripts/coverity-scan/run-coverity-scan
> +++ b/scripts/coverity-scan/run-coverity-scan
> @@ -29,6 +29,7 @@
>  =20
>   # Command line options:
>   #   --dry-run : run the tools, but don't actually do the upload
> +#   --docker : create and work inside a docker container
>   #   --update-tools-only : update the cached copy of the tools, but don'=
t run them
>   #   --tokenfile : file to read Coverity token from
>   #   --version ver : specify version being analyzed (default: ask git)
> @@ -36,6 +37,8 @@
>   #   --srcdir : QEMU source tree to analyze (default: current working di=
r)
>   #   --results-tarball : path to copy the results tarball to (default: d=
on't
>   #                       copy it anywhere, just upload it)
> +#   --src-tarball : tarball to untar into src dir (default: none); this
> +#                   is intended mainly for internal use by the Docker su=
pport
>   #
>   # User-specifiable environment variables:
>   #  COVERITY_TOKEN -- Coverity token
> @@ -125,6 +128,7 @@ update_coverity_tools () {
>   # Check user-provided environment variables and arguments
>   DRYRUN=3Dno
>   UPDATE_ONLY=3Dno
> +DOCKER=3Dno
>  =20
>   while [ "$#" -ge 1 ]; do
>       case "$1" in
> @@ -181,6 +185,19 @@ while [ "$#" -ge 1 ]; do
>               RESULTSTARBALL=3D"$1"
>               shift
>               ;;
> +        --src-tarball)
> +            shift
> +            if [ $# -eq 0 ]; then
> +                echo "--src-tarball needs an argument"
> +                exit 1
> +            fi
> +            SRCTARBALL=3D"$1"
> +            shift
> +            ;;
> +        --docker)
> +            DOCKER=3Dyes
> +            shift
> +            ;;
>           *)
>               echo "Unexpected argument '$1'"
>               exit 1
> @@ -212,6 +229,10 @@ PROJTOKEN=3D"$COVERITY_TOKEN"
>   PROJNAME=3DQEMU
>   TARBALL=3Dcov-int.tar.xz
>  =20
> +if [ "$UPDATE_ONLY" =3D yes ] && [ "$DOCKER" =3D yes ]; then
> +    echo "Combining --docker and --update-only is not supported"
> +    exit 1
> +fi
>  =20
>   if [ "$UPDATE_ONLY" =3D yes ]; then
>       # Just do the tools update; we don't need to check whether
> @@ -221,8 +242,17 @@ if [ "$UPDATE_ONLY" =3D yes ]; then
>       exit 0
>   fi
>  =20
> +if [ ! -e "$SRCDIR" ]; then
> +    mkdir "$SRCDIR"
> +fi
> +
>   cd "$SRCDIR"
>  =20
> +if [ ! -z "$SRCTARBALL" ]; then
> +    echo "Untarring source tarball into $SRCDIR..."
> +    tar xvf "$SRCTARBALL"
> +fi
> +
>   echo "Checking this is a QEMU source tree..."
>   if ! [ -e "$SRCDIR/VERSION" ]; then
>       echo "Not in a QEMU source tree?"
> @@ -242,6 +272,66 @@ if [ -z "$COVERITY_EMAIL" ]; then
>       COVERITY_EMAIL=3D"$(git config user.email)"
>   fi
>  =20
> +# Run ourselves inside docker if that's what the user wants
> +if [ "$DOCKER" =3D yes ]; then
> +    # build docker container including the coverity-scan tools
> +    # Put the Coverity token into a temporary file that only
> +    # we have read access to, and then pass it to docker build
> +    # using --secret. This requires at least Docker 18.09.
> +    # Mostly what we are trying to do here is ensure we don't leak
> +    # the token into the Docker image.
> +    umask 077
> +    SECRETDIR=3D$(mktemp -d)
> +    if [ -z "$SECRETDIR" ]; then
> +        echo "Failed to create temporary directory"
> +        exit 1
> +    fi
> +    trap 'rm -rf "$SECRETDIR"' INT TERM EXIT
> +    echo "Created temporary directory $SECRETDIR"
> +    SECRET=3D"$SECRETDIR/token"
> +    echo "$COVERITY_TOKEN" > "$SECRET"
> +    echo "Building docker container..."
> +    # TODO: This re-downloads the tools every time, rather than
> +    # caching and reusing the image produced with the downloaded tools.
> +    # Not sure why.

I remember something similar when using -f and COPY.

My guess is using -f somefile instead of a directory, then COPY from=20
outside of the directory, the cache is invalidated (or not used). If the=20
file copied and the Dockerfile are in the same directory, it works (for me)=
.

> +    # TODO: how do you get 'docker build' to print the output of the
> +    # commands it is running to its stdout? This would be useful for deb=
ug.

Maybe '--progress plain'?

> +    DOCKER_BUILDKIT=3D1 docker build -t coverity-scanner \
> +                   --secret id=3Dcoverity.token,src=3D"$SECRET" \
> +                   -f scripts/coverity-scan/coverity-scan.docker \
> +                   scripts/coverity-scan
> +    echo "Archiving sources to be analyzed..."
> +    ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
> +    if [ "$DRYRUN" =3D yes ]; then
> +        DRYRUNARG=3D--dry-run
> +    fi
> +    echo "Running scanner..."
> +    # If we need to capture the output tarball, get the inner run to
> +    # save it to the secrets directory so we can copy it out before the
> +    # directory is cleaned up.
> +    if [ ! -z "$RESULTSTARBALL" ]; then
> +        RTARGS=3D"--results-tarball /work/cov-int.tar.xz"
> +    else
> +        RTARGS=3D""
> +    fi
> +    # Arrange for this docker run to get access to the sources with -v.
> +    # We pass through all the configuration from the outer script to the=
 inner.
> +    export COVERITY_EMAIL COVERITY_BUILD_CMD
> +    docker run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
> +           -v "$SECRETDIR:/work" coverity-scanner \
> +           ./run-coverity-scan --version "$VERSION" \
> +           --description "$DESCRIPTION" $DRYRUNARG --tokenfile /work/tok=
en \
> +           --srcdir /qemu --src-tarball /work/qemu-sources.tgz $RTARGS
> +    if [ ! -z "$RESULTSTARBALL" ]; then
> +        echo "Copying results tarball to $RESULTSTARBALL..."
> +        cp "$SECRETDIR/cov-int.tar.xz" "$RESULTSTARBALL"
> +    fi
> +    echo "Docker work complete."
> +    exit 0
> +fi
> +
> +# Otherwise, continue with the full build and upload process.
> +
>   check_upload_permissions
>  =20
>   update_coverity_tools
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


