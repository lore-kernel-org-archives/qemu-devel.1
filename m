Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B5CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 01:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D08206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 01:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D08206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCDCg-00052d-CP
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 21:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iCDB1-0004RW-ID
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 21:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iCDAy-00073r-Ky
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 21:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iCDAy-0006zm-ES
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 21:30:04 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87A282A09DA
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 01:30:02 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id v6so9251889pfm.1
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2019 18:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Fnj1qK3UBLuEUBNNCkV8/vntG8wMLbq3/3l57syEKtc=;
 b=VdCD/IDDfd08Baw3vROLTUjd4nUTqy3iAI/WwEAqgiHZjuTmcaqeJecX9zNn/Biwf+
 4k3wgIhtVWsffvvALe1Q72B66pcDEL3X5lcT6dT3N26qWvEZgFoNt0q9yUjSdFjdrc9G
 urhmvKVYrbcCbQ7GrMkf41VVJSjBLWt/dXZ2mbvoar/9d3QIE49ob6qlB7sB05BNLpka
 WTA7atS0EdL1ALBGNc6PwEjWixD7jk7yjfSadzghvmYnBecVTPMK8SD60vzHSfGI1RFW
 bySIquvbwiq200PMR31bwxAMp0mzDs6e3KpX0gwCk6RWwIaSKGKpQt1tEyJIv7apBTVa
 cG1A==
X-Gm-Message-State: APjAAAV6yZKTP81rBV+hb1yp/+zvITGy2KcBBJ1g+UXfXql/366TMVxr
 LorFklfeyjaZ7XxdLPLcjJQy1zVSqq4BPkNtEAhscHrhviZzCDskSaYhgz+z8zhuVcv3wugYXcn
 rtTEk6k+EgjK7xJA=
X-Received: by 2002:a17:90a:6547:: with SMTP id
 f7mr8744089pjs.13.1569202201958; 
 Sun, 22 Sep 2019 18:30:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6q86eAShoCObUDtAQofCd/T+L9+R4bF4MhodAUh6V/zf9JWeErevhIF7lH5PYpLBcDjpI0w==
X-Received: by 2002:a17:90a:6547:: with SMTP id
 f7mr8744076pjs.13.1569202201585; 
 Sun, 22 Sep 2019 18:30:01 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 20sm9675786pfp.153.2019.09.22.18.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2019 18:30:00 -0700 (PDT)
Date: Mon, 23 Sep 2019 09:29:46 +0800
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 0/2] kvm: clear dirty bitmaps from all overlapping memslots
Message-ID: <20190923012946.GJ12858@xz-x1>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
 <20190920121951.GI12858@xz-x1> <20190920155851.7445cd2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920155851.7445cd2a@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 03:58:51PM +0200, Igor Mammedov wrote:
> On Fri, 20 Sep 2019 20:19:51 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Fri, Sep 20, 2019 at 12:21:20PM +0200, Paolo Bonzini wrote:
> > > A single ram_addr (representing a host-virtual address) could be aliased
> > > to multiple guest physical addresses.  Since the KVM dirty page reporting
> > > works on guest physical addresses, we need to clear all of the aliases
> > > when a page is migrated, or there is a risk of losing writes to the
> > > aliases that were not cleared.  
> > 
> > (CCing Igor too so Igor would be aware of these changes that might
> >  conflict with the recent memslot split work)
> > 
> 
> Thanks Peter,
> I'll rebase on top of this series and do some more testing

Igor,

It turns out that this series is probably not required for the current
tree because memory_region_clear_dirty_bitmap() should have handled
the aliasing issue correctly, but then this patchset will be a
pre-requisite of your split series because when we split memory slots
it starts to be possible that log_clear() will be applied to multiple
kvm memslots.

Would you like to pick these two patches directly into your series?
The 1st paragraph in the 2nd patch could probably be inaccurate and
need amending (as mentioned).

Thanks,

-- 
Peter Xu

