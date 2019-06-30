Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD8AC5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 21:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DF22089F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 21:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DF22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhhWg-0002dH-DU
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 17:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44822)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hhhVt-000237-4t
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 17:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hhhVr-0007rw-M3
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 17:37:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hhhVp-0007oi-Py
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 17:37:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so12579600qtr.12
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 14:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tSOfPHB6P++JKfQpvOi+kFA7vxbzojZURtvOS+6FsgE=;
 b=a/lUhZJINsyj56HhCXL0NzQupOQjqBG6rxhSbLZN8flWjrHOV0iAQFSN7FaGNPvF7V
 nTCzus5kJ8fCe7Y7b8kvKRJr9NAGtbFey78XNFuGl76fodd7+7bqtPMhktXehPAZAy5q
 yVOFjSa6sRj8+6ThfvDxU2xpSlVN4ReOdm/uGbXkV/nABMuY/s6/r60IlYEo825uzfJa
 pqJgjP7D+YVPe2+jYReeiZz9X2WPQbbzXmMCrfePCU8S5mzvEvMfbKsP1uqlNRw0AwpF
 L/c2Jcp5x+BgroTBDXS+4w4Ppgq+9BQ8+/0NDxQBOuviHdkjkd1nVWMCyIIa6o/w4Jpn
 4k2w==
X-Gm-Message-State: APjAAAWeS6ZKEF3EQLtOrgBAoq547q0mLKPs25gGHMGKlWa3C8fvbgOm
 7qyMOfk//pKeWhdlvEbdPMRgvQ==
X-Google-Smtp-Source: APXvYqztsAcmB38GwC/5J0o5BgEhcXTtE/xp6bNdwW8SfoOxCNMCXLnJWijLIHSSKSPyvIn6CpPOwQ==
X-Received: by 2002:ac8:2971:: with SMTP id z46mr17262911qtz.322.1561930648756; 
 Sun, 30 Jun 2019 14:37:28 -0700 (PDT)
Received: from redhat.com ([37.26.146.159])
 by smtp.gmail.com with ESMTPSA id l6sm3735618qkc.89.2019.06.30.14.37.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 14:37:27 -0700 (PDT)
Date: Sun, 30 Jun 2019 17:37:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190630173704-mutt-send-email-mst@kernel.org>
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-5-slp@redhat.com>
 <20190628100458-mutt-send-email-mst@kernel.org>
 <e2268d2c-6fcb-2567-1993-4b5b65c949dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2268d2c-6fcb-2567-1993-4b5b65c949dd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/i386: Introduce the microvm machine
 type
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 29, 2019 at 12:17:22AM +0200, Paolo Bonzini wrote:
> On 28/06/19 16:06, Michael S. Tsirkin wrote:
> >> +    assert(kvm_irqchip_in_kernel());
> > Hmm - irqchip in kernel actually increases the attack surface,
> > does it not? Or at least, the severity of the attacks.
> 
> Yeah, we should at least support split irqchip.  But, irqchip completely
> in userspace is slow when it is not broken, and it does not support
> APICv.  So it's not really feasible.
> 
> Paolo

Right, I meant split.

-- 
MST

