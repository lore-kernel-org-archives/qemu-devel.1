Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB10C76191
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B0C22CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B0C22CD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0VV-0001i4-0P
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40738)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hr0VE-0000n2-2o
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hr0VD-00074U-03
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hr0VC-000740-RH
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so48380552qtt.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tpz0o0HtptiqWAbyMgcqjARVOPDVa2onb/Cwo4qFEWc=;
 b=ab3LWVlrxj9JyfL9S+BOhOFEIsosIly8t1ENn18Q1rbSw5FgMFYLXVH++Jn37+v2eS
 4gukVRsvV1El+iObqkaxrFnPfI5/j3vunTNITd4yvQEFh92vzumC1S8I8BVo0+SjBuLd
 RJK0k9wYiyGUkwYLx1l40sitmu6PkkjKf3WP87hTqFmP838wbpARD5AY054RXQY6kXMX
 eVKWN836RO8gkZwrwB/3k4uGxQQCRU04IvxPXd11GwGhQkvY8uRVShOLiPx7SxxjG23t
 HTL199AfFf4unj9xidVqufVQUiEOtCr2S4Z6YkgHU5/AUAtkdq0Ex8ZFi+LiJaOVgzMV
 nv4w==
X-Gm-Message-State: APjAAAVhU6zDBJKf3j42WRyvm8RCP+IbBePn21oJj96bzeyViQi1Ocgt
 k45nJAaLGRRRJ+chtVj9XygSgw==
X-Google-Smtp-Source: APXvYqx2i1owEavULFhYd7NwT9gUGptScRiUFymPV4s+qGuDDDGw7l9IODhtjXc0uUD/8Chy68RLTA==
X-Received: by 2002:a0c:afbd:: with SMTP id s58mr68457919qvc.217.1564148597984; 
 Fri, 26 Jul 2019 06:43:17 -0700 (PDT)
Received: from redhat.com ([212.92.104.165])
 by smtp.gmail.com with ESMTPSA id x23sm21612349qtp.37.2019.07.26.06.43.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 06:43:17 -0700 (PDT)
Date: Fri, 26 Jul 2019 09:43:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190726093727-mutt-send-email-mst@kernel.org>
References: <20190702150606.24851-1-mst@redhat.com>
 <CAFEAcA-Qcq1ZmfDO_dkh_H9-aeQVU83ceLKU1NXM3VpW8g5sPQ@mail.gmail.com>
 <20190702124823-mutt-send-email-mst@kernel.org>
 <CAFEAcA-UFks7CmtcMT15KzK3TzRqGjwXWtFa8K6XZ=Bks92CJw@mail.gmail.com>
 <20190702142058-mutt-send-email-mst@kernel.org>
 <CAFEAcA_c3UXPVy_rXR_FxyXRw5ZE1-QgumPr9B-j+pmvBGWgpQ@mail.gmail.com>
 <CAFEAcA8EQPdNTDf_t2aFDkfBj8iSevYpVCxTjjuX9NFGJJbTkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8EQPdNTDf_t2aFDkfBj8iSevYpVCxTjjuX9NFGJJbTkg@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes,
 cleanups
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 01:39:26PM +0100, Peter Maydell wrote:
> On Tue, 2 Jul 2019 at 19:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 2 Jul 2019 at 19:22, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Jul 02, 2019 at 06:20:01PM +0100, Peter Maydell wrote:
> > > > On Tue, 2 Jul 2019 at 18:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > This isn't from mainline. We have a bit of a deadlock with linux merge
> > > > > window opening soon. I think it's reasonable temporarily
> > > > > and then before release either virtio-pmem gets there or I will
> > > > > revert it and drop the header.
> > > >
> > > > It's definitely not ideal: until the headers are actually
> > > > upstream there's no guarantee that they won't change ABI.
> > >
> > > But then I'm watching it, if I see that I'll drop the device from qemu for
> > > now.
> >
> > OK; I guess we can take this for now if we make sure we revert
> > if the headers aren't upstream by the time we get to say rc2
> > (23rd July). (That is, we'd want to do any revert shortly after
> > rc2, since rc3 might be the last rc before release.)
> 
> Ping for status update -- have the headers hit the mainline
> kernel yet? Do they match the versions we put into QEMU?
> 
> thanks
> -- PMM

Yes they do: here's the diff:


diff --git a/include/standard-headers/linux/virtio_pmem.h b/include/standard-headers/linux/virtio_pmem.h
index 7e3d43b121..c5f610ed6b 100644
--- a/include/standard-headers/linux/virtio_pmem.h
+++ b/include/standard-headers/linux/virtio_pmem.h
@@ -7,8 +7,8 @@
  * Author(s): Pankaj Gupta <pagupta@redhat.com>
  */
 
-#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
-#define _UAPI_LINUX_VIRTIO_PMEM_H
+#ifndef _LINUX_VIRTIO_PMEM_H
+#define _LINUX_VIRTIO_PMEM_H
 
 #include "standard-headers/linux/types.h"
 #include "standard-headers/linux/virtio_ids.h"

Didn't decide whether I want to update it now or after the pull,
but it shouldn't matter. If you want to do an update now, go ahead.

-- 
MST

