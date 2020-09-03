Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7848C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1E720578
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V06lR6up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1E720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsDd-0008Kp-RI
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDruv-0004m5-EU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:16:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31940
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDrut-0000rh-3r
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599149810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xk/k+a0JrnT/sfqhOU7JVN/uTTbpZzpNspBQJyGENig=;
 b=V06lR6upFafzulwnaQmyeTcPzzD0se+ugu3XV/2cWE2yR0q3FX9DPU2ePgBvyrSu5sjZnu
 IjRTjvVWUCVmxr0+v3ArnpyTKQFdoIWexM0q2XXzgdprYCpZxP5IalTGY0aPF/8EO7dySd
 x5IKTbmN90btHltXWSaHpxYLgZ7fp50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-qyty5IZIPy27PZokcTMFNQ-1; Thu, 03 Sep 2020 12:16:48 -0400
X-MC-Unique: qyty5IZIPy27PZokcTMFNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82FDF801AEA;
 Thu,  3 Sep 2020 16:16:47 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4043610013D9;
 Thu,  3 Sep 2020 16:16:47 +0000 (UTC)
Date: Thu, 3 Sep 2020 12:16:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 20/63] pc87312: Rename TYPE_PC87312_SUPERIO to TYPE_PC87312
Message-ID: <20200903161646.GG4940@habkost.net>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-21-ehabkost@redhat.com>
 <2863f7ea-6fde-5a2e-b55f-e805f5db35be@amsat.org>
MIME-Version: 1.0
In-Reply-To: <2863f7ea-6fde-5a2e-b55f-e805f5db35be@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 berrange@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 02:45:12PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> > This will make the type name constant consistent with the name of
> > the type checking macro.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> > Cc: qemu-ppc@nongnu.org
> > Cc: qemu-devel@nongnu.org
> > ---
> >  include/hw/isa/pc87312.h | 4 ++--
> >  hw/isa/pc87312.c         | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
> > index a65168a157..da8dc5ddf5 100644
> > --- a/include/hw/isa/pc87312.h
> > +++ b/include/hw/isa/pc87312.h
> > @@ -29,10 +29,10 @@
> >  #include "qom/object.h"
> >  
> >  
> > -#define TYPE_PC87312_SUPERIO "pc87312"
> > +#define TYPE_PC87312 "pc87312"
> 
> We loose self-documentation. What is a TYPE_PC87312
> when reviewing a board setup code? Should we add a
> comment /* Create the Super I/O */? The current name
> is self-describing...
> 
> Is it easier to rename the type as 'pc87312-superio'?

This is an option.  In that case, I would like to rename the
PC87312 type checking macro to PC87312_SUPERIO, if that's OK.

The actual string name doesn't matter for the QOM macros, by the
way.  We can still rename it if you want to, but we don't have
to.

-- 
Eduardo


