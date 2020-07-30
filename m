Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0922C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663C12074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHcipVi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663C12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k167e-0007K6-Mt
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k166l-0006s6-5q
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:48:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k166j-00081r-HV
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596106096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jsk36ivxNx3QKwiETnhPq7voIDVHx7X8KyNXJOMbugQ=;
 b=OHcipVi6FtUzAVsZCbZdjCQvCf51GhA1DNfo5dn+qXA8qha5lf3ZI/MhNNXoSNeMnMEIK9
 OWZUSYDsOyZ4Zxlo4S/7e2wUg8HbWtd1jhWVrfoQgvUay7I8MS8un4BhfWF3d5L1vxuuFA
 05w/R2sOpBb2v//68kG8NuGneyD2iZY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325--GkF3FZAPduQEryjtDL1Ag-1; Thu, 30 Jul 2020 06:48:15 -0400
X-MC-Unique: -GkF3FZAPduQEryjtDL1Ag-1
Received: by mail-wr1-f71.google.com with SMTP id k11so7275133wrv.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 03:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Jsk36ivxNx3QKwiETnhPq7voIDVHx7X8KyNXJOMbugQ=;
 b=kvJ4itNeO91d50zJg3T0WtmSxLPfg+HfyBi6Klg+T7pBxgSTaB+utnnYrP42H1PG/P
 jK8JQsEz1UROMcyM1NlSG/vlpS45KJR7twWmlrBJACmRm/CtaWndslSiUkvgRf5An6Jk
 wSoFi1khn9ZxIgfIhpwai6C6qItdIi2RaGJlcQD1ZmgGsPFXYaDv6RaLDEPvK0tgSC0r
 tiAyHTC4I+aF28eqL8tbFXggt+xQzuIxBstKBFZEgUJLssQWglmxVutEKL1ItXbKdMuE
 9hzspinkA7KMUG1pw98EIgIkSW2mVcrn0o4sCI73RD9mz1vHASJnfZu6IDdm5d99Jftb
 5rAg==
X-Gm-Message-State: AOAM531TuyB5vZR8NlkvOXZ7LknxQNGNR9+xvDT20Ci2EPw6Ho6GzzE/
 DNkD9QaM0E9dueNfFlYIG1t3/EYng8YIo3TDHLmoWbL0L2d1csC7nlrt7R84Gr5IE52j48C6fqZ
 TvDw6jBDp/Mopt+s=
X-Received: by 2002:a1c:7915:: with SMTP id l21mr13437006wme.50.1596106094114; 
 Thu, 30 Jul 2020 03:48:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+QZRp5LeB1NgHCQpEHGDSjI8LwW0SDMfPb1YpmDeIpkDINjg2FpK7JxDl2rUh0Q0OZ79sVw==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr13436987wme.50.1596106093902; 
 Thu, 30 Jul 2020 03:48:13 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id j5sm9023906wmb.15.2020.07.30.03.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 03:48:13 -0700 (PDT)
Date: Thu, 30 Jul 2020 12:48:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] pci_dma_rw: return correct value instead of 0
Message-ID: <20200730104804.apxqhhaszjnef77d@steredhat.lan>
References: <20200729221732.29041-1-e.emanuelegiuseppe@gmail.com>
 <20200730074146.b66tur2v7tx4uo3d@steredhat.lan>
 <CAFEAcA9A6_S0NEzjmjvxJofFQVKgZS2U_YjgW7jwEo--irNQyw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9A6_S0NEzjmjvxJofFQVKgZS2U_YjgW7jwEo--irNQyw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 09:58:21AM +0100, Peter Maydell wrote:
> On Thu, 30 Jul 2020 at 08:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
> > I agree that it is better to return the dma_memory_rw() return value, but
> > at first look, no one seems to check the return value of pci_dma_rw(),
> > pci_dma_read(), andpci_dma_write().
> >
> > Should we make them void?
> 
> In general code (eg device models) that issues memory transactions
> need to have a mechanism for finding out whether the transaction
> succeeds. Traditionally QEMU didn't have the concept of a
> transaction failing, but we have added it, starting with the
> APIs at the bottom level (the address_space_* ones). We haven't
> always plumbed the error-handling (or the memory-transaction
> input, for that matter) through to some of these other APIs.
> I think for consistency we should do that, and ideally we
> should make all these APIs look the same as the base-level
> address_space* ones, which would mean returning a MemTxError
> rather than a bool.

Yeah, that makes a lot of sense to me.

> 
> We should also figure out why the dma_* functions exist at all:
> they include some calls to dma_barrier(), but not all devices
> do DMA with the dma_* functions, so we have an inconsistency
> that should be sorted out...
> 

I've never looked in detail, but I agree we should have more consistency.

Thanks for the details!
Stefano


