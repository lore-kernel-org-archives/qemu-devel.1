Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF0BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B0321D7B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2QbPfzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B0321D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIx1Y-0005NI-Bd
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIwrh-0003ji-Pn
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:34:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54067
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIwrf-0001P5-IW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360470;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAw1CIlFujp0KM/r5VGhz5uFQyMXykpTwnGnJK4rDIw=;
 b=F2QbPfzVd8ExwdRSTlrEFEf8ckUchARJyMyu8aa9pPxxTColLw7lFcBesq1CJM4LtBTtB1
 nwLksn6K98e9wW6EWE0m0xi6e6+pnfMbCIYD+PyezmgeO2ByikSduwQqyn65RSM4SFKxKx
 bMl57EfbDBFHbnYrOEJUOHvttKzFunU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-xZLKN8A-O0OjBdLQYCKd-g-1; Thu, 17 Sep 2020 12:34:18 -0400
X-MC-Unique: xZLKN8A-O0OjBdLQYCKd-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAA22186DD2A;
 Thu, 17 Sep 2020 16:34:17 +0000 (UTC)
Received: from redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EEE255763;
 Thu, 17 Sep 2020 16:34:16 +0000 (UTC)
Date: Thu, 17 Sep 2020 17:34:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] docs: simplify and clarify the platform support rules
Message-ID: <20200917163413.GM1597829@redhat.com>
References: <20200917155606.1623795-1-berrange@redhat.com>
 <20200917162851.GP7594@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200917162851.GP7594@habkost.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 12:28:51PM -0400, Eduardo Habkost wrote:
> On Thu, Sep 17, 2020 at 04:56:06PM +0100, Daniel P. Berrangé wrote:
> > The distinction between short life and long life Linux distributions
> > turned out to be redundant. They can both be covered in a simple way
> > by noting support will target the current release, and the previous
> > release for a period of two years or until its EOL. This rule can also
> > apply to the other UNIX based distros, leaving only Windows needing a
> > different set of rules.
> > 
> > This also clarifies that Debian LTS is out of scope, because the LTS
> > support is provided by a separate group from the main Debian maintainer
> > team.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > 
> > This is a spin off from the Python 3.5 thread
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06358.html
> > 
> >  docs/system/build-platforms.rst | 59 ++++++++++-----------------------
> >  1 file changed, 18 insertions(+), 41 deletions(-)
> > 
> > diff --git a/docs/system/build-platforms.rst b/docs/system/build-platforms.rst
> > index 9734eba2f1..03d2fd217f 100644
> > --- a/docs/system/build-platforms.rst
> > +++ b/docs/system/build-platforms.rst
> > @@ -29,51 +29,28 @@ The Repology site https://repology.org is a useful resource to identify
> [...]
> > +Linux OS, macOS, FreeBSD, NetBSD, OpenBSD
> > +-----------------------------------------
> [...]
> > +For FreeBSD, decisions will be made based on the contents of the ports tree;
> > +for macOS, `HomeBrew`_ will be used, although `MacPorts`_ is expected to carry
> > +similar versions.
> 
> Shouldn't we mention NetBSD and OpenBSD too?

Hmm, yes, i updated the section heading but not the text

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


