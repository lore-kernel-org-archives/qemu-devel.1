Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A77C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1124206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmFqfwEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1124206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k81XQ-0006ae-0l
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 09:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k81Wr-00067f-1q
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:19:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45918
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k81Wp-0000hW-5Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597756790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eSPf+SRKW3phpi0IaY22ZHDL6ClXUk6rCx5TtjzAeks=;
 b=HmFqfwEaJ1bf2Pp55HC0IkfJXKHnhwZSsj5dFHicHg1i2pMumLxvLixadDPsYw+bzZrkmJ
 WzEJR/qs4VvdxPpSvclUqRjsiVZzhSZTAgL8HTQRRkXQ/ncutMysgLCSzQh9ciQaSLXJio
 zPO+mut2Jyne9LL3ZHYNLs+1QpbWFGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-Uz4UEzZiNZuO2BJZZc4Kmw-1; Tue, 18 Aug 2020 09:19:46 -0400
X-MC-Unique: Uz4UEzZiNZuO2BJZZc4Kmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73B9E80B71B;
 Tue, 18 Aug 2020 13:19:45 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 290815C64D;
 Tue, 18 Aug 2020 13:19:45 +0000 (UTC)
Date: Tue, 18 Aug 2020 09:19:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH 00/41] qom: Automated conversion of type checking
 boilerplate
Message-ID: <20200818131944.GK1700540@habkost.net>
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200818095903.GF98227@SPB-NB-133.local>
MIME-Version: 1.0
In-Reply-To: <20200818095903.GF98227@SPB-NB-133.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 12:59:03PM +0300, Roman Bolshakov wrote:
> On Thu, Aug 13, 2020 at 06:25:44PM -0400, Eduardo Habkost wrote:
> > This is an extension of the series previously submitted by
> > Daniel[1], including a script that will convert existing type
> > checker macros automatically.
> > 
> 
> Hi Eduardo,
> 
> do you have a repo where it can be checked it out?

Yes:
https://github.com/ehabkost/qemu-hacks/tree/work/qom-macros-autoconvert

-- 
Eduardo


