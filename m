Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21827C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3313207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i36rvBwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3313207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k92TA-0007Ae-6h
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 04:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k92Sb-0006kU-Mx
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:31:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44833
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k92SZ-0005Ga-So
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597998698;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvDUmOAP06OblI/6MGMj1hV8vq0QZo3AOtNcKGH6Pp4=;
 b=i36rvBwx5HahmEq4jfTtFr8cN0I2caPC3oZ7wa8mXGct5NM+ogYFFokPga4HDSi2tjSXV6
 NKpSNn4hxV4i6zlkS8FUuq0WT2cb+yVeub/CLWFA78vIk3ZTE1zrXKxGKqzEPt7woRJHa1
 KWm5cLZyDYGFHUy9eZIOu9PCccSwa0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-RIhbDqqbMfiLmf6rXJwlxg-1; Fri, 21 Aug 2020 04:31:30 -0400
X-MC-Unique: RIhbDqqbMfiLmf6rXJwlxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77EF71876561;
 Fri, 21 Aug 2020 08:31:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2025D7AEC9;
 Fri, 21 Aug 2020 08:31:26 +0000 (UTC)
Date: Fri, 21 Aug 2020 09:31:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
Message-ID: <20200821083123.GA251583@redhat.com>
References: <20200820173124.243984-1-berrange@redhat.com>
 <814594a0-391c-01fb-a418-234e477793d3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <814594a0-391c-01fb-a418-234e477793d3@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 04:15:59PM -0500, Eric Blake wrote:
> On 8/20/20 12:31 PM, Daniel P. Berrangé wrote:
> > Meson requires the build dir to be separate from the source tree. Many
> > people are used to just running "./configure && make" though and the
> > meson conversion breaks that.
> > 
> > This introduces some backcompat support to make it appear as if an
> > "in source tree" build is being done, but with the the results in the
> > "build/" directory. This allows "./configure && make" to work as it
> > did historically, albeit with the output binaries staying under build/.
> 
> An observation:
> 
> If you already had out-of-tree builds, this does not change anything. You
> can do an incremental build, where a tree that builds pre-merge should
> continue to build incrementally with 'make -C dir' post-merge.
> 
> If you are used to in-tree builds, and do a fresh checkout, this lets you
> maintain the illusion of an in-tree build although binaries may be located
> differently than you are used to.
> 
> But if you do an incremental update to an in-tree build, this will cause
> some odd behaviors, starting with the git update:

snip.

> So I'm not sure why the first build gets as far as it does, but does NOT
> complete things and yet does not fail make, but my advice is that you should
> NOT try to an incremental build on in-tree build when crossing the meson
> epoch.  If you are a fan of in-tree convenience, you need a ONE-TIME
> distclean when pulling in these changes (the fact that you HAVE to clean up
> trace.h files to merge in the meson stuff should be a hint for that).  After
> that has been done, you can go back to pretending meson supports in-tree.

Yeah, I think that's something we'll have to live with. The amount of
extra complexity that would be required to try to make the incremental
build work across the meson introduction would be quite large. A more
efficient use of time is to just clean the dir manually, rather than
debugging some makefile rules that will only be needed once.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


