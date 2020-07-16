Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B445C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46694206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUD1J2oX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46694206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4qm-0001pd-Ic
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw4q2-00019W-3X
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:26:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw4q0-0005aS-9l
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594909574;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6UkLSoZmWn9TpT0HI92FnQUHZc/A8vtgeZCGFB79lJQ=;
 b=ZUD1J2oXOGm4Q4htNsVvrCHBqkfs6LK7VZwJcqusQaLijVsnen6wlVaAkBcFKdIjAgxc6O
 tgCSvxxTvwynBTSpEL/jKpDJt+5V7yuejdv3g2aMO81oLUW3WIfRqwV0imMrqiZVlqH2Eq
 ilnqjfl4wSXq4rfqceRbsXEt6903k3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-YrusgdYlOA6TzmJ4X5bacA-1; Thu, 16 Jul 2020 10:26:00 -0400
X-MC-Unique: YrusgdYlOA6TzmJ4X5bacA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A12212FCCC;
 Thu, 16 Jul 2020 14:25:22 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEAA660C84;
 Thu, 16 Jul 2020 14:25:20 +0000 (UTC)
Date: Thu, 16 Jul 2020 15:25:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH] configure: Fix atomic64 test for --enable-werror on
 macOS
Message-ID: <20200716142518.GU227735@redhat.com>
References: <20200716131101.18462-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200716131101.18462-1-thuth@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 03:11:01PM +0200, Thomas Huth wrote:
> When using --enable-werror for the macOS builders in the Cirrus-CI,
> the atomic64 test is currently failing, and config.log shows a bunch
> of error messages like this:
> 
>  config-temp/qemu-conf.c:6:7: error: implicit declaration of function
>  '__atomic_load_8' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>   y = __atomic_load_8(&x, 0);
>       ^
>  config-temp/qemu-conf.c:6:7: error: this function declaration is not a
>  prototype [-Werror,-Wstrict-prototypes]
> 
> Suppress the warnings to make it pass.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Not sure whether this is the best way to fix this issue ... thus marked
>  as RFC.
>  Even though the compiler warns here, the program links apparently just
>  fine afterwards and CONFIG_ATOMIC64=y gets set in the config-host.mak
>  file on macOS, so the 64-bit atomic operations seem to be available...
>  Any macOS users here who could shed some light on this?

The error message refers to c99, but QEMU code standard is gnu99.

It doesn't look like we set std=gnu99 when running configure
tests though, and I wonder if that is relevant in this case,
given that the atomic_load* stuff is all compiler built-in.
eg does  -std=gnu99  have any impact on the warnings ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


