Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16817C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB4A20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB4A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxAg-0005m3-8Q
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:54:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQx9s-0005Sp-4C
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQx9q-0008DQ-Qw
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQx9q-0008D7-J1
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:53:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB4B937EEB;
	Wed, 15 May 2019 16:53:33 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C4C05C298;
	Wed, 15 May 2019 16:53:31 +0000 (UTC)
Date: Wed, 15 May 2019 17:53:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190515165328.GK4751@redhat.com>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
	<20190514191653.31488-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514191653.31488-2-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 15 May 2019 16:53:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 01/24] build: Link user-only with
 crypto-rng-obj-y
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 12:16:30PM -0700, Richard Henderson wrote:
> For user-only, we require only the random number bits of the
> crypto subsystem.
> 
> We need to preserve --static linking, which for many recent Linux
> distributions precludes using GnuTLS or GCrypt.  Instead, use our
> random-platform module unconditionally.

I don't think we need to special case in this way.

Today if you do a default build with all targets & tools and want
to use --static, but don't have static libs available for some
things you can achieve that

 ./configure --static --disable-gnutls --disable-gcrypt --disable-nettle

Previously if you took care to disable system emulators & tools
you could avoid the need to pass the --disable-* args, but I
think that's fairly minor.

So I think we should just use $(crypto-obj-y) unconditionally in
the user emulators, and get rid of crypto-aes-obj-y too.

This will give a consistent crypto story across all the things we
build with no special cases.

If people want a minimal static build they can stsill pass the
above --disable-XXX args which will result in them only using
the aes.o and rng-platform.o pieces.

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile             | 6 ++++--
>  Makefile.objs        | 1 +
>  Makefile.target      | 3 ++-
>  crypto/Makefile.objs | 1 +
>  4 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 66d5c65156..524f2f8a57 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -411,6 +411,7 @@ dummy := $(call unnest-vars,, \
>                  block-obj-m \
>                  crypto-obj-y \
>                  crypto-aes-obj-y \
> +                crypto-rng-obj-y \
>                  qom-obj-y \
>                  io-obj-y \
>                  common-obj-y \
> @@ -482,8 +483,9 @@ subdir-capstone: .git-submodule-status
>  subdir-slirp: .git-submodule-status
>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
>  
> -$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
> -	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
> +$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) $(qom-obj-y) \
> +	$(crypto-aes-obj-$(CONFIG_USER_ONLY)) \
> +	$(crypto-rng-obj-$(CONFIG_USER_ONLY))
>  
>  ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
>  # Only keep -O and -g cflags
> diff --git a/Makefile.objs b/Makefile.objs
> index cf065de5ed..0c13ff47ea 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -26,6 +26,7 @@ block-obj-m = block/
>  
>  crypto-obj-y = crypto/
>  crypto-aes-obj-y = crypto/
> +crypto-rng-obj-y = crypto/
>  
>  #######################################################################
>  # qom-obj-y is code used by both qemu system emulation and qemu-img
> diff --git a/Makefile.target b/Makefile.target
> index ae02495951..4e579a0a84 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -181,6 +181,7 @@ dummy := $(call unnest-vars,.., \
>                 chardev-obj-y \
>                 crypto-obj-y \
>                 crypto-aes-obj-y \
> +               crypto-rng-obj-y \
>                 qom-obj-y \
>                 io-obj-y \
>                 common-obj-y \
> @@ -189,7 +190,7 @@ all-obj-y += $(common-obj-y)
>  all-obj-y += $(qom-obj-y)
>  all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
>  all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
> -all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y)
> +all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y) $(crypto-rng-obj-y)
>  all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
>  all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
>  
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 256c9aca1f..ee7e628ca6 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -37,5 +37,6 @@ crypto-obj-y += block-luks.o
>  
>  # Let the userspace emulators avoid linking gnutls/etc
>  crypto-aes-obj-y = aes.o
> +crypto-rng-obj-y = random-platform.o
>  
>  stub-obj-y += pbkdf-stub.o
> -- 
> 2.17.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

