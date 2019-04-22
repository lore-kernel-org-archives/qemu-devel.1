Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260B6C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5613218B0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MZnMJSvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5613218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIesi-00039l-3I
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 15:45:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hIeru-0002nz-Go
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hIers-0004hS-S0
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:44:46 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hIero-0004bk-RV
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:44:44 -0400
Received: by mail-oi1-x241.google.com with SMTP id v10so9389108oib.1
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=be6f2f0XIlqFU7RHgEDNHdFLaZKAoDs5ON2xf3GreVs=;
	b=MZnMJSvszGOJ69yW2f92BRR2//4YgYRkKKac5Gqy7Awh1bsWzu6rOOSWtZwJtx/tcG
	eDw1eDkllfmunatVZlfYdB6E/H0sEhYx56nkD9/3BTyiQhK1cK3ohxtnncyN808QU9Ip
	EHjb1faIflXV5qJO4U85TcW+zBgo6JUqMcJpYrNghYuo1YIWP/jnyZ0my2UTfw52gR0p
	0x1xVJYtgpLLMZiiVV2/R/giaXcjlq2VvA7Z8shcCNAngnJ6VI6G+ScfLPtwzKJEy1HA
	MzWZ1/YUvj5/eXdhJA+Ieta7O8ADe/tnz1YT0d9DikYe3aJrHMlfOTBTM/lY7uViDVxI
	lLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=be6f2f0XIlqFU7RHgEDNHdFLaZKAoDs5ON2xf3GreVs=;
	b=YZjgJo+knA/6hv75VCeYN19XibJnJ8DAkBmEkLOsiTW6OWtuZonHb3OIiSGz6+k2xK
	VjJIT0HztMU8Cnxl+xTT6cvEdEnxLAB/msMDxAzxXv84BDZ/yO7VD6yDr5bpaqJZCNTg
	FvucAgMNQuxpJQVg0ZcFemT+j8VCOBCNn7YC7+LuK4v8t/hihNUwhVZ2WmTgIpzO/B2T
	k2np80XTxZGeFybJStHfq5ezMn/+oNpN0T17siNzAJG9optYgaOahR7jtqk/fckfXDfy
	omnTXRM0V/nL7mlFiBG+CAY25PTpgF2y1A4GqgJG1xcZbDdS43fB8ZsR80USUCiz1GiD
	Pj/w==
X-Gm-Message-State: APjAAAUEVaC7Z9VNv4eNmQLSN9D97f8Cj7M+pGynYSllG+xYGZ5uCx0a
	Cyfe+sdoalngYeL8ZskyyxKXDfEae0hZVijlij6gyw==
X-Google-Smtp-Source: APXvYqy9oEwsfMU6Hmi4yVBnW8LZ4gUZmwS+KAWSnUmv484C2kN850KPfxFBG55AG8ix9yht3mk81r/aARykAzdCsRE=
X-Received: by 2002:aca:f581:: with SMTP id t123mr11818692oih.0.1555962272101; 
	Mon, 22 Apr 2019 12:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<20190412083230.GA29850@quack2.suse.cz>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
	<20190418161833.GA22970@infradead.org>
	<CAPcyv4jPOF_+R6U17J_+88+X8LC-LSPCugA6gbKxuphuuFB2gg@mail.gmail.com>
	<x497ebm82d4.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x497ebm82d4.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Apr 2019 12:44:21 -0700
Message-ID:
 <CAPcyv4gGmN2LLMPy6BzWpYhRyV7fFNVgh=xAWSAdnnAWu5APtg@mail.gmail.com>
To: Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
	Christoph Hellwig <hch@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
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
Message-ID: <20190422194421.LfOjYDBGy_JkBKOhd-19a5ylRkZa8WYOKge0tGf4fhw@z>

On Mon, Apr 22, 2019 at 8:59 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Thu, Apr 18, 2019 at 9:18 AM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
> >> > > > I'd either add a comment about avoiding retpoline overhead here or just
> >> > > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
> >> > > > get confused by the code.
> >> > >
> >> > > Isn't this premature optimization?  I really don't like adding things
> >> > > like this without some numbers to show it's worth it.
> >> >
> >> > I don't think it's premature given this optimization technique is
> >> > already being deployed elsewhere, see:
> >> >
> >> > https://lwn.net/Articles/774347/
> >>
> >> For one this one was backed by numbers, and second after feedback
> >> from Linux we switched to the NULL pointer check instead.
> >
> > Ok I should have noticed the switch to NULL pointer check. However,
> > the question still stands do we want everyone to run numbers to
> > justify this optimization, or make it a new common kernel coding
> > practice to do:
> >
> >     if (!object->op)
> >         generic_op(object);
> >     else
> >         object->op(object);
> >
> > ...in hot paths?
>
> I don't think nvdimm_flush is a hot path.  Numbers of some
> representative workload would prove one of us right.

I'd rather say that the if "if (!op) do_generic()" pattern is more
readable in the general case, saves grepping for who set the op in the
common case. The fact that it has the potential to be faster is gravy
at that point.

