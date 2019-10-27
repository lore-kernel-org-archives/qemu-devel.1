Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D88CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 13:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48844214AF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 13:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48844214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOiLe-0006Ad-28
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 09:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOiKg-0005G8-99
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 09:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOiKa-0005TW-4S
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 09:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOiKY-0005SZ-4L
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 09:11:40 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B0F1259455
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 13:11:35 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id k11so143256qtq.7
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 06:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D1/9bEJPk7DgKdT9AEv81Yv7YqaG5uHDz6hORKB557k=;
 b=hkpFTxuuqBEYa1euxjcL5/1a44qRYaSBWLZaO9DaoHiKRsG5SHBw0eKC5IyR1zRIzm
 KzN+S4/U1MPCWCUQhy1ftlmZGW7rGXzI0Ci3iJfPtJC/5LIm6A/YYx9+Nk1+wf4XHhIh
 RW0OxJyupiA3QpvGuvTn/R7nSMEke1MbO0NFz6NElioaS7SzWNEAeES21cBBFqvwPSFv
 iBPzoF3xcFgsuYrgItrUcUBhetKU/itckCa5IP3Fin1OXNucUNPgAIsR+jLwOa76ED+5
 GIMZSoMwV8YOUTHlosebYV0pkA0dBxr8jR5+rntvsbW83RfG0dtPWsDpLwnvYHBZGtbU
 4TOw==
X-Gm-Message-State: APjAAAUogboiQtpz16/COVWSvXS5DFctKVlviC3l+mGRZffT9VyWkwnC
 DLee6PJyc2goxk/1hQYIjgXU+8gxvxw6OkJlpy9MMHsJ1Npee1W1ImWgWaJpninxDmAI0xHvXh1
 cNl4LVXFgBTrPusc=
X-Received: by 2002:ac8:7646:: with SMTP id i6mr13125956qtr.251.1572181895014; 
 Sun, 27 Oct 2019 06:11:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwnNZ+eAvbiTenQQvcxOrVIdG3sWUfgQKKzLkHTZjmiUitsf4FecNL8Bo1feTLJjAV3yo3P5g==
X-Received: by 2002:ac8:7646:: with SMTP id i6mr13125938qtr.251.1572181894834; 
 Sun, 27 Oct 2019 06:11:34 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 v13sm3511327qkv.132.2019.10.27.06.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 06:11:34 -0700 (PDT)
Date: Sun, 27 Oct 2019 09:11:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 00/30] virtiofs daemon (base)
Message-ID: <20191027091007-mutt-send-email-mst@kernel.org>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
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
Cc: qemu-devel@nongnu.org, piaojun@huawei.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 11:58:02AM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This is the 1st set for the virtiofsd - a daemon
> that implements the user space side of virtiofs.
> 
>   The kernel and qemu device parts recently went in,
> so the daemon is the only thing missing to have a working
> set.
> 
>   This set is the absolute minimal base set of patches;
> it's not yet safe to use (from security or correctness);

So based on this I'm guessing we don't want to rush this in
before the soft freeze.
If you have a different opinion, let me know pls.

-- 
MST

