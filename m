Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBE7C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1386F21738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1386F21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpw4t-0003gZ-V9
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 10:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hpw4h-0003Hl-9i
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hpw4f-0001uN-OM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:47:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hpw4f-0001tQ-Ig
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:47:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so38846207wmj.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 07:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CqArpVbhNxwm8C31oYZRNauA+++Px+SY2wJ9VZ0eL6E=;
 b=VMCFzV3poTfaulYJqpbjrXdXyw2ysdferaAMRdbBgmG8UdP9ZqIolEp9y2zOGpO53I
 xI70Q605VYC6eTuDes7nbyEdjwDUVCUDcYnbbvnbNMo4KR9WLKhNiok/6kxJOH+gJoHz
 Tpoi6aOHlpivYpnMX/iB2ml4fwLYmvMupdN9vyxoSOvM4C9rwss+zLMMDHZuZKPeZArb
 E0pTNWZsuugUW4+Sa0S4IXZgqCapTdUwSTiNzQ3/w9k+Y9KUiYhExTF2SS+CvT6Lm1wt
 MXOBN1vrhDyoCG/IkeETZ1jvRDZIaVnIU+ppGDuhcPbPdCEFID/pyLYsPX5ZBtw4pwel
 Of7w==
X-Gm-Message-State: APjAAAVBoBteEfLnS9f1B2DN70XrkTwC1N545ULPj8H0B2GNCZeVFcPG
 lSwRVNpEllWT0XoEps9jAeQKiw==
X-Google-Smtp-Source: APXvYqzljdKPIYb8g+7OTNravrSSg9ZYvbdz5cQ3tsdmv1f5li7jmgfi2FeqfMwBuglB6u274Uu36A==
X-Received: by 2002:a05:600c:2c7:: with SMTP id
 7mr63041622wmn.45.1563893248468; 
 Tue, 23 Jul 2019 07:47:28 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id w7sm50413648wrn.11.2019.07.23.07.47.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 07:47:28 -0700 (PDT)
Date: Tue, 23 Jul 2019 16:47:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190723144725.hajnj7ibumnj3kqn@steredhat>
References: <20190723140445.12748-1-sgarzare@redhat.com>
 <20190723140445.12748-3-sgarzare@redhat.com>
 <a19c6de9-654e-f57f-987f-bae41d9050d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a19c6de9-654e-f57f-987f-bae41d9050d2@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/i386/pc: Map into memory the
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 04:30:17PM +0200, Paolo Bonzini wrote:
> On 23/07/19 16:04, Stefano Garzarella wrote:
> > In order to reduce the memory footprint we map into memory
> > the initrd using g_mapped_file_new() instead of reading it.
> > In this way we can share the initrd pages between multiple
> > instances of QEMU.
> > 
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Coverity is going to complain about the leaks.  Should we instead store
> the initrd GMappedFile in PCMachineState, even if it is just for reference?
> 

Yes, I'll put it in the PCMachineState.

Thanks,
Stefano

