Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF2FC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3048D2190F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3048D2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqBpx-00054Y-22
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 03:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqBpf-000463-Ag
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqBpe-0002Tb-BB
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:37:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqBpe-0002TF-4T
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:37:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so45727540wrt.6
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 00:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Tb8RlXXFbf+R/GDazYYkzD3SaZnIu6persnOJj7gyKY=;
 b=XjqEVvTk7YFUzbXzbcIzz0JRaUDpvFbUChqF4rNItprf8cc2DktSuY1/6r7J6LwTtF
 QBH8SFzFEDKH08JzYlNiRmb55YeZ30EVs1AuVF4G0EJ5RzbpXvecq4VGXUoziWqG2fPx
 Ax1Jynyhbh6OlNaNDipPeJuB94mSXoSXFUkThZBFYwtyCoC6VXF/93pC8RlOxRI33KiJ
 kUDU/a45iqdt3H+AUr0QzYeKHp6w36dGgAs0FZxMB2V5kAtaOJ/ktgmn50h3SR12a9YD
 vdF6asuewXPjxUbUoouPjWostiLVq1ddoecC1PALYbW7qrNzdOTwiySOjTd2BUPHd8U1
 ptcg==
X-Gm-Message-State: APjAAAXma3yJ9tunZXjB4HDVGIe5c50x8vaBZDLtE9NK86P+kZnyqzs9
 C8fRn6ki3TMYAwaPdil7qRSMlw==
X-Google-Smtp-Source: APXvYqw0fBaJ/NQIsH6bnq8VP4RtgxPBPW7+jvFH8fmk5yR7JWJuJ7O/p1eZAv8kjaDe5QSzDnLXAg==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr85136797wru.195.1563953821043; 
 Wed, 24 Jul 2019 00:37:01 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id o7sm17605893wru.58.2019.07.24.00.36.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 00:37:00 -0700 (PDT)
Date: Wed, 24 Jul 2019 09:36:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Montes, Julio" <julio.montes@intel.com>
Message-ID: <20190724073657.ldisme6i4u55axga@steredhat>
References: <20190723140445.12748-1-sgarzare@redhat.com>
 <4d2967a1637b3ab93ff79fa016fd4a42f5638204.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d2967a1637b3ab93ff79fa016fd4a42f5638204.camel@intel.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 0/2] pc: mmap kernel (ELF image) and
 initrd
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "slp@redhat.com" <slp@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 05:37:18PM +0000, Montes, Julio wrote:
> Stefano, Brilliant job!
> 
> I can confirm that with these patches the memory footprint is smaller
> and the boot time is the same for kata
> 
> Here the results using kata metrics
> 
> https://pasteboard.co/Ipl06Q0.png
> https://pasteboard.co/Ipl3p4d.png
> 

Hi Julio,
thank you very much for testing :)

When you measure the PPS, how many QEMU instances did you start?
Did you use also the initrd?

Thanks,
Stefano

