Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF829C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36342073F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36342073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3GXg-0000eW-FB
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 05:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i3GWR-0008CE-Vo
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i3GWQ-0008AI-Mg
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:15:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i3GWQ-00089i-Cr
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:15:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9287049;
 Thu, 29 Aug 2019 09:15:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BC705D9C9;
 Thu, 29 Aug 2019 09:15:08 +0000 (UTC)
Date: Thu, 29 Aug 2019 10:15:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhe.he@windriver.com
Message-ID: <20190829091505.GB17141@redhat.com>
References: <1567068782-371028-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1567068782-371028-1-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 29 Aug 2019 09:15:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] configure: Add pkg-config handling for
 libgcrypt
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
Cc: pbonzini@redhat.com, thuth@redhat.com, philmd@redhat.com, laurent@vivier.eu,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 04:53:02PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> libgcrypt may also be controlled by pkg-config, this patch adds pkg-config
> handling for libgcrypt.

Where are you seeing pkg-config files for libgcrypt ?

The upstream project has (frustratingly) been hostile to any proposal to
add pkg-config support saying people should stick with their custom 
libgcrypt-config tool

   https://dev.gnupg.org/T2037

Even if this is something added by some distro downstream, what is the
benefit in using it, compared with libgcrypt-confg which should already
work & is portable.

> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  configure | 48 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/configure b/configure
> index e44e454..0f362a7 100755
> --- a/configure
> +++ b/configure
> @@ -2875,6 +2875,30 @@ has_libgcrypt() {
>      return 0
>  }
>  
> +has_libgcrypt_pkgconfig() {
> +    if ! has $pkg_config ; then
> +        return 1
> +    fi
> +
> +    if ! $pkg_config --list-all | grep libgcrypt > /dev/null 2>&1 ; then
> +        return 1
> +    fi
> +
> +    if test -n "$cross_prefix" ; then
> +        host=$($pkg_config --variable=host libgcrypt)
> +        if test "${host%-gnu}-" != "${cross_prefix%-gnu}" ; then
> +            print_error "host($host) does not match cross_prefix($cross_prefix)"
> +            return 1
> +        fi
> +    fi
> +
> +    if ! $pkg_config --atleast-version=1.5.0 libgcrypt ; then
> +        print_error "libgcrypt version is $($pkg_config --modversion libgcrypt)"
> +        return 1
> +    fi
> +
> +    return 0
> +}
>  
>  if test "$nettle" != "no"; then
>      pass="no"
> @@ -2902,7 +2926,14 @@ fi
>  
>  if test "$gcrypt" != "no"; then
>      pass="no"
> -    if has_libgcrypt; then
> +    if has_libgcrypt_pkgconfig; then
> +        gcrypt_cflags=$($pkg_config --cflags libgcrypt)
> +        if test "$static" = "yes" ; then
> +            gcrypt_libs=$($pkg_config --libs --static libgcrypt)
> +        else
> +            gcrypt_libs=$($pkg_config --libs libgcrypt)
> +        fi
> +    elif has_libgcrypt; then
>          gcrypt_cflags=$(libgcrypt-config --cflags)
>          gcrypt_libs=$(libgcrypt-config --libs)
>          # Debian has removed -lgpg-error from libgcrypt-config
> @@ -2912,15 +2943,16 @@ if test "$gcrypt" != "no"; then
>          then
>              gcrypt_libs="$gcrypt_libs -lgpg-error"
>          fi
> +    fi
>  
> -        # Link test to make sure the given libraries work (e.g for static).
> -        write_c_skeleton
> -        if compile_prog "" "$gcrypt_libs" ; then
> -            LIBS="$gcrypt_libs $LIBS"
> -            QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
> -            pass="yes"
> -        fi
> +    # Link test to make sure the given libraries work (e.g for static).
> +    write_c_skeleton
> +    if compile_prog "" "$gcrypt_libs" ; then
> +	    LIBS="$gcrypt_libs $LIBS"
> +	    QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
> +	    pass="yes"
>      fi
> +
>      if test "$pass" = "yes"; then
>          gcrypt="yes"
>          cat > $TMPC << EOF
> -- 
> 2.7.4
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

