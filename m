Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EEDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540F62076A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4xJ66ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540F62076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtV8O-00048t-LO
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtV6p-0002eb-PD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:52:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtV6n-0005ht-UI
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594295576;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEUmS449zc+LVMIL5Dy5Yph45es5AIROwB5bJmRAiMg=;
 b=D4xJ66ijfudr2lmVQbhTIqP1ETZp6nl3wbglpxom8B/X0fNcFmUWz3vwYQnEbo/LxW1Qo0
 ts+jpV69mzXZS/KuQYwkBhAtjEiIgb4CuK2IK26Z/0nVH86OhOl6CfIXIWtX6alFLe5+oJ
 OUTvtiWy1sbnZE8QIHQxQZoxZfiITkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-xBnGCVQBPtGAH4KMDP5aTg-1; Thu, 09 Jul 2020 07:52:49 -0400
X-MC-Unique: xBnGCVQBPtGAH4KMDP5aTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4666B1089;
 Thu,  9 Jul 2020 11:52:48 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB331002380;
 Thu,  9 Jul 2020 11:52:43 +0000 (UTC)
Date: Thu, 9 Jul 2020 12:52:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/2] util/qemu-sockets: make keep-alive enabled by default
Message-ID: <20200709115239.GL3753300@redhat.com>
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
 <20200708191540.28455-3-vsementsov@virtuozzo.com>
 <20200709082954.GD3753300@redhat.com>
 <62e64c31-1f6b-f27e-82ca-dfb3085a9869@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <62e64c31-1f6b-f27e-82ca-dfb3085a9869@virtuozzo.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
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
Cc: den@openvz.org, kraxel@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 11:49:17AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 09.07.2020 11:29, Daniel P. Berrangé wrote:
> > On Wed, Jul 08, 2020 at 10:15:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Keep-alive won't hurt, let's try to enable it even if not requested by
> > > user.
> > 
> > Keep-alive intentionally breaks TCP connections earlier than normal
> > in face of transient networking problems.
> > 
> > The question is more about which type of pain is more desirable. A
> > stall in the network connection (for a potentially very long time),
> > or an intentionally broken socket.
> > 
> > I'm not at all convinced it is a good idea to intentionally break
> > /all/ QEMU sockets in the face of transient problems, even if the
> > problems last for 2 hours or more.
> > 
> > I could see keep-alives being ok on some QEMU socket. For example
> > VNC/SPICE clients, as there is no downside to proactively culling
> > them as they can trivially reconnect. Migration too is quite
> > reasonable to use keep alives, as you generally want migration to
> > run to completion in a short amount of time, and aborting migration
> > needs to be safe no matter what.
> > 
> > Breaking chardevs or block devices or network devices that use
> > QEMU sockets though will be disruptive. The only solution once
> > those backends have a dead socket is going to be to kill QEMU
> > and cold-boot the VM again.
> > 
> 
> Reasonable, thanks for explanation.
> 
> We are mostly interested in keep-alive for migration and NBD connections.
> (NBD driver has ability to reconnect). What do you think about setting
> keep-alive (with some KEEPIDLE smaller than 2 hours) by default for
> migration and NBD (at least when NBD reconnect is enabled), would it be
> valid?

I think it should be reasonable to set by default for those particular
scenarios, as both are expecting failures and ready to take action when
they occur.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


