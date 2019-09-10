Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6B8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6210920872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6210920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7clO-000475-Hk
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i7ckX-0003f3-GJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i7ckW-0006Sg-Cz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i7ckW-0006S9-5a
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:47:48 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DFAB5C08EC09
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 09:47:46 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n6so8693918wrm.20
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ksm4yNXeWk/Iffo4gb1llKUCbCqubT66WiDLcZg2Eew=;
 b=TNwGwQm6baxrkQFh57Cf9M5LnhhabljfTmYMJYdonQmGmGbBFFnJ0o8Oteo2JsZvLf
 W4vBSSroaOgbUllhCkygPMpvrGWDSOqKVoAuC+l58EYm0Ghq83yNpaCVd30UC3BnuF9E
 JdUUECCx1ELopr0wT15C/RQo7edmOczzfujMFIVOPLfeNhmLDjzk8cWgtfjrrnPkMR5T
 Dbecy1uv9NExsGCEpxLlcv3A3uFo7RToVd2NOA7RHquoxPtNDp2LrFrOzspkwnppRrYQ
 BZ3wn8ogQ+KBgGgm9CK2ilBH0RSkOPU694OBxFFOoOv/UL1CLD74YxQLlydN2quA1qyk
 dPrA==
X-Gm-Message-State: APjAAAVC8pq2tXahidIEVcpvXmYJxS9CArZFU5/he+XW29wlzV7GQsne
 3tsXkwnkcWqTxBN1gJnZ/IjlM2FLCLuGzxa0V75nq2bE5tfj67vbAhtmU7g0gqE6DtBA8NTTqVb
 /nBvhYm5EUi85S/8=
X-Received: by 2002:adf:fc05:: with SMTP id i5mr19710012wrr.134.1568108865654; 
 Tue, 10 Sep 2019 02:47:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhLXk4NuEC7VszMNDqWtq7LnKhAb1klay10gwQr5QvIWlvU0y3LwV4Z/lgb1ceh/+DO+3W6w==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr19709989wrr.134.1568108865425; 
 Tue, 10 Sep 2019 02:47:45 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id r28sm23659898wrr.94.2019.09.10.02.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:47:44 -0700 (PDT)
Date: Tue, 10 Sep 2019 11:47:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190910094742.iwltoez5fovi2hj3@steredhat>
References: <20190910090821.28327-1-sgarzare@redhat.com>
 <CAFEAcA8tZgoC=U5-K7m=Lq-vhb65-jPadjV6_mKAD7Z4_fXs8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8tZgoC=U5-K7m=Lq-vhb65-jPadjV6_mKAD7Z4_fXs8g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] elf-ops.h: fix int overflow in load_elf()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 10:37:28AM +0100, Peter Maydell wrote:
> On Tue, 10 Sep 2019 at 10:08, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > This patch fixes a possible integer overflow when we calculate
> > the total size of ELF segments loaded.
> >
> > Reported-by: Coverity (CID 1405299)
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > Now we are limited to INT_MAX, should load_elf() returns ssize_t
> > to support bigger ELFs?
> > ---
> >  include/hw/elf_ops.h | 6 ++++++
> >  hw/core/loader.c     | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> > index 1496d7e753..46dd3bf413 100644
> > --- a/include/hw/elf_ops.h
> > +++ b/include/hw/elf_ops.h
> > @@ -485,6 +485,12 @@ static int glue(load_elf, SZ)(const char *name, int fd,
> >                  }
> >              }
> >
> > +            if (mem_size > INT_MAX - total_size) {
> > +                error_report("ELF total segments size is too big to load "
> > +                             "max is %d)", INT_MAX);
> > +                goto fail;
> > +            }
> 
> This function doesn't report issues via error_report()
> (some callers intentionally have fallback options for
> what they try to do with the file), but by returning
> a suitable error value in 'ret', so I think we should
> continue that approach rather than adding an error_report()
> call here.

I agree, maybe I can add a new macro "ELF_LOAD_TOO_BIG" and
add the error message to load_elf_strerror().

I'll send a v2.

> 
> I agree that accumulating the size in an 'int' is a bit
> dubious these days.

Maybe I can send another patch to change it and wherever it's used.

Thanks,
Stefano

