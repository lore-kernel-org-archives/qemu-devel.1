Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59565C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3081421871
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3081421871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZCJ-00078F-9Q
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqZC4-0006ZY-D5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqZC3-0002Dv-Ae
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:33:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqZC3-0002DZ-4l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:33:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so49743744wru.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 01:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hNDzLtnadekvczyA8QKBhLa/Xo9evwjj37/UY25la34=;
 b=M2TZCz9ubsRTljR9cJaq5iVsHPWneBpBU4teYg/VEatnLUhSm2Sbiqi7EREqLGffTP
 pB1c89WtajGZr+d5TFmkXnJqRwi1kmpv3pFeRtdkHJxiJPAASY6fsBfTWrL979uEZs/h
 ULH4a+qK8ljoVGH5sNRrcJjzYgTlxFwdVudEE5wVg7sxIHOKfU6Y7BMI5wRVUnVJOi0j
 C9kHALyj21GxvGiet9ZWwdRBfkYNw3r0Dh0oDwAP4mospUHQtfUEBorVBzcTuRPCu3P4
 n67v6tYJt4EdRagER/CNxAKB5FjZMFLxC0uSZuApzMYuUjJJXWwXgwrKk92THyqvx7XX
 BQTA==
X-Gm-Message-State: APjAAAW6hZfJW4o4Y7VC0d++hN+UhH/p2WSOIQ7la69dcKnesorpHRiX
 ELFZNVBACQJl9iVA5dpyISr64A==
X-Google-Smtp-Source: APXvYqwJ1OMDpUKHmEGLSs1Q0qbgtLKBm7VddhWHCbQ6esZPAIo0wIPP8ZmhJf7Dprfe+k5DCKZLsA==
X-Received: by 2002:adf:ed0e:: with SMTP id a14mr93822735wro.259.1564043622091; 
 Thu, 25 Jul 2019 01:33:42 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id c1sm105315106wrh.1.2019.07.25.01.33.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 01:33:41 -0700 (PDT)
Date: Thu, 25 Jul 2019 10:33:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Montes, Julio" <julio.montes@intel.com>
Message-ID: <20190725083339.rrfuo2dczoystp7q@steredhat>
References: <20190724143105.307042-1-sgarzare@redhat.com>
 <0d7d1ba8b4da6021c7e05ce736f38df1d012e9c6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7d1ba8b4da6021c7e05ce736f38df1d012e9c6.camel@intel.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v4 0/3] pc: mmap kernel (ELF image) and
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

On Wed, Jul 24, 2019 at 04:35:23PM +0000, Montes, Julio wrote:
> Hi Stefano
> 
> Here the results
> 
> https://pasteboard.co/Ipu3DO4.png
> https://pasteboard.co/Ipu3L69.png
> 
> boot time with initrd is a little bit better
> 

Thanks for sharing!

It is interesting that 'inkernel' time with initrd is almost twice the time of
nvdimm.


Stefano

