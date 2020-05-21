Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F170C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C112D206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fN7/2RTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C112D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmek-0005Ez-W6
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jbme5-0004jG-Rr
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:58:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jbme5-0005Bc-3G
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590073083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Si3qtkn40kX0AiF533h/p6EDRcZ7Trw0xx0ZzJl84Y=;
 b=fN7/2RTQKRa/f9rokgYJyXKyfBIOsa6i67okTQILKgxsRHaqZ2Tz0tRBQ06b62fEdpfjUR
 gvaHaWLigXAneHqvcLEokMu4PHUkpAJg6ala90VmAe58yaeQQdGju25iaG3B0nwEIHBUTK
 /4UQCnO4Ga4AL2g/ctnAGDPlOCPNSoE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-g-Tw4jGTNNObhqL2Ar3W1Q-1; Thu, 21 May 2020 10:57:57 -0400
X-MC-Unique: g-Tw4jGTNNObhqL2Ar3W1Q-1
Received: by mail-wr1-f71.google.com with SMTP id d16so3010347wrv.18
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3Si3qtkn40kX0AiF533h/p6EDRcZ7Trw0xx0ZzJl84Y=;
 b=Mxh/jat9cWUPWqZylvOSn6zVD+DaIRDLBfL2Kykcs53BHT0XJ0ikcD/SXUWltsc1FK
 2RU4Sgr6QzA43Ov/zU/lUBP57tN846C6xaVKJN9Ezw2KONMoPuTC7nA4aKTCkUssbYGa
 Ux6ZcgxE8GiFMxr/GXcuy9g80iJ3JufV8dFH1e6hjlFYXVP3RLL1lvyr0c6MyTkjeTfQ
 RtJ7bfAszwOfk0e3pELQKAUMZmIBD7h+7iUGLDF6H1/RI+UGVj+/RbQctaQnXOWp5X+B
 HgdqJERF5j4u5GUtsrVMj3WqYC92YEb8iuQqMP8/fRwrD+dT5+zrx86H4apaPcE9av6a
 6NEg==
X-Gm-Message-State: AOAM531H1n7cVyEZuJHLeY835kNmMDys+ZYeG/CyktSgNMwDXhj2kakH
 ds6TnAMlGUhFNgiCQoXGCAgPfgNIz+Z697E79Tgnr84/kWC7uIhOyyhWvmvH6BQg1lB/O1+0kWZ
 f8U6RaChHrzBHYBY=
X-Received: by 2002:a5d:608d:: with SMTP id w13mr4802845wrt.298.1590073076308; 
 Thu, 21 May 2020 07:57:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOFS5TejhR15+Y2WeAZJPpL455gAydDwrBHpXNH3HyID9tenRjiiMm+wrbBFwPOfB+5/kMew==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr4802821wrt.298.1590073076040; 
 Thu, 21 May 2020 07:57:56 -0700 (PDT)
Received: from steredhat ([79.49.207.108])
 by smtp.gmail.com with ESMTPSA id w20sm6729890wmk.25.2020.05.21.07.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 07:57:55 -0700 (PDT)
Date: Thu, 21 May 2020 16:57:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] io_uring: use io_uring_cq_ready() to check for ready cqes
Message-ID: <20200521145753.psawkk3elsgnxony@steredhat>
References: <20200519134942.118178-1-sgarzare@redhat.com>
 <20200521144534.GN251811@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200521144534.GN251811@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 03:45:34PM +0100, Stefan Hajnoczi wrote:
> On Tue, May 19, 2020 at 03:49:42PM +0200, Stefano Garzarella wrote:
> > In qemu_luring_poll_cb() we are not using the cqe peeked from the
> > CQ ring. We are using io_uring_peek_cqe() only to see if there
> > are cqes ready, so we can replace it with io_uring_cq_ready().
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  block/io_uring.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> io_uring_cq_ready() was added in liburing 0.2 and is already used by
> fdmon-io_uring.c. It's safe to use here.
> 
> I wanted to mention this in case anyone is concerned about dependencies.
> liburing is a fast-moving target and everyone should be on liburing 0.5+.

Yeah, thanks for doing that. I did this check, but I forgot to write it down...

> 
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block

Thanks,
Stefano


