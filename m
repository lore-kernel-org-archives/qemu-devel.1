Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D028C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90BC2086D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90BC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hab7R-0007FQ-Fa
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 03:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kchamart@redhat.com>) id 1hab61-0006Rv-5t
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1hab60-0000C0-6y
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:21:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1hab5z-0007zY-RQ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:21:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA2E6308218D;
 Tue, 11 Jun 2019 07:21:05 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-144.ams2.redhat.com
 [10.36.117.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D28585C541;
 Tue, 11 Jun 2019 07:21:02 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id E1CA73E0029; Tue, 11 Jun 2019 09:21:00 +0200 (CEST)
Date: Tue, 11 Jun 2019 09:21:00 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190611072100.GM2725@paraplu>
References: <20190606161943.GA9657@paraplu>
 <20190606141904-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606141904-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 11 Jun 2019 07:21:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] PCI(e): Documentation "io-reserve" and related
 properties?
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 06, 2019 at 02:20:18PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 06, 2019 at 06:19:43PM +0200, Kashyap Chamarthy wrote:
> > Hi folks,
> > 
> > Today I learnt about some obscure PCIe-related properties, in context of
> > the adding PCIe root ports to a guest, namely:
> > 
> >     io-reserve
> >     mem-reserve
> >     bus-reserve
> >     pref32-reserve
> >     pref64-reserve
> > 
> > Unfortunately, the commit[*] that added them provided no documentation
> > whatsover.
> > 
> > In my scenario, I was specifically wondering about what does
> > "io-reserve" mean, in what context to use it, etc.  (But documentation
> > about other properties is also welcome.)
> > 
> > Anyone more well-versed in this area care to shed some light?
> > 
> > 
> > [*] 6755e618d0 (hw/pci: add PCI resource reserve capability to legacy
> >     PCI bridge, 2018-08-21)
> 
> So normally bios would reserve just enough io space to satisfy all
> devices behind a bridge. What if you intend to hotplug more devices?
> These properties allow you to ask bios to reserve extra space.

Thanks.  Would be useful to have them documented in the official QEMU
command-line documentation.  Otherwise, they will remain as arcane
properties that barely anyone knows about.

-- 
/kashyap

