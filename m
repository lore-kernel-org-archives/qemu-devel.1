Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDE6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7547420639
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR795hLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7547420639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k92LB-0004nK-PJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 04:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k92KZ-0004NP-G0
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:23:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35735
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k92KW-0004Ct-Rp
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597998198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ftbZ8kYiwnruCCORw9s9ztYB42W+aUZ53EkXmpblm5Y=;
 b=DR795hLMeXqNmS4+g6MFLLqhV68F9FWQD2QjaMbEQFZjv7td9/LTKxZdjqnSlqUDhhA9CJ
 fnLk8cxeKRnZQsuiwmCCCXCh9Ac0+P3rDFMe1CgF9x1Ve4PepxWlfmwmy6JCRB5Au/zDO6
 N//c0WZ3LM2CzcSP7sQNl6u4s/R/LCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-hbp0ed-PNnOeijAamMRufA-1; Fri, 21 Aug 2020 04:23:17 -0400
X-MC-Unique: hbp0ed-PNnOeijAamMRufA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8A831006706;
 Fri, 21 Aug 2020 08:23:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59F9F5C1D0;
 Fri, 21 Aug 2020 08:23:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 64C3297CF; Fri, 21 Aug 2020 10:23:14 +0200 (CEST)
Date: Fri, 21 Aug 2020 10:23:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Li Qiang <liq3ea@163.com>
Subject: Re: [PATCH] hw: cirrus_vga: mask 'off_begin' in
 cirrus_invalidate_region()
Message-ID: <20200821082314.fkd7bwv3x2jsakba@sirius.home.kraxel.org>
References: <20200820153228.85587-1-liq3ea@163.com>
MIME-Version: 1.0
In-Reply-To: <20200820153228.85587-1-liq3ea@163.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: alxndr@bu.edu, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> This patch fixes this.

> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -644,7 +644,7 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
>          off_cur_end = ((off_cur + bytesperline - 1) & s->cirrus_addr_mask) + 1;
>          assert(off_cur_end >= off_cur);
>          memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
> -        off_begin += off_pitch;
> +        off_begin = (off_begin + off_pitch) & s->cirrus_addr_mask;
>      }

Well.  Only in case the wraparound doesn't split a scanline ...

take care,
  Gerd


