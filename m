Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2A6C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A03C20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A03C20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCIc-0003xl-Bw
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48103)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hZBEk-0008Tb-1n
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hZBEi-0001Lp-UE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:32:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hZBEi-00011A-Bj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:32:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B45BC3082E4D;
 Fri,  7 Jun 2019 09:32:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-25.ams2.redhat.com
 [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 612AF80D91;
 Fri,  7 Jun 2019 09:32:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9F1B316E1A; Fri,  7 Jun 2019 11:32:19 +0200 (CEST)
Date: Fri, 7 Jun 2019 11:32:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190607093219.pdifzottq5rxbwmi@sirius.home.kraxel.org>
References: <20190401211712.19012-1-bsd@redhat.com>
 <CAFEAcA8irfgXaGvUWxVAEa5Cr5yjNMCcwt_9KcBB+sggvhAMzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8irfgXaGvUWxVAEa5Cr5yjNMCcwt_9KcBB+sggvhAMzg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 07 Jun 2019 09:32:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/3] misc usb-mtp fixes
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
Cc: Bandan Das <bsd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > Bandan Das (3):
> >   usb-mtp: fix return status of delete
> >   usb-mtp: remove usb_mtp_object_free_one
> >   usb-mtp: refactor the flow of usb_mtp_write_data
> 
> Hi Bandan, Gerd -- what's the status of this patchset?
> I think this is the one that fixes the CID1399415
> Coverity issue about usb_mtp_write_data() return values, right?

1+2 fixes where merged during 4.0 freeze, 3 left for post-freeze.
It can follow now, queued up, next usb pull will have it.

thanks for the reminder,
  Gerd


