Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 16:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961CD2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 16:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qx+psqH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961CD2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFgs-0006vN-Nc
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 12:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdFdB-0003wO-LZ; Mon, 25 May 2020 12:07:14 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:55122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdFd7-0002ru-LM; Mon, 25 May 2020 12:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Brf0MPNznNMsnghMmNnZd6ZdsCyNaUiW4t8ZYY0R6eU=; 
 b=qx+psqH3lHYlQ4l/Xo6UjKB6ol3kJI+XvNaR2JFZluvnEW/53M7rzjZjz9vkdGHB3wxRk1fzmt5rygD+/tFzL/OpIeTsUrlalMGzrmu/BHCTYXuNa4bvYtgMuCSY1gcQp4f6PTPdiiuyfN+A5PE4SCFuXsh1RcRAiC+ZkWHr9yvATOUv/nD+ioXnbZCopfjL3UeU+0f4bgqm/PnwZlvF9AyQtGKoMFV35QDjsWAYUMxPiENgUc/8ceJ8LZ5IYxGo9+dagi+8nlIxFJhZAoJWQbwNwlPu7yLYaMfRxG3SHeVMqwOXShV2JDXv9JkN1yVrQVffHaQHIsRaS/wQrLpC+w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jdFch-0007xn-J2; Mon, 25 May 2020 18:06:43 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jdFch-0006mf-9S; Mon, 25 May 2020 18:06:43 +0200
From: Alberto Garcia <berto@igalia.com>
To: no-reply@patchew.org
Subject: Re: [PATCH v6 00/32] Add subcluster allocation to qcow2
In-Reply-To: <159033805582.25024.9998111829771601365@45ef0f9c86ae>
References: <159033805582.25024.9998111829771601365@45ef0f9c86ae>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 25 May 2020 18:06:43 +0200
Message-ID: <w51d06st2wc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 12:06:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 dereksu@qnap.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun 24 May 2020 06:34:17 PM CEST, no-reply@patchew.org wrote:
> /tmp/qemu-test/src/block/qcow2-cluster.c:1912:54: error: implicit conversion from enumeration type 'QCow2ClusterType' (aka 'enum QCow2ClusterType') to different enumeration type 'enum qcow2_discard_type' [-Werror,-Wenum-conversion]
>         qcow2_free_any_clusters(bs, old_l2_entry, 1, type);
>         ~~~~~~~~~~~~~~~~~~~~~~~                      ^~~~

This is actually a bug, I'll send a new version with this fixed.

Berto

