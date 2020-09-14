Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E4C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CEA208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WO9lYOsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CEA208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmkk-0006sp-KL
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHmkD-0006Sf-Fa
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:34:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHmkA-00014h-Nd
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600083237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6hTdSn8ZPPvOq+fbgXPPf308u6BHZeTflpLG5n+3No8=;
 b=WO9lYOskvB4MSy9oa9XyeVHjLr0GWbbvpoBy2PNQ0/mH6dmNW0YRRl4/VQCLTR2KY76R0L
 KAe4XIpwVeStq2DhweSRJlrzciaGf7ZIWDeMMKGF31bgiiB0mpD79/RwN1lYs3LFc5m230
 SkhkYD6LH5vEe+BwFv5HO07wNVUUubE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-cNfQ-DXNODWXRgxyjTeQeg-1; Mon, 14 Sep 2020 07:33:55 -0400
X-MC-Unique: cNfQ-DXNODWXRgxyjTeQeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBCA48B94C8
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 11:33:54 +0000 (UTC)
Received: from redhat.com (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF94F5DA84;
 Mon, 14 Sep 2020 11:33:53 +0000 (UTC)
Date: Mon, 14 Sep 2020 12:33:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] scripts: display how long each test takes to execute
Message-ID: <20200914113351.GJ1252186@redhat.com>
References: <20200914110948.1425082-1-berrange@redhat.com>
 <fdbb969d-6569-87bc-901a-f51d7bf2cd21@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fdbb969d-6569-87bc-901a-f51d7bf2cd21@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 01:19:20PM +0200, Paolo Bonzini wrote:
> On 14/09/20 13:09, Daniel P. Berrangé wrote:
> > I'm unclear if meson's native test runner can print timings. If not,
> > we might want to submit an RFE there too.
> 
> I agree that any holes should be filled in there.  In this case it does,
> so I think we should start using it in CI so that RFEs can be sent there.
> 
> mtest2make-style output has been in use (and good enough) for years so
> I'd rather avoid piling up more hacks on top.  "meson test" is not
> perfect but I'd rather improve it instead.

When I run "meson test" it doesn't use the results from the previous
"make", instead it re-compiles the entire codebase using ninja.

If we're telling users to continue to use "make" and "make check" though,
I don't think we should be using "meson test" in the CI systems, as it
means CI is not testing the same build process as our users, which is
defeating the point of CI.

If using "meson compile" and "meson test" already works though, what
is our current ninja -> make convertor doing for us, besides letting
people have a facade to pretend nothing has changed ?


> >  scripts/mtest2make.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> > index 9cbb2e374d..9103ae65b9 100644
> > --- a/scripts/mtest2make.py
> > +++ b/scripts/mtest2make.py
> > @@ -20,7 +20,7 @@ print('''
> >  SPEED = quick
> >  
> >  # $1 = environment, $2 = test command, $3 = test name, $4 = dir
> > -.test-human-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | ./scripts/tap-driver.pl --test-name="$3" $(if $(V),,--show-failures-only)
> > +.test-human-tap = export then=`date +%s` ; $1 $(if $4,(cd $4 && $2),$2) < /dev/null | ./scripts/tap-driver.pl --test-name="$3" $(if $(V),,--show-failures-only) ; export now=`date +%s` ; delta=`expr $$now - $$then` ; $(if $(V),echo "TIME $$delta seconds",true)
> >  .test-human-exitcode = $1 $(PYTHON) scripts/test-driver.py $(if $4,-C$4) $(if $(V),--verbose) -- $2 < /dev/null
> >  .test-tap-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $3/" || true
> >  .test-tap-exitcode = printf "%s\\n" 1..1 "`$1 $(if $4,(cd $4 && $2),$2) < /dev/null > /dev/null || echo "not "`ok 1 $3"
> > -- 2.26.2
> 
> 
> Paolo
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


