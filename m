Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A835C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB60723787
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9f5pB/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB60723787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGZe-0007jF-MT
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJGZ0-00073u-Cn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:36:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJGYy-0003eh-3K
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600436190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o99zveXLmC63hDm7Ckqo5LzE89TTRnCFe+gSIpA6uBU=;
 b=S9f5pB/YAv0HG1X6ZTLoUHMLFMnRc42CX7jyyRZzpMj+yqQ7EUvGWqvCYmn67jInWELTGm
 NCcH9NZNmUspOOaJ0lYuZ4GeuF3FNxnR+2lNNTAaLt5yiC8WlhiTf19xKzJZibk95newQZ
 MxSXWajCua8eGJvdudFmgi4YY/uvAZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-5PHn4ekvMu-ToOHBeVeqNg-1; Fri, 18 Sep 2020 09:36:25 -0400
X-MC-Unique: 5PHn4ekvMu-ToOHBeVeqNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9F8D89154A;
 Fri, 18 Sep 2020 13:36:07 +0000 (UTC)
Received: from redhat.com (ovpn-114-199.ams2.redhat.com [10.36.114.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1C2973660;
 Fri, 18 Sep 2020 13:36:06 +0000 (UTC)
Date: Fri, 18 Sep 2020 14:36:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: Deprecating --enable-gprof?
Message-ID: <20200918133604.GI1628512@redhat.com>
References: <CAJ+F1CKSBCwWZjdUJ7Q3w5uGvM0ZLe65Vw05mm8v3t6kNLKUzg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKSBCwWZjdUJ7Q3w5uGvM0ZLe65Vw05mm8v3t6kNLKUzg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 05:25:45PM +0400, Marc-André Lureau wrote:
> Hi
> 
> configure has --enable-gprof since its creation, but is it actually being
> used, or is it sporadic enough that we could deprecate it?
> 
> I have some reason to believe that it's not used much:
> - --enable-gprof only enables -p, which is prof (not gprof!)
> - nowadays there are better profiling tools, such as perf
> 
> Should we fix it to use gprof instead? Or does anyone actually care about
> it?

If we consider a future where configure is eliminated, then I think
the answer is it should be made a built-in feature of meson.

Whether we want to remove it from configure now, in anticipation
of this future day though...

> It is problematic as the flag is passed to meson globally
> (add_project_arguments), but some targets may not support it. I have
> pending patches for pc-bios/* roms. And we can't remove the flag for those
> easily (not as easily as if it was supported by meson, like coverage)

Is that just because it gets added to QEMU_CFLAGS instead of having
it own explicit config option ? If it doesn't work for some parts
of the build, then we can we just add a GPROF_CFLAGS arg and only
add it to the parts of the build where it actually works ?


> 
> I would propose to deprecate it on the configure options. A user can always
> override the cflags manually to provide -p option if he really needs it.
> Alternatively, I could work on getting support in meson (
> https://github.com/mesonbuild/meson/issues/3659), but this would bump our
> meson dependency more.

Meson has built-in support for various similar concepts such as
coverage, address sanitizer, profile guided optimization and so
on. It seems like grof fits in meson in this way.

We would not need to bump our minimum depedancy if it merely
requires a meson flag to be passed - anyone who wanted to use
it would merely install newer meson to get access to the flag.
We're not using it by default, so we don't have a need to bump
the version.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


