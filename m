Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDACEC4727E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF0821974
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIXtThTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF0821974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtnE-0007FT-Rq
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kMtmI-0006Hk-SQ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kMtmC-00013Z-3F
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:05:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601301910;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trCBkrHaPUSuG4v9ihh0uMMOSzPYjTQS0ZDI4bktlEY=;
 b=FIXtThTNRLHNmlwVm+dpvvYlnh8fn9mG50IaNeZscGvDuURKEZv9jQfdxBFIpYGh4rXEuC
 +GWWWytfzWeJz3DyasixdSq8rvHkbQVJdZchN3tWc236nM9Msc8maGNhZULWm9Cyx9MBh2
 fEw2KSr+a3xYcFO+MeGjI7N2OOyoDEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-sXwED7fTMCeuk0DGoInSUQ-1; Mon, 28 Sep 2020 10:04:54 -0400
X-MC-Unique: sXwED7fTMCeuk0DGoInSUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F3161019625;
 Mon, 28 Sep 2020 14:04:53 +0000 (UTC)
Received: from redhat.com (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EE2E60DA0;
 Mon, 28 Sep 2020 14:04:51 +0000 (UTC)
Date: Mon, 28 Sep 2020 15:04:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/3] qemu/compiler: Simplify as all compilers support
 attribute 'gnu_printf'
Message-ID: <20200928140448.GH2230076@redhat.com>
References: <20200928125859.734287-1-philmd@redhat.com>
 <20200928125859.734287-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200928125859.734287-2-philmd@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 02:58:57PM +0200, Philippe Mathieu-Daudé wrote:
> Since commit efc6c070aca ("configure: Add a test for the minimum
> compiler version") the minimum compiler version required for GCC
> is 4.8, which supports the gnu_printf attribute.
> 
> We can safely remove the code introduced in commit 9c9e7d51bf0
> ("Move macros GCC_ATTR and GCC_FMT_ATTR to common header file").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/qemu/compiler.h | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index c76281f3540..207e3bd4feb 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -104,17 +104,14 @@
>                                     sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))
>  
>  #if defined __GNUC__
> -# if !QEMU_GNUC_PREREQ(4, 4)
> -   /* gcc versions before 4.4.x don't support gnu_printf, so use printf. */
> -#  define GCC_FMT_ATTR(n, m) __attribute__((format(printf, n, m)))
> -# else
> -   /* Use gnu_printf when supported (qemu uses standard format strings). */
> -#  define GCC_FMT_ATTR(n, m) __attribute__((format(gnu_printf, n, m)))
> -#  if defined(_WIN32)
> -    /* Map __printf__ to __gnu_printf__ because we want standard format strings
> -     * even when MinGW or GLib include files use __printf__. */
> -#   define __printf__ __gnu_printf__
> -#  endif
> +  /* Use gnu_printf when supported (qemu uses standard format strings). */
> +# define GCC_FMT_ATTR(n, m) __attribute__((format(gnu_printf, n, m)))
> +# if defined(_WIN32)
> +   /*
> +    * Map __printf__ to __gnu_printf__ because we want standard format strings
> +    * even when MinGW or GLib include files use __printf__.
> +    */
> +#  define __printf__ __gnu_printf__
>  # endif
>  #else
>  #define GCC_FMT_ATTR(n, m)

I think this can be simplified even more by using GLib's macros

  #define GCC_FMT_ATTR(n, m)  G_GNUC_PRINTF(n, m)

and ideally we'd then convert all crrent usage to the latter and
drop GCC_FMT_ATTR.

https://developer.gnome.org/glib/2.64/glib-Miscellaneous-Macros.html

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


