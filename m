Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EAEC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CB92071B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3YlzC4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CB92071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaHg-0004OI-Fn
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBaH3-0003y8-O6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:02:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42977
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBaH1-0001az-Ix
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598605334;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5lxZVrpUW4uFbSVL98zacSo2KzjkthB15AJs0p7n9Q0=;
 b=h3YlzC4cgqtVB0HJISICaJ4xlPSnRlx+XVdc/OHtAxdpwmOA7pr1Yqg+NRBJlBuhawoS9w
 t0oxU8Oe+4VG0j1bCnsdi8SYzNUCVcLUw/aK53VfUU0+WoCDlvVGlOtaFJSnN0fMN4SXQY
 VJPvHrcwB2WmrPz/nqjDbCPW2KFeTIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-YBC4rszCNBqDJvKkLRY-QA-1; Fri, 28 Aug 2020 05:02:12 -0400
X-MC-Unique: YBC4rszCNBqDJvKkLRY-QA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 927CD18B9F83;
 Fri, 28 Aug 2020 09:02:11 +0000 (UTC)
Received: from redhat.com (ovpn-113-167.ams2.redhat.com [10.36.113.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D0B9757D1;
 Fri, 28 Aug 2020 09:02:10 +0000 (UTC)
Date: Fri, 28 Aug 2020 10:02:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: build broken with --enable-gcrypt
Message-ID: <20200828090207.GF224144@redhat.com>
References: <046eb29c-9c68-1baf-846e-decd65f567e0@linaro.org>
MIME-Version: 1.0
In-Reply-To: <046eb29c-9c68-1baf-846e-decd65f567e0@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 02:18:46PM -0700, Richard Henderson wrote:
> The meson conversion seems to have not been properly accomplished for the
> gcrypt option: we fail to link against -lgcrypt.
> 
> I tried aping the nettle bits, like the following, but it has no effect.  I
> don't understand how the "nettle" token works, honestly, since it doesn't
> appear to be used at all.

Hmm, a red flag that we're missing CI coverage of the different
crypto backends.  I'll look into fixing this and the meson issue.


> diff --git a/configure b/configure
> index b1e11397a8..4fd50c0275 100755
> --- a/configure
> +++ b/configure
> @@ -6972,6 +6972,8 @@ if test "$gcrypt" = "yes" ; then
>    if test "$gcrypt_hmac" = "yes" ; then
>      echo "CONFIG_GCRYPT_HMAC=y" >> $config_host_mak
>    fi
> +  echo "GCRYPT_CFLAGS=$gcrypt_cflags" >> $config_host_mak
> +  echo "GCRYPT_LIBS=$gcrypt_libs" >> $config_host_mak
>  fi
>  if test "$nettle" = "yes" ; then
>    echo "CONFIG_NETTLE=y" >> $config_host_mak
> diff --git a/meson.build b/meson.build
> index f0fe5f8799..d45c548191 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -108,6 +108,11 @@ if 'CONFIG_NETTLE' in config_host
>    nettle = declare_dependency(compile_args: config_host['NETTLE_CFLAGS'].split(),
>                                link_args: config_host['NETTLE_LIBS'].split())
>  endif
> +gcrypt = not_found
> +if 'CONFIG_GCRYPT' in config_host
> +  gcrypt = declare_dependency(compile_args: config_host['GCRYPT_CFLAGS'].split(),
> +                              link_args: config_host['GCRYPT_LIBS'].split())
> +endif
>  gnutls = not_found
>  if 'CONFIG_GNUTLS' in config_host
>    gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


