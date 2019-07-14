Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71331C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 14:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394E620644
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 14:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g92aXMLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394E620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60917 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmfsX-0004Kn-Hg
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 10:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55238)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hmfsO-0003wT-KU
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 10:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hmfsN-0004PH-NK
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 10:53:20 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hmfsN-0004O3-Er
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 10:53:19 -0400
Received: by mail-lj1-x243.google.com with SMTP id 16so13641944ljv.10
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dAqeL5r8KlQ2MbAqgIH356bMtfzDzTA7TkWlTL0ypME=;
 b=g92aXMLSJKQLT/jECsfEtlwWevz5H1lU4TaoF6RI8rTRU8kfmcsIrbF75vlgNk7x3T
 OA99+ewaogDjq+bw1DAKZfaWcXQ2o2FjPZqCIKGbnF5SNAdJOTpNi3dca+KmKK3iZ9MG
 cYyrkSqwgI2LXw6SSyhnD5HMxJBm2+XMbKdl5ts83wiAdT7sIHRpVsLSYsVFgxs1EwdS
 ncjZKALf7TXDnuGfzhlzwXdrKmL2niRqDCwbKKZGx3Ws+7plXEAvg6iAnNYgXVCu4+t5
 7pCHQRSFOZ1WkJdR9Omh5uP8V2T5/fwlLqVbiN9NYPv+x2V17Hq3cgP9KfsiHOavKT3M
 xA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dAqeL5r8KlQ2MbAqgIH356bMtfzDzTA7TkWlTL0ypME=;
 b=nIA4p6tQ7zzXFmOylSjPZCSfLFIW2CkqgKrmcYHVoBzlfgI9SJynAPsSD1MxkHqVqt
 P2kfcpuS1iRkdACct10K2HFq8YYZmUxntHIpBUect8gpJvRcblrTdNHy7LqHinR6Ru2E
 8Ef7AQbI5/5hqlAA+3lSvdu6Wh6x0OGdLPt1wobwoCcG+epY0O1PK4hEbO8z7CwzYAOL
 sL8urQJv+HOa2oHwan4T5Q+XjF8R//SWu3basRCfWCu+3GWQ4OWe4ZoYY6DFD4jwx6E1
 Weuas0p+BPHCFpcdP6hWpOsNmVUlxgFqDpdCJGij706amX1nxnds3nWLh1Sit+aMMeJ+
 eZZQ==
X-Gm-Message-State: APjAAAWnSvrqdUKPWp22dfbMXjD29ehiamB6O2j+2LvdRTEbNDNODCC1
 w3ymztgBDU73UNSOJmvREvnYF4M3gqtOCt1KWfY=
X-Google-Smtp-Source: APXvYqziteOREfEraZyHXf21j0YBNoKIPwCv64kwPqgEj15Mu2ZKZ1UaWIPgQ7DMoarqTBaU/pIEPdF3QwTf8scRU3M=
X-Received: by 2002:a2e:9a49:: with SMTP id k9mr11183474ljj.78.1563115997646; 
 Sun, 14 Jul 2019 07:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
In-Reply-To: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
From: Ivan Ren <renyime@gmail.com>
Date: Sun, 14 Jul 2019 22:53:05 +0800
Message-ID: <CA+6E1==9SCRd4aVm0_M7gHbMNPhVsBExof4+DeDCGiFDZwkpMA@mail.gmail.com>
To: quintela@redhat.com, dgilbert@redhat.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/3] migration: fix migrate_cancel problems
 of multifd
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The problem still exists in mainline, Ping for review

On Tue, Jun 25, 2019 at 9:18 PM Ivan Ren <renyime@gmail.com> wrote:

> The patches fix the problems encountered in multifd migration when try
> to cancel the migration by migrate_cancel.
>
> Ivan Ren (3):
>   migration: fix migrate_cancel leads live_migration thread endless loop
>   migration: fix migrate_cancel leads live_migration thread hung forever
>   migration: fix migrate_cancel multifd migration leads destination hung
>     forever
>
>  migration/ram.c | 62 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 51 insertions(+), 11 deletions(-)
>
> --
> 2.17.2 (Apple Git-113)
>
>
