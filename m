Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631B5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BA621D41
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7W/rYVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BA621D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQzxF-0004MF-Qk
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 17:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQzwd-0003w2-Bj
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQzwY-0000DV-Ar
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602278929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXLSopzOuojFS7JcEUXKl6doxyNX2omgQmCFz6CmmQQ=;
 b=d7W/rYVCsLSE9LK7O7IFBIAYD2XM1i3htimR36DMGd/3Jc6k/OHM2QZyDE8r98lNAsF3OQ
 tGySr9sualKwsZ57LLSzevKuPceJAPqkURsoDEh+bkL8yws2Fp4H0NEdHMs8pfth50hs62
 n4n1LaVsuTP6pRv0YSUyfFC1zu6UFBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-tFqJ9U3CPAe6J0ovj7I_yQ-1; Fri, 09 Oct 2020 17:28:47 -0400
X-MC-Unique: tFqJ9U3CPAe6J0ovj7I_yQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55E448064BA;
 Fri,  9 Oct 2020 21:28:46 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83E4A5D9F3;
 Fri,  9 Oct 2020 21:28:45 +0000 (UTC)
Date: Fri, 9 Oct 2020 17:28:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: Who uses TYPE_VMBUS_DEVICE?
Message-ID: <20201009212844.GH7303@habkost.net>
References: <20201009193919.GF7303@habkost.net>
 <5039480a-690a-314d-cab0-ca230a012990@maciej.szmigiero.name>
MIME-Version: 1.0
In-Reply-To: <5039480a-690a-314d-cab0-ca230a012990@maciej.szmigiero.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org,
 Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 11:05:31PM +0200, Maciej S. Szmigiero wrote:
> Hi Eduardo,
> 
> On 09.10.2020 21:39, Eduardo Habkost wrote:
> > Hi,
> > 
> > I've just stumbled upon hw/hyperv/vmbus.c and I'm a bit confused:
> > I haven't found any subclasses of the abstract type
> > TYPE_VMBUS_DEVICE in the QEMU tree.
> > 
> > I see a few patches in qemu-devel implementing a few vmbus
> > devices, but none were merged to qemu.git master.  Are there any
> > short term plans to merge vmbus device implementations in QEMU?
> > 
> 
> Perhaps this depends on your definition of "short term".
> At least one VMBus driver (hv-balloon) is being actively worked on
> (by me).

Good to know, thanks!

> 
> Also, a working VMBus implementation (even without any downstream
> devices) is apparently required for high-performance Windows
> kernel debugging interfaces.

Other code might be required, but TYPE_VMBUS_DEVICE seems to be
dead code (which can't be executed or tested at all) unless a
concrete class exists.

-- 
Eduardo


