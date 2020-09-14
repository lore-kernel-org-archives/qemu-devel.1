Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A309C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60DC217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="It11Dwpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60DC217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHj5V-0004xK-UU
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHj4v-0004NU-Hj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:39:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37715
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHj4t-0004Wo-L5
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600069146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAs3BslIboK7KqmDYZ4zPTJ7uPIW1nFXw6kbuex322M=;
 b=It11DwpvO/PSgjvdf1OOfj3mgMA1E3M9DbFMRSbSBk2JiPllgfpuYvhNm2QzI8au2haAqA
 MJsDG4wF4FTAxbeIMGSJjsH42uqz2fmf6MXti3JxhMb73tTO+mKJqJB66QzjxjYcvTedyt
 uVicAOZevyQRa0VRPc8kiV+E84bnhG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-KGQPKtmsNgaussawf3A40A-1; Mon, 14 Sep 2020 03:39:01 -0400
X-MC-Unique: KGQPKtmsNgaussawf3A40A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F05581008301;
 Mon, 14 Sep 2020 07:38:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-134.ams2.redhat.com [10.36.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31DBC5D98C;
 Mon, 14 Sep 2020 07:38:52 +0000 (UTC)
Subject: Re: [PATCH v8 24/27] ci: Enable msys2 ci in cirrus
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-25-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3529d95-6d0b-a8ca-23cb-21393435ba94@redhat.com>
Date: Mon, 14 Sep 2020 09:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200912224431.1428-25-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/2020 00.44, Yonggang Luo wrote:
> Install msys2 in a proper way refer to https://github.com/cirruslabs/cirrus-ci-docs/issues/699
> The https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 need to be updated.

I don't think that a request to update the wiki should be part of the
commit message here.
Stefan, could you please have a look at the wiki to see whether it needs
an update?

> There is no need of --cross-prefix, open mingw64.exe instead of msys2.exe then we don't
> need the --cross-prefix, besides we using environment variable settings:
>     MSYS: winsymlinks:nativestrict
>     MSYSTEM: MINGW64
>     CHERE_INVOKING: 1
> to opening mingw64 native shell.
> We now running tests with make -i check to skip tests errors.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .cirrus.yml | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 690c6882e8..1ff9f0a72f 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -44,3 +44,63 @@ macos_xcode_task:
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

The lines here are very long ... could you please put the stuff after
the "&&" on a new line?

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

Installing jemalloc only makes sense if you also use --enable-jemalloc
later. So I'd suggest to drop this package here.

> +        mingw-w64-x86_64-lzo2
> +        mingw-w64-x86_64-zstd
> +        mingw-w64-x86_64-libjpeg-turbo
> +        mingw-w64-x86_64-pixman
> +        mingw-w64-x86_64-libgcrypt
> +        mingw-w64-x86_64-capstone

Hmm, so in an earlier patch, you've added an update to the capstone
submodule, but here you install the system-wide capstone as well? ...
that does not make too much sense. Which one do you intend to use?

> +        mingw-w64-x86_64-libpng
> +        mingw-w64-x86_64-libssh
> +        mingw-w64-x86_64-libxml2
> +        mingw-w64-x86_64-snappy
> +        mingw-w64-x86_64-libusb
> +        mingw-w64-x86_64-usbredir
> +        mingw-w64-x86_64-libtasn1
> +        mingw-w64-x86_64-libnfs

I think your NFS patch needs a review/ack from the block layer folks
first, so for the time being, I'd suggest drop libnfs here first and add
it later, once the nfs patch has been merged via the block layer queue.

> +        mingw-w64-x86_64-nettle
> +        mingw-w64-x86_64-cyrus-sasl
> +        mingw-w64-x86_64-curl
> +        mingw-w64-x86_64-gnutls
> +        mingw-w64-x86_64-zstd"
> +  script:
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure --python=python3 --ninja=ninja"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
> +  test_script:
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
> +
> 

 Thomas


