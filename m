Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF8CC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EA620775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADLmcv7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EA620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrUz-000150-E0
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDrUR-0000by-I2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:49:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDrUP-0004QL-Mi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599148168;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aF8FdIRhQ5qniC1jnrUoIjWDzjVfGJ18O/BccyptD/I=;
 b=ADLmcv7UZQbR0+tgcb4ZFs4R511w5xwhzCmU/FHs1rMgX85NRbpgW2YESqEF7TRtsMuPqP
 lmScsNBv2fkw0izGWAMqTp80nxNHwLQeMYuyO96jJ6eoaTE9EnfaZrVBrcHEAIIWA4ZCdM
 bmGVcKO9+xfXTSgfUI5W32/2oib9qMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-tJdRCOZUNAmZmEmCN4Blnw-1; Thu, 03 Sep 2020 11:49:21 -0400
X-MC-Unique: tJdRCOZUNAmZmEmCN4Blnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B0FEAFB85;
 Thu,  3 Sep 2020 15:49:11 +0000 (UTC)
Received: from redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1A4A5D9CC;
 Thu,  3 Sep 2020 15:49:09 +0000 (UTC)
Date: Thu, 3 Sep 2020 16:49:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
Message-ID: <20200903154906.GA441291@redhat.com>
References: <20200903153524.98168-1-brogers@suse.com>
 <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 05:44:25PM +0200, Paolo Bonzini wrote:
> On 03/09/20 17:35, Bruce Rogers wrote:
> > Turn on the meson install flag for these executables
> > 
> > Signed-off-by: Bruce Rogers <brogers@suse.com>
> > ---
> >  contrib/ivshmem-client/meson.build | 2 +-
> >  contrib/ivshmem-server/meson.build | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
> > index 1b171efb4f..83a559117f 100644
> > --- a/contrib/ivshmem-client/meson.build
> > +++ b/contrib/ivshmem-client/meson.build
> > @@ -1,4 +1,4 @@
> >  executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
> >             dependencies: glib,
> >             build_by_default: targetos == 'linux',
> > -           install: false)
> > +           install: true)
> > diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
> > index 3a53942201..a1c39aa3b3 100644
> > --- a/contrib/ivshmem-server/meson.build
> > +++ b/contrib/ivshmem-server/meson.build
> > @@ -1,4 +1,4 @@
> >  executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
> >             dependencies: [qemuutil, rt],
> >             build_by_default: targetos == 'linux',
> > -           install: false)
> > +           install: true)
> > 
> 
> They weren't installed before the conversion, were they?

Unfortunately they were historically installed with --enable-tools.

IMHO nothing in contrib/ should be installed by default. If we consider
something maintained and high enough quality for end users, it should
migrate out of contrib/ into tools/.

vhost-user-gpu and elf2dmp are also both in contrib/ but installed
by default :-(


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


