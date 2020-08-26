Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52462C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E28206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISA7yK2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E28206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqnq-000632-2d
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAqnA-0005cD-Pi
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:28:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35229
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAqn8-0007Ww-LF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598430500;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TnkRcD64lc8QEiIrggnYK/0OKF8kfckHJafBC1xhUDg=;
 b=ISA7yK2x49l5fAu0wX7RGoh22/WmjtrFRDWm9HQNmHW6FjlP8xV9N5fCuSVGg9j32axjlI
 JhwXM6AUTe8Z4ZM6EIfGiRSSOXb/6gO5DTG67bU0YpM+JUC49B6Hha0LqFW9uqLS5GE1sq
 LpXZrGcPJdKzxQe/N2FvdcE5IcqUwNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-yLVgq9JHP2yJWgOaxdGBaQ-1; Wed, 26 Aug 2020 04:28:18 -0400
X-MC-Unique: yLVgq9JHP2yJWgOaxdGBaQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 937868030CE;
 Wed, 26 Aug 2020 08:28:17 +0000 (UTC)
Received: from redhat.com (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E2A11944D;
 Wed, 26 Aug 2020 08:28:13 +0000 (UTC)
Date: Wed, 26 Aug 2020 09:28:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH v2 1/5] meson: pass confsuffix option
Message-ID: <20200826082810.GC168515@redhat.com>
References: <20200825175827.355940-1-marcandre.lureau@redhat.com>
 <20200825175827.355940-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200825175827.355940-2-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:47:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: sw@weilnetz.de, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 09:58:23PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The following patches will make use of it to fix installation paths.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  configure         | 1 +
>  meson_options.txt | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/configure b/configure
> index b1e11397a8..e19e2de2f0 100755
> --- a/configure
> +++ b/configure
> @@ -8222,6 +8222,7 @@ NINJA=$PWD/ninjatool $meson setup \
>          --mandir "${pre_prefix}$mandir" \
>          --sysconfdir "${pre_prefix}$sysconfdir" \
>          --localstatedir "${pre_prefix}$local_statedir" \
> +        -Dconfsuffix="$confsuffix" \
>          -Doptimization=$(if test "$debug" = yes; then echo 0; else echo 2; fi) \
>          -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
>          -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
> diff --git a/meson_options.txt b/meson_options.txt
> index c55f9cd94c..7bb2c0fca9 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -1,3 +1,4 @@
> +option('confsuffix', type : 'string', value: 'qemu')

In "configure",  $confsuffix defaults to "/qemu", but here is misses the
"/".  Not having the "/" is better as meson will add the correct platform
specific dir separator, but it makes me think that configure needs updating
to strip a leading "/" when passing it into meson ?  

>  option('gettext', type : 'boolean', value : true)
>  option('sdl', type : 'feature', value : 'auto')
>  option('sdl_image', type : 'feature', value : 'auto')
> -- 
> 2.26.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


