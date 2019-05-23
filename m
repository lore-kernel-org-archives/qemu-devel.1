Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F356C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D98221019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D98221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33851 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlaY-0006k2-Ll
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:08:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hTlZn-0006RB-AD
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hTlZm-0004bf-C8
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hTlZm-0004Ye-7j
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:07:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41705307E04E;
	Thu, 23 May 2019 11:07:43 +0000 (UTC)
Received: from redhat.com (ovpn-112-64.ams2.redhat.com [10.36.112.64])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F34865F65;
	Thu, 23 May 2019 11:07:39 +0000 (UTC)
Date: Thu, 23 May 2019 12:07:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190523110736.GD20973@redhat.com>
References: <20190523024229.1158-1-richard.henderson@linaro.org>
	<20190523024229.1158-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523024229.1158-2-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 23 May 2019 11:07:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] capstone: Adjust include of capstone.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 22, 2019 at 10:42:27PM -0400, Richard Henderson wrote:
> Since v4.0, capstone.h has moved to <capstone/capstone.h>.

NB this was a regression bug in capstone pkg-config file which has been
fixed upstream

   https://github.com/aquynh/capstone/pull/1276

In Fedora we pulled in the fix to our v4.0 builds and I'd suggest
other distros should do the same

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/disas/capstone.h | 4 ++++
>  configure                | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/disas/capstone.h b/include/disas/capstone.h
> index e29068dd97..90631d84a9 100644
> --- a/include/disas/capstone.h
> +++ b/include/disas/capstone.h
> @@ -3,7 +3,11 @@
>  
>  #ifdef CONFIG_CAPSTONE
>  
> +#ifdef CONFIG_CAPSTONE_CAPSTONE_H
> +#include <capstone/capstone.h>
> +#else
>  #include <capstone.h>
> +#endif
>  
>  #else
>  
> diff --git a/configure b/configure
> index d2fc346302..eec7f061c3 100755
> --- a/configure
> +++ b/configure
> @@ -5021,6 +5021,9 @@ case "$capstone" in
>    system)
>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
>      LIBS="$($pkg_config --libs capstone) $LIBS"
> +    if check_include capstone/capstone.h; then
> +      capstone_capstone_h=yes
> +    fi
>      ;;
>  
>    no)
> @@ -7197,6 +7200,9 @@ if test "$ivshmem" = "yes" ; then
>  fi
>  if test "$capstone" != "no" ; then
>    echo "CONFIG_CAPSTONE=y" >> $config_host_mak
> +  if test "$capstone_capstone_h" != "no" ; then
> +    echo "CONFIG_CAPSTONE_CAPSTONE_H=y" >> $config_host_mak
> +  fi
>  fi
>  if test "$debug_mutex" = "yes" ; then
>    echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

