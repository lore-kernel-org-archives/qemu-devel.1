Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F315C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D5D20665
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D5D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHtz-0005sZ-S9
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iBHrq-0004nl-Ty
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iBHro-0004ki-Se
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iBHro-0004kD-AB
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:18:28 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD4F67CB80
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 12:18:25 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id v4so4314325plp.23
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 05:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=M9sDdKFPajYc2bRtETuET6VJ4ojwNJEvtjgQQioBBK4=;
 b=BxG1qg6oHbVmy1EjMfDlMMT9PfyiPkPYfR/Km2/wQnAXOtTv2cS1nRbwCEoedQG5rW
 O7istlbqelqK29uaygT2A1YBjzN527pvDLmb1eBpgP2IV8qd5uVNjR80QDYoKf2qN/Cs
 C1Y7FQL6SnVXqbqXxl7R5OChOtM2hjVMbjf7AJnM99Vb268yDjmsfGy5UHsoCCUWhu/i
 qeCcvKOVX76St140uspcsx/qoL/JlrYW6DC/iEJAWKxaR3mTH0v4DbTikSWUbbhFWOrG
 mDW3dDWKAPnd5xbu91iUhS699UG6hbQ7rzhbfEll7ICibau9IQROV1p3fPBL1yQ8h6qq
 CZ9Q==
X-Gm-Message-State: APjAAAXR/4RsanhHWxJPjtBCvOyO3FjSWCPJOVjHqopSYkHrNMLpwKLZ
 QYBWvNPKk/5rgE8Y0900NsihYj9mzikI6fdPIWYMjr+Iac6FOQ5wIHno1PuleKMAM5R9ynsweTF
 /Mtr0TmiFy3Y/+Ic=
X-Received: by 2002:a62:5214:: with SMTP id g20mr17127177pfb.103.1568981905395; 
 Fri, 20 Sep 2019 05:18:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyaU4mG4sD0N1omesFcJGqeiHtDZc+DMNp9bhEgV0lRxdo+RLDLNmYSD/0pwApUj8kq+4rrMQ==
X-Received: by 2002:a62:5214:: with SMTP id g20mr17127151pfb.103.1568981905144; 
 Fri, 20 Sep 2019 05:18:25 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u31sm7042349pgn.93.2019.09.20.05.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 05:18:24 -0700 (PDT)
Date: Fri, 20 Sep 2019 20:18:13 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] kvm: clear dirty bitmaps from all overlapping memslots
Message-ID: <20190920121813.GH12858@xz-x1>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
 <1568974882-7419-3-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1568974882-7419-3-git-send-email-pbonzini@redhat.com>
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
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 12:21:22PM +0200, Paolo Bonzini wrote:
> Since the KVM dirty page reporting works on guest physical addresses,
> we need to clear all of the aliases when a page is migrated, or there
> is a risk of losing writes to the aliases that were not cleared.

The patch content looks perfect to me, though I just want to make sure
I understand the issue behind, and the commit message...

IMHO we've got two issues to cover for log_clear():

  (1) memory region aliasing, hence multiple GPAs can point to the same
      HVA/HPA so we need to clear the memslot dirty bits on all the
      mapped GPAs, and,

  (2) large log_clear() request which can cover more than one valid
      kvm memslots.  Note that in this case, the mem slots can really
      be having different HVAs so imho it should be a different issue
      comparing to (1)

The commit message says it's solving problem (1).  However for what I
understand, we are actually doing well on issue (1) because in
memory_region_clear_dirty_bitmap() we iterate over all the flat views
so that we should have caught all the aliasing memory regions if there
are any.  However this patch should perfectly fix problem (2).  Am I
right?

Thanks,

-- 
Peter Xu

