Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63A2C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6786B21534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ1ma+hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6786B21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrcq-0003nn-D1
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kUrNf-0007pe-Ms
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kUrNc-0006Dg-US
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603199322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XVK1MAdhpy7fGwtv3k8eoU66vd8qbMmO5kgnakUq/SY=;
 b=IZ1ma+hbv+9ZCOhmBQY8iAqrBYMRIziAxTXD2QP9Rk7N6ZHV/v34E7/5CPEfqqtlpWYdLw
 dFL5FgltssNgBHcfrb8C9uWTlGjaW4A47gNcXOP8PFjv68F/xmu6tKtvXU5t7fOgsq/BaY
 yYOfDkbx1kGnF2MdhEENFdpiCpl5AQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-4_h4OPBzPUusMhFlxg7J-A-1; Tue, 20 Oct 2020 09:08:41 -0400
X-MC-Unique: 4_h4OPBzPUusMhFlxg7J-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB10E18C520C;
 Tue, 20 Oct 2020 13:08:39 +0000 (UTC)
Received: from kaapi (ovpn-112-157.phx2.redhat.com [10.3.112.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E92066CE4D;
 Tue, 20 Oct 2020 13:08:22 +0000 (UTC)
Date: Tue, 20 Oct 2020 18:38:20 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] ati: mask x y display parameter values
In-Reply-To: <d43d9494-72c3-eb52-4588-d324f2857c45@eik.bme.hu>
Message-ID: <nycvar.YSQ.7.78.906.2010201810120.1506567@xnncv>
References: <20201018120852.1415440-1-ppandit@redhat.com>
 <607d183b-8885-583f-de2a-ee693e641a50@eik.bme.hu>
 <nycvar.YSQ.7.78.906.2010191056550.1472930@xnncv>
 <1e94cbca-121f-52f2-b1e3-6d2fdb59ee42@eik.bme.hu>
 <nycvar.YSQ.7.78.906.2010201220140.1506567@xnncv>
 <d43d9494-72c3-eb52-4588-d324f2857c45@eik.bme.hu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: Gaoning Pan <pgn@zju.edu.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 20 Oct 2020, BALATON Zoltan wrote --+
| The card has 32 bit registers with values in them interpreted differently for
| different regs. For dst_x|y lower 14 bits can be set and value should be
| interpreted as -8192:8191 according to docs. I've got this wrong because all
| guests I've tried did not actually use negative values. The Solaris driver I
| was recently shown not to work may use that so I plan to look at it and fix it
| when I'll have time. 
... 
| Docs aren't very clear on that but I think these cannot be negative so 
| 0:8191 is valid range because it mentions that also bits 0-13 (or maybe 
| 0-15, the docs have a lot of copy&paste errors) are valid but only 0-12 are 
| used for rectangles, 13-15 used only for trapezoids (which we don't 
| emulate). The docs are really bad so we have to guess and see what guest 
| drivers do most of the time.

* I see. Are the docs available/accessible online?

| >  dst_y(=4294950914(=-16382)) + s->regs.dst_height(=16383)) overflows to => 1
| > Ie. (dst_bits + dst_x(=0) + (1) * dst_stride >= end) returns false.
| 
| So maybe we should cast something (like dst_stride) to uint64_t here to
| promote everything to 64 bit and prevent it overflowing which then should
| catch this as well?
... 
| > +    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
| > +        || dst_bits + dst_x + (dst_y + s->regs.dst_height)
| > +         * dst_stride >= end) {
| > ...
| > +        if (src_x > 0x3fff || src_y > 0x3ff || src_bits >= end
| > +            || src_bits + src_x + (src_y + s->regs.dst_height)
| > +             * src_stride >= end) {
| >             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
| 
| I can live with that until I have a chance to rewrite it but are you sure this
| will catch all possible overflows with all vram sizes that can be set with
| vgamem_mb property?

* Considering all fields are 'uint32_t' type; And majority of the values 
  s->regs.[src|dst]_[xy], s->regs.dst_height are masked with '0x3fff', it 
  should help to avoid overflows.

* Not sure about all vram sizes. What are possible/supported size options?

* Between casting expression to 64 bits & explicit src_[xy] > 0x3fff check, 
  I'd go with explicit check, as it's easy to follow.

  Will send a revised patch with src_[xy] > 0x3fff if it's okay with you.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


