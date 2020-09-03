Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2FDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D4320775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoAB6YA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D4320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsMT-0003WC-WA
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDsLu-0002uV-0H
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:44:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27949
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDsLq-0004s2-UY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599151481;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCfmzr7U2wIN10FzbOLEklFnpiEEao6OvrYx8ibo4ws=;
 b=IoAB6YA90sdFe728u+ivsoSwSq8+8Qtzu/jh6s6aa0EcWVMj/SbY849U+PeRaRiKHY3EJg
 xrsEL8oCYMxIp9gOzjbdcQi+giuPndW8XQhSGXbZ+95Nq6GVNJu2KR1OgqKaw/endR3m/u
 CTbZppr4jHLBNdQHHswisr1BnAKzQts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-GEnyYnNrNm2sdtKsflDfCg-1; Thu, 03 Sep 2020 12:44:39 -0400
X-MC-Unique: GEnyYnNrNm2sdtKsflDfCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7860A8030BA
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 16:44:38 +0000 (UTC)
Received: from redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07D965C1C2;
 Thu,  3 Sep 2020 16:44:31 +0000 (UTC)
Date: Thu, 3 Sep 2020 17:44:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 14/63] i8254: Rename TYPE_I8254 to TYPE_PIT
Message-ID: <20200903164429.GD441291@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-15-ehabkost@redhat.com>
 <9a2be0a5-1d7f-1813-5bdb-2c741f07c593@redhat.com>
 <20200903161809.GH4940@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200903161809.GH4940@habkost.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 12:18:09PM -0400, Eduardo Habkost wrote:
> On Thu, Sep 03, 2020 at 02:47:03PM +0200, Philippe Mathieu-DaudÃÂ© wrote:
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
> > >  include/hw/timer/i8254.h | 4 ++--
> > >  hw/timer/i8254.c         | 4 ++--
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
> > > index 1a522a2457..ddd925074f 100644
> > > --- a/include/hw/timer/i8254.h
> > > +++ b/include/hw/timer/i8254.h
> > > @@ -45,7 +45,7 @@ typedef struct PITCommonClass PITCommonClass;
> > >  DECLARE_OBJ_CHECKERS(PITCommonState, PITCommonClass,
> > >                       PIT_COMMON, TYPE_PIT_COMMON)
> > >  
> > > -#define TYPE_I8254 "isa-pit"
> > > +#define TYPE_PIT "isa-pit"
> > 
> > I disagree with this patch, as we have various PIT and only one I8254.
> 
> I was unsure about this, and I agree with your point.  I will
> suggest renaming the PIT macro to I8254 instead.

IMHO the macro name should be directly related to the object name
string with non-alnum characters replaced by underscore.

ie since the object type is "isa-pit", then the macro should be
TYPE_ISA_PIT

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


