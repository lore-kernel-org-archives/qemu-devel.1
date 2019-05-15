Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F12C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597EA20873
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597EA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39719 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQx0F-0002df-Ex
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:43:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQwzT-0002Ky-Kf
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQwzS-0008Gu-GE
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:42:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hQwzS-0008Fu-8J
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C0C030832CE;
	Wed, 15 May 2019 16:42:48 +0000 (UTC)
Received: from [10.40.205.57] (unknown [10.40.205.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BF2225C236;
	Wed, 15 May 2019 16:42:46 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190514191653.31488-1-richard.henderson@linaro.org>
	<20190514191653.31488-2-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <0574ecaa-ed9a-40d5-5e09-050266455c90@redhat.com>
Date: Wed, 15 May 2019 18:42:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514191653.31488-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 15 May 2019 16:42:48 +0000 (UTC)
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
Cc: berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2019 21:16, Richard Henderson wrote:
> For user-only, we require only the random number bits of the
> crypto subsystem.
> 
> We need to preserve --static linking, which for many recent Linux
> distributions precludes using GnuTLS or GCrypt.  Instead, use our
> random-platform module unconditionally.
> 

Perhaps we can rename "crypto-aes-obj" to "crypto-user-obj" and put
aes.o and random-platform.o into?

The only aim of crypto-aes-obj was to link aes.o with linux-user binaries.

Anyway, it's only cosmetic, so you can add:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

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
> 


