Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B55CC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78C9218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78C9218CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOf4-0005pj-6w
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hjOaw-0002yH-1L
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hjOas-0004j0-Rn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hjOam-00048r-Iv; Fri, 05 Jul 2019 09:49:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 34C5E356E4;
 Fri,  5 Jul 2019 13:49:35 +0000 (UTC)
Received: from redhat.com (ovpn-112-48.ams2.redhat.com [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D97F668C79;
 Fri,  5 Jul 2019 13:49:32 +0000 (UTC)
Date: Fri, 5 Jul 2019 14:49:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, keith.busch@intel.com, mreitz@redhat.com,
 lersek@redhat.com
Message-ID: <20190705134929.GM32473@redhat.com>
References: <20190705072333.17171-1-klaus@birkelund.eu>
 <20190705072333.17171-17-klaus@birkelund.eu>
 <20190705133616.GA4707@bogfinke>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190705133616.GA4707@bogfinke>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 05 Jul 2019 13:49:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/16] nvme: support multiple
 namespaces
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 03:36:17PM +0200, Klaus Birkelund wrote:
> On Fri, Jul 05, 2019 at 09:23:33AM +0200, Klaus Birkelund Jensen wrote:
> > This adds support for multiple namespaces by introducing a new 'nvme-ns'
> > device model. The nvme device creates a bus named from the device name
> > ('id'). The nvme-ns devices then connect to this and registers
> > themselves with the nvme device.
> > 
> > This changes how an nvme device is created. Example with two namespaces:
> > 
> >   -drive file=nvme0n1.img,if=none,id=disk1
> >   -drive file=nvme0n2.img,if=none,id=disk2
> >   -device nvme,serial=deadbeef,id=nvme0
> >   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
> >   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> > 
> > A maximum of 256 namespaces can be configured.
> > 
>  
> Well that was embarrasing.
> 
> This patch breaks nvme-test.c. Which I obviously did not run.
> 
> In my defense, the test doesn't do much currently, but I'll of course
> fix the test for v2.

That highlights a more serious problem.  This series changes the syntx
for configuring the nvme device in a way that is not backwards compatible.
So anyone who is using QEMU with NVME will be broken when they upgrade
to the next QEMU release.

I understand why you wanted to restructure things to have a separate
nvme-ns device, but there needs to be some backcompat support in there
for the existing syntax to avoid breaking current users IMHO.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

