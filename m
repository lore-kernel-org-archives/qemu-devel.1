Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC2C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C3B2133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C3B2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbhmC-0000ff-5D
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbhlJ-0000Ce-2h
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbhlG-0000By-VO
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:40:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbhlF-00008i-6i
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:40:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so1424764wmm.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 01:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pPtHLlx17NhBbzckWwC4+U9d9HbDHljwdwUWHxAH71s=;
 b=U4X5zbAQAy1UYE9ydEwHjiYa02hOW0B4GVvubSnMTKKpMXoBtMpPig+7EJOMYs9bTh
 Gwt8b54G/b9IMNM8CK0gBCM/IYDgohhmjBLFx6cfmUkWdv+ey+mrduwK0OpAJPTDwdWC
 RCfdGBMgHrgGfk7e3fJRVQL0/Nn/qEYmclfmOEnilZVABT5WImDCBcZISA62efVGuoMY
 nj819fNbAnmA3h1N1C3r2L6mqdfTTAbUszcwBJPhtdq0bIcbEgK/97hT7HMv8PfS9Gih
 eg8X/AfI3F8LnJTq+D7uoHaFsFeoKijnM7ju/GJ9zPDdE1CPx1LJNnEFijJJgwlD7QW3
 z8tA==
X-Gm-Message-State: APjAAAV4oaAYmtcHLGJExR6bUKQG904N4WQmKPJJC+xhhpYUG2vvtr4A
 7LfscDvaQejy8R/mzT/G5QWqzA==
X-Google-Smtp-Source: APXvYqzBONjS70/QanMpN3cS77+A9K3eD32h0w2CV7lkY9myFaxrfGUx25eMqki8sbVb62izw539iw==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr4781845wme.11.1560501634804; 
 Fri, 14 Jun 2019 01:40:34 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l190sm2262424wml.16.2019.06.14.01.40.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 01:40:34 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190614072432.820-1-philmd@redhat.com>
 <20190614072432.820-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0855a9ee-631b-29e6-cafa-7b7d988cbf1b@redhat.com>
Date: Fri, 14 Jun 2019 10:40:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614072432.820-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 2/6] configure: Link test before
 auto-enabling glusterfs libraries
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 integration@gluster.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Lo=c3=afc_Minier?= <loic.minier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Bharata B Rao <bharata@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 9:24 AM, Philippe Mathieu-Daudé wrote:
> Similarly to commit a73e82ef912, test the libraries link correctly
> before considering them as usable.
> 
> This fixes using ./configure --static on Ubuntu 18.04:
> 
>   $ make subdir-aarch64-softmmu
>   [...]
>     LINK    aarch64-softmmu/qemu-system-aarch64
>   /usr/bin/ld: cannot find -lgfapi
>   /usr/bin/ld: cannot find -lglusterfs
>   /usr/bin/ld: cannot find -lgfrpc
>   /usr/bin/ld: cannot find -lgfxdr
>   collect2: error: ld returned 1 exit status
>   Makefile:204: recipe for target 'qemu-system-aarch64' failed
>   make[1]: *** [qemu-system-aarch64] Error 1
> 
>   $ fgrep gf config-host.mak
>   GLUSTERFS_LIBS=-lacl -lgfapi -lglusterfs -lgfrpc -lgfxdr -luuid
> 
>   $ lsb_release -cri
>   Distributor ID: Ubuntu
>   Release:        18.04
>   Codename:       bionic
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  configure | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 13fd4a1166..3428adb75b 100755
> --- a/configure
> +++ b/configure
> @@ -4179,9 +4179,23 @@ fi
>  # glusterfs probe
>  if test "$glusterfs" != "no" ; then
>    if $pkg_config --atleast-version=3 glusterfs-api; then
> -    glusterfs="yes"
>      glusterfs_cflags=$($pkg_config --cflags glusterfs-api)
> -    glusterfs_libs=$($pkg_config --libs glusterfs-api)
> +    if test "$static" = "yes"; then
> +        glusterfs_libs=$($pkg_config --libs --static glusterfs-api)
> +    else
> +        glusterfs_libs=$($pkg_config --libs glusterfs-api)
> +    fi

I just noticed in ./configure:

  case "$opt" in
  --static)
    static="yes"
    LDFLAGS="-static $LDFLAGS"
    QEMU_PKG_CONFIG_FLAGS="--static $QEMU_PKG_CONFIG_FLAGS"
  ;;

And

pkg_config_exe="${PKG_CONFIG-${cross_prefix}pkg-config}"
query_pkg_config() {
    "${pkg_config_exe}" ${QEMU_PKG_CONFIG_FLAGS} "$@"
}
pkg_config=query_pkg_config

So I shouldn't need to test "$static" = "yes" and manually add --static.
(same apply to other patches in this series).

I'll see what's wrong...

> +    # Packaging for the static libraries is not always correct.
> +    # At least ubuntu 18.04 ships only shared libraries.
> +    write_c_skeleton
> +    if ! compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
> +        if test "$glusterfs" = "yes" ; then
> +          error_exit "glusterfs check failed."
> +        fi
> +        glusterfs="no"
> +    else
> +        glusterfs="yes"
> +    fi
>      if $pkg_config --atleast-version=4 glusterfs-api; then
>        glusterfs_xlator_opt="yes"
>      fi
> 

