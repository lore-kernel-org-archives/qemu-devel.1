Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47158C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C391D2087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P31JOUvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C391D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG33Y-00033J-0V
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG32L-0001kO-NR
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:33:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG32I-0000x7-Mt
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599669210;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z6aWMHSNxtTERZLLw0MyZr0AbA3Son3U9PEorgPwY8w=;
 b=P31JOUvvKIvHkkPy1SVSgt3pRh4RgLdXG3EZmk1+nhd1KwK9HYztYEVZ/Tr2ybGpGyE7ER
 XV2nlHxlv3jT3d7j9++x9ddyzOUVbCdBl6kVO0UE3wtg0415DhcLvgn/hzbDgz4Q3vnOCl
 eD1EcoZx07P5EzkTeIRKQdwONKf6nOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-VFkKP_K8NIuLJTSxoz2tCg-1; Wed, 09 Sep 2020 12:33:23 -0400
X-MC-Unique: VFkKP_K8NIuLJTSxoz2tCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB7564093;
 Wed,  9 Sep 2020 16:33:21 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AED5558824;
 Wed,  9 Sep 2020 16:33:13 +0000 (UTC)
Date: Wed, 9 Sep 2020 17:33:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v4 24/24] ci: Enable msys2 ci in cirrus
Message-ID: <20200909163310.GT1011023@redhat.com>
References: <20200909161430.1789-1-luoyonggang@gmail.com>
 <20200909161430.1789-11-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200909161430.1789-11-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 12:14:30AM +0800, Yonggang Luo wrote:
> Install msys2 in a proper way refer to https://github.com/cirruslabs/cirrus-ci-docs/issues/699
> The https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 need to be updated.
> There is no need of --cross-prefix, open mingw64.exe instead of msys2.exe then we don't
> need the --cross-prefix, besides we using environment variable settings:
>     MSYS: winsymlinks:nativestrict
>     MSYSTEM: MINGW64
>     CHERE_INVOKING: 1
> to opening mingw64 native shell.
> We now running tests with make -i check to skip tests errors.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  .cirrus.yml | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index a18971aac4..f819d202db 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -44,3 +44,62 @@ macos_xcode_task:
>                     --enable-werror --cc=clang || { cat config.log; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
>      - gmake check
> +
> +windows_msys2_task:
> +  windows_container:
> +    image: cirrusci/windowsservercore:cmake
> +    os_version: 2019
> +    cpu: 8
> +    memory: 8G
> +  env:
> +    MSYS: winsymlinks:nativestrict
> +    MSYSTEM: MINGW64
> +    CHERE_INVOKING: 1
> +  printenv_script:
> +    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
> +  install_script:
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfirm -S bash pacman pacman-mirrors msys2-runtime"
> +    - taskkill /F /IM gpg-agent.exe
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
> +        base-devel
> +        git
> +        mingw-w64-x86_64-python
> +        mingw-w64-x86_64-python-setuptools
> +        mingw-w64-x86_64-toolchain
> +        mingw-w64-x86_64-SDL2
> +        mingw-w64-x86_64-SDL2_image
> +        mingw-w64-x86_64-gtk3
> +        mingw-w64-x86_64-glib2
> +        mingw-w64-x86_64-ninja
> +        mingw-w64-x86_64-make
> +        mingw-w64-x86_64-jemalloc
> +        mingw-w64-x86_64-lzo2
> +        mingw-w64-x86_64-zstd
> +        mingw-w64-x86_64-libjpeg-turbo
> +        mingw-w64-x86_64-pixman
> +        mingw-w64-x86_64-libgcrypt
> +        mingw-w64-x86_64-capstone
> +        mingw-w64-x86_64-libpng
> +        mingw-w64-x86_64-libssh
> +        mingw-w64-x86_64-libxml2
> +        mingw-w64-x86_64-snappy
> +        mingw-w64-x86_64-libusb
> +        mingw-w64-x86_64-usbredir
> +        mingw-w64-x86_64-libtasn1
> +        mingw-w64-x86_64-libnfs
> +        mingw-w64-x86_64-nettle
> +        mingw-w64-x86_64-cyrus-sasl
> +        mingw-w64-x86_64-curl
> +        mingw-w64-x86_64-gnutls
> +        mingw-w64-x86_64-zstd"
> +  script:
> +    - mkdir build
> +    - cd build
> +    - ../configure --python=python3 --enable-werror --ninja=ninja --disable-pie

You shouldn't need  --disable-pie anymore, as this is merged:

  commit fb648e9cacf4209ddaa8ee67d1a87a9b78a001c6
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Mon Aug 24 17:31:09 2020 +0100

    configure: default to PIE disabled on Windows platforms
    
    If Windows EXE files are built with -pie/-fpie they will fail to
    launch. Historically QEMU defaulted to disabling PIE for Windows,
    but this setting was accidentally lost when the configure summary
    text was removed in
    
      commit f9332757898a764d85e19d339ec421236e885b68
      Author: Paolo Bonzini <pbonzini@redhat.com>
      Date:   Mon Feb 3 13:28:38 2020 +0100
    
        meson: move summary to meson.build
    
        Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>


IIUC, the --enable-werror is present by default too thanks to this code
snippet:

if test -z "$werror" ; then
    if test -e "$source_path/.git" && \
        { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
        werror="yes"
    else
        werror="no"
    fi
fi


If you remove the --disable-pie && --enable-werror args then you can add

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


