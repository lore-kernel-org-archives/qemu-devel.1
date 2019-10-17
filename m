Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B032FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56EF22089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EF22089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8ed-00040Q-Vg
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iL7iz-0004wv-Sk
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iL7iw-0002Xm-Sc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:30:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iL7iw-0002XW-MZ; Thu, 17 Oct 2019 11:29:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1C2DC058CBD;
 Thu, 17 Oct 2019 15:29:57 +0000 (UTC)
Received: from gondolin (dhcp-192-202.str.redhat.com [10.33.192.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3B6C60BE1;
 Thu, 17 Oct 2019 15:29:56 +0000 (UTC)
Date: Thu, 17 Oct 2019 17:29:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/s390x: Emit a warning if user tried to enable USB
Message-ID: <20191017172954.4e9712de.cohuck@redhat.com>
In-Reply-To: <2e689f2b-9bed-e40e-c761-6f38efaae635@redhat.com>
References: <20191017142123.1236-1-thuth@redhat.com>
 <20191017163402.43437191.cohuck@redhat.com>
 <2e689f2b-9bed-e40e-c761-6f38efaae635@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 17 Oct 2019 15:29:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 16:40:56 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17/10/2019 16.34, Cornelia Huck wrote:
> > On Thu, 17 Oct 2019 16:21:23 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> There is no USB on s390x, so running qemu-system-s390x with
> >> "-machine ...,usb=on" is certainly wrong. Emit a warning to make
> >> the users aware of their misconfiguration.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  After a year or two, we could finally turn this into a hard error,
> >>  but I think we should give the users some time to fix their command
> >>  lines first, so I'm initially only emitting a warning here.
> >>
> >>  hw/s390x/s390-virtio-ccw.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index d3edeef0ad..af8c4c0daf 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -243,6 +243,10 @@ static void ccw_init(MachineState *machine)
> >>      VirtualCssBus *css_bus;
> >>      DeviceState *dev;
> >>  
> >> +    if (machine->usb) {
> >> +        warn_report("This machine does not support USB");  
> > 
> > I'm wondering if this is the only machine type not supporting usb...
> > if not, how are others handling it?  
> 
> I think most machines are silently ignoring it, like we did on s390x
> until now, too.

I'm wondering how many options we have that do nothing when configured
:)

> 
> > The usb parsing code in machine.c does not care if usb is even
> > configured (CONFIG_USB).  
> 
> machine.c is common code, so you can not use CONFIG_USB there.

Hm, yes.

> 
> > There's other stuff in there like
> > igd-passthru, which seems to be x86 specific; probably historical
> > reasons?  
> 
> IMHO igd-passthru should be moved to the xen machine, which seems to be
> the only user.

OTOH, I can currently specify igd-passthru=on on any machine, which
would break if we moved it. Not that it makes any sense...

