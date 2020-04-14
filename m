Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D66C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBC72075E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huF2ZsIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBC72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKTU-0002I0-AM
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOKSi-0001VW-Px
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOKSg-00079Y-HE
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:14:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOKSg-000791-1j
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586866481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSZasHDWl8t4hWmW/nquVJ3evtfM35wPV6sVK5ZJDKE=;
 b=huF2ZsIbl/5OUJgkq8JpSShA2sXVkk9FHUZPsE2SZAS7H1n4prbGceZEXp4pqOwIkiBsng
 6ColoRV4FlcyvZNizV8vdzZzFknwxbKXFu8EF0XCOqATZfcW8D36J6yrOh4uehs5yIo6B7
 RYpN+KcpEd7evj3CjXbngKypEzi9Dcs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-vlIRTw44MOm1Xh-RWubhAA-1; Tue, 14 Apr 2020 08:14:39 -0400
X-MC-Unique: vlIRTw44MOm1Xh-RWubhAA-1
Received: by mail-wr1-f69.google.com with SMTP id g6so8550490wru.8
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 05:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HysHCR4ruGbVLOolkEh/FFI0GFGmGnhlEcJfmpXuQJs=;
 b=AuzG0olPJxCWCQzesbS46HFvsMQo98UqSK7ilT+1uyMWCw2x+sU4D0pntojwz3VPXX
 neNqrWyq8bfSi7Xfmf6rr3jLNh7ff/RL5i1423bffvXaQys77H1eC0xU8uSoQCx5PE/b
 2YpXzFT5JD9sDNMkb+RJV2uODQxJQZncHdIxcFayGOpAVLQ1jWHuXVakn88l3et6N2Dm
 Wotpo+GbgemUZFYxC1wjqLO9cyJ1GC7pYLfOs52ZZB3NiOtMf6SjAKc9JGUDUd2ngZsd
 f5tAYCTVv0Zf4rLbqSTkQRF5MBRzY5HwixlL6RRQd1QX2s+VxlnnjF1kI6GZJiT/Fcb0
 9mcQ==
X-Gm-Message-State: AGi0PuZwXcWFBCKH+PtW9AD9YpAZyz34lSRIbYKfdN7SR6MytbJqNnhE
 tYnRfGOOdQv3tvmUVdcggDo8dMSDp5zD+GlVe2ctxpZD4hzxUi1Rg/GyhCYag3XW3hAXjOKMqgk
 B8DEG9YT1DmoJrg8=
X-Received: by 2002:a5d:4292:: with SMTP id k18mr4134046wrq.137.1586866475005; 
 Tue, 14 Apr 2020 05:14:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypJElXj3tuxGx4V/JbW59bj87tAWe7WSJg6gsmyA2y4jHn3nfdZwxNYfW/u/xbk22mCDU3sv1A==
X-Received: by 2002:a5d:4292:: with SMTP id k18mr4134011wrq.137.1586866474575; 
 Tue, 14 Apr 2020 05:14:34 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q18sm11971018wmj.11.2020.04.14.05.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 05:14:34 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] scripts/run-coverity-scan: Script to run Coverity
 Scan build
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a0b0055-4abe-6fcf-4cfb-b26b0206dbfd@redhat.com>
Date: Tue, 14 Apr 2020 14:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319193323.2038-6-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> Add a new script to automate the process of running the Coverity
> Scan build tools and uploading the resulting tarball to the
> website.
>=20
> This is intended eventually to be driven from Travis,
> but it can be run locally, if you are a maintainer of the
> QEMU project on the Coverity Scan website and have the secret
> upload token.
>=20
> The script must be run on a Fedora 30 system.  Support for using a
> Docker container is added in a following commit.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> changes v1->v2:
>   * fix sense of DRYRUN test in check_upload_permissions
>   * use nproc rather than hardcoding -j8
>   * use $PWD rather than $(pwd)
>   * minor tweaks to configure line
>   * new --results-tarball option
> ---
>   MAINTAINERS                             |   5 +
>   scripts/coverity-scan/run-coverity-scan | 311 ++++++++++++++++++++++++
>   2 files changed, 316 insertions(+)
>   create mode 100755 scripts/coverity-scan/run-coverity-scan
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7364af0d8b0..395534522b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2003,6 +2003,11 @@ M: Markus Armbruster <armbru@redhat.com>
>   S: Supported
>   F: scripts/coverity-model.c
>  =20
> +Coverity Scan integration
> +M: Peter Maydell <peter.maydell@linaro.org>
> +S: Maintained
> +F: scripts/coverity-scan/
> +
>   Device Tree
>   M: Alistair Francis <alistair.francis@wdc.com>
>   R: David Gibson <david@gibson.dropbear.id.au>
> diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-s=
can/run-coverity-scan
> new file mode 100755
> index 00000000000..d40b51969fa
> --- /dev/null
> +++ b/scripts/coverity-scan/run-coverity-scan
> @@ -0,0 +1,311 @@
> +#!/bin/sh -e
> +
> +# Upload a created tarball to Coverity Scan, as per
> +# https://scan.coverity.com/projects/qemu/builds/new
> +
> +# This work is licensed under the terms of the GNU GPL version 2,
> +# or (at your option) any later version.
> +# See the COPYING file in the top-level directory.
> +#
> +# Copyright (c) 2017-2020 Linaro Limited
> +# Written by Peter Maydell
> +
> +# Note that this script will automatically download and
> +# run the (closed-source) coverity build tools, so don't
> +# use it if you don't trust them!
> +
> +# This script assumes that you're running it from a QEMU source
> +# tree, and that tree is a fresh clean one, because we do an in-tree
> +# build. (This is necessary so that the filenames that the Coverity
> +# Scan server sees are relative paths that match up with the component
> +# regular expressions it uses; an out-of-tree build won't work for this.=
)
> +# The host machine should have as many of QEMU's dependencies
> +# installed as possible, for maximum coverity coverage.
> +
> +# To do an upload you need to be a maintainer in the Coverity online
> +# service, and you will need to know the "Coverity token", which is a
> +# secret 8 digit hex string. You can find that from the web UI in the
> +# project settings, if you have maintainer access there.
> +
> +# Command line options:
> +#   --dry-run : run the tools, but don't actually do the upload
> +#   --update-tools-only : update the cached copy of the tools, but don't=
 run them
> +#   --tokenfile : file to read Coverity token from
> +#   --version ver : specify version being analyzed (default: ask git)
> +#   --description desc : specify description of this version (default: a=
sk git)
> +#   --srcdir : QEMU source tree to analyze (default: current working dir=
)
> +#   --results-tarball : path to copy the results tarball to (default: do=
n't
> +#                       copy it anywhere, just upload it)
> +#
> +# User-specifiable environment variables:
> +#  COVERITY_TOKEN -- Coverity token
> +#  COVERITY_EMAIL -- the email address to use for uploads (default:
> +#                    looks at your git user.email config)
> +#  COVERITY_BUILD_CMD -- make command (default: 'make -jN' where N is
> +#                    number of CPUs as determined by 'nproc')
> +#  COVERITY_TOOL_BASE -- set to directory to put coverity tools
> +#                        (default: /tmp/coverity-tools)
> +#
> +# You must specify the token, either by environment variable or by
> +# putting it in a file and using --tokenfile. Everything else has
> +# a reasonable default if this is run from a git tree.
> +
> +check_upload_permissions() {
> +    # Check whether we can do an upload to the server; will exit the scr=
ipt
> +    # with status 1 if the check failed (usually a bad token);
> +    # will exit the script with status 0 if the check indicated that we
> +    # can't upload yet (ie we are at quota)
> +    # Assumes that PROJTOKEN, PROJNAME and DRYRUN have been initialized.
> +
> +    echo "Checking upload permissions..."
> +
> +    if ! up_perm=3D"$(wget https://scan.coverity.com/api/upload_permitte=
d --post-data "token=3D$PROJTOKEN&project=3D$PROJNAME" -q -O -)"; then
> +        echo "Coverity Scan API access denied: bad token?"
> +        exit 1
> +    fi
> +
> +    # Really up_perm is a JSON response with either
> +    # {upload_permitted:true} or {next_upload_permitted_at:<date>}
> +    # We do some hacky string parsing instead of properly parsing it.
> +    case "$up_perm" in
> +        *upload_permitted*true*)
> +            echo "Coverity Scan: upload permitted"
> +            ;;
> +        *next_upload_permitted_at*)
> +            if [ "$DRYRUN" =3D yes ]; then
> +                echo "Coverity Scan: upload quota reached, continuing dr=
y run"
> +            else
> +                echo "Coverity Scan: upload quota reached; stopping here=
"
> +                # Exit success as this isn't a build error.
> +                exit 0
> +            fi
> +            ;;
> +        *)
> +            echo "Coverity Scan upload check: unexpected result $up_perm=
"
> +            exit 1
> +            ;;
> +    esac
> +}
> +
> +
> +update_coverity_tools () {
> +    # Check for whether we need to download the Coverity tools
> +    # (either because we don't have a copy, or because it's out of date)
> +    # Assumes that COVERITY_TOOL_BASE, PROJTOKEN and PROJNAME are set.
> +
> +    mkdir -p "$COVERITY_TOOL_BASE"
> +    cd "$COVERITY_TOOL_BASE"
> +
> +    echo "Checking for new version of coverity build tools..."
> +    wget https://scan.coverity.com/download/linux64 --post-data "token=
=3D$PROJTOKEN&project=3D$PROJNAME&md5=3D1" -O coverity_tool.md5.new
> +
> +    if ! cmp -s coverity_tool.md5 coverity_tool.md5.new; then
> +        # out of date md5 or no md5: download new build tool
> +        # blow away the old build tool
> +        echo "Downloading coverity build tools..."
> +        rm -rf coverity_tool coverity_tool.tgz
> +        wget https://scan.coverity.com/download/linux64 --post-data "tok=
en=3D$PROJTOKEN&project=3D$PROJNAME" -O coverity_tool.tgz
> +        if ! (cat coverity_tool.md5.new; echo "  coverity_tool.tgz") | m=
d5sum -c --status; then
> +            echo "Downloaded tarball didn't match md5sum!"
> +            exit 1
> +        fi
> +        # extract the new one, keeping it corralled in a 'coverity_tool'=
 directory
> +        echo "Unpacking coverity build tools..."
> +        mkdir -p coverity_tool
> +        cd coverity_tool
> +        tar xf ../coverity_tool.tgz
> +        cd ..
> +        mv coverity_tool.md5.new coverity_tool.md5
> +    fi
> +
> +    rm -f coverity_tool.md5.new
> +}
> +
> +
> +# Check user-provided environment variables and arguments
> +DRYRUN=3Dno
> +UPDATE_ONLY=3Dno
> +
> +while [ "$#" -ge 1 ]; do
> +    case "$1" in
> +        --dry-run)
> +            shift
> +            DRYRUN=3Dyes
> +            ;;
> +        --update-tools-only)
> +            shift
> +            UPDATE_ONLY=3Dyes
> +            ;;
> +        --version)
> +            shift
> +            if [ $# -eq 0 ]; then
> +                echo "--version needs an argument"
> +                exit 1
> +            fi
> +            VERSION=3D"$1"
> +            shift
> +            ;;
> +        --description)
> +            shift
> +            if [ $# -eq 0 ]; then
> +                echo "--description needs an argument"
> +                exit 1
> +            fi
> +            DESCRIPTION=3D"$1"
> +            shift
> +            ;;
> +        --tokenfile)
> +            shift
> +            if [ $# -eq 0 ]; then
> +                echo "--tokenfile needs an argument"
> +                exit 1
> +            fi
> +            COVERITY_TOKEN=3D"$(cat "$1")"
> +            shift
> +            ;;
> +        --srcdir)
> +            shift
> +            if [ $# -eq 0 ]; then
> +                echo "--srcdir needs an argument"
> +                exit 1
> +            fi
> +            SRCDIR=3D"$1"
> +            shift
> +            ;;
> +        --results-tarball)
> +            shift
> +            if [ $# -eq 0 ]; then
> +                echo "--results-tarball needs an argument"
> +                exit 1
> +            fi
> +            RESULTSTARBALL=3D"$1"
> +            shift
> +            ;;
> +        *)
> +            echo "Unexpected argument '$1'"
> +            exit 1
> +            ;;
> +    esac
> +done
> +
> +if [ -z "$COVERITY_TOKEN" ]; then
> +    echo "COVERITY_TOKEN environment variable not set"
> +    exit 1
> +fi
> +
> +if [ -z "$COVERITY_BUILD_CMD" ]; then
> +    NPROC=3D$(nproc)
> +    COVERITY_BUILD_CMD=3D"make -j$NPROC"
> +    echo "COVERITY_BUILD_CMD: using default '$COVERITY_BUILD_CMD'"
> +fi
> +
> +if [ -z "$COVERITY_TOOL_BASE" ]; then
> +    echo "COVERITY_TOOL_BASE: using default /tmp/coverity-tools"
> +    COVERITY_TOOL_BASE=3D/tmp/coverity-tools
> +fi
> +
> +if [ -z "$SRCDIR" ]; then
> +    SRCDIR=3D"$PWD"
> +fi
> +
> +PROJTOKEN=3D"$COVERITY_TOKEN"
> +PROJNAME=3DQEMU
> +TARBALL=3Dcov-int.tar.xz
> +
> +
> +if [ "$UPDATE_ONLY" =3D yes ]; then
> +    # Just do the tools update; we don't need to check whether
> +    # we are in a source tree or have upload rights for this,
> +    # so do it before some of the command line and source tree checks.
> +    update_coverity_tools
> +    exit 0
> +fi
> +
> +cd "$SRCDIR"
> +
> +echo "Checking this is a QEMU source tree..."
> +if ! [ -e "$SRCDIR/VERSION" ]; then
> +    echo "Not in a QEMU source tree?"
> +    exit 1
> +fi
> +
> +# Fill in defaults used by the non-update-only process
> +if [ -z "$VERSION" ]; then
> +    VERSION=3D"$(git describe --always HEAD)"
> +fi
> +
> +if [ -z "$DESCRIPTION" ]; then
> +    DESCRIPTION=3D"$(git rev-parse HEAD)"
> +fi
> +
> +if [ -z "$COVERITY_EMAIL" ]; then
> +    COVERITY_EMAIL=3D"$(git config user.email)"
> +fi
> +
> +check_upload_permissions
> +
> +update_coverity_tools
> +
> +TOOLBIN=3D"$(cd "$COVERITY_TOOL_BASE" && echo $PWD/coverity_tool/cov-ana=
lysis-*/bin)"
> +
> +if ! test -x "$TOOLBIN/cov-build"; then
> +    echo "Couldn't find cov-build in the coverity build-tool directory??=
"
> +    exit 1
> +fi
> +
> +export PATH=3D"$TOOLBIN:$PATH"
> +
> +cd "$SRCDIR"
> +
> +echo "Doing make distclean..."
> +make distclean
> +
> +echo "Configuring..."
> +# We configure with a fixed set of enables here to ensure that we don't
> +# accidentally reduce the scope of the analysis by doing the build on
> +# the system that's missing a dependency that we need to build part of
> +# the codebase.
> +./configure --disable-modules --enable-sdl --enable-gtk \
> +    --enable-opengl --enable-vte --enable-gnutls \
> +    --enable-nettle --enable-curses --enable-curl \
> +    --audio-drv-list=3Doss,alsa,sdl,pa --enable-virtfs \
> +    --enable-vnc --enable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png \
> +    --enable-xen --enable-brlapi \
> +    --enable-linux-aio --enable-attr \
> +    --enable-cap-ng --enable-trace-backends=3Dlog --enable-spice --enabl=
e-rbd \
> +    --enable-xfsctl --enable-libusb --enable-usb-redir \
> +    --enable-libiscsi --enable-libnfs --enable-seccomp \
> +    --enable-tpm --enable-libssh --enable-lzo --enable-snappy --enable-b=
zip2 \
> +    --enable-numa --enable-rdma --enable-smartcard --enable-virglrendere=
r \
> +    --enable-mpath --enable-libxml2 --enable-glusterfs \
> +    --enable-virtfs --enable-zstd
> +
> +echo "Making libqemustub.a..."
> +make libqemustub.a
> +
> +echo "Running cov-build..."
> +rm -rf cov-int
> +mkdir cov-int
> +cov-build --dir cov-int $COVERITY_BUILD_CMD
> +
> +echo "Creating results tarball..."
> +tar cvf - cov-int | xz > "$TARBALL"
> +
> +if [ ! -z "$RESULTSTARBALL" ]; then
> +    echo "Copying results tarball to $RESULTSTARBALL..."
> +    cp "$TARBALL" "$RESULTSTARBALL"
> +fi
> +
> +echo "Uploading results tarball..."
> +
> +if [ "$DRYRUN" =3D yes ]; then
> +    echo "Dry run only, not uploading $TARBALL"
> +    exit 0
> +fi
> +
> +curl --form token=3D"$PROJTOKEN" --form email=3D"$COVERITY_EMAIL" \
> +     --form file=3D@"$TARBALL" --form version=3D"$VERSION" \
> +     --form description=3D"$DESCRIPTION" \
> +     https://scan.coverity.com/builds?project=3D"$PROJNAME"
> +
> +echo "Done."
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


