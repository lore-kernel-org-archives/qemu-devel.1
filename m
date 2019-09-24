Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34F5C4320D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFF320820
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFF320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCYWZ-0007lD-Tl
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 20:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iCYUS-0006px-2O
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iCYUP-0005Ei-Mu
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iCYUP-0005Cm-Gc
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:15:33 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B44681F31
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 00:15:32 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id g20so9600264plj.15
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 17:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EecwyCacTY8euhE/Y83uwBnVxGHTkkSoSh0uaCkJb0Q=;
 b=oDu2Vv3k1zSXXh2kXItz3fFebC35YvwzPe1vrwjG2YqTfpVxW1Pb+Z3rhbqZxI9AYF
 hB2ZsMnOOL/QSCwrZyGJ1PtSSFYqhFq2Q3C+oz7ACWCWT0iFSWzr5yzHQcct1MdUi1eI
 MFQ06YOz0DIMNKbW/bxZNH16toCc4iohRuMcDSmvr+z3D6YpfkJ0fEPnCPjc0kM/PaW1
 8ktr9WXGYbGm4wg/m0Ps42UDDSe5Qcp+Db1Nn3XZF+xbIs4gITXDqH1h5d/BDFcYFpVD
 G7K4I4D+t/MfO8phqbHUNhCazyV9Li7p//FFlgzQLJp3od2dWtrVBbZSFblgBqsB117Q
 omKQ==
X-Gm-Message-State: APjAAAVcScgtIvDo49vFFg4QdZVEpawfjhkWLC3s0qep64jIBZ41ZBkd
 zYNF5tZRPboZ8B57BVEvqBq/M+gIeiAzmbX6El/aVG1/y/sVJ5B38uL8w0VIvoBi58xbaBokV/S
 zZIvAILsm22X00H4=
X-Received: by 2002:a65:5905:: with SMTP id f5mr200747pgu.332.1569284131616;
 Mon, 23 Sep 2019 17:15:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvFAru/5lo5qxkdAqS+afa50P/GCH20kYZQQyxVjHE2j7y1klrFiCQpbSHCzlrGngfz3BVRA==
X-Received: by 2002:a65:5905:: with SMTP id f5mr200730pgu.332.1569284131344;
 Mon, 23 Sep 2019 17:15:31 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 127sm17703355pfy.56.2019.09.23.17.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 17:15:30 -0700 (PDT)
Date: Tue, 24 Sep 2019 08:15:20 +0800
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration/postcopy: Recognise the recovery states as
 'in_postcopy'
Message-ID: <20190924001520.GC28074@xz-x1>
References: <20190923174942.12182-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923174942.12182-1-dgilbert@redhat.com>
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
Cc: thuth@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 06:49:42PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Various parts of the migration code do different things when they're
> in postcopy mode; prior to this patch this has been 'postcopy-active'.
> This patch extends 'in_postcopy' to include 'postcopy-paused' and
> 'postcopy-recover'.
> 
> In particular, when you set the max-postcopy-bandwidth parameter, this
> only affects the current migration fd if we're 'in_postcopy';
> this leads to a race in the postcopy recovery test where it increases
> the speed from 4k/sec to unlimited, but that increase can get ignored
> if the change is made between the point at which the reconnection
> happens and it transitions back to active.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Yeh this makes quite a lot of sense to me...

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

