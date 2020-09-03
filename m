Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DA9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8E120716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMZN9+P/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8E120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsNZ-0004Wl-LV
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDsMd-0003qc-LR
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDsMb-00059n-Bn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599151528;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wfw2oE1gKmYvMEpB67vO2QFg5BET11+mr5a1XZGPALM=;
 b=eMZN9+P/zgA1QLHbELh+FzSG3SjaIQKcmUFGOPVXF8PJeEa4pQxfZXz0TVfSRb45A3LIAE
 CsuAiGXu3n3F8cQr02w0Cd9AjfgOPRc0ObCsgkDuVikSNrQv69H2FT2qmT7n4h2U9VOfsg
 sT9ZoWbnaQ5DS2dHWrWrgTWwbUbqGYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-LEVSSat6PO6d5_PR9oxCTg-1; Thu, 03 Sep 2020 12:45:26 -0400
X-MC-Unique: LEVSSat6PO6d5_PR9oxCTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52060100670B
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 16:45:25 +0000 (UTC)
Received: from redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AA0578B38;
 Thu,  3 Sep 2020 16:45:21 +0000 (UTC)
Date: Thu, 3 Sep 2020 17:45:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 15/63] i8259: Rename TYPE_I8259 to TYPE_PIC
Message-ID: <20200903164518.GE441291@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-16-ehabkost@redhat.com>
 <bb2d291d-158f-0e79-e384-f6d011b4922e@redhat.com>
 <20200903161946.GI4940@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200903161946.GI4940@habkost.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 12:19:46PM -0400, Eduardo Habkost wrote:
> On Thu, Sep 03, 2020 at 02:47:33PM +0200, Philippe Mathieu-Daudé wrote:
> > On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> > > This will make the type name constant consistent with the name of
> > > the type checking macro.
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: qemu-devel@nongnu.org
> > > ---
> > >  hw/intc/i8259.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> > > index 344fd04db1..e536cc90be 100644
> > > --- a/hw/intc/i8259.c
> > > +++ b/hw/intc/i8259.c
> > > @@ -37,10 +37,10 @@
> > >  
> > >  //#define DEBUG_IRQ_LATENCY
> > >  
> > > -#define TYPE_I8259 "isa-i8259"
> > > +#define TYPE_PIC "isa-i8259"
> > 
> > I disagree with this patch, as we have various PIC and only one I8259.
> 
> Like in the I8254 case, I agree with your point.  I will suggest
> renaming the PIC macro to I8259 instead.

I'd suggest it should be TYPE_ISA_I8259  to match the object type name
string.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


