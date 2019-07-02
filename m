Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66574C06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0238B2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0238B2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiIlY-0000LQ-3B
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 09:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiIkN-0007sh-Rn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiIkN-0001WU-1f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:22:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiIkM-0001Vb-P9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:22:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01A457EBC4;
 Tue,  2 Jul 2019 13:22:58 +0000 (UTC)
Received: from redhat.com (ovpn-124-236.rdu2.redhat.com [10.10.124.236])
 by smtp.corp.redhat.com (Postfix) with SMTP id DF2195D6A9;
 Tue,  2 Jul 2019 13:22:47 +0000 (UTC)
Date: Tue, 2 Jul 2019 09:22:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190702092221-mutt-send-email-mst@kernel.org>
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-3-slp@redhat.com>
 <20190628100145-mutt-send-email-mst@kernel.org>
 <87r27dwi1k.fsf@redhat.com>
 <20190630173354-mutt-send-email-mst@kernel.org>
 <20190702081910.e35g4aawxp3ofhy6@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702081910.e35g4aawxp3ofhy6@sirius.home.kraxel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 02 Jul 2019 13:22:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/virtio: Factorize virtio-mmio
 headers
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org,
 Sergio Lopez <slp@redhat.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 10:19:10AM +0200, Gerd Hoffmann wrote:
> > > > I am not sure we want a new machine with 0.X mmio devices.
> > > > Especially considering that virtio-mmio does not have support for
> > > > transitional devices.
> > > 
> > > What are the practical implications of that?
> > 
> > On the plus side, this means we don't need to maintain a bunch of hacks
> > for old guests with quirky drivers.
> 
> Also note that some newer virtio devices require virtio 1.0.
> 
> cheers,
>   Gerd

Right. I forgot.

