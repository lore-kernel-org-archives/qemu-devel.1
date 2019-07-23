Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76447C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D99720828
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D99720828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprkg-0001DU-IT
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57548)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hprkW-0000ju-SK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hprkV-0002vb-Uo
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:10:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hprkV-0002v3-O7
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:10:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so17446722wrr.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yB3mKstzEJEuLVDJFU9tF6hvtRcSnhH6/oqzUxCWfeM=;
 b=tF10Rk57L32d4VTm2opUPeKs6NlB9edZmbtGa14EuKhTYW5K6XpveM0nTLevvu0mPs
 Ce3A7E9X31XTugD/OU3fJc77HmhuumDbehPb9ryEIGPnDObLQ8dG/ek0lZM/XbHr3CHE
 m2of27HTRjGCE38H2MbDfwy8p7LxhhDZcbfxKX65EuXGIQi/PcpqAliP4LV6yf90Y/4X
 e5GDL+RgLNQYnkB5e5fJm5DSYzohGWX5VCGrRp/jnsECqipcey+nBCASrHlsqPCrZ9eg
 1DFLLE5W0PmOXzioa7oscW6KPYicaSx87QR8DfZDXKspZ7bjAc/9xvnyKCjrIUw+pIuW
 nZ6w==
X-Gm-Message-State: APjAAAUe2PcwQHCDUJxVkFwcm4NvcB9U6x4x9e//hDyHWFRyBukrVxCU
 bzGjIgoG/4zi2VwSF0GdC5mnTg==
X-Google-Smtp-Source: APXvYqyzozKAcREDpSfm+MVIj48zOPts8sD2QbJrHvTXO9Zzwr/NliVN6MOJc96j7h3BPwfjRqwxFA==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr80137851wrs.105.1563876622763; 
 Tue, 23 Jul 2019 03:10:22 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id s25sm32171973wmc.21.2019.07.23.03.10.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:10:22 -0700 (PDT)
Date: Tue, 23 Jul 2019 12:10:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190723101019.3wkqqvp4qohybymj@steredhat>
References: <20190723090718.14590-1-sgarzare@redhat.com>
 <20190723090718.14590-2-sgarzare@redhat.com>
 <CAFEAcA_KspUxk75hR4YV444tj8-bQKOJ_4eq+aPD-idZ12Lzwg@mail.gmail.com>
 <20190723094241.7znxmk3wa6gti6tr@steredhat>
 <a4ec2c49-7b21-26bf-42a0-61427539d5d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ec2c49-7b21-26bf-42a0-61427539d5d2@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 1/2] elf-ops.h: Map into memory the ELF to
 load
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
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 11:49:13AM +0200, Paolo Bonzini wrote:
> On 23/07/19 11:42, Stefano Garzarella wrote:
> > "If writable is TRUE, the mapped buffer may be modified, otherwise it is an
> > error to modify the mapped buffer. Modifications to the buffer are not visible
> > to other processes mapping the same file, and are not written back to the file."
> > 
> > I don't know what "error" means, but reading the second part I thought
> > the changes in that case were only visible at the current process.
> 
> My reading would be that the second part applies to the writable==TRUE
> case.  In fact, the glib source code agrees:
> 
>       file->contents = (gchar *) mmap (NULL,  file->length,
>                            writable ? PROT_READ|PROT_WRITE : PROT_READ,
>                            MAP_PRIVATE, fd, 0);
> 
> meaning that we could after all just use writable == true.

Thanks for checking! I'll use writable == true in the v2!

Stefano


