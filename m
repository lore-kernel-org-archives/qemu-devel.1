Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65604C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79AB221E7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aONrHGN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79AB221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxgt-0001or-Ni
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIxen-0000qm-BT
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIxei-0008Ob-Of
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600363511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiMqJyOAgc9k1O8hdbp9WPJC1wRY2KpiBiqi5B/E4yE=;
 b=aONrHGN7zhrlxqMmwdpw8346eKgrIhoyr6mzOP71oInPg7O3a4e4zJuGcwBFU7C+n7FqLX
 VhxAcz28XknVPSfaRpeSmEwcLnZ2pU9Th/fbLA+SxGvrDpFy4H5oMDfK+geJvimzeb31hL
 G0kadb6qBlnl6zmgjXh7zCKDK7XtncE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-rjuuK4ekPPCmAEloKglTLw-1; Thu, 17 Sep 2020 13:25:08 -0400
X-MC-Unique: rjuuK4ekPPCmAEloKglTLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056281084C84;
 Thu, 17 Sep 2020 17:25:07 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 224DB73664;
 Thu, 17 Sep 2020 17:25:02 +0000 (UTC)
Date: Thu, 17 Sep 2020 13:25:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 2/2] qom: Use DECLARE_INTERFACE_CHECKER macro
Message-ID: <20200917172501.GR7594@habkost.net>
References: <20200917024947.707586-1-ehabkost@redhat.com>
 <20200917024947.707586-3-ehabkost@redhat.com>
 <e77ca535-4f70-98ce-c49f-f5f2fa4c6150@kaod.org>
MIME-Version: 1.0
In-Reply-To: <e77ca535-4f70-98ce-c49f-f5f2fa4c6150@kaod.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 09:38:02AM +0200, Cédric Le Goater wrote:
> On 9/17/20 4:49 AM, Eduardo Habkost wrote:
> > Mechanical search/replace to use the new
> > DECLARE_INTERFACE_CHECKER macro instead of manually defining
> > macros using INTERFACE_CHECK.
> > 
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > This is an alternative to the patches submitted at
> > https://lore.kernel.org/qemu-devel/20200916193101.511600-3-ehabkost@redhat.com/
> > https://lore.kernel.org/qemu-devel/20200916193101.511600-4-ehabkost@redhat.com/
> > ---
> > Changes v1 -> v2:
> > * Build fix: move declarations after typedef
> 
> Would it be possible to move the typedef in the DECLARE_INTERFACE_CHECKER 
> macro ? 

The typedef will be moved later to a OBJECT_DECLARE_INTERFACE
macro, to follow the same pattern as
DECLARE_INTERFACE_CHECKER/OBJECT_DECLARE_TYPE.

-- 
Eduardo


