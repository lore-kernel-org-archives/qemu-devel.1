Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17F3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5A22074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MupLuZvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5A22074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0kMU-0003Dr-LZ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 07:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k0kLw-0002ov-HK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 07:34:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k0kLu-0002RL-Po
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 07:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596022470;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eS9w68sby7v0S89GU3IOEZy6V2AYbQmJpPUKjcB+LEQ=;
 b=MupLuZvTRrgBsVoUL6XItWA+XrkI0UBrSxVjMDYgv+Fz5XMhax03hbN7022BPpVG7Xc0WZ
 6qKBl2UZYg9w/cc1UkxwAwQrdloUZ1dGeZuEHOZd2cslPEOFKo8kco0xaddfVKZt9wmbKt
 NlDAk4tmDwiZlDjIZvwLoJsGPxqXEmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-pc7kCjbnO32WDjtO5wl1mw-1; Wed, 29 Jul 2020 07:34:23 -0400
X-MC-Unique: pc7kCjbnO32WDjtO5wl1mw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C97501005504;
 Wed, 29 Jul 2020 11:34:22 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 915265F1E9;
 Wed, 29 Jul 2020 11:34:18 +0000 (UTC)
Date: Wed, 29 Jul 2020 12:34:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
Message-ID: <20200729113415.GB3451141@redhat.com>
References: <20200714162659.1017432-1-berrange@redhat.com>
 <20200729103719.GD37763@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200729103719.GD37763@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.74; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 03:32:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 11:37:19AM +0100, Stefan Hajnoczi wrote:
> On Tue, Jul 14, 2020 at 05:26:59PM +0100, Daniel P. Berrangé wrote:
> > In Fedora 33 rawhide, we now have sphinx 3.1.1, as opposed
> > to previous 2.2.2. This new version generates a warning on
> > the source:
> > 
> > docs/qemu-option-trace.rst.inc:4:Malformed option description
> >   '[enable=]PATTERN', should look like "opt", "-opt args",
> >   "--opt args", "/opt args" or "+opt args"
> > 
> > This turns into an error when QEMU passes -W to sphinx-build
> > 
> > Strangely the previous 2.2.2 code has the exact same logic
> > for checking the syntax, but it is not being triggered. While
> > it is only complaining about the first option, I changed all
> > the options to give consistency.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/qemu-option-trace.rst.inc | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Thanks, applied to my tracing tree:
> https://github.com/stefanha/qemu/commits/tracing

I'm not sure this is a good idea to queue it, based on the other
part of this thread about incompatibilities with differnet sphinx
versions, and the patchew failures.

I don't have a answer for how to fix this to make every versions happy.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


