Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF56C4CEC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 03:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1ED206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 03:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1ED206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9hFE-0007Np-7a
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 23:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9hEY-0006xY-0C
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 22:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9hEV-0002d8-F0
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 22:59:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9hEV-0002cA-6X
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 22:59:19 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5CC4A83F3D
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 02:59:17 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id y18so1677816pll.17
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 19:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=B9Un9+IMbZrv2Q6xr08yuoHVCij6eLjQNUznGfGT6mQ=;
 b=SQSxT4jPlEmISb9cfsrKZ3Yr7/Ox7HFXPK040t54xw8JKkCw4l8d+0g2VWlxFRgbri
 27MAq4frCEegoADX3EuZXUGQgS52bgQ0XRrXENdC1cHTDjAdgDvQAZ/6IIyv/QrxSQkq
 EqJ0kVr2oVG6gpgzt/OM/RW5g8a+NB8HoqfjbUtn/2XywY0JO5B9tPhxuEIs3NpF3JyV
 1cfGpspaDjW11LVTk7r9XVr8rjHWcxKH+8CLMQT/Xd7QlRRL54ZxwN4d+iUwpMGmWNVe
 m1i3ddVPdRO4VckOWzB88An1kBcycsCSw/x8ywpSZ4CRG1410CCXFy4r+gihxprOw6zw
 T52g==
X-Gm-Message-State: APjAAAUzmybPXoqX933gq28fhs77JY/8oAW1DaTJZhWFxKbgYeUw74ZZ
 rwkCbKsl/AI770aK35TMWsD2UTs+ZcFLkVFsxX5cShPJpHV3DVt5iB7mU/nrppl60P1nC3ZRHUS
 GHjzoXZ5jDYOoNsY=
X-Received: by 2002:a62:2f84:: with SMTP id
 v126mr52849190pfv.167.1568602756893; 
 Sun, 15 Sep 2019 19:59:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMAFCyBODKU2rFkDdb8kA4bOYE5gJ0+3znrqwNqCIBEAaro8s9H175EXtRspBmIzvfyM8Q1Q==
X-Received: by 2002:a62:2f84:: with SMTP id
 v126mr52849182pfv.167.1568602756663; 
 Sun, 15 Sep 2019 19:59:16 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z14sm13019780pgj.22.2019.09.15.19.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 19:59:15 -0700 (PDT)
Date: Mon, 16 Sep 2019 10:59:06 +0800
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190916025906.GA14232@xz-x1>
References: <20190913163507.1403-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190913163507.1403-1-dgilbert@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] migration/rdma disconnect fixes
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 13, 2019 at 05:35:05PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This fixes a deadlock that can occur on the source after
> a failed RDMA migration and cleans up some warning messages
> that can appear during normal completion.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1746787

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

