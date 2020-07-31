Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7347C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836B921744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApY+I6ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836B921744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1bs7-0006Fx-Q8
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 16:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1brM-0005j0-Ii
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 16:42:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20346
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1brK-0006L7-Dr
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 16:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596228148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UESLcMXNNYX8BjZd7vrqMNyETHH3fBLnnwqiaMWQcl4=;
 b=ApY+I6okGyDq0ZhIcxLnKA/dHxVblDn5Tlo1sLN3rbb3QJ9HglLihdAWDz/ZVXz3V9xD9q
 Ndx171z8qhUdnCC/id1xrjrZmEzszKEE1O1sluN3p1nSCfXfI2Cl3ihJowxcBBbElnHyxr
 ayRZj5DiZaAhXmOXwuce6Y3nKHs7Odg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-xHZRB3I2PE6GIc6vyQ1jVA-1; Fri, 31 Jul 2020 16:42:24 -0400
X-MC-Unique: xHZRB3I2PE6GIc6vyQ1jVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90C2A101C8A0;
 Fri, 31 Jul 2020 20:42:23 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F62D6FEEB;
 Fri, 31 Jul 2020 20:42:20 +0000 (UTC)
Date: Fri, 31 Jul 2020 16:42:19 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/i386/vmport: Drop superfluous parenthesis around
 function typedef
Message-ID: <20200731204219.GK225270@habkost.net>
References: <20200505142836.16903-1-philmd@redhat.com>
 <303faba8-851f-a0da-4df3-0d57ffd1ff14@redhat.com>
MIME-Version: 1.0
In-Reply-To: <303faba8-851f-a0da-4df3-0d57ffd1ff14@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 08:55:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 03, 2020 at 07:04:26AM +0200, Philippe Mathieu-Daudé wrote:
> On 5/5/20 4:28 PM, Philippe Mathieu-Daudé wrote:
> > Drop superfluous parenthesis around VMPortReadFunc typedef
> > (added in d67f679d99, missed to remove when moved in e595112985).
> > 
> > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > ---
> >  hw/i386/vmport.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/vmport.h b/hw/i386/vmport.h
> > index 47eda7a22b..a6624e3045 100644
> > --- a/hw/i386/vmport.h
> > +++ b/hw/i386/vmport.h
> > @@ -27,7 +27,7 @@
> >  
> >  #define TYPE_VMPORT "vmport"
> >  
> > -typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
> > +typedef uint32_t VMPortReadFunc(void *opaque, uint32_t address);
> >  
> >  void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
> >  
> > 
> 
> ping?

Queued for 5.2.  Sorry for missing it.

-- 
Eduardo


