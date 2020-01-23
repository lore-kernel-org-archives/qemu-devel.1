Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0030EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C190021734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AduBdj5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C190021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugaB-0002G0-Br
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iudXe-0003tX-T5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iudXd-0004fx-I4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:33:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iudXd-0004fc-EP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579789984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFixVKejGKV1lPMIOJMNLN4pBeIgmrEj0dpbcqCDYuE=;
 b=AduBdj5ItYxre/rCT28mLFlGOp0KH/8HJWtiY9wzxlCbaJhUnbCp3Jw6d5o58V94iBW2fD
 Q33Tc36jOZN+EwFT0ZXWhLBw0pnwVwVBYdrmjiVfqPW0LpmkKV0DQip86CKdMsR7sIPqqG
 m6WioraqU6vMUvBwugdVmELw4z+OsvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-st08lnKqPNWdVtKyJyL_mw-1; Thu, 23 Jan 2020 09:33:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1352DB23;
 Thu, 23 Jan 2020 14:32:58 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAA271001DC0;
 Thu, 23 Jan 2020 14:32:57 +0000 (UTC)
Date: Thu, 23 Jan 2020 15:32:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH REPOST v3 13/80] arm/imx25_pdk: drop RAM size fixup
Message-ID: <20200123153256.43256f57@redhat.com>
In-Reply-To: <20200123123907.qa2fyg2iqlzyemmb@kamzik.brq.redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-14-git-send-email-imammedo@redhat.com>
 <20200123123907.qa2fyg2iqlzyemmb@kamzik.brq.redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: st08lnKqPNWdVtKyJyL_mw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 jcd@tribudubois.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 13:39:07 +0100
Andrew Jones <drjones@redhat.com> wrote:

> On Thu, Jan 23, 2020 at 12:37:38PM +0100, Igor Mammedov wrote:
> > If user provided non-sense RAM size, board will complain and
> > continue running with max RAM size supported.
> > Also RAM is going to be allocated by generic code, so it won't be
> > possible for board to fix things up for user.
> > 
> > Make it error message and exit to force user fix CLI,
> > instead of accepting non-sense CLI values.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: drjones@redhat.com
> > CC: jcd@tribudubois.net
> > CC: peter.maydell@linaro.org
> > CC: qemu-arm@nongnu.org
> > ---
> >  hw/arm/imx25_pdk.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> > index c76fc2b..a2b7b35 100644
> > --- a/hw/arm/imx25_pdk.c
> > +++ b/hw/arm/imx25_pdk.c
> > @@ -78,10 +78,10 @@ static void imx25_pdk_init(MachineState *machine)
> >  
> >      /* We need to initialize our memory */
> >      if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {
> > -        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
> > +        error_report("RAM size " RAM_ADDR_FMT " above max supported, "
> >                      "reduced to %x", machine->ram_size,
> >                      FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE);
> > -        machine->ram_size = FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE;
> > +        exit(EXIT_FAILURE);
> >      }
> >  
> >      memory_region_allocate_system_memory(&s->ram, NULL, "imx25.ram",
> > -- 
> > 2.7.4
> >  
> 
> This would break existing command lines that are happily using the max ram
> size, which is only 512 MB. Yes, those command lines are wrong, but I'm
> not sure we want to flip the warn to an error without machine type
> versioning - which this board doesn't have.

We typically don't do machine type versioning for CLI changes
and in this case it would be plain user error in providing
invalid CLI, so it should be fixed on user's side and not
worked around by QEMU.

It was fine before when board was allocating RAM on its own,
but with RAM initialization moved to generic code it won't be
possible. Hence fixup dropped and warning is converted to error
to let user know that their CLI should be fixed.
 
Board description [1] says that it supports up to 512Mb of RAM max.
1) https://www.nxp.com/design/development-boards/i.mx-evaluation-and-development-boards/i.mx25-product-development-kit:IMX25PDK


> Thanks,
> drew 


