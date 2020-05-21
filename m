Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D72C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EAA2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7DXx5oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EAA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbi7d-0004fW-5c
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 06:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbi6v-0003o0-D9
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:07:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbi6t-0007vf-Mq
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590055650;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baT+4CJp4I0YAmggm/ipdIJMbUnP9gnMA/lxanJ+S30=;
 b=C7DXx5oemy9ZnNsdPczELb/xR8NAXvlRRYwl8HgPj8utmcFIkxt8ArYgFMsAdZ9kDC4+/d
 vjLurxecGN5ywHLVjVFSpqb9jvtS2xf//Z3RWhLhvduhPMIxFtYKY1FY3JGv93ERwVVMOs
 EEcxcQqxtzRrvAla64r98BUoPM92U84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-tU58GAEbMNSDRBHiaYtjdg-1; Thu, 21 May 2020 06:07:26 -0400
X-MC-Unique: tU58GAEbMNSDRBHiaYtjdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8425C8014D7;
 Thu, 21 May 2020 10:07:25 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34F0E2E188;
 Thu, 21 May 2020 10:07:23 +0000 (UTC)
Date: Thu, 21 May 2020 11:07:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH] crypto: add "none" random provider
Message-ID: <20200521100720.GC2211791@redhat.com>
References: <20200520132022.6913-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
In-Reply-To: <20200520132022.6913-1-marmarek@invisiblethingslab.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 03:20:23PM +0200, Marek Marczykowski-Górecki wrote:
> In case of not using random-number needing feature, it makes sense to
> skip RNG init too. This is especially helpful when QEMU is sandboxed in
> Stubdomain under Xen, where there is very little entropy so initial
> getrandom() call delays the startup several seconds. In that setup, no
> random bytes are needed at all.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
>  configure            | 11 +++++++++++
>  crypto/Makefile.objs |  3 ++-
>  crypto/random-none.c | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 crypto/random-none.c
> 
> diff --git a/configure b/configure
> index 26084fc53a..79a3affe70 100755
> --- a/configure
> +++ b/configure
> @@ -509,6 +509,7 @@ libpmem=""
>  default_devices="yes"
>  plugins="no"
>  fuzzing="no"
> +rng_none="no"
>  
>  supported_cpu="no"
>  supported_os="no"
> @@ -1601,6 +1602,10 @@ for opt do
>    ;;
>    --gdb=*) gdb_bin="$optarg"
>    ;;
> +  --enable-rng-none) rng_none=yes
> +  ;;
> +  --disable-rng-none) rng_none=no
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1894,6 +1899,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    debug-mutex     mutex debugging support
>    libpmem         libpmem support
>    xkbcommon       xkbcommon support
> +  rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
>  
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -6733,6 +6739,7 @@ echo "default devices   $default_devices"
>  echo "plugin support    $plugins"
>  echo "fuzzing support   $fuzzing"
>  echo "gdb               $gdb_bin"
> +echo "rng-none          $rng_none"
>  
>  if test "$supported_cpu" = "no"; then
>      echo
> @@ -7705,6 +7712,10 @@ if test "$edk2_blobs" = "yes" ; then
>    echo "DECOMPRESS_EDK2_BLOBS=y" >> $config_host_mak
>  fi
>  
> +if test "$rng_none" = "yes"; then
> +  echo "CONFIG_RNG_NONE=y" >> $config_host_mak
> +fi
> +
>  # use included Linux headers
>  if test "$linux" = "yes" ; then
>    mkdir -p linux-headers
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index c2a371b0b4..cdee92b4e5 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -35,5 +35,6 @@ crypto-obj-y += block-luks.o
>  
>  util-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
>  util-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
> -util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
> +util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,$(CONFIG_RNG_NONE))) += random-none.o
> +util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,$(if $(CONFIG_RNG_NONE),n,y))) += random-platform.o
>  util-obj-y += aes.o init.o
> diff --git a/crypto/random-none.c b/crypto/random-none.c
> new file mode 100644
> index 0000000000..102f8a4dce
> --- /dev/null
> +++ b/crypto/random-none.c
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU Crypto "none" random number provider
> + *
> + * Copyright (c) 2020 Marek Marczykowski-Górecki
> + *                      <marmarek@invisiblethingslab.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "crypto/random.h"
> +#include "qapi/error.h"
> +
> +int qcrypto_random_init(Error **errp)
> +{
> +    return 0;
> +}
> +
> +int qcrypto_random_bytes(void *buf,
> +                         size_t buflen,
> +                         Error **errp)
> +{
> +    error_setg(errp, "Random bytes not available with \"none\" rng");
> +    return -1;
> +}

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


and queued.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


