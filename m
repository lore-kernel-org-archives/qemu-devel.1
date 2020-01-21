Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD40C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C2721734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C2721734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itnM0-0003IR-5U
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 01:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1itnLK-0002td-Cv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1itnLI-0001l2-Qw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:48:53 -0500
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:19127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1itnLI-0001c3-Ag
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:48:52 -0500
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [192.168.231.130]) by
 mgwkm03.jp.fujitsu.com with smtp
 id 5e3d_c97e_ccb5429a_a876_4183_92e4_c85c1d5a5da0;
 Tue, 21 Jan 2020 15:48:41 +0900
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
 (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id B3E7BAC00AA
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 15:48:40 +0900 (JST)
Received: from g01jpexchyt35.g01.fujitsu.local (unknown [10.128.193.4])
 by g01jpfmpwyt02.exch.g01.fujitsu.local (Postfix) with ESMTP id A70F05842A5;
 Tue, 21 Jan 2020 15:48:39 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchyt35.g01.fujitsu.local (10.128.193.50) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 15:48:40 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 016/104] virtiofsd: Open vhost connection instead of
 mounting
Date: Tue, 21 Jan 2020 15:57:21 +0900
Message-ID: <20200121065721.28912-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-17-dgilbert@redhat.com>
References: <20191212163904.159893-17-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.219.69.170
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
Cc: misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> When run with vhost-user options we conect to the QEMU instead
> via a socket.  Start this off by creating the socket.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

<snip>
> +    /*
> +     * Poison the fuse FD so we spot if we accidentally use it;
> +     * DO NOT check for this value, check for fuse_lowlevel_is_virtio()
> +     */
> +    se->fd = 0xdaff0d11;
</snip>

As a result of this, se->fd now holds dummy fd.
So we should remove close(se->fd) in fuse_session_destroy():
https://gitlab.com/virtio-fs/qemu/blob/virtio-fs-dev/tools/virtiofsd/fuse_lowlevel.c#L2663

Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

