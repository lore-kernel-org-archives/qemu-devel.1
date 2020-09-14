Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3680EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9676520715
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWvc/KjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9676520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHsBe-0005tI-G8
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 13:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kHs8j-0003eb-U3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:19:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kHs8h-0005mw-RA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600103974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5LMkSxWEM5Z2amTXMBLAvuvm2e95suH+S4/vGDDpVgo=;
 b=cWvc/KjJk6uFW7kNQFT1ef6fBNqEJIOdGlvnXKYTyKMWIjKGgB9kM/I26P766o6QianxsB
 OpMawsP17UBdCsD6H5RrbBw5lm19PdsCzFrInPnB86cGLnIwN0xmjcMKYlRh0bA3kpncKa
 lZ7JSO3aLbPg+V+QXzy2cYcAxdSUStA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-3X5SYji9P3G6tWOARw84oQ-1; Mon, 14 Sep 2020 13:19:31 -0400
X-MC-Unique: 3X5SYji9P3G6tWOARw84oQ-1
Received: by mail-oo1-f72.google.com with SMTP id n19so156616oof.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 10:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5LMkSxWEM5Z2amTXMBLAvuvm2e95suH+S4/vGDDpVgo=;
 b=jT6QbImDG+VAbXmBrVK/7v/hgWaEw+NO916dc5CqO3qxdeFhpYikuMjZfsicIxsgP2
 WK3/Uxz454fI6d4RqAycT+wZR6bCDHT99JEBDO3FikKW7fno1eg0UeY4EtxfNFaIB9Kn
 RnrOEOX+Pxbi1adaDayqyI6iruGgAhlAr6jRsABDXBD5rrOwZlbp0kcuBsrlyvsdFj66
 gHB51EcFXyfvy3oud9n9bG5jHAHkFg8K7W5vngZqzaZWSeZumIqbDkDxkwSxftZKv/io
 Nl7HZ4fDBfYamNujdx4vgesbEAaXLeDRoBpZrfSPOZ3IDigFSw47Fv2uPzXSMqkconEF
 l3lQ==
X-Gm-Message-State: AOAM533wKEFTcy8sJ70rYGv3X6rK0cyl0SK9md/PHgP4Ok3O1UkK/qy7
 Hg7ie+WhzAVZwTJ94iKAopBJMfNr53n+f5y4uCv0ACNV0DcyLg24wmPyToh/mpp2vsTUhqJDXHu
 ZCUmyh2msYcckosCyRtopoR6FDixiB0w=
X-Received: by 2002:a9d:6b0c:: with SMTP id g12mr10338995otp.315.1600103970439; 
 Mon, 14 Sep 2020 10:19:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+SLOW1FPDYNg521s2w/ASWByIOH9S/FSaq0VpZD4cT6EzzbXaGQFa+5hvVlqPZYu9uk5Z2VjP03Q+nCIqt74=
X-Received: by 2002:a9d:6b0c:: with SMTP id g12mr10338984otp.315.1600103970223; 
 Mon, 14 Sep 2020 10:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200831140127.657134-1-nsoffer@redhat.com>
In-Reply-To: <20200831140127.657134-1-nsoffer@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 14 Sep 2020 20:19:14 +0300
Message-ID: <CAMRbyyvyjJW3bQR7FUhBnjTDv6ZecMyW4i6R9KR5JPPqxDc_1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Replace posix_fallocate() with falloate()
To: Nir Soffer <nirsof@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 5:01 PM Nir Soffer <nirsof@gmail.com> wrote:
>
> Change preallocation=falloc to use fallocate() instead of
> posix_fallocte(), improving performance when legacy filesystem that do
> not support fallocate, and avoiding issues seen with OFD locks.
>
> More work is needed to respect cache mode when using full preallocation
> and maybe optimize buffer size.
>
> Continuing the discussion at:
> https://lists.nongnu.org/archive/html/qemu-block/2020-08/msg00947.html
>
> Nir Soffer (2):
>   block: file-posix: Extract preallocate helpers
>   block: file-posix: Replace posix_fallocate with fallocate
>
>  block/file-posix.c                     | 202 ++++++++++++++-----------
>  docs/system/qemu-block-drivers.rst.inc |  11 +-
>  docs/tools/qemu-img.rst                |  11 +-
>  qapi/block-core.json                   |   4 +-
>  4 files changed, 127 insertions(+), 101 deletions(-)

Ping


