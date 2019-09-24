Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0345FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 02:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC868207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 02:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC868207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCaxr-0005r6-UC
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 22:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iCaxC-0005PG-4D
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 22:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iCaxA-0004KR-2v
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 22:53:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iCax9-0004K5-UB
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 22:53:24 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEF2C3DE31
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 02:53:20 +0000 (UTC)
Received: by mail-pg1-f198.google.com with SMTP id t19so380962pgh.6
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 19:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aYZJGBMRsRr7il1pIVfrB/JqrfrfnrG5W48drpGx8OU=;
 b=LmiN5dSIS+J3tTci+i5UxU0DOG2jiE5CYAKUIhs+LsuD+/hynNZyz+GmiavRPs4xWX
 1loPLt+OAFYIlccJRVva/7Hy76NkhwoFkyvEuCwdKo3S+RC12gA/GjckXZy9a1drhSKe
 AyPxsROTM0TylLI38c15zHykKa/ISE4uGX9sg9OrpsUVnaLTkJPmO7Ga1eyxxirc1Iuf
 BhLP2EBe2knOEP8xSDsuUX+VQd7g1043Ky8j8iinj9NrV2zjGzschMOyQaSp2rb3gQJ/
 85Xq8jfFWxyF56aJi1sl9AIkZswQ7RsPRckEHYAOAZfxMGEHUyqe20BqULMpTMwNflPS
 knvQ==
X-Gm-Message-State: APjAAAVkIXSVBOgEwJ9RxN//6hlDEs/m7wF/oNPp9xVBYXS7/P6eiTZA
 jzJ3yOREK8FfGaXd9PFnPK3Ka3EsjlO7ZDB95y4IZ3le0Qij8VhHEo3HDvWa8S7Ry/tZaLnB+63
 qaiB8rZHogHJrsRM=
X-Received: by 2002:a17:902:7585:: with SMTP id j5mr491502pll.19.1569293600450; 
 Mon, 23 Sep 2019 19:53:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxW59hlMvXP57MoV1tFaGXlYH+MLTAfGqI97gyjGUh5UTrqJ3AcbvwXPbs/AgO8RbyuCY+cpA==
X-Received: by 2002:a17:902:7585:: with SMTP id j5mr491491pll.19.1569293600299; 
 Mon, 23 Sep 2019 19:53:20 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k31sm184884pjb.14.2019.09.23.19.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 19:53:19 -0700 (PDT)
Date: Tue, 24 Sep 2019 10:53:10 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] kvm: clear dirty bitmaps from all overlapping memslots
Message-ID: <20190924025310.GE28074@xz-x1>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
 <20190920121951.GI12858@xz-x1> <20190920155851.7445cd2a@redhat.com>
 <20190923012946.GJ12858@xz-x1> <20190923181512.144e3b77@redhat.com>
 <ad751c10-69f5-8d20-5150-9750425a5f72@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad751c10-69f5-8d20-5150-9750425a5f72@redhat.com>
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 06:49:12PM +0200, Paolo Bonzini wrote:
> On 23/09/19 18:15, Igor Mammedov wrote:
> > Yep, commit message doesn't fit patch, how about following description:
> > "
> > Currently MemoryRegionSection has 1:1 mapping to KVMSlot.
> > However next patch will allow splitting MemoryRegionSection into
> > several KVMSlot-s, make sure that kvm_physical_log_slot_clear()
> > is able to handle such 1:N mapping.
> > "
> 
> Yes, that's great.

Please feel free to add my r-b directly on patch 2 with that amended.

Thanks,

-- 
Peter Xu

