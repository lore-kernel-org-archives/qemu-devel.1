Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0288BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E13020795
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTGYtcHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E13020795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGH9r-0001UZ-9Z
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGH9H-0000rq-36
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:37:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGH9E-0006G2-Vo
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599723456;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ydfQhLPSKXc8pP2QKJ404YzvLiKUkoT6gPyQFwi3YQ=;
 b=CTGYtcHAMeInDF52Jolp6/8UUhaOR3MR+lUl/Q+ns9sEn4QywITd/aJZmMe1WhFFPEUFwl
 nhpUEgCweZfx87TRQ1FAXj+Y+A6vkF992+LKQ1wTOj39w0Y9P9X0AzkpMdlZLbMEZapBIa
 nAb4+Zhd7g60vcxfmkIPT2CmLc00Wlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-Y53CD8XhOYqGzuK2b2szhA-1; Thu, 10 Sep 2020 03:37:20 -0400
X-MC-Unique: Y53CD8XhOYqGzuK2b2szhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9DA51DDFD;
 Thu, 10 Sep 2020 07:37:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2C675D9E8;
 Thu, 10 Sep 2020 07:37:13 +0000 (UTC)
Date: Thu, 10 Sep 2020 08:37:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Message-ID: <20200910073710.GA1083348@redhat.com>
References: <2764135.D4k31Gy3CM@silver> <13443969.F0S6BcH2UH@silver>
 <20200909181355.GV1011023@redhat.com> <1695914.5EixHECA2G@silver>
MIME-Version: 1.0
In-Reply-To: <1695914.5EixHECA2G@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 03:02:23
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, qemu-devel@nongnu.org,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 08:56:48PM +0200, Christian Schoenebeck wrote:
> On Mittwoch, 9. September 2020 20:13:55 CEST Daniel P. Berrangé wrote:
> > > On Mittwoch, 9. September 2020 15:40:05 CEST Daniel P. Berrangé wrote:
> > > > Ideally any xcode setup would just invoke whatever our standard
> > > > build tools are IMHO, so it has zero possibility of introducing
> > > > new build problems.
> > > 
> > > Then you would not win anything on Mac. The problematic on macOS is that
> > > Apple froze many standard FOSS tools that switched to GPL3. So by default
> > > you just have e.g. GNU make 3.81 (2006), Bash 3.2.57 (2007), ...  unless
> > > you start to manually install them (e.g. from Homebrew & Co). And being
> > > forced to use Meson on Mac with all its Python dependencies does not make
> > > it easier.
> > 
> > It is going to need to use homebrew (or an equivalent) to bring in various
> > 3rd party libraries QEMU depends on at build time, not least glib.
> 
> External libraries are not the problem. AFAICS that's just libffi, glib and 
> pixman. These could be added as submodules.
> 
> The more relevant ones would be the build tools that those QEMU scripts are 
> running to auto generate source files.

I don't think we want to be adding more 3rd party deps as submodules, quite
the opposite, we want to remove more submodules we currently have.

Bundling every important dep we use as a submodule and providing build rules,
means we're effectively re-inventing Homebrew / MacPorts and this is not a
sane use of our time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


