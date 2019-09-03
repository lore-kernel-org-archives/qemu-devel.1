Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F19AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2342A22CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2342A22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55wg-00071A-9D
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i55w1-0006Zh-Um
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i55w0-0007Sj-9b
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i55w0-0007S6-3X
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:21:12 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A8238811BF
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 10:21:10 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id k20so10650424pgg.15
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 03:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=z/99HzLodMDN2umkuTyQvgZPQhz/lGissm15dvu6AGw=;
 b=G6dzQxZb0Q6XIHNcHwUCHpS7jfMHyikFQFkIWGUOIyh0xlKrGgJT+U8gLrGvz+H6Wj
 KWPkNG2G/p+ArRQ/tol7t1nHe1qcMH853hIG2iEnMuwaRDnqE7toe/+xNaS1mgp+LEqo
 LjUNbo55veD74VpvX6hB+JyiO5M157xQz5gnPXxEf+b5wQhCa0err1lgOfJCPDPT0N/o
 G6K7JcjLfME//zzY2dDAeS3ChJw8YDcDVa4rUkdgnU2mvalNjwo3To5Hqfcl1X5lU6c9
 R+ItYNWEYPNLiGLYijIqB+FQO66Ivel9y31malmF8Yp7KxHEbgYNuBfnLNXUy6dRUako
 y+8w==
X-Gm-Message-State: APjAAAUEPIfg0cuo5v5pkFYHVOCVHo+LgRTVEqpP7le5F5PEvm60OQS6
 HCgFpj9kUOf7A5IW9rIcWVCpZLcjHfNHa3hJrcfzjRYKGpRgBkz7U9gx9DtU5aG17G0CPgRfxXz
 Gp7xu1SFTLRl8z0A=
X-Received: by 2002:a17:90a:b38a:: with SMTP id
 e10mr6764003pjr.91.1567506070243; 
 Tue, 03 Sep 2019 03:21:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx2DB4e3i2KGzNRghz64Qu0XqH0182aakmk87i/hG4O17Uf6lreb4HUGJywASaR9o24mTgZnw==
X-Received: by 2002:a17:90a:b38a:: with SMTP id
 e10mr6763985pjr.91.1567506070008; 
 Tue, 03 Sep 2019 03:21:10 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l124sm21896901pgl.54.2019.09.03.03.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 03:21:09 -0700 (PDT)
Date: Tue, 3 Sep 2019 18:21:00 +0800
From: Peter Xu <peterx@redhat.com>
To: Tony Nguyen <tony.nguyen@bt.com>
Message-ID: <20190903102100.GA30402@xz-x1>
References: <20190902012647.1761-1-tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190902012647.1761-1-tony.nguyen@bt.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: Set notdirty_mem_ops validator
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 02, 2019 at 11:26:47AM +1000, Tony Nguyen wrote:
> Existing read rejecting validator was mistakenly cleared.
> 
> Reads dispatched to io_mem_notdirty then segfaults as there is no read
> handler.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

