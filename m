Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0104E2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ktsdaFbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0104E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBrD-0003Pn-A0
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:33:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hHBZ6-0005Yq-N2
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hHBZ5-000131-Hm
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:15:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hHBZ5-00011w-3u
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:15:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id f10so2474782otb.6
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=cNvcYTnY3+vvHUTxTkoLoLivaNOP88tmLELkxGdG9NU=;
	b=ktsdaFbHHTTd3R9uOez0tgfH91piu1Xl5DlUQg9AdDFLkPBDJI5BaCJt8wdik0yC9L
	dH1VUAIEKpMOG3eMgmYm1jbHjjxODglk6p70vY9qXowThleT7Q0gQUDAJS9MA3j7Y9lF
	v8ZxpajT9Rk0mPmn47Onvt24QMYIumY0g4+EJAIXZlXQcKxDlrzTO/b2iH+eG5vkZQVH
	ouopY1EtaMEeFiq04GySGtlZKge2N6IsV7o1pM7Je/rREB1BqCRPzbORKPO8w/0MElm/
	Opf6d01RSEY9uEf/J9C9GZzgTb2wZrkTq4GMtT+Dl+3EhN2pMqMJwWjbjUxgrKq+DhMm
	CmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=cNvcYTnY3+vvHUTxTkoLoLivaNOP88tmLELkxGdG9NU=;
	b=B5v6R6sHOEOjuSD6lxKlXLsKjKyguxfcJFANJbAq0EB5sD3YHFBt4//rt7rJHAqSl5
	0ghE5DlAROpUFjpf7RPLVMnEG69yX5D7qY5se+ItqQFZXaYO7moE2WdrEAlKz8GYq2eK
	Zn3s9cX04U/9vSpoqMQsvfleWfRDVUrJ7YRgRL1VKgOZOU8ssATiTe5COPW1JGRQ6ejo
	PZuEB4+cybRbBXjB4rtxUTcsVOgn6AZveTW1D9viMGLcanLlPhdTrSwyw2pBo79iM0JP
	YfZtRXrCI0/rVzSj/lkODtzUbPubweDFjt1sHgoLAi4ZdQWKD8OIvxmiuYGbVzpyPlo0
	rBmw==
X-Gm-Message-State: APjAAAVVK9UbtzGr6dh0wuJQTiVdCiyENFvSo9C/bc8wDEQks6fCcga/
	1kQ1IkmdYZ34bzl5gaIrQBfYNOjh6VPXjKThIlk2fg==
X-Google-Smtp-Source: APXvYqw+Y0/Df9bqsKP+vBWmJnbCdRcBlSHVgj/brP9uo3QhMkPjrQhjEhP/44UfrxTt+scRqmIZz03SqgCzRGRlQNI=
X-Received: by 2002:a05:6830:15d4:: with SMTP id
	j20mr4679415otr.367.1555611312059; 
	Thu, 18 Apr 2019 11:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<20190412083230.GA29850@quack2.suse.cz>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
	<20190418161833.GA22970@infradead.org>
In-Reply-To: <20190418161833.GA22970@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Apr 2019 11:14:59 -0700
Message-ID:
 <CAPcyv4jPOF_+R6U17J_+88+X8LC-LSPCugA6gbKxuphuuFB2gg@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v5 1/6] libnvdimm: nd_region flush callback
 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Pankaj Gupta <pagupta@redhat.com>, cohuck@redhat.com,
	Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	virtualization@lists.linux-foundation.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, kilobyte@angband.pl,
	Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418181459.5JezRXLo3LIcKXj6SWKlsaxR0Qtt_jIXHbAruXl69Fc@z>

On Thu, Apr 18, 2019 at 9:18 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
> > > > I'd either add a comment about avoiding retpoline overhead here or just
> > > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
> > > > get confused by the code.
> > >
> > > Isn't this premature optimization?  I really don't like adding things
> > > like this without some numbers to show it's worth it.
> >
> > I don't think it's premature given this optimization technique is
> > already being deployed elsewhere, see:
> >
> > https://lwn.net/Articles/774347/
>
> For one this one was backed by numbers, and second after feedback
> from Linux we switched to the NULL pointer check instead.

Ok I should have noticed the switch to NULL pointer check. However,
the question still stands do we want everyone to run numbers to
justify this optimization, or make it a new common kernel coding
practice to do:

    if (!object->op)
        generic_op(object);
    else
        object->op(object);

...in hot paths? I agree with not doing premature optimization in
principle, but this hack is minimally intrusive from a readability
perspective similar to likely()/unlikely() usage which also don't come
with numbers on a per patch basis.

