Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230AEC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF78C20828
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF78C20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprmQ-0003mJ-B5
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hprmG-0003Np-7v
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hprmF-00040g-8e
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:12:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hprmF-00040L-28
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:12:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so17452733wrr.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=L086TSA39GjKhmajjU0FtzCFcihLX97ronc1HUSQh+k=;
 b=nESdl4uJsQZ7idrL+xJLH16uMEPu3esfNd5qDq4/0b9eW4QcHLpZe2HNWtUHfA9U7E
 RSMyDKTA9WdSgnlC4yf5Z9Pu0eawMzmUSgkuNnF8r3vDFXeWFN+mwnJ0tpAt10USc/Sh
 FQZcFQMHBlOoECVpB/5E3LhmwI62GUPSq5/gIHdexLizvXxq4bymPb4khoqemre73NwN
 Rikcu5Ago0Q2H1JwUtQSr1b4F3EJjWiDtFnwoauGYgeVAo9z9vIV4xljf/IPgXXgjmQi
 /4Vghn9Q8ypxFPbDYy84gaB7deTHFHMUSo/IwE0OOyYDlZFFZ5JcwQNJHELpSlmyE1cj
 6VCQ==
X-Gm-Message-State: APjAAAXGc7Hcx0cCHo/tMSUfWsQAyE4hdMx6cQeEL02InUOeu/XVqyvm
 oFg8yeW8qDp/srf9sX3pHunRDg==
X-Google-Smtp-Source: APXvYqypH36PfaRxlcudHNcWwV/TpuP+kR4BS5bb9kO1E3dipUVnQEZubh9Qr+zwpWwHr5HpzCGhKQ==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr24744770wru.311.1563876730123; 
 Tue, 23 Jul 2019 03:12:10 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id t63sm35228335wmt.6.2019.07.23.03.12.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:12:09 -0700 (PDT)
Date: Tue, 23 Jul 2019 12:12:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190723101207.7hyrnvlw7ahbvinc@steredhat>
References: <20190723090718.14590-1-sgarzare@redhat.com>
 <20190723090718.14590-2-sgarzare@redhat.com>
 <CAFEAcA_KspUxk75hR4YV444tj8-bQKOJ_4eq+aPD-idZ12Lzwg@mail.gmail.com>
 <20190723094241.7znxmk3wa6gti6tr@steredhat>
 <CAFEAcA90Atw2KC-9zc5fM8oY8ikPDms1+UKtaj=YJcpq48PMSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA90Atw2KC-9zc5fM8oY8ikPDms1+UKtaj=YJcpq48PMSg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 10:50:24AM +0100, Peter Maydell wrote:
> On Tue, 23 Jul 2019 at 10:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
> > Reading the 'g_mapped_file_new_from_fd()' docs [1]:
> > "If writable is TRUE, the mapped buffer may be modified, otherwise it is an
> > error to modify the mapped buffer. Modifications to the buffer are not visible
> > to other processes mapping the same file, and are not written back to the file."
> >
> > I don't know what "error" means, but reading the second part I thought
> > the changes in that case were only visible at the current process.
> 
> Ah, I misread the docs here (and thought the following paragraph
> which talks about changes to the underlying file becoming visible
> to the mapping process was talking about changes in the mapping
> process becoming visible to the file).

I misread too...

> 
> So I think the answer is that we do want to pass writable=true.

Yes, I'll do in the v2!

> 
> Looking at the implementation, we always use mmap()'s MAP_PRIVATE,
> so we get a copy-on-write mapping that doesn't change the underlying
> file. The effect of the 'writable' flag is that we use PROT_READ|PROT_WRITE,
> so if we don't pass writable=true we're liable to get a segfault.

Yes, I just tried and I got the segfault.

Thanks,
Stefano

