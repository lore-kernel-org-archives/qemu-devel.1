Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777FEC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 07:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4CA22469
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 07:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="avH4f7ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4CA22469
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFYwL-0002Wm-F9
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 03:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iFYvZ-0001wE-HW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 03:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iFYvY-0006CG-76
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 03:20:01 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:42484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iFYvX-0006Ac-Vf
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 03:20:00 -0400
Received: by mail-ed1-x52e.google.com with SMTP id y91so14197932ede.9
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=MRVccGIumP91E2d8e91mjtfvfWnfnRcypexVMu2YmYc=;
 b=avH4f7ymvjsBJcB0YisarsoKKoSgarnvLBwPSz3kCdYOYdhzSIUdlbWlu+GWakRgCp
 lS2HefpUhJcgigpiFCxAb+mKcRsay/Qlvbk+Uh7eyQq+oQRftlG+W/Nx8ZvGVihSxNQ4
 ueeWhnds819RWVU9Y5ZLMjYxC1fXTPAFJ3+4K+78UrP7S4Pn6yRN+5xc3gzCSFBlEz5K
 LsQtoYJHO75sLsEBncXBR90M6F2ckA9K6e4w9n6DjRkAw7CtFOqFIfzjKccJCPOmJywF
 KsSllKivFaEujvAXcEcbh9/KRuHb0aU1aXmF5Wbf76K0NlaW7Wn4yjedoFyFhlDw0kJi
 Ez6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=MRVccGIumP91E2d8e91mjtfvfWnfnRcypexVMu2YmYc=;
 b=ne3Savd6NOhHTtXgYqMdfIEr8JRfV/ggnOupHFunZbYaO0rQV8GKBqMFeRrPEU3Enb
 DaJLeLB62nn1dfvUXb70g05FqS+Nq3HGdoIFvVSjoTk6FeC4r28l2pkkTM4il1TUosGt
 sQcKRimZrewDiPbySzkg7gWSUt5DHUCfg4hZwyub5LRIWVngvPhtpNB0jfaoFjwor5dp
 1JNh1flWF0c2q+t9MgtQToK6jkoWju7k0U4r5p5Nijh2wCxUjPU7CPqbvjOVGsn5Eb6n
 nH0yKIIDSUxjfo1ITYOQMJwyHJkRQbSIyRCBms5K4oKyyVEZdzfpvmjDs52PeDtwxDs/
 OjcQ==
X-Gm-Message-State: APjAAAXa9TaFh33xlKlxgvC8NsO1uhs5dmBxc4DoeSoY8EYovq2z7Mqy
 tWOesLTFo3iHg3AMOvz17J55UNqYIVw=
X-Google-Smtp-Source: APXvYqw4OuCn2baKIV0s5c0j6dd5Xtdkj1tkp2lpOS13Ne6HXXiCna4+lCJkTAC8wrdSvJTWboa0lQ==
X-Received: by 2002:aa7:d883:: with SMTP id u3mr2170060edq.281.1570000798172; 
 Wed, 02 Oct 2019 00:19:58 -0700 (PDT)
Received: from msennikovskii2.pb.local
 ([2001:1438:4010:2558:d098:3701:97c4:7b4e])
 by smtp.googlemail.com with ESMTPSA id y22sm2147648eje.42.2019.10.02.00.19.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 02 Oct 2019 00:19:57 -0700 (PDT)
From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] virtio-net: prevent offloads reset on migration
Date: Wed,  2 Oct 2019 09:19:44 +0200
Message-Id: <1570000785-9257-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::52e
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
Cc: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

This is the second version of the patch with the coding style problem fixed.

Regards,
Mikhail

Mikhail Sennikovsky (1):
  virtio-net: prevent offloads reset on migration

 hw/display/virtio-gpu-base.c |  3 ++-
 hw/net/virtio-net.c          |  5 +++--
 hw/virtio/virtio.c           | 11 ++++++-----
 include/hw/virtio/virtio.h   |  2 +-
 4 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.7.4


