Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840C7C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574B8217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574B8217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvfzQ-0002Gg-MI
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 06:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37423)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hvfyq-0001Rs-NK
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hvfyp-0004sG-JH
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:49:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hvfyp-0004qK-Dr
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:49:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D60B8830F;
 Thu,  8 Aug 2019 10:49:10 +0000 (UTC)
Received: from redhat.com (ovpn-112-28.ams2.redhat.com [10.36.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03C905D9D3;
 Thu,  8 Aug 2019 10:49:07 +0000 (UTC)
Date: Thu, 8 Aug 2019 11:49:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190808104904.GD2534@redhat.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190807071445.4109-2-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 08 Aug 2019 10:49:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 hari@linux.vnet.ibm.com, clg@kaod.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 12:44:40PM +0530, Balamuruhan S wrote:
> Adds scripting interface with python library to call functions in
> python modules from Qemu that can be used to feed input externally
> and without recompiling Qemu that can be used for early development,
> testing and can be extended to abstract some of Qemu code out to a
> python script to ease maintenance.

I admit the use case is interesting, but this is opening a can of
worms...

Historically the project has held the view that we do not wish
to have an mechanism to support loading out of tree code into the
QEMU process. Much previously talk was around dlopen'd C plugins,
but dynanically loaded Python plugins are doing the same thing
at a conceptual level.

We didn't wish to expose internals of QEMU in a plugin API to
avoid having any kind of API promise across releases.

There was also the question of licensing with plugins opening
the door for people to extend QEMU with non-free/closed source
functionality.

While this series only uses the plugin for one fairly obscure
device, once a python plugin feature is intergrated in QEMU
there will inevitably be requests to use it in further areas
of QEMU.

IOW, acceptance of this patch is a significant question for
the project, and a broader discussion point, than just this
PPC feature patch series.

> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  configure                   |  10 +++++
>  include/sysemu/python_api.h |  30 +++++++++++++
>  util/Makefile.objs          |   1 +
>  util/python_api.c           | 100 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 141 insertions(+)
>  create mode 100644 include/sysemu/python_api.h
>  create mode 100644 util/python_api.c

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

