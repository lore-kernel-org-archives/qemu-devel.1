Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2927C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD42208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aepH7gb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD42208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSV8z-0004oE-0j
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 20:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kSV8L-0004MV-3P
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 20:59:13 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kSV8J-0007Hx-Kn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 20:59:12 -0400
Received: by mail-oi1-x243.google.com with SMTP id l85so1444324oih.10
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 17:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M30VCh9yHCgm7T+NLq3kbfMrz3+N43ywxuK4/Rxhmhk=;
 b=aepH7gb7u5z5Q4kloeQLJbiORCh2b62JxQKVWOWgx08D7E9YLV/2Wsi49YGRzTl2ij
 +MyzRjPGhNM3WhRpBoCptU/gQYd1t7Oig5sH6YqN+pGHSVfSRVc1zy3MMRezZ3ZBNAFH
 hWoWwQTrUATOekLLg9+j+yGnqL/lqRrhBxe44zHHTE8poV3JFSWsEozdlwcArGvx1XpP
 MdlXmPn/8shpraHl58Mr0Mz0ip/ZC4etCkv2+I+z2MBkg8nGN1b9o8rtLJk34bNIcKH6
 0wGc3Vonj184K8M+9JZK8C/+FiqPO75CSiP4KquSeXrnUyQ7tEKy20ZdCQHZrU3gsF3D
 Lrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M30VCh9yHCgm7T+NLq3kbfMrz3+N43ywxuK4/Rxhmhk=;
 b=iRRKRwCXkqc9ESd+FV8mQItFnljgprGfcq5xRxQ+5ulphGsIfpWqphPCTy0X6tUlrh
 RNhSQDR1eAcves1vRgGnrIbEjFEWwGMmhK1EkU+ZJZce/1HhaQ6GT/Nmoykdp/37siaD
 2fFKxpbTvsaqn8Mn+ZnzEsNbkWpJTW9kM3AVlTzkxHRQSDKNUMa7E6HXFdBvOZdLThRq
 deKML9Y4Sg5rSDjoUu5AUCDDibzs1TM0fYeb+jXquYWnGglAPeL8+tfcd81QSZkTblFv
 a3WT1GnOMI03BZtJWar0zbPCHS9eaaAwZLi6LhaVKBF5TmM4R9RKNqzYTilV6L6M6jes
 wxbw==
X-Gm-Message-State: AOAM533atXTaeFf7tDixmV20JTZs6WDLq8pM5F0csirU0k+iku8VyFQg
 z436ZNVLVtF+JzJRvE+v+T0holqoSxNf/hZmYnI=
X-Google-Smtp-Source: ABdhPJwuSvRzXmhGWUhqVRsmQANdV2DYHsx0HKZJuRtvGuLete1R05fQztwUCAlnhiG+luWqhW6F+pyr9UyHw9MjM0A=
X-Received: by 2002:aca:724a:: with SMTP id p71mr651955oic.157.1602637150031; 
 Tue, 13 Oct 2020 17:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131731.69684-1-chenjiajun8@huawei.com>
 <20201006114801.6833a72d@redhat.com>
In-Reply-To: <20201006114801.6833a72d@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 13 Oct 2020 20:58:59 -0400
Message-ID: <CAFubqFtqXorzk6g9d3A3TFcPnE9eSJKsjfSCK5zwTNX6xtJ3kw@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, QEMU <qemu-devel@nongnu.org>, xiexiangyou@huawei.com,
 Jiajun Chen <chenjiajun8@huawei.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 6, 2020 at 5:48 AM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon, 28 Sep 2020 21:17:31 +0800
> Jiajun Chen <chenjiajun8@huawei.com> wrote:
>
> > Used_memslots is equal to dev->mem->nregions now, it is true for
> > vhost kernel, but not for vhost user, which uses the memory regions
> > that have file descriptor. In fact, not all of the memory regions
> > have file descriptor.
> > It is usefully in some scenarios, e.g. used_memslots is 8, and only
> > 5 memory slots can be used by vhost user, it is failed to hot plug
> > a new memory RAM because vhost_has_free_slot just returned false,
> > but we can hot plug it safely in fact.
>
> I had an impression that all guest RAM has to be shared with vhost,
> so combination of anon and fd based RAM couldn't work.
> Am I wrong?

I'm not sure about the kernel backend, but I've tested adding anon
memory to a VM with a vhost-user-scsi device and it works (eventually
the VM crashed, but I could see the guest recognized the anon RAM).
The vhost-user code is designed to work with both. I'm not sure I see
a use case, but if there is one, this would be a valid issue. Maybe
Jiajun or Jianjay can elaborate.

>
> >
> > --
> > ChangeList:
> > v3:
> > -make used_memslots a member of struct vhost_dev instead of a global static value
> it's global resource, so why?

I suggested it because I thought it made the code a little cleaner.
I'm not opposed to changing it back, or having it stored at the
vhost_user level.

