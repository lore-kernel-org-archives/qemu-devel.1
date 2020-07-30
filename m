Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C20C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E4C2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpujOq7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E4C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k17eN-0005bl-67
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 08:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k17dj-00055a-PK; Thu, 30 Jul 2020 08:26:27 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k17di-0005er-6w; Thu, 30 Jul 2020 08:26:27 -0400
Received: by mail-oi1-x244.google.com with SMTP id k4so23578478oik.2;
 Thu, 30 Jul 2020 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qzBKBEOXkUl7zvcF9gGgLTZpnx9+/FZa7VaZoeoxtSs=;
 b=IpujOq7utBhHlQtJ1DJfH1GY5JLGEnV0++YxzFvkXI7/4KTDUD6QHiOPE6PimeexEf
 66OPMZ8TJKPqNEUf0i7paBDUr7vW7nQI3PZfuNwhprQO5UbQh91NGY2hE059qFW878zN
 fYL4gtw38i6oIxt7WLGH75Ta01+cLaDjKRnWKRf3k11nhBRdGaUREaxqTRvb+3bk6DZj
 TIrX8rjpfsfsggpzP2snuwabg2KyL/a6THKLWSXAxw5ZLfXoi6MTsMpIA4u+O8zNGZ6l
 S9v/QAch2djEA37OLmSYY5U/2xTw+ZLpPCK547NCYd99zJeXM7uk9rrxrWcLJF5llWhf
 sbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qzBKBEOXkUl7zvcF9gGgLTZpnx9+/FZa7VaZoeoxtSs=;
 b=N76jFkcUvqybGYQ/ZXoOz2PUo/L6NPe/wRj94QU4224W0/B6+s5mGFeCt3jVkHhji5
 PP8xy6z+N3UgnIol282ma1o3nRgPZbLSo6+6jWzaKhp0Va0AMTROBFfQMIwpbkipf5dB
 pqFvKqukAOLHoU9EGORvnbxnLCuuBwQxT224ZSH11Y3TNVZEPavXQOn6H3rZQiiveO0F
 C8d/lVdra+aUWCgZwYwh0wyhsS16YgeyA6G7cF0aWk2YF09DcnGk9BhlKjLP4XTAARxD
 8mimdWbPYsExpnLM9XmnIsJyyofD8OZkeq+KXF6dY5sydzfGqNBeQ/B8zL7KQsEQmR/T
 jqsw==
X-Gm-Message-State: AOAM531BQmHycuIAKzxOwajmz6+VwIGkaLL8BXRAxxgA5iwxpmghrfd0
 VfzjAh2NlwmS4WTd6b7yi6OK6NGwqGmZ9OtRisg=
X-Google-Smtp-Source: ABdhPJzFol7oYEZgwu0pOehXq9rb54PvmzBiA6gh29XbQESHyJEzGrjqtvVLrUtKJsbj1m5emptc4zN5Irac6qn2uXk=
X-Received: by 2002:aca:1016:: with SMTP id 22mr10798383oiq.66.1596111984896; 
 Thu, 30 Jul 2020 05:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-15-its@irrelevant.dk>
 <20200730103117.5f7pd6cv3vgqh2mx@localhost.localdomain>
 <20200730110933.GA504315@apples.localdomain>
In-Reply-To: <20200730110933.GA504315@apples.localdomain>
From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Thu, 30 Jul 2020 21:26:13 +0900
Message-ID: <CAA7jztdw-8akL3cSZurPPeWqxmR3x-TMcm5Scs8wH4+L=TgzSQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] hw/block/nvme: consolidate qsg/iov clearing
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Hi Minwoo,
>
> The is that on 'exit' we release request resources (like the qsg and
> iov). On 'clear' we initialize the request by clearing the struct. I
> guess I could call it nvme_req_init instead maybe, but really - it is
> clearing it.

Yeah, I just wanted to make it clear to understand myself here.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

