Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D0DC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7164E206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0ql/CbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7164E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFv9-0003GS-O5
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFsj-0000fg-RI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:03:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46611
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFsg-0003Ur-Vy
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598288617;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wR532ddwM5HY09GJiFNbUnmzjgcchauOu8vL2gsLRus=;
 b=K0ql/CbDXHlwUtUDf/v+ZOVveLVwwNTWrIiVlx0ZytvP4GVEHzOI6JH0Njk1tqk7YyH6SJ
 1FVmEq3+o932WcZcRjNsg3yublw/oYqUCMcNzfxvMqH/a37MvwHXReGya/2TOIQc2xX0xC
 wZFeduNe7wuZDOjMVo8KcGoCcCrAuOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509--dc6_-DCPPmjvNOvTzVoPQ-1; Mon, 24 Aug 2020 13:03:25 -0400
X-MC-Unique: -dc6_-DCPPmjvNOvTzVoPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E972801AC9
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 17:03:24 +0000 (UTC)
Received: from redhat.com (ovpn-114-223.ams2.redhat.com [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1179962A27;
 Mon, 24 Aug 2020 17:03:19 +0000 (UTC)
Date: Mon, 24 Aug 2020 18:03:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] meson: Build qemu-nbd on macOS again
Message-ID: <20200824170317.GX10011@redhat.com>
References: <20200823083215.14952-1-thuth@redhat.com>
 <cc6c11a1-18af-b887-b597-6f2df431e872@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cc6c11a1-18af-b887-b597-6f2df431e872@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 05:21:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 09:29:21AM -0500, Eric Blake wrote:
> On 8/23/20 3:32 AM, Thomas Huth wrote:
> > Before switching to the meson build system, we used to compile qemu-nbd
> > for macOS, too, which is especially important for running the iotests
> > there. Commit b7c70bf2c5 disabled it by accident, since it did not take
> > into consideration that the $bsd variable in the configure script was
> > also set to "yes" on macOS. Fix it by enabling qemu-nbd on all systems
> > but Windows now instead (which was likely the original intention of the
> > old code in the configure script).
> > 
> > Fixes: b7c70bf2c5 ("meson: qemu-{img,io,nbd}")
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   meson.build | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I can queue this through my NBD tree, although if there is a batch of meson
> fixes going in sooner than that, I don't mind if it goes there.
> 
> Acked-by: Eric Blake <eblake@redhat.com>

FYI, it is pretty trivial to enable building of qemu-nbd.exe on Windows,
which eanbles the conditional to be removed from meson entirely. I've
just CC you a series todo that.

> 
> > 
> > diff --git a/meson.build b/meson.build
> > index df5bf728b5..d79f849768 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1075,7 +1075,7 @@ if have_tools
> >     qemu_io = executable('qemu-io', files('qemu-io.c'),
> >                dependencies: [block, qemuutil], install: true)
> >     qemu_block_tools += [qemu_img, qemu_io]
> > -  if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
> > +  if targetos != 'windows'
> >       qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
> >                  dependencies: [block, qemuutil], install: true)
> >       qemu_block_tools += [qemu_nbd]
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


