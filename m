Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C62C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 05:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5917821927
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 05:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZMdCxxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5917821927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvDYM-0000GK-Hv
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 01:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvDXe-0008Hp-2T
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 01:31:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54551
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvDXb-0001ue-C8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 01:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594704701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=T1IzJI6FQGEmXcXiL2rhCTHumLvZ9DHnMEev40E0vHo=;
 b=NZMdCxxRGTv5NsiNZdJWQRIQmtiLi3puhdyU9HfZ82npeFatcWENs0yQImEU1z9eTRCmOW
 nqd7X09reUoL83mKjBN4nQ6vau4Cy11je800IwTqhWvVra/PIf411PYSDBVnrIl3HF1Am7
 W06UM/LyPcf/mbS3B3LuY6EJOwAXMOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-h5CMj3STOA-ggS1zaNGGJA-1; Tue, 14 Jul 2020 01:31:39 -0400
X-MC-Unique: h5CMj3STOA-ggS1zaNGGJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0515D1932481;
 Tue, 14 Jul 2020 05:31:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BE4D6FED1;
 Tue, 14 Jul 2020 05:31:31 +0000 (UTC)
Subject: Re: [PATCH v2 05/11] tests/plugins: don't unconditionally add -Wpsabi
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200713200415.26214-1-alex.bennee@linaro.org>
 <20200713200415.26214-6-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8409f634-9ee3-1a26-e5d0-ce812aa107b6@redhat.com>
Date: Tue, 14 Jul 2020 07:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200713200415.26214-6-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/07/2020 22.04, Alex Bennée wrote:
> Not all compilers support the -Wpsabi (clang-9 in my case). To handle
> this gracefully we pare back the shared build machinery so the
> Makefile is relatively "standalone". We still take advantage of
> config-host.mak as configure has done a bunch of probing for us but
> that is it.
> 
> Fixes: bac8d222a
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - separate from main build system and check probe
> ---
>  configure             |  3 +++
>  tests/plugin/Makefile | 22 ++++++++++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/configure b/configure
> index e1de2f5b24..08eaa99d19 100755
> --- a/configure
> +++ b/configure
> @@ -7112,6 +7112,9 @@ echo "GIT_UPDATE=$git_update" >> $config_host_mak
>  
>  echo "ARCH=$ARCH" >> $config_host_mak
>  
> +echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
> +echo "GLIB_LDFLAGS=$glib_ldflags" >> $config_host_mak
> +
>  if test "$default_devices" = "yes" ; then
>    echo "CONFIG_MINIKCONF_MODE=--defconfig" >> $config_host_mak
>  else
> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
> index 3a50451428..e9348fde4a 100644
> --- a/tests/plugin/Makefile
> +++ b/tests/plugin/Makefile
> @@ -1,9 +1,16 @@
> +# -*- Mode: makefile -*-
> +#
> +# This Makefile example is fairly independent from the main makefile
> +# so users can take and adapt it for their build. We only really
> +# include config-host.mak so we don't have to repeat probing for
> +# cflags that the main configure has already done for us.
> +#
> +
>  BUILD_DIR := $(CURDIR)/../..
>  
>  include $(BUILD_DIR)/config-host.mak
> -include $(SRC_PATH)/rules.mak
>  
> -$(call set-vpath, $(SRC_PATH)/tests/plugin)
> +VPATH += $(SRC_PATH)/tests/plugin
>  
>  NAMES :=
>  NAMES += bb
> @@ -17,11 +24,18 @@ NAMES += lockstep
>  
>  SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
>  
> -QEMU_CFLAGS += -fPIC -Wpsabi
> -QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
> +# The main QEMU uses Glib extensively so it's perfectly fine to use it
> +# in plugins (which many example do).
> +CFLAGS = $(GLIB_CFLAGS)
> +CFLAGS += -fPIC
> +CFLAGS += $(if $(findstring no-psabi,$(QEMU_CFLAGS)),-Wpsabi)
> +CFLAGS += -I$(SRC_PATH)/include/qemu
>  
>  all: $(SONAMES)
>  
> +%.o: %.c
> +	$(CC) $(CFLAGS) -c -o $@ $<
> +
>  lib%.so: %.o
>  	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
>  
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


