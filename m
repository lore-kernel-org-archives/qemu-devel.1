Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA67C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4393D2071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4393D2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXoY-00017y-DR
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1jVXk8-0002Ka-3F; Mon, 04 May 2020 05:50:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1jVXk6-0008GI-6B; Mon, 04 May 2020 05:50:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id g13so20120603wrb.8;
 Mon, 04 May 2020 02:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RuQGDzagBjIACSLqpibjj4H3rS4YbDKcJD3yqxtmVe8=;
 b=GvmkBGNrvs3X4SrAOkVMpSz7cI8SXMAnbF/fRReV0srJv0E+xReDrdVFOLYHYU+NvD
 JZhdX1IvkPcgROSQJQO+jjcSh33mPznE8B3brIKnq6EIRirJjATlpel9+uzkZu180EZm
 EY7Vtel6JypSYwwkmEpt1HJpHAqcvo8tbd1orwEGDRX/LQCkEV2s3WQnovjnwosgBUyX
 Ac2zlXH5ma4klrhqSff+iGbRrAUex3ESiXoY3Bzg8Kkf9ZR83O/VnsoxQJKkMH5ahnvf
 PFb9Q7ZPuz+Dbagg7lyFr6Mj5rGYaGAu/7gO4GBG3m76PJqRoBFJpA63YdvSTffytQkM
 IDBA==
X-Gm-Message-State: AGi0Pua2e2cJ0Uwy8neRnuyqnWRlD0338jBQuesh/e/XaR5InTjUGRa8
 spE5XLLoRcpWwDuKH8n8bwM=
X-Google-Smtp-Source: APiQypJyTIvH3WWE4llkozK/zGDN1YfrYQsXxOdJGRrVA5BhfCvrLg+hWwIUzNB9HH1aumNcfPaGag==
X-Received: by 2002:adf:f004:: with SMTP id j4mr17920800wro.123.1588585828092; 
 Mon, 04 May 2020 02:50:28 -0700 (PDT)
Received: from thl530.multi.box (pD9E8315D.dip0.t-ipconnect.de.
 [217.232.49.93])
 by smtp.gmail.com with ESMTPSA id k9sm18445205wrd.17.2020.05.04.02.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:50:27 -0700 (PDT)
Date: Mon, 4 May 2020 11:50:23 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/2] hw/display: Include local 'framebuffer.h'
Message-ID: <20200504115023.19e56c51@thl530.multi.box>
In-Reply-To: <20200504082003.16298-2-f4bug@amsat.org>
References: <20200504082003.16298-1-f4bug@amsat.org>
 <20200504082003.16298-2-f4bug@amsat.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.221.66; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:50:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Mon,  4 May 2020 10:20:02 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:

> The "framebuffer.h" header is not an exported include.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/display/artist.c  | 2 +-
>  hw/display/next-fb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

