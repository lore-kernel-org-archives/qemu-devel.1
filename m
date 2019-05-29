Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC69DC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 05:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16A520B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 05:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16A520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVqjS-00071A-QO
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 01:02:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqiX-0006jD-Tm
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqiX-0002so-1D
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVqiW-0002s7-Of
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D030E89C34;
	Wed, 29 May 2019 05:01:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D9D77A425;
	Wed, 29 May 2019 05:01:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6666A11AAB; Wed, 29 May 2019 07:01:23 +0200 (CEST)
Date: Wed, 29 May 2019 07:01:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190529050123.dblwhfffwa5emhjf@sirius.home.kraxel.org>
References: <20190528204331.5280-1-kraxel@redhat.com>
	<016bde36-9476-91c3-0a06-5cd13d317083@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016bde36-9476-91c3-0a06-5cd13d317083@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 29 May 2019 05:01:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] q35: fix mmconfig and PCI0._CRS
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	=?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 07:48:03AM +0300, Marcel Apfelbaum wrote:
> Hi Gerd,
> 
> On 5/28/19 11:43 PM, Gerd Hoffmann wrote:
> > This patch changes the handling of the mmconfig area.  Thanks to the
> > pci(e) expander devices we already have the logic to exclude address
> > ranges from PCI0._CRS.  We can simply add the mmconfig address range
> > to the list get it excluded as well.
> > 
> > With that in place we can go with a fixed pci hole which covers the
> > whole area from the end of (low) ram to the ioapic.
> > 
> > This will make the whole logic alot less fragile.  No matter where the
> > firmware places the mmconfig xbar, things should work correctly.  The
> > guest also gets a bit more PCI address space (seabios boot):
> > 
> >      # cat /proc/iomem
> >      [ ... ]
> >      7ffdd000-7fffffff : reserved
> >      80000000-afffffff : PCI Bus 0000:00            <<-- this is new
> >      b0000000-bfffffff : PCI MMCONFIG 0000 [bus 00-ff]
> >        b0000000-bfffffff : reserved
> >      c0000000-febfffff : PCI Bus 0000:00
> >        f8000000-fbffffff : 0000:00:01.0
> >      [ ... ]
> > 
> > So this is a guest visible change.
> 
> Looks good to me, but shouldn't we use some compat
> property to not affect previous machine versions?

acpi table changes are typically not versioned, and IIRC the acpi tables
are part of the live migration data stream so the tables will not change
under the feet of the running guest even when it is migrated to another
qemu version.

cheers,
  Gerd


