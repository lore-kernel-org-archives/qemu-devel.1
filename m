Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7213C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21652070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/6SM1TO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21652070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mtR-0006WO-0i
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k0msG-0005dH-R2
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:16:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k0msF-0008IU-5S
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596032161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFlYn9tn9jzZBL+1B+PdrV3QGyq4zE9DGD8h5DXbYCE=;
 b=L/6SM1TOfvX2D9lJD4cAw5wtTOpc3JlHj+YUxVVQQV/L5a4bBAun2uardvDoe/MA1/hNxZ
 +zOhap5ASql1JPMnRvK3ph94CHJFIJo+09U19jNKiSi0IuwWDi0aUfdpPQJkUmHMJW2nfS
 xG5rArjnrfg4YzxJmWZFULycR3e0yCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-D4CxC4e0OhK6bcXdJ7KWTA-1; Wed, 29 Jul 2020 10:16:00 -0400
X-MC-Unique: D4CxC4e0OhK6bcXdJ7KWTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 191EC800472;
 Wed, 29 Jul 2020 14:15:58 +0000 (UTC)
Received: from localhost (unknown [10.40.208.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73B685F7D8;
 Wed, 29 Jul 2020 14:15:51 +0000 (UTC)
Date: Wed, 29 Jul 2020 16:15:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v5 2/2] hw: hyperv: vmbus: Fix 32bit compilation
Message-ID: <20200729161547.691f2396@redhat.com>
In-Reply-To: <CAHiYmc7oo3Vn1RaP+UiuQqJVS2OJXgoqyNPvbY+gAGjn_dD=8w@mail.gmail.com>
References: <20200715084326.678715-1-arilou@gmail.com>
 <20200715084326.678715-3-arilou@gmail.com>
 <CAHiYmc7oo3Vn1RaP+UiuQqJVS2OJXgoqyNPvbY+gAGjn_dD=8w@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
 Jon Doron <arilou@gmail.com>, mst@redhat.com,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rvkagan@yandex-team.ru" <rvkagan@yandex-team.ru>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 25 Jul 2020 14:16:08 +0200
Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> wrote:

> On Wednesday, July 15, 2020, Jon Doron <arilou@gmail.com> wrote:

Michael,

could you merge it via your tree please?

> 
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  hw/hyperv/vmbus.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> > index 34392e892a..c28bb4201b 100644
> > --- a/hw/hyperv/vmbus.c
> > +++ b/hw/hyperv/vmbus.c
> > @@ -383,7 +383,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void
> > *buf, uint32_t len)
> >              }
> >          }
> >
> > -        p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
> > off_in_page);
> > +        p = (void *)(uintptr_t)(((uintptr_t)iter->map &
> > TARGET_PAGE_MASK) |
> > +                off_in_page);
> >          if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
> >              memcpy(p, buf, cplen);
> >          } else {
> > --
> > 2.24.1
> >
> >
> >  
> Tested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> 
> It looks to me this patch should definitely be selected for 5.1.?


