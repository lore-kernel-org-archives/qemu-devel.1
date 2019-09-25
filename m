Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A649C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8DE214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8DE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDH03-0005Ac-AC
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 19:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iDGyK-0004TX-N9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iDGyB-0002C6-Iw
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:45:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iDGyB-0002Ab-9f
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:45:15 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 680308E3C0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 23:45:14 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id x8so161717pgq.14
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Eie0ePw9gnxJqP8+FD/Hg6TczZlGo6MaZSPOYdFLjcc=;
 b=iUgHnM7w9aStznv5I41a+MYSc9RkLx3+l1DBvltGI0Y2ysCgFoi0uPnvQKX0FieEIL
 btoxJmWY/xjFF9cLxND2TqGIxcAmlt3DMdajS72HCLJ3KcayTcvkQfxS9kRiTzFYt4dQ
 N7Dy5PbpjQQGvclA8ytqMYGVxAvvU7QcBW7NfvPC/0lqxnUW7tE9aTuS50Snlh1AAq8I
 /PW7nkYfZ0Y40V27osZUrtHthY6oom7QFE5+v7azhNHmZQ5GBlX1L39zZBS8JiQcStLw
 RHql3Pl5LDmpj/Bo2ToMtgi/XFyTEWQwywPNe+42181oE+/en0pYhSZnvMu+LLnrqUSr
 RbUw==
X-Gm-Message-State: APjAAAU5st1NGGSqi34rJN7vtOw4pJuv7tXxCdL//BPo6UBEpgOpbKDE
 48R/AZCFPBlae3B+QHtF5NUKh7cKAxGaAsjAER7Hfv6nxTAnOa6Jpj5hv7dhxUUsWSfvgE5o8u8
 YDcxCG5dv/W9hZpo=
X-Received: by 2002:a65:6102:: with SMTP id z2mr430349pgu.391.1569455113804;
 Wed, 25 Sep 2019 16:45:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmclPNI5Zl/4LWBwxCAu6lelcfoc8cJZPzE4h29a2ZqqwI15BEVhKDH9PJN4fmISW8REg+Ww==
X-Received: by 2002:a65:6102:: with SMTP id z2mr430324pgu.391.1569455113509;
 Wed, 25 Sep 2019 16:45:13 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w189sm130958pfw.101.2019.09.25.16.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 16:45:12 -0700 (PDT)
Date: Thu, 26 Sep 2019 07:45:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v7 3/4] kvm: split too big memory section on several
 memslots
Message-ID: <20190925234501.GT28074@xz-x1>
References: <20190924144751.24149-1-imammedo@redhat.com>
 <20190924144751.24149-4-imammedo@redhat.com>
 <20190925031211.GH28074@xz-x1> <20190925140915.3d43c8ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925140915.3d43c8ab@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 02:09:15PM +0200, Igor Mammedov wrote:
> On Wed, 25 Sep 2019 11:12:11 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Tue, Sep 24, 2019 at 10:47:50AM -0400, Igor Mammedov wrote:
> > 
> > [...]
> > 
> > > @@ -2877,6 +2912,7 @@ static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
> > >  
> > >      for (i = 0; i < kvm->nr_as; ++i) {
> > >          if (kvm->as[i].as == as && kvm->as[i].ml) {
> > > +            size = MIN(kvm_max_slot_size, size);
> > >              return NULL != kvm_lookup_matching_slot(kvm->as[i].ml,
> > >                                                      start_addr, size);
> > >          }  
> > 
> > Ideally we could also check that the whole (start_addr, size) region
> > is covered by KVM memslots here, but with current code I can't think
> > of a case where the result doesn't match with only checking the 1st
> > memslot. So I assume it's fine.
> yep, it's micro-optimization that works on assumption that whole memory
> section always is covered by memslots and original semantics where
> working only for if start_addr/size where covering whole memory section.
> 
> Sole user mtree_print_flatview() is not performance sensitive,
> so if you'd like I can post an additional patch that iterates
> over whole range.

No need it's fine, thanks!

-- 
Peter Xu

