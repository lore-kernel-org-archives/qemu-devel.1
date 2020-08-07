Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FFFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2880822C9F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVb1DMkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2880822C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yLz-00057u-Cs
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3yLI-0004JF-MU
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:07:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3yLG-0008VL-OQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596791229;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34IyfuNRR4KBbBRelQw/kFBIfACYv1CT61yCTOykc3Q=;
 b=UVb1DMkMGyKt2K1cZBQEpvg7eCmZlf9VYq3sh2sdaQX4YmvhljT5fu/KiQxMLmMSnD4Xh2
 Y3kRG9a/dsWQaubNkxbs962l1XOpNVNme8+gHqYy7V4drfuujuipKMOcNpsnC6smpZ0gq/
 H5n0xSMdWGDUMtC7rk6cbZPHvPYOOeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-wG67IvoSPQ-IN0WACck5Qg-1; Fri, 07 Aug 2020 05:07:04 -0400
X-MC-Unique: wG67IvoSPQ-IN0WACck5Qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42EA757;
 Fri,  7 Aug 2020 09:07:03 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF6708AC04;
 Fri,  7 Aug 2020 09:06:57 +0000 (UTC)
Date: Fri, 7 Aug 2020 10:06:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
Message-ID: <20200807090654.GF120942@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
 <20200807082206.GC120942@redhat.com>
 <87o8nmygk5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87o8nmygk5.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:11:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 07, 2020 at 11:02:34AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Aug 07, 2020 at 09:56:42AM +0200, Markus Armbruster wrote:
> [...]
> >> I think it's now time to plan the end game, preferably without even more
> >> weeks of intense rebasing.
> >> 
> >> Do we have consensus to move forward with Meson?  If yes, I'd like to
> >> propose to aim for merging as early as practical in the 5.2 cycle.
> >> Rationale: rebasing build system changes on top of the Meson work is
> >> probably easier than rebasing the Meson work, and avoids turning Paolo
> >> into an overworked bottleneck.
> >> 
> >> In more detail:
> >> 
> >> 1. Pick a tentative deadline.
> >
> > I'd suggest we need a bare minimum of half a development cycle to.
> > So if we want it tin 5.2, we need to make a strong push now and over
> > next month to review it and iron out any obvious blocking testing
> > problems.
> 
> I had less than a "now and over next month" (>7 weeks!) in mind.

To be clear, I'm not recommending we wait that long - I'm just
suggesting that is an upper bound after which we'd really need
to wait for the dev cycle after.

Ideally we would make a strong push to get it merged just 2 weeks
after this release, ie by early september.

> The choice of deadline is really about how much of Paolo's time we are
> (and he is!) willing to spend on rebasing vs. how much risk of toothing
> problems in master we are willing to accept.
> 
> "First thing after 5.2 opens" would be ideal from a "avoid more
> rebasing" point of view, but it may not be practical.
> 
> Once the flood gates are open, we can probably just as well wait for the
> initial flood to subside.

All depends how quickly Paolo thinks it get to mergeable state....

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


