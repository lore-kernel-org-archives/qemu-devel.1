Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B101C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 22:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049BB23A6C
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 22:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zq7VBgDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049BB23A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn8Q6-0001lq-AI
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 18:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jn8P9-0000sh-Ao
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 18:25:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34373
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jn8P7-0008LW-M4
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 18:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592778332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wLh05LSu5IVTmVOLm3gE1g6oKmi9TWvu2g0h8UTKqm8=;
 b=Zq7VBgDfEVKFun3fb22CmOiT+znHNsmCK3qFiuUfX6boRxXH8vXJbuD3ZKUHano4KWOzcf
 iVo5+ehRgcXJGRsj51lFvkrcKJTAAyNYpyP5XL8wdsXrtNFRhPwaQjGFf65qCBYbyFKhTs
 Sere89vnnE5PMYnoMgzvCBojCfYJwGU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-H9kFcnOiOhS81lOj2uwgfg-1; Sun, 21 Jun 2020 18:25:26 -0400
X-MC-Unique: H9kFcnOiOhS81lOj2uwgfg-1
Received: by mail-oi1-f198.google.com with SMTP id n130so7313814oig.9
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 15:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wLh05LSu5IVTmVOLm3gE1g6oKmi9TWvu2g0h8UTKqm8=;
 b=JuEhfse/wD0pLFvwOhTKbi9bAFmMJVV0vkqrAS3dDIO1NQ42WkVJYbqtoKAmGGHYTb
 wU4PsAVfsFAlp9uzrB7ZUPeoqHDjfiyz3FwaRy/82XxvxMvkR4ulRgPN5cX1XW+N3Lck
 RE4eCz1pldM96SDnJvPCfKjSIWvVeyDb2oxAoaISq5zKtnEnyAIpMXYvf7HQ2Ld5Cpp0
 HI6KosaXNAI0a5YRAPcE5D2aaTlsHg+eyI53hD4O9UfY4DTIWMK8V7r1V4vSjP/7xAzi
 XTXcqfJx9CUY7Wr+hxGfZqv872zoK0gi/Mck+bmICkzu0nrTRQfKr7j6P2HpoRovetqN
 3T1A==
X-Gm-Message-State: AOAM533JB5QQJrX9VWC4QrjPhnfCkZaAvJHnDDYe/t3ZVOvPBpHPHn02
 q+FVoqIqZ4g1IJWBQ1gZ7hnSdHl5nH3lF0tGdm2T60W6rp0wm7c5g4C+n9rZBf4mf9hEDcYdFQ4
 A1D/DUjiAeJ2MNhRwPdEOg1uMt3WPkHM=
X-Received: by 2002:a9d:7f06:: with SMTP id j6mr11363493otq.132.1592778326048; 
 Sun, 21 Jun 2020 15:25:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSSRdCqdrlNLW7xLwDy6aKV68FUSnJ3Q5TY5wk9ogz0NwzgbTItIVabCNvp69e20SAsCaxV0SpeWL1rFRmlCg=
X-Received: by 2002:a9d:7f06:: with SMTP id j6mr11363484otq.132.1592778325759; 
 Sun, 21 Jun 2020 15:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200619104012.235977-1-mreitz@redhat.com>
In-Reply-To: <20200619104012.235977-1-mreitz@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 22 Jun 2020 01:25:09 +0300
Message-ID: <CAMRbyyu1ZC2qMKSHJXNy7-98-nXHh00dL-v_D0BKcEL6Rmmj+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] qcow2: Force preallocation with data-file-raw
To: Max Reitz <mreitz@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 17:35:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 1:40 PM Max Reitz <mreitz@redhat.com> wrote:
>
> Hi,
>
> As discussed here:
>
> https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00644.html
> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00329.html
> https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00240.html
>
> I think that qcow2 images with data-file-raw should always have
> preallocated 1:1 L1/L2 tables, so that the image always looks the same
> whether you respect or ignore the qcow2 metadata.

I don't know the internals of qcow2 data_file, but are we really using
qcow2 metadata
when accessing the data file? This may have unwanted performance consequences.

If I understand correctly, qcow2 metadata is needed only for keeping
bitmaps (or maybe
future extensions) for raw data file, and reading from the qcow2 image
should be read
directly from the raw file without any extra work.

Writing to the data file should also bypass the qcow2 metadata, since the bitmap
is updated in memory.

>  The easiest way to
> achieve that is to enforce at least metadata preallocation whenever
> data-file-raw is given.

But preallocation is not free, even on file systems, it can be even
slow (NFS < 4.2).
With block storage this means you need to allocate the entire image size on
storage for writing the metadata.

While oVirt does not use qcow2 with data_file, having preallocated qcow2
will make this very hard to use, for example for 500 GiB disk we will have to
allocate 500 GiB disk for the raw data file and 500 GiB disk for the qcow2
metadata disk which will be 99% unused.

I don't think that kubevirt is planning to use this either, but if
they decide to use
this it may be a problem for them as well when using block storage.

It looks like we abuse preallocation for getting the side effect that
the backing file
will be rejected, instead of adding the validation rejecting backing
file in this case.

Nir


Nir

> Max Reitz (2):
>   qcow2: Force preallocation with data-file-raw
>   iotests/244: Test preallocation for data-file-raw
>
>  block/qcow2.c              | 22 +++++++++++++
>  tests/qemu-iotests/244     | 65 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/244.out | 32 ++++++++++++++++---
>  3 files changed, 114 insertions(+), 5 deletions(-)
>
> --
> 2.26.2
>
>


