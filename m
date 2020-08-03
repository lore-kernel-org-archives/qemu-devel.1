Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B28C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465EF20672
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFdXn1Ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465EF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Tfo-0005Oi-4X
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 02:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2Tf3-0004zd-FT
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 02:09:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45808
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2Tez-00052o-Rc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 02:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596434959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=o5FAiWhPJhSEDdC2WeVu95x2uNx6kr159GFiwwokoMk=;
 b=TFdXn1LyDz8rsJDXXGdwjDPZVsUO1OYKKJJ2t/i2594Rh9NmL9S9Ar7TfoquVwJfo7+ffV
 2yp9yJ7/KFjfeiILZg/8nuD9ppTgWGt+AiA2P3qI4hIgaODWwzVpyYOUFwJaYsA6ptSGRc
 w7Av2UzkopUKQQQGmzqUY0ior9bsfS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-OYayEgf3PSCyCtXUU9Gu5w-1; Mon, 03 Aug 2020 02:09:17 -0400
X-MC-Unique: OYayEgf3PSCyCtXUU9Gu5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F53B1005504;
 Mon,  3 Aug 2020 06:09:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-113.ams2.redhat.com [10.36.112.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 633E669314;
 Mon,  3 Aug 2020 06:09:09 +0000 (UTC)
Subject: Re: [PATCH] configure: Require pixman for vhost-user-gpu.
To: Rafael Kitover <rkitover@gmail.com>, qemu-devel@nongnu.org
References: <20200801224406.315875-1-rkitover@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f09f5172-a22c-d51a-7db7-a6fd880d386c@redhat.com>
Date: Mon, 3 Aug 2020 08:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200801224406.315875-1-rkitover@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/08/2020 00.44, Rafael Kitover wrote:
> Use the test from Makefile to check if vhost-user-gpu is being built,
> and if so require pixman.

Fixes: 9b52b17ba5 ("configure: Allow to build tools without pixman")

... sorry, I missed that there is indeed a tool that requires pixman.

> Signed-off-by: Rafael Kitover <rkitover@gmail.com>
> ---
>  configure | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/configure b/configure
> index 2acc4d1465..181b465861 100755
> --- a/configure
> +++ b/configure
> @@ -4062,20 +4062,6 @@ if test "$modules" = yes; then
>      fi
>  fi
>  
> -##########################################
> -# pixman support probe
> -
> -if test "$softmmu" = "no"; then
> -  pixman_cflags=
> -  pixman_libs=
> -elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
> -  pixman_cflags=$($pkg_config --cflags pixman-1)
> -  pixman_libs=$($pkg_config --libs pixman-1)
> -else
> -  error_exit "pixman >= 0.21.8 not present." \
> -      "Please install the pixman devel package."
> -fi
> -
>  ##########################################
>  # libmpathpersist probe
>  
> @@ -4491,6 +4477,20 @@ if test "$opengl" = "yes" && test "$have_x11" = "yes"; then
>    done
>  fi
>  
> +##########################################
> +# pixman support probe
> +
> +if test "$softmmu" = "no" && ! ( test "${linux} ${virglrenderer} ${gbm} ${want_tools}" = "yes yes yes yes" );  then

Do you need the round brackets here?

> +  pixman_cflags=
> +  pixman_libs=
> +elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
> +  pixman_cflags=$($pkg_config --cflags pixman-1)
> +  pixman_libs=$($pkg_config --libs pixman-1)
> +else
> +  error_exit "pixman >= 0.21.8 not present." \
> +      "Please install the pixman devel package."
> +fi
> +
>  ##########################################
>  # libxml2 probe
>  if test "$libxml2" != "no" ; then
> 

With the round brackets removed:

Reviewed-by: Thomas Huth <thuth@redhat.com>


