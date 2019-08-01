Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788DEC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495F02084C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495F02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htH2Y-0002my-KM
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47358)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1htH1B-0001oN-5E
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1htH1A-0000O4-9x
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:45:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1htH19-0000Np-WF
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:45:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so71537192qto.4
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 12:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VKnplRngoTlR91qbpYCLVAS8osQ8tyHffm1YM0UxXE4=;
 b=iA/E1fnCxfh10oj2DOBq+V6xX4S+Jdz/a/b+jTou9NHtzd3HeEa02wmr4BrDKTQqDM
 oPjp5067aM3t8BcK/Xito8lUTy1rRlnw7VhfaEj4cIFyU+hSKDDzHIbZVjawdMSP/uZo
 RsoKoc8zPbrXVHV+MTa3jPqpNUVBwNDYzSMwK3lViolY6PXro+hEPuIfMveSRznyWzZW
 D4w8m8+5Mbt+1qsgavyh3JLP15J2Q8s+CkSxtEcf3Om7FxZRqVxDqPH+aHJZ6Uxzxuf6
 5eLoIMrAabDNsOUKTM7vZeOb7bqptuRgvfCOP+VH6WY036HVlPVMvUdjm2sqkoPa9cfV
 iShA==
X-Gm-Message-State: APjAAAX78iybLM/NLl9mbEZfeBozJTur8/63iQxOFPfPB8ncRRjOupFf
 1YlKRx8hfnF4Ai8A90B9wLLZHA==
X-Google-Smtp-Source: APXvYqxQXUfGZVUZdTWvCPADg627PRN0A2Xq/oFqIIuky0aPbjIfdaO3ONkuyfL5IEpcBlMLzpnNlg==
X-Received: by 2002:ac8:6c59:: with SMTP id z25mr96776853qtu.43.1564688739477; 
 Thu, 01 Aug 2019 12:45:39 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 c45sm37177726qte.70.2019.08.01.12.45.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 12:45:38 -0700 (PDT)
Date: Thu, 1 Aug 2019 15:45:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190801154456-mutt-send-email-mst@kernel.org>
References: <20190729125755.45008-1-slp@redhat.com>
 <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
 <9953cc99-80b3-814c-f75e-a16c987c23e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9953cc99-80b3-814c-f75e-a16c987c23e5@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez Pascual <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 01, 2019 at 01:58:35AM +0200, Paolo Bonzini wrote:
> On 30/07/19 18:06, Laszlo Ersek wrote:
> > On 07/29/19 14:57, Sergio Lopez wrote:
> >> Implement the modern (v2) personality, according to the VirtIO 1.0
> >> specification.
> >>
> >> Support for v2 among guests is not as widespread as it'd be
> >> desirable. While the Linux driver has had it for a while, support is
> >> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.
> > 
> > That's right; not only are there no plans to implement virtio-mmio/1.0
> > for OVMF (to my knowledge), I'd even argue against such efforts.
> > 
> > OVMF is a heavy-weight guest firmware, which I see entirely out of scope
> > for "micro VMs". And so virtio-mmio/1.0 would seem like a needless &
> > unwelcome complication, from the OVMF maintainership perspective.
> 
> But given that, why not rip out virtio-mmio completely?
> 
> Paolo

From OVMF?


-- 
MST

