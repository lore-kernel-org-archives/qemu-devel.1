Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0E3C2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724AB2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMKSA2Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724AB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIq5T-0001nW-23
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIq4o-0001Mk-AD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIq4i-00052w-Pa
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600334371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlZDsJMadSg9vCknRiH6mTTxvtTFtF9sHp1UJ3DTgXk=;
 b=iMKSA2QyuqUZk07SssmyqdJaKTTc4s+b4YTXT7Zzcyr/Q2g5Dlgtnl3YnwpcBDlorWVaON
 ci9+0SCvTUmprPXbYt/dXcnInQjMyezgYqt+deI/gUXHdKCcvn05y8i//uqmY0M8Q8zKZ0
 5BG59+MdJm9YV1GB6d97zk47KJIkUAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-Sk5bpiUgPBmLiLMeIj5yfg-1; Thu, 17 Sep 2020 05:19:15 -0400
X-MC-Unique: Sk5bpiUgPBmLiLMeIj5yfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C48881F009;
 Thu, 17 Sep 2020 09:19:14 +0000 (UTC)
Received: from redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82F267E46E;
 Thu, 17 Sep 2020 09:19:12 +0000 (UTC)
Date: Thu, 17 Sep 2020 10:19:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: Should we apply for GitLab's open source program?
Message-ID: <20200917091909.GA1568038@redhat.com>
References: <878sdp4ks9.fsf@linaro.org>
 <20200908141701.GB7154@stefanha-x1.localdomain>
 <87zh5puw8k.fsf@ebb.org>
 <bf85f4c7-bbea-bb33-3455-222d7f101b9a@gnu.org>
 <877dssztty.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <877dssztty.fsf@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <bonzini@gnu.org>,
 "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu@sfconservancy.org" <qemu@sfconservancy.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 09:32:57AM +0100, Alex Bennée wrote:
> 
> Paolo Bonzini <bonzini@gnu.org> writes:
> 
> > On 17/09/20 01:39, Bradley M. Kuhn wrote:
> >> One thing to note is that my understanding is that most of what you're
> >> getting access to through this program is proprietary software features that
> >> GitLab offers as add-ons.
> >
> > Basically all we need is the increased access to the CI environment (not
> > just 400 minutes), and none of the add-on features.  Self-hosting would
> > of course help but we'd have to pay for the hardware resources to run
> > the CI, and have someone that can keep the hardware running.
> 
> It seems for the time being that public CI is still unlimited. The idea
> of making our position as an FLOSS project "official" was to preempt any
> changes to that might come down the track.
> 
> The question of using proprietary features hadn't come up beyond a
> hand-waving of "ohh there is a long list". We are however thinking about
> consolidating some of our more disparate infrastructure onto gitlab so
> it's mostly in one place - for example the bug tracker currently hosted
> on launchpad. Personally I'd think it's unlikely we want to move things
> like the mailing lists which are currently on nongnu (via Savannah).
> 
> Ultimately as developers having to manage infrastructure is a bit of a
> time-sink and currently it's hard for volunteer admins to be as
> responsive as cloud-scale hosting companies who's income from non-free
> software hosting pays for all our server time.

All the evidence we have is that developers generally do not do a good
job at maintaining infrastructure in their spare time. This is largely
unavoidable since a developer is always going to treat sysadmin tasks as
a part time thing to spend as little time as possible on, prioritizing
their coding work. So we end up either with unreliable services that
continuously break (look how many times has Patchew died from ENOSPC
this year), or the service happens to work reliably but is unmaintained
becoming increasingly out of date and thus vulnerable, or the service
simply ends up lagging behind state of the art offered by alternatives.

>                                                 If there was a free
> software only instance of GitLab which offered the same level of service
> I would personally be interested but I don't know how much of the
> projects income could be diverted to supporting that versus the travel
> bursaries and other such things we usually spend our money on.

Clearly the ideal situation would be 100% free software infrastructure
we can use at zero cost, while still being state of the art in terms
of services available to support our workflow. This doesn't exist, so
we have to figure out the most effective tradeoff to make that supports
QEMU's needs in an effective manner.

GitLab's open core model means we're at least partially using open
source infra, even if some features are closed. The basic GitLab CI
features are actually open source AFAIK, so we're not relying on the
closed source infra part of GitLab in that area. IOW, joining the
open source program there is simply about getting an increased grant
of free hardware resources to use.

This is certainly preferrable to us making more use of Travis or
Cirrus CI, or GitHub Actions, all of which are 100% closed CI
systems AFAIK.

Some projects have deployed their own GitLab instances (GNOME,
FreeDesktop), but that is not without significant challenges in
terms of deploying and maintaining the software as well as
providing sufficient hardware to go along. eg See the surprising
effect this self-hosting had on FreeDesktop costs:

  https://lists.freedesktop.org/archives/wayland-devel/2020-February/041232.html

It has been a long tedious road merely to bring up a small number
of CI runners on hardware sponsored by Red Hat, let alone get
enough hardware to replace everything that we and our contributors
currentl get for free via various public services. 

There's ultimately a big gap that exists in terms of a publically
host Git Forge that offers state of the art features, based on
100% open source infra. I'm not seeing anyone being able to solve
that in the forseeable future, and it doesn't seem like a sane use
of QEMU's limited contributor time to divert resources away from
development into infrastructure. We need to make a pragmatic
tradeoff, certainly favouring open source where possible, but if
we need to use other services too that's acceptable.

Our switch to increasingly use GitLab for CI is certainly an
improvement over our historical use of Travis, Shippable and
Cirrus, and better for our contributors than our reliance on
a handful of machines that only the QEMU Git maintainer can
access, or the patchew system that breaks multiple times a
year.

> In this regard FLOSS projects are both leaches on paid for services as
> well as being useful public facing PR for a SaaS platforms abilities.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


