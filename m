Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E9AC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BEA20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZvZvMmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BEA20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsxV-0007F0-37
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 13:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsw3-0005MM-OP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:22:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsw2-0001fK-3w
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599153725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yF9598OG2OefXX4+Z3MVHHJUJNZgD5AhRmjnDAwDB0c=;
 b=HZvZvMmUupQwifaUdpEksLRmGgflpMM1S8bi0hUDJ/Hqy8vrAOLjS75EZvgD4pbeVuo2y0
 m/Otx3zxvlCpNXbKfJni3/mDb18jNUMm3DzX2ExnSxUSthYTvP+vkDzlSv/amKGaF3Yqgz
 fHNvv94RSBj2FswNxQLC78vhE3EnLmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-yA6TtA16MwO-FMXP2XNVhQ-1; Thu, 03 Sep 2020 13:22:03 -0400
X-MC-Unique: yA6TtA16MwO-FMXP2XNVhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C3F6801FDB;
 Thu,  3 Sep 2020 17:22:02 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1203B7E400;
 Thu,  3 Sep 2020 17:22:01 +0000 (UTC)
Date: Thu, 3 Sep 2020 13:22:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 20/63] pc87312: Rename TYPE_PC87312_SUPERIO to TYPE_PC87312
Message-ID: <20200903172201.GQ4940@habkost.net>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-21-ehabkost@redhat.com>
 <2863f7ea-6fde-5a2e-b55f-e805f5db35be@amsat.org>
 <20200903161646.GG4940@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200903161646.GG4940@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 03, 2020 at 12:16:47PM -0400, Eduardo Habkost wrote:
> On Thu, Sep 03, 2020 at 02:45:12PM +0200, Philippe Mathieu-Daudé wrote:
> > On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> > > This will make the type name constant consistent with the name of
> > > the type checking macro.
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > > Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> > > Cc: qemu-ppc@nongnu.org
> > > Cc: qemu-devel@nongnu.org
> > > ---
> > >  include/hw/isa/pc87312.h | 4 ++--
> > >  hw/isa/pc87312.c         | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
> > > index a65168a157..da8dc5ddf5 100644
> > > --- a/include/hw/isa/pc87312.h
> > > +++ b/include/hw/isa/pc87312.h
> > > @@ -29,10 +29,10 @@
> > >  #include "qom/object.h"
> > >  
> > >  
> > > -#define TYPE_PC87312_SUPERIO "pc87312"
> > > +#define TYPE_PC87312 "pc87312"
> > 
> > We loose self-documentation. What is a TYPE_PC87312
> > when reviewing a board setup code? Should we add a
> > comment /* Create the Super I/O */? The current name
> > is self-describing...

I've just realized that TYPE_PC87312_SUPERIO is not used anywhere
in the code, so I don't understand where exactly this comment
applies.

> > 
> > Is it easier to rename the type as 'pc87312-superio'?
> 
> This is an option.  In that case, I would like to rename the
> PC87312 type checking macro to PC87312_SUPERIO, if that's OK.
> 
> The actual string name doesn't matter for the QOM macros, by the
> way.  We can still rename it if you want to, but we don't have
> to.

Based on Daniel's suggestion of keeping the macro names
consistent with the QOM type name string, I'd like to keep the
original color of the bike shed and keep this patch as is.

I will queue this patch on machine-next with Hervé's Reviewed-by
line.

If anybody wants to rename the user-visible QOM type name string
later, that's OK.  But I don't think this should be done as part
of the QOM boilerplate cleanup work.

-- 
Eduardo


