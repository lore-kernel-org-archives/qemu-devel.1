Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA41AC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD1F20821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD1F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJIh-0007SD-12
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:18:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJGK-0006S3-68
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJGJ-0004Xl-0J
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGJGI-0004Vz-Od
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:16:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD8D92D813;
	Tue, 16 Apr 2019 08:16:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CCAA119C78;
	Tue, 16 Apr 2019 08:16:08 +0000 (UTC)
Date: Tue, 16 Apr 2019 09:16:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190416081605.GB31311@redhat.com>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415203917.GA32317@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415203917.GA32317@habkost.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 16 Apr 2019 08:16:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: mst@redhat.com, Pu Wen <puwen@hygon.cn>, qemu-devel@nongnu.org,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416081605.42NdrMh3TyW61sKcTuiC98CmxHrVlmzcL2PMez8XEQw@z>

On Mon, Apr 15, 2019 at 05:39:17PM -0300, Eduardo Habkost wrote:
> On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
> > Add a new base CPU model called 'Dhyana' to model processors from Hygon
> > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > 
> > The following features bits have been removed compare to AMD EPYC:
> > aes, pclmulqdq, sha_ni
> > 
> > The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
> > So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> > CPU model.
> > 
> > Reference:
> > [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
> > 
> > Signed-off-by: Pu Wen <puwen@hygon.cn>
> 
> Thanks for the patch.
> 
> I'm wondering if we should let the CPU model be used only on
> Hygon hosts, to avoid confusion.

Why should we artificially restrict it ?  All the other CPUs are able to
be used on any host that is able to support the feature list required by
the CPU model. If some other host has sufficient features to run Dhyana
the CPU model we shouldn't block it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

