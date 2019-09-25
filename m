Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2570C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917F621D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGRsvirX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917F621D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8N4-0002y3-Tt
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iD8J4-0000Xt-DS
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iD8J3-0006yR-A0
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44125
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iD8J3-0006y0-1B
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569421812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BsejPs8VR4bQ8vSDiQ1D+SsqmkY4XQ6nG+kn2dcwppo=;
 b=gGRsvirXC0/FDnQLIgBFuh5wuw7a7H+ZJO3tf8dFkCXhlAX+CvDugj6U44hj4aN53kv5Wd
 4+mxGTQDiFYPqDmu7rpUW2qRgAgbSwfcv4i05aj4BEJvkbnoROZk5srP87pbK+52WVVtfK
 jbjBxqC5aHlEPC1dKIrv2GBtJgq0GX8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-qX-DH7oZNgaOakxlrkycbQ-1; Wed, 25 Sep 2019 10:30:11 -0400
Received: by mail-qk1-f197.google.com with SMTP id x186so6245388qke.13
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 07:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=S3oDpkzwFQW/6Qog9stiWy3NOJLymT7tgQynsFt0T0k=;
 b=HA4Pcn0Y2eij7S7bP1seffRjvl32mviptJ+GUaUja7vzl5RCPbeJyVS2MKOYXHFmRf
 S1Ln+UbojMcKv2zmMdob6jmUU4lnOW1RLkzR3xMItSZR/GpY6IIXPajSmfoW+6wxQBk0
 P4QTmaDTEgg7F99UkUva/6ktMjia/K7Td/IHoNDyo++17OZGMeijwPK69+BiIzkdX9sP
 DQDG+rnjK7HzWSK3U2lRzF3rCb0g4fS+89rSkk4wFgrIyA8YCTOAlcKMyqmLzv9SQWwa
 0y1z0sUNv+ySQLxYYCcDGqPNyELzPgPcJwfluvQEOa8sg727THsKkAEBekG6PrSIVzwD
 Pe2g==
X-Gm-Message-State: APjAAAWomgju3Do8WGqPNW092x27ji9FjPIPZoUl5AmAd1MCVMPnBQ2U
 EpObHdkrghIpqLFdKApo3vzlIqQcRMOGIqx1x/c/WsICw/n/76yDkBL36cLJM9ifML9TXNMY+5+
 4Ku+WtuHQjwwjhQE=
X-Received: by 2002:ac8:184:: with SMTP id x4mr9161640qtf.249.1569421810058;
 Wed, 25 Sep 2019 07:30:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzyQXBwBwzP3xoucmn13TBr7t3Tk+CzmN4FmCppaodvKVeZDVNhsDo/rUEN8wNOhbcKhx98QQ==
X-Received: by 2002:ac8:184:: with SMTP id x4mr9161626qtf.249.1569421809884;
 Wed, 25 Sep 2019 07:30:09 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id m136sm3164665qke.78.2019.09.25.07.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 07:30:09 -0700 (PDT)
Date: Wed, 25 Sep 2019 10:30:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] vhost: fixes
Message-ID: <20190925142910.26529-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: qX-DH7oZNgaOakxlrkycbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A very quiet cycle. Did I miss a bunch of patches? if so, let me know.

The following changes since commit 240ab11fb72049d6373cbbec8d788f8e411a00bc=
:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190924' int=
o staging (2019-09-24 15:36:31 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 3fc4a64cbaed2ddee4c60ddc06740b320e18ab82:

  vhost: Fix memory region section comparison (2019-09-25 10:16:39 -0400)

----------------------------------------------------------------
vhost: fixes

Misc fixes related to memory region handling.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (3):
      memory: Align MemoryRegionSections fields
      memory: Provide an equality function for MemoryRegionSections
      vhost: Fix memory region section comparison

 include/exec/memory.h | 14 +++++++++++++-
 hw/virtio/vhost.c     |  9 +++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)


