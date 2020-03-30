Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72127C2D0F0
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8982072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwVNjJ1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8982072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIs8i-0001iH-D4
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 06:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pankaj.gupta.linux@gmail.com>) id 1jIs7x-0001IT-JK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pankaj.gupta.linux@gmail.com>) id 1jIs7w-00024T-Kh
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:58:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jIs7w-000237-F3; Mon, 30 Mar 2020 06:58:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id 31so21031507wrs.3;
 Mon, 30 Mar 2020 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Oq85Kv8Q2AnOzhchKRfF2cZCLjCk+7ncSapWENTEmk0=;
 b=jwVNjJ1MOEw0XVflNsnNMbRA+wukQTyIsXw/qlSJ4wWLYaEIf0Sfa6FdkfnhnwhCRM
 ECd3AoJclNgrp77V3Q500SKGA06dn33VMnTmJyNK7Y7QKmShcvSbBi1NCq3QRC2nh6dC
 JMZK4CCjEysoRSPQ/i2aH3+zrxC9ZJ5xG+2bPUBknkDixaM8eQtrzvn1I02CaaQsOFTt
 cBUqtVlZaTFzu6fXrxGRNlycScrBuu6wAq1VVVUCaxNzMUkLNjPjLObja2zL2gdQnpIq
 IcaRFL9TwWXZkS39M0ayePJQZzeRJN0LHUkAsoWNKYQyjSTuGTEmOTznmRdqwzXF9BXM
 UJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Oq85Kv8Q2AnOzhchKRfF2cZCLjCk+7ncSapWENTEmk0=;
 b=A2DwkdTVA6Qbqf3+lVym6O0H19p/yjc3aF3d67Zxizlw722+4neNYP1h1JbgeZ3f45
 1H0WDF0s0xEhEyQFETI+vLE+dYH1iHGkMK8WsQc+aHcYBxlK4J80LsTS2SnAFvj9CFN+
 GHM5S1awZAWut0iHQN+kFOAJ0DshiEl7BtUTuATd1zJ2EU0xN+n6fdkiooW7uD6Y2XZ1
 ujVEYee3B4mQrDE3hjyTjsJsmO8nvRk4zbhGiCNq7D1jQN+f6pCLArNbnRnPT5lwxfFS
 P59Xptr7u1lPg1/xYmVMPqrgqfDwH033AcDMP3okfd57NFh3OArAyfa4hdLp+EoDSkoz
 OHzw==
X-Gm-Message-State: ANhLgQ1TRvuxTzGJjpmW73CmTM1hjQ02lMWXCSh9CRZE0fna+dGU9Dfp
 F8xMrU10+1J1RBk18V1ay1969N8L15+NZfQXSCs=
X-Google-Smtp-Source: ADFU+vsPtPvjl20GaSZ7FnZGPLGNqzcYG5NbHq2xidpUdHMBhZV5M+mGqg1MoacFLll/xmYwafGO6c5l/4VhV+Am1WY=
X-Received: by 2002:a5d:674f:: with SMTP id l15mr14050764wrw.196.1585565922665; 
 Mon, 30 Mar 2020 03:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200328005705.29898-1-pannengyuan@huawei.com>
 <20200328005705.29898-2-pannengyuan@huawei.com>
In-Reply-To: <20200328005705.29898-2-pannengyuan@huawei.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Mon, 30 Mar 2020 12:58:31 +0200
Message-ID: <CAM9Jb+hAPaqp1Qp+rxFsCQ6Y92a+VkyrKf0zKE0gGEVnuU_dhA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] virtio-blk: delete vqs on the error path in
 realize()
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Kevin Wolf <kwolf@redhat.com>, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

