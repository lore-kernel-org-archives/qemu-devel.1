Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA68C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D96F2166E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D96F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd5m-0003JG-Me
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:28:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQd0j-0007Gh-2T
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQd0h-00045x-3f
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:22:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hQd0f-0003pP-G6; Tue, 14 May 2019 15:22:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DDC4300502A;
	Tue, 14 May 2019 19:22:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-28.ams2.redhat.com [10.36.112.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B270608AB;
	Tue, 14 May 2019 19:22:34 +0000 (UTC)
Date: Tue, 14 May 2019 20:22:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190514192232.GB9512@redhat.com>
References: <155785983236.11040.9618506134214930578.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <155785983236.11040.9618506134214930578.stgit@gimli.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 14 May 2019 19:22:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0.1] q35: Revert to kernel irqchip
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-stable@nongnu.org,
	peterx@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 01:03:31PM -0600, Alex Williamson wrote:
> Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
> the default for the pc-q35-4.0 machine type to use split irqchip, which
> turned out to have disasterous effects on vfio-pci INTx support.  KVM
> resampling irqfds are registered for handling these interrupts, but
> these are non-functional in split irqchip mode.  We can't simply test
> for split irqchip in QEMU as userspace handling of this interrupt is a
> significant performance regression versus KVM handling (GeForce GPUs
> assigned to Windows VMs are non-functional without forcing MSI mode or
> re-enabling kernel irqchip).
> 
> The resolution is to revert the change in default irqchip mode with a
> new pc-q35-4.0.1 machine type for qemu-stable while the development
> branch makes the same change in the pc-q35-4.1 machine type.  The
> qemu-q35-4.0 machine type should not be used in vfio-pci configurations
> for devices requiring legacy INTx support without explicitly modifying
> the VM configuration to use KVM irqchip.  This new 4.0.1 machine type
> makes this change automatically.

If we introduce a pc-q35-4.0.1 machine type in -stable, then VMs
created in stable won't be migratable to future 4.1 unless we also
create this same machine type in master.

If we really want to create a new 4.0.1 machine type, then this
patch needs to go to git master before stable IMHO to guarantee
no regression to master.

> Link: https://bugs.launchpad.net/qemu/+bug/1826422
> Link: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03305.html
> Fixes: b2fc91db8447 ("q35: set split kernel irqchip as default")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> Do we want new stable versions for other archs too or only as needed?



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

