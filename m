Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0BC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 22:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729EE26F7F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 22:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729EE26F7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWpg4-0001GH-Em
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 18:07:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWpel-0000VD-6Y
	for qemu-devel@nongnu.org; Fri, 31 May 2019 18:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWpYu-00040A-3R
	for qemu-devel@nongnu.org; Fri, 31 May 2019 17:59:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hWpYt-0003zm-UL
	for qemu-devel@nongnu.org; Fri, 31 May 2019 17:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19E673179B49
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 21:59:43 +0000 (UTC)
Received: from localhost (ovpn-120-246.rdu2.redhat.com [10.10.120.246])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E3085DEE1;
	Fri, 31 May 2019 21:59:33 +0000 (UTC)
Date: Fri, 31 May 2019 18:59:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190531215932.GO22103@habkost.net>
References: <20190530134631-mutt-send-email-mst@kernel.org>
	<20190530180022.GB2864@work-vm>
	<20190530140419-mutt-send-email-mst@kernel.org>
	<20190530182210.GA22103@habkost.net>
	<20190530190322-mutt-send-email-mst@kernel.org>
	<20190531170154.GB22103@habkost.net>
	<20190531135059-mutt-send-email-mst@kernel.org>
	<20190531184512.GN3169@work-vm> <20190531142933.248cbd17@x1.home>
	<20190531170437-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531170437-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 31 May 2019 21:59:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
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
Cc: pkrempa@redhat.com, berrange@redhat.com, aadam@redhat.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>, laine@redhat.com,
	jdenemar@redhat.com, Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 05:05:26PM -0400, Michael S. Tsirkin wrote:
> On Fri, May 31, 2019 at 02:29:33PM -0600, Alex Williamson wrote:
> > I don't know what this frontend/backend rework would
> > look like for vfio-pci, but it seems non-trivial for this one use case
> > and I don't see that it adds any value outside of this use case,
> > perhaps quite the opposite, it's an overly complicated interface for
> > the majority of use cases so we either move to a more complicated
> > interface or maintain both.  Poor choices either way.
> 
> Well put Alex this is what I meant when I said it's a useless
> interface. I meant it only has a single use.

I might agree if the code needed to hide the VFIO device from the
guest while keeping resources open (so it can be re-added if
migration fails) is demonstrably simpler than the code that would
be necessary to separate the device backend from the frontend.

But I couldn't find the code that does that in this series.  Is
this already implemented?

All I see is a qdev_unplug() call (which will close host
resources) and a qdev_device_add() call (which will reopen the
host device).

-- 
Eduardo

