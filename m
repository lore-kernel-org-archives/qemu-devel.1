Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F079CC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43CF206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43CF206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9m2B-0004CG-Th
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9m04-0002Xd-Sl
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9m03-0000XI-Pr
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9m03-0000X5-Jk
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:04:43 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C79F7C03D478
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:04:42 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id a13so7115734pgw.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 01:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DoH97sBNIDzTi1xbr3Bu8Wq1lpv5TUtN3sGtUQayrsA=;
 b=OHLp3nZ0DdqQkYBgg+FgCFx/BJnqKIsbkL1Oyh76dJnjm/24Jcd4AG45R+esN4ZFOy
 ksb7XUXuF3iQ5jeAFumwtaaO8D9INEntsTyL8fZxJJY3OL9H7AAprRdKanan5LLvWV1R
 BnO9cE94D4YHFI2OokFyAtbSudud8UFy946TXomncIMnGN60Mgicc+cO/IU+D80fg/6P
 9mw7s3LimKmalR+5we1OqfEGzQiPWdTSS5OPBIZhpN7tp9r/p6JRRjGaweSqxjDGji3i
 WYU2QF7+CHK/BRryIarglKqTTNSL2nbhCNlrNhcYDDKmTt8kbStyfo3kx48zrBnB/q9E
 J6bQ==
X-Gm-Message-State: APjAAAV4JiuqOuIdnuiVPJmg3jnhg5diLCSLt2HuWhJCThH5ycZdQGyD
 D8nbskwWGC8nHa3Uy0MNc+4yfiGqcZgzcleB0IgWHkJn65AhwMacEJuUY5zvdIokzf77sQTh6CA
 rPCD9Icraa/D/rC0=
X-Received: by 2002:a62:7646:: with SMTP id r67mr69196793pfc.116.1568621081956; 
 Mon, 16 Sep 2019 01:04:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx2AUlygdjjxHgG21rDgJVgzbD1Wile3j8BMLWZYK2cgtDS7b+EiFVHhpDtpVfN4ZkTil/g6Q==
X-Received: by 2002:a62:7646:: with SMTP id r67mr69196770pfc.116.1568621081822; 
 Mon, 16 Sep 2019 01:04:41 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z22sm5143395pgf.10.2019.09.16.01.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 01:04:41 -0700 (PDT)
Date: Mon, 16 Sep 2019 16:04:30 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190916080430.GB30562@xz-x1>
References: <20190916075839.390-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916075839.390-1-peterx@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 03:58:35PM +0800, Peter Xu wrote:
> v2:
> - rebase to master [Eric]
> - add r-bs for Eric
> - remove RFC tag

No... this is the new cover letter with the old commits...

I'll post again.  Sorry for the noise.

-- 
Peter Xu

