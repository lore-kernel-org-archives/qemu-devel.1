Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E2C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FDF2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FDF2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgUSp-0005qU-At
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 09:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hgURh-0005KF-Oo
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hgURg-00062P-ET
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:28:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hgURg-000620-8p
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D20C30842CE
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 13:28:06 +0000 (UTC)
Received: from redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D296D5D707;
 Thu, 27 Jun 2019 13:28:01 +0000 (UTC)
Date: Thu, 27 Jun 2019 14:27:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190627132758.GL12358@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-4-git-send-email-pbonzini@redhat.com>
 <20190627090353.GA24929@redhat.com>
 <b8ae5bd6-2b52-99e0-993c-fe8f65d40da3@redhat.com>
 <20190627125505.GH12358@redhat.com>
 <20190627131601.3zln6ywzewm35qvn@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190627131601.3zln6ywzewm35qvn@sirius.home.kraxel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 27 Jun 2019 13:28:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/7] configure: integrate Meson in the
 build system
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 03:16:01PM +0200, Gerd Hoffmann wrote:
>  Hi,
> 
> > Ok, I can understand that. I've been thinking about how we can switch
> > libvirt to use meson too, and trying to decide between meson being the
> > owner, calling out to make  vs keeping make as the owner and calling
> > out to meson. Ultimately to entirely banish make, autoconf, automake,
> > libtool, m4 & shell from our build system :-)
> > 
> > Despite thinking about an incremental conversion though, I was still
> > hoping libvirt would just have a single (largish) patch series to
> > do a complete conversion at a specific point in time.
> 
> Another possible approach would be to have two build systems.
> The traditional configure & make and the new meson & ninja.
> 
> Advantage is we don't have to worry about the transition and mixing &
> make + meson at all.
> 
> Disadvantage is the duplication.  That wouldn't be forever though.
> I'd expect we'll have one or maybe two releases with both build systems,
> then delete the make & configure.

Personally I strongly wish to avoid having two parallel build systems.
In several projects I've encountered with that I've ended up hitting
bugs where each build system produced different binary results  due to
the developers not putting the same changes into both build systems.

Prefer to only merge a new build system once there is confidence that
it is working, and then immediately delete the old one so as to avoid
bitrot & concentrate any bug fixing on the modern stuff.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

