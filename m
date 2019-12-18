Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDA8C2D0D1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38CB24692
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkQc9G2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38CB24692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUTX-0004Ge-1G
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihUSn-0003nR-Or
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihUSm-00049F-Ia
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:13:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihUSm-000481-Di
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576656823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ae4wFI3QwhBbA2nAEKNwY9njT9aB5BF7mRZGTVqEixY=;
 b=FkQc9G2scpZtDd3AMN80ghKOEIdjnyusTBbotUymy9pRyaoe+f6GmQA1QEx6E3r7gXCOdK
 +FCfmnvP7gy54Og9ZiW7OEBsvUwaR2dnk8as9BsCILdEhCMokvgcO9UwxHF3lnbt4Fb2/P
 op9Lym9HtElz9vDnRhlBeJ2ol2x45RE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-INsEizqzMoaVEWmriQ6krg-1; Wed, 18 Dec 2019 03:13:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42B14107ACC4;
 Wed, 18 Dec 2019 08:13:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 899855D9E2;
 Wed, 18 Dec 2019 08:13:37 +0000 (UTC)
Subject: Re: [PATCH 6/7] configure: Override the os default with --disable-pie
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218031920.6414-7-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <03f68f02-d3c5-1df3-8697-df8d20010b86@redhat.com>
Date: Wed, 18 Dec 2019 09:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218031920.6414-7-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: INsEizqzMoaVEWmriQ6krg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/2019 04.19, Richard Henderson wrote:
> Some distributions, e.g. Ubuntu 19.10, enable PIE by default.
> If for some reason one wishes to build a non-pie binary, we
> must provide additional options to override.
> 
> At the same time, reorg the code to an elif chain.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/configure b/configure
> index f8981eec15..1645a58b3a 100755
> --- a/configure
> +++ b/configure
> @@ -2029,19 +2029,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
>    LDFLAGS_NOPIE="-no-pie"
>  fi
>  
> -if test "$pie" != "no" ; then
> -  if compile_prog "-fPIE -DPIE" "-pie"; then
> -    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
> -    LDFLAGS="-pie $LDFLAGS"
> -    pie="yes"
> -  else
> -    if test "$pie" = "yes"; then
> -      error_exit "PIE not available due to missing toolchain support"
> -    else
> -      echo "Disabling PIE due to missing toolchain support"
> -      pie="no"
> -    fi
> -  fi
> +if test "$pie" = "no"; then
> +  QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
> +  LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
> +elif compile_prog "-fPIE -DPIE" "-pie"; then
> +  QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
> +  LDFLAGS="-pie $LDFLAGS"
> +  pie="yes"
> +elif test "$pie" = "yes"; then
> +  error_exit "PIE not available due to missing toolchain support"
> +else
> +  echo "Disabling PIE due to missing toolchain support"
> +  pie="no"
>  fi
>  
>  # Detect support for DT_BIND_NOW.
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


