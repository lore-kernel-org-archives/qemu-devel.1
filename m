Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9CDC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77B5206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuHMfl2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77B5206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKQY-00009A-56
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOKPv-0008A6-Pl
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOKPt-0005l6-BR
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:11:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29961
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOKPt-0005kY-68
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586866308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/E4F2fl1cOu6SQVRgu2wi7h+/KyQ8HT4hqagkS1mJEI=;
 b=OuHMfl2iwPoupsLUCTx+QWxm9YrWXH+m9HMKB2/WddmK8QS/ermaFs0aBXu9cAEo19/KUh
 t/tCeX+kW4ujIZ6kc2x3cG3m1+NiYGFJ6zNzAoqq81ehM7fUY3K9KJgnKXbNYKEj9USKLR
 TyL+upchHxvMkcliyQA4L5a2hA94pwo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-naMbdMwqMdWlK3awzIXVHQ-1; Tue, 14 Apr 2020 08:11:44 -0400
X-MC-Unique: naMbdMwqMdWlK3awzIXVHQ-1
Received: by mail-wm1-f71.google.com with SMTP id f81so3682783wmf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 05:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1JCMOTphXNMurQKHvcjuo8updro0xAu6rEwtYQqgj60=;
 b=rkY+Y4ZgLqKD7n6/OSPv1qUsQJ0Y6QjBLbdTT6dmtW+O2V3N9dNfMNtgdeJog5E0fE
 QyZZFUh/4Us9sVGGXMWrGHxD3hatR8XOaqgYTRDyeUU3EQueFBfrtxpV3YTl6weDuSUZ
 3bmDxlBA9by65G25CSUc37n4UywkVUObgOK3vEko3q8qoGosYarJ8YyZ2uwLMbAOqss6
 UTJ2z9yaVJsBz0BLLFonjbhr7teKmiJpX+4eAX7xSMp2OPLpbXYE0I64yWbJMc1y2dRD
 MvV9C5RzIK1nOL6eAD3Yw/VdHrcI36yDFn4ihRuVYxARUwvDFPjma7DpLNyZoLc+eGzB
 amiA==
X-Gm-Message-State: AGi0Pub22EjqnahQeosK1Ajq6Qq6xWuWAElRWAGQVpB81MkJo8AclfHL
 HQOB0pbxqiNh85Man7IluMBXiyBj7iwCxgMVgcgOERogZeGaSkk6ArYJCmU7cOB6j41vDhRSEU6
 4aJ6UxPl2ZK5aLNk=
X-Received: by 2002:a1c:a344:: with SMTP id m65mr23450849wme.20.1586866303118; 
 Tue, 14 Apr 2020 05:11:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypIR7H7HJX2PQJtT2Mv7tpNAKT0/DH06hZmvxaNMm+q9IOBKAZRLwtDVE8OuL8yxulhilAq9rw==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr23450825wme.20.1586866302731; 
 Tue, 14 Apr 2020 05:11:42 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id c190sm18466505wme.4.2020.04.14.05.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 05:11:41 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] scripts/coverity-scan: Add Docker support
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-7-peter.maydell@linaro.org>
 <5012c7e4-c1ec-79e7-ac0a-f15e2eb1fd6e@redhat.com>
Message-ID: <f283e56b-0ba0-30f3-4c32-9b16b56e2e7b@redhat.com>
Date: Tue, 14 Apr 2020 14:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5012c7e4-c1ec-79e7-ac0a-f15e2eb1fd6e@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 4/14/20 1:58 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/19/20 8:33 PM, Peter Maydell wrote:
>> Add support for running the Coverity Scan tools inside a Docker
>> container rather than directly on the host system.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> v1->v2:
>> =C2=A0 * various bug fixes
>> =C2=A0 * added --src-tarball rather than putting the whole source
>> =C2=A0=C2=A0=C2=A0 tree in the 'secrets' directory
>> =C2=A0 * docker file package list updated
>> ---
>> =C2=A0 scripts/coverity-scan/coverity-scan.docker | 131 ++++++++++++++++=
+++++
>> =C2=A0 scripts/coverity-scan/run-coverity-scan=C2=A0=C2=A0=C2=A0 |=C2=A0=
 90 ++++++++++++++
>> =C2=A0 2 files changed, 221 insertions(+)
>> =C2=A0 create mode 100644 scripts/coverity-scan/coverity-scan.docker
>>
>> diff --git a/scripts/coverity-scan/coverity-scan.docker=20
>> b/scripts/coverity-scan/coverity-scan.docker
>> new file mode 100644
>> index 00000000000..a4f64d12834
>> --- /dev/null
>> +++ b/scripts/coverity-scan/coverity-scan.docker
>> @@ -0,0 +1,131 @@
>> +# syntax=3Ddocker/dockerfile:1.0.0-experimental
>> +#
>> +# Docker setup for running the "Coverity Scan" tools over the source
>> +# tree and uploading them to the website, as per
>> +# https://scan.coverity.com/projects/qemu/builds/new
>> +# We do this on a fixed config (currently Fedora 30 with a known
>> +# set of dependencies and a configure command that enables a specific
>> +# set of options) so that random changes don't result in our=20
>> accidentally
>> +# dropping some files from the scan.
>> +#
>> +# We don't build on top of the fedora.docker file because we don't
>> +# want to accidentally change or break the scan config when that
>> +# is updated.
>> +
>> +# The work of actually doing the build is handled by the
>> +# run-coverity-scan script.
>> +
>> +FROM fedora:30
>> +ENV PACKAGES \
>> +=C2=A0=C2=A0=C2=A0 alsa-lib-devel \
>> +=C2=A0=C2=A0=C2=A0 bc \
>> +=C2=A0=C2=A0=C2=A0 bison \
>> +=C2=A0=C2=A0=C2=A0 brlapi-devel \
>> +=C2=A0=C2=A0=C2=A0 bzip2 \
>> +=C2=A0=C2=A0=C2=A0 bzip2-devel \
>> +=C2=A0=C2=A0=C2=A0 ccache \
>> +=C2=A0=C2=A0=C2=A0 clang \
>> +=C2=A0=C2=A0=C2=A0 curl \
>> +=C2=A0=C2=A0=C2=A0 cyrus-sasl-devel \
>> +=C2=A0=C2=A0=C2=A0 dbus-daemon \
>> +=C2=A0=C2=A0=C2=A0 device-mapper-multipath-devel \
>> +=C2=A0=C2=A0=C2=A0 findutils \
>> +=C2=A0=C2=A0=C2=A0 flex \
>> +=C2=A0=C2=A0=C2=A0 gcc \
>> +=C2=A0=C2=A0=C2=A0 gcc-c++ \
>> +=C2=A0=C2=A0=C2=A0 gettext \
>> +=C2=A0=C2=A0=C2=A0 git \
>> +=C2=A0=C2=A0=C2=A0 glib2-devel \
>> +=C2=A0=C2=A0=C2=A0 glusterfs-api-devel \
>> +=C2=A0=C2=A0=C2=A0 gnutls-devel \
>> +=C2=A0=C2=A0=C2=A0 gtk3-devel \
>> +=C2=A0=C2=A0=C2=A0 hostname \
>> +=C2=A0=C2=A0=C2=A0 libaio-devel \
>> +=C2=A0=C2=A0=C2=A0 libasan \
>> +=C2=A0=C2=A0=C2=A0 libattr-devel \
>> +=C2=A0=C2=A0=C2=A0 libblockdev-mpath-devel \
>> +=C2=A0=C2=A0=C2=A0 libcap-devel \
>> +=C2=A0=C2=A0=C2=A0 libcap-ng-devel \
>> +=C2=A0=C2=A0=C2=A0 libcurl-devel \
>> +=C2=A0=C2=A0=C2=A0 libepoxy-devel \
>> +=C2=A0=C2=A0=C2=A0 libfdt-devel \
>> +=C2=A0=C2=A0=C2=A0 libgbm-devel \
>> +=C2=A0=C2=A0=C2=A0 libiscsi-devel \
>> +=C2=A0=C2=A0=C2=A0 libjpeg-devel \
>> +=C2=A0=C2=A0=C2=A0 libpmem-devel \
>> +=C2=A0=C2=A0=C2=A0 libnfs-devel \
>> +=C2=A0=C2=A0=C2=A0 libpng-devel \
>> +=C2=A0=C2=A0=C2=A0 librbd-devel \
>> +=C2=A0=C2=A0=C2=A0 libseccomp-devel \
>> +=C2=A0=C2=A0=C2=A0 libssh-devel \
>> +=C2=A0=C2=A0=C2=A0 libubsan \
>> +=C2=A0=C2=A0=C2=A0 libudev-devel \
>> +=C2=A0=C2=A0=C2=A0 libusbx-devel \
>> +=C2=A0=C2=A0=C2=A0 libxml2-devel \
>> +=C2=A0=C2=A0=C2=A0 libzstd-devel \
>> +=C2=A0=C2=A0=C2=A0 llvm \
>> +=C2=A0=C2=A0=C2=A0 lzo-devel \
>> +=C2=A0=C2=A0=C2=A0 make \
>> +=C2=A0=C2=A0=C2=A0 mingw32-bzip2 \
>> +=C2=A0=C2=A0=C2=A0 mingw32-curl \
>> +=C2=A0=C2=A0=C2=A0 mingw32-glib2 \
>> +=C2=A0=C2=A0=C2=A0 mingw32-gmp \
>> +=C2=A0=C2=A0=C2=A0 mingw32-gnutls \
>> +=C2=A0=C2=A0=C2=A0 mingw32-gtk3 \
>> +=C2=A0=C2=A0=C2=A0 mingw32-libjpeg-turbo \
>> +=C2=A0=C2=A0=C2=A0 mingw32-libpng \
>> +=C2=A0=C2=A0=C2=A0 mingw32-libtasn1 \
>> +=C2=A0=C2=A0=C2=A0 mingw32-nettle \
>> +=C2=A0=C2=A0=C2=A0 mingw32-nsis \
>> +=C2=A0=C2=A0=C2=A0 mingw32-pixman \
>> +=C2=A0=C2=A0=C2=A0 mingw32-pkg-config \
>> +=C2=A0=C2=A0=C2=A0 mingw32-SDL2 \
>> +=C2=A0=C2=A0=C2=A0 mingw64-bzip2 \
>> +=C2=A0=C2=A0=C2=A0 mingw64-curl \
>> +=C2=A0=C2=A0=C2=A0 mingw64-glib2 \
>> +=C2=A0=C2=A0=C2=A0 mingw64-gmp \
>> +=C2=A0=C2=A0=C2=A0 mingw64-gnutls \
>> +=C2=A0=C2=A0=C2=A0 mingw64-gtk3 \
>> +=C2=A0=C2=A0=C2=A0 mingw64-libjpeg-turbo \
>> +=C2=A0=C2=A0=C2=A0 mingw64-libpng \
>> +=C2=A0=C2=A0=C2=A0 mingw64-libtasn1 \
>> +=C2=A0=C2=A0=C2=A0 mingw64-nettle \
>> +=C2=A0=C2=A0=C2=A0 mingw64-pixman \
>> +=C2=A0=C2=A0=C2=A0 mingw64-pkg-config \
>> +=C2=A0=C2=A0=C2=A0 mingw64-SDL2 \
>> +=C2=A0=C2=A0=C2=A0 ncurses-devel \
>> +=C2=A0=C2=A0=C2=A0 nettle-devel \
>> +=C2=A0=C2=A0=C2=A0 nss-devel \
>> +=C2=A0=C2=A0=C2=A0 numactl-devel \
>> +=C2=A0=C2=A0=C2=A0 perl \
>> +=C2=A0=C2=A0=C2=A0 perl-Test-Harness \
>> +=C2=A0=C2=A0=C2=A0 pixman-devel \
>> +=C2=A0=C2=A0=C2=A0 pulseaudio-libs-devel \
>> +=C2=A0=C2=A0=C2=A0 python3 \
>> +=C2=A0=C2=A0=C2=A0 python3-sphinx \
>> +=C2=A0=C2=A0=C2=A0 PyYAML \
>> +=C2=A0=C2=A0=C2=A0 rdma-core-devel \
>> +=C2=A0=C2=A0=C2=A0 SDL2-devel \
>> +=C2=A0=C2=A0=C2=A0 snappy-devel \
>> +=C2=A0=C2=A0=C2=A0 sparse \
>> +=C2=A0=C2=A0=C2=A0 spice-server-devel \
>> +=C2=A0=C2=A0=C2=A0 systemd-devel \
>> +=C2=A0=C2=A0=C2=A0 systemtap-sdt-devel \
>> +=C2=A0=C2=A0=C2=A0 tar \
>> +=C2=A0=C2=A0=C2=A0 texinfo \
>> +=C2=A0=C2=A0=C2=A0 usbredir-devel \
>> +=C2=A0=C2=A0=C2=A0 virglrenderer-devel \
>> +=C2=A0=C2=A0=C2=A0 vte291-devel \
>> +=C2=A0=C2=A0=C2=A0 wget \
>> +=C2=A0=C2=A0=C2=A0 which \
>> +=C2=A0=C2=A0=C2=A0 xen-devel \
>> +=C2=A0=C2=A0=C2=A0 xfsprogs-devel \
>> +=C2=A0=C2=A0=C2=A0 zlib-devel
>> +ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
>> +
>> +RUN dnf install -y $PACKAGES
>> +RUN rpm -q $PACKAGES | sort > /packages.txt
>> +ENV PATH $PATH:/usr/libexec/python3-sphinx/
>> +ENV COVERITY_TOOL_BASE=3D/coverity-tools
>> +COPY run-coverity-scan run-coverity-scan
>> +RUN --mount=3Dtype=3Dsecret,id=3Dcoverity.token,required=20
>> ./run-coverity-scan --update-tools-only --tokenfile=20
>> /run/secrets/coverity.token
>> diff --git a/scripts/coverity-scan/run-coverity-scan=20
>> b/scripts/coverity-scan/run-coverity-scan
>> index d40b51969fa..2e067ef5cfc 100755
>> --- a/scripts/coverity-scan/run-coverity-scan
>> +++ b/scripts/coverity-scan/run-coverity-scan
>> @@ -29,6 +29,7 @@
>> =C2=A0 # Command line options:
>> =C2=A0 #=C2=A0=C2=A0 --dry-run : run the tools, but don't actually do th=
e upload
>> +#=C2=A0=C2=A0 --docker : create and work inside a docker container
>> =C2=A0 #=C2=A0=C2=A0 --update-tools-only : update the cached copy of the=
 tools, but=20
>> don't run them
>> =C2=A0 #=C2=A0=C2=A0 --tokenfile : file to read Coverity token from
>> =C2=A0 #=C2=A0=C2=A0 --version ver : specify version being analyzed (def=
ault: ask git)
>> @@ -36,6 +37,8 @@
>> =C2=A0 #=C2=A0=C2=A0 --srcdir : QEMU source tree to analyze (default: cu=
rrent working=20
>> dir)
>> =C2=A0 #=C2=A0=C2=A0 --results-tarball : path to copy the results tarbal=
l to=20
>> (default: don't
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy =
it anywhere, just upload it)
>> +#=C2=A0=C2=A0 --src-tarball : tarball to untar into src dir (default: n=
one); this
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is intended mainly for internal use=
 by the Docker=20
>> support
>> =C2=A0 #
>> =C2=A0 # User-specifiable environment variables:
>> =C2=A0 #=C2=A0 COVERITY_TOKEN -- Coverity token
>> @@ -125,6 +128,7 @@ update_coverity_tools () {
>> =C2=A0 # Check user-provided environment variables and arguments
>> =C2=A0 DRYRUN=3Dno
>> =C2=A0 UPDATE_ONLY=3Dno
>> +DOCKER=3Dno
>> =C2=A0 while [ "$#" -ge 1 ]; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "$1" in
>> @@ -181,6 +185,19 @@ while [ "$#" -ge 1 ]; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 RESULTSTARBALL=3D"$1"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 shift
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ;;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --src-tarball)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shif=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [=
 $# -eq 0 ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 echo "--src-tarball needs an argument"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 exit 1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SRCT=
ARBALL=3D"$1"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shif=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --docker)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DOCK=
ER=3Dyes
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shif=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 echo "Unexpected argument '$1'"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 exit 1
>> @@ -212,6 +229,10 @@ PROJTOKEN=3D"$COVERITY_TOKEN"
>> =C2=A0 PROJNAME=3DQEMU
>> =C2=A0 TARBALL=3Dcov-int.tar.xz
>> +if [ "$UPDATE_ONLY" =3D yes ] && [ "$DOCKER" =3D yes ]; then
>> +=C2=A0=C2=A0=C2=A0 echo "Combining --docker and --update-only is not su=
pported"
>> +=C2=A0=C2=A0=C2=A0 exit 1
>> +fi
>> =C2=A0 if [ "$UPDATE_ONLY" =3D yes ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Just do the tools update; we don't need=
 to check whether
>> @@ -221,8 +242,17 @@ if [ "$UPDATE_ONLY" =3D yes ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit 0
>> =C2=A0 fi
>> +if [ ! -e "$SRCDIR" ]; then
>> +=C2=A0=C2=A0=C2=A0 mkdir "$SRCDIR"
>> +fi
>> +
>> =C2=A0 cd "$SRCDIR"
>> +if [ ! -z "$SRCTARBALL" ]; then
>> +=C2=A0=C2=A0=C2=A0 echo "Untarring source tarball into $SRCDIR..."
>> +=C2=A0=C2=A0=C2=A0 tar xvf "$SRCTARBALL"
>> +fi
>> +
>> =C2=A0 echo "Checking this is a QEMU source tree..."
>> =C2=A0 if ! [ -e "$SRCDIR/VERSION" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "Not in a QEMU source tree?"
>> @@ -242,6 +272,66 @@ if [ -z "$COVERITY_EMAIL" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 COVERITY_EMAIL=3D"$(git config user.email=
)"
>> =C2=A0 fi
>> +# Run ourselves inside docker if that's what the user wants
>> +if [ "$DOCKER" =3D yes ]; then
>> +=C2=A0=C2=A0=C2=A0 # build docker container including the coverity-scan=
 tools
>> +=C2=A0=C2=A0=C2=A0 # Put the Coverity token into a temporary file that =
only
>> +=C2=A0=C2=A0=C2=A0 # we have read access to, and then pass it to docker=
 build
>> +=C2=A0=C2=A0=C2=A0 # using --secret. This requires at least Docker 18.0=
9.
>> +=C2=A0=C2=A0=C2=A0 # Mostly what we are trying to do here is ensure we =
don't leak
>> +=C2=A0=C2=A0=C2=A0 # the token into the Docker image.
>> +=C2=A0=C2=A0=C2=A0 umask 077
>> +=C2=A0=C2=A0=C2=A0 SECRETDIR=3D$(mktemp -d)
>> +=C2=A0=C2=A0=C2=A0 if [ -z "$SECRETDIR" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "Failed to create tempo=
rary directory"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit 1
>> +=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 trap 'rm -rf "$SECRETDIR"' INT TERM EXIT
>> +=C2=A0=C2=A0=C2=A0 echo "Created temporary directory $SECRETDIR"
>> +=C2=A0=C2=A0=C2=A0 SECRET=3D"$SECRETDIR/token"
>> +=C2=A0=C2=A0=C2=A0 echo "$COVERITY_TOKEN" > "$SECRET"
>> +=C2=A0=C2=A0=C2=A0 echo "Building docker container..."
>> +=C2=A0=C2=A0=C2=A0 # TODO: This re-downloads the tools every time, rath=
er than
>> +=C2=A0=C2=A0=C2=A0 # caching and reusing the image produced with the do=
wnloaded tools.
>> +=C2=A0=C2=A0=C2=A0 # Not sure why.
>=20
> I remember something similar when using -f and COPY.
>=20
> My guess is using -f somefile instead of a directory, then COPY from=20
> outside of the directory, the cache is invalidated (or not used). If the=
=20
> file copied and the Dockerfile are in the same directory, it works (for=
=20
> me).
>=20
>> +=C2=A0=C2=A0=C2=A0 # TODO: how do you get 'docker build' to print the o=
utput of the
>> +=C2=A0=C2=A0=C2=A0 # commands it is running to its stdout? This would b=
e useful for=20
>> debug.
>=20
> Maybe '--progress plain'?
>=20
>> +=C2=A0=C2=A0=C2=A0 DOCKER_BUILDKIT=3D1 docker build -t coverity-scanner=
 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --secret id=3Dcoverity.token,src=3D=
"$SECRET" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -f scripts/coverity-scan/coverity-s=
can.docker \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts/coverity-scan
>> +=C2=A0=C2=A0=C2=A0 echo "Archiving sources to be analyzed..."
>> +=C2=A0=C2=A0=C2=A0 ./scripts/archive-source.sh "$SECRETDIR/qemu-sources=
.tgz"
>> +=C2=A0=C2=A0=C2=A0 if [ "$DRYRUN" =3D yes ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRYRUNARG=3D--dry-run
>> +=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 echo "Running scanner..."
>> +=C2=A0=C2=A0=C2=A0 # If we need to capture the output tarball, get the =
inner run to
>> +=C2=A0=C2=A0=C2=A0 # save it to the secrets directory so we can copy it=
 out before the
>> +=C2=A0=C2=A0=C2=A0 # directory is cleaned up.
>> +=C2=A0=C2=A0=C2=A0 if [ ! -z "$RESULTSTARBALL" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RTARGS=3D"--results-tarball =
/work/cov-int.tar.xz"
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RTARGS=3D""
>> +=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 # Arrange for this docker run to get access to the s=
ources with -v.
>> +=C2=A0=C2=A0=C2=A0 # We pass through all the configuration from the out=
er script to=20
>> the inner.
>> +=C2=A0=C2=A0=C2=A0 export COVERITY_EMAIL COVERITY_BUILD_CMD
>> +=C2=A0=C2=A0=C2=A0 docker run -it --env COVERITY_EMAIL --env COVERITY_B=
UILD_CMD \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -v "$SECRE=
TDIR:/work" coverity-scanner \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./run-cove=
rity-scan --version "$VERSION" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --descript=
ion "$DESCRIPTION" $DRYRUNARG --tokenfile=20
>> /work/token \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --srcdir /=
qemu --src-tarball /work/qemu-sources.tgz $RTARGS
>> +=C2=A0=C2=A0=C2=A0 if [ ! -z "$RESULTSTARBALL" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "Copying results tarbal=
l to $RESULTSTARBALL..."
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp "$SECRETDIR/cov-int.tar.x=
z" "$RESULTSTARBALL"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 echo "Docker work complete."
>> +=C2=A0=C2=A0=C2=A0 exit 0
>> +fi
>> +
>> +# Otherwise, continue with the full build and upload process.
>> +
>> =C2=A0 check_upload_permissions
>> =C2=A0 update_coverity_tools
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Oh also,
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
until:

#14 0.441 Connecting to scan.coverity.com=20
(scan.coverity.com)|45.60.34.99|:443... connected.
#14 0.570 HTTP request sent, awaiting response... 401 Unauthorized
#14 1.033
#14 1.033 Username/Password Authentication Failed.


