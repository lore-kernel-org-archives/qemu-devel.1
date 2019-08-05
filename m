Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CC7C19759
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 01:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7588520B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 01:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0NI3rWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7588520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huRcu-0002Qs-Gd
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 21:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45734)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1huRc5-000210-2n
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 21:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1huRc4-0005l0-1a
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 21:16:36 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1huRc3-0005kl-Tx
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 21:16:35 -0400
Received: by mail-io1-xd43.google.com with SMTP id j6so44083991ioa.5
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 18:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A+CXHMTEp2iXxLBY1jr9wyuIUqoe8AYbxPBtOmXAoqY=;
 b=P0NI3rWAY2Qhua/QjquxKASuQ7kCwNdfSyWWGq3F0Co35I9vThDvpgt5OGgEN0Axtu
 Ar9Ar4iLOtoW0OKywdrmyhbKWRPnojy5TpZT/V5qznta9bcOWvnFSVGxXpylOE8+LAGs
 tML0db0W+OiPtzLSEcaMyfAiBBdEpolapI6f0FjnlXJk93K0tm1hOBvj97M2077lTv+f
 HwuTDavlQ0BR4p08C8b7d02UgklOqwuNh5eCbWmM1hYYEl3J5MWrDSinRJlyakXNnl6L
 25yZ/ife9CAvWpLGMsqfgf+rX0NMmBuD1rKxs4kEE56DJ3yDlXWGbOhXmRMvrr7CMbvj
 zOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A+CXHMTEp2iXxLBY1jr9wyuIUqoe8AYbxPBtOmXAoqY=;
 b=OC+4VXYg21Y858SEZSfECSP+HNw6xWig1MnqSOlxG98uZJDPAGIDHOIcqU/4Fu8sRG
 WB+pPighLuwmqFrhJzuLJmKkgYVot3NFx/01HHpos0HOpAsyuhmOtlJYK1JpER+IBLfm
 SNZu5VGwxJ7AGf5CGvZm5D1sQthDTOjYXOo2ou2IwBmp+aU5EE4o0fTvuNtp9ZJNwGvo
 VR1MEc//o2lSCZ3/LvQoQnwaBcnImf/43Wgn/IChhDgIQxSVyawcake3pGUorJJUTMTN
 Euh/JTcol4wZbrOGmeJIFXoiiLIqYAMvBvoxu9r/Z7apAxTfVWCwLTuogdktzChek+Ee
 eSug==
X-Gm-Message-State: APjAAAXvxa5Qd3boIHWlFlRcEPCxaN50pbDBjp7TPIr2j22vnAFDjDdt
 N9uHVq1XZP1JwEAC0ynwrgJfmDEhpKw6rX/SeqQ=
X-Google-Smtp-Source: APXvYqw5Q+QNSMDYU1wq505loPiwOYNWu6zEjn19Bw++UsNVKxSWJ9rezmLa44FEuS2pORvguNFs9bE7gYLB/69D+jI=
X-Received: by 2002:a02:85c7:: with SMTP id d65mr38695326jai.8.1564967794946; 
 Sun, 04 Aug 2019 18:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <1564741121-1840-1-git-send-email-ivanren@tencent.com>
 <20190805003350.GA1311@richard>
In-Reply-To: <20190805003350.GA1311@richard>
From: Ivan Ren <renyime@gmail.com>
Date: Mon, 5 Aug 2019 09:16:24 +0800
Message-ID: <CA+6E1=mweGaPh6wbnuXFvNf4ojSVZrjCBRuLH5AgC3AqbnNFmA@mail.gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH v3] migration: always initial ram_counters
 for a new migration
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 5, 2019 at 8:34 AM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> On Fri, Aug 02, 2019 at 06:18:41PM +0800, Ivan Ren wrote:
> >From: Ivan Ren <ivanren@tencent.com>
> >
> >This patch fix a multifd migration bug in migration speed calculation, this
> >problem can be reproduced as follows:
> >1. start a vm and give a heavy memory write stress to prevent the vm be
> >   successfully migrated to destination
> >2. begin a migration with multifd
> >3. migrate for a long time [actually, this can be measured by transferred bytes]
> >4. migrate cancel
> >5. begin a new migration with multifd, the migration will directly run into
> >   migration_completion phase
> >
> >Reason as follows:
> >
> >Migration update bandwidth and s->threshold_size in function
> >migration_update_counters after BUFFER_DELAY time:
> >
> >    current_bytes = migration_total_bytes(s);
> >    transferred = current_bytes - s->iteration_initial_bytes;
> >    time_spent = current_time - s->iteration_start_time;
> >    bandwidth = (double)transferred / time_spent;
> >    s->threshold_size = bandwidth * s->parameters.downtime_limit;
> >
> >In multifd migration, migration_total_bytes function return
> >qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes.
> >s->iteration_initial_bytes will be initialized to 0 at every new migration,
> >but ram_counters is a global variable, and history migration data will be
> >accumulated. So if the ram_counters.multifd_bytes is big enough, it may lead
> >pending_size >= s->threshold_size become false in migration_iteration_run
> >after the first migration_update_counters.
> >
> >Signed-off-by: Ivan Ren <ivanren@tencent.com>
> >Reviewed-by: Juan Quintela <quintela@redhat.com>
> >Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
> >---
> >v2->v3:
> >- fix the bug of update_iteration_initial_status function prototype
> >
>
> Code looks good. Have you verified on this version?

Yes

> BTW, you didn't address the multifd count in this patch, right?

Yes.
Currently multifd page count has no harm, so I think it's better to
optimize it in a new patch to make things clearer.

Thanks.

