Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C10C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A57208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mL35zFGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A57208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgX92-00082g-H9
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37895)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hgWXa-0003Jy-BP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hgWXZ-0007n0-Bd
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:42:26 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:58224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hgWXZ-0007jl-2A; Thu, 27 Jun 2019 11:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=9OM7ffAYtPQEUzMnCZjJN9TZQY0MwQ2qvgMVvlP6Cds=; 
 b=mL35zFGO+NPQ+4I08ys32KdkQ6vEvOVaui5yej0AbEXBFnudX7lBOuz3rWG8o74sbstQklU/of2d+3MzRMFttbyUI2C05niz5wRINpQepuOlK7WAFeUKguRnQy+hAdqw9DqOtQWTCxvOjCj5dcGCvOdqpvIcKvxjII6HOvhmocd+T3OqCDLF4MnON6XCLVPtlNLwjso1qZ6QfWfS96z2Br1lba0fQsRpXNrRJ4FAmLErHhakEKpY1wwxKZmuDLkejuR2zFWHDLF3McljUA1L3VijzcNirRltO8V+CF1+g1V75Zazcaz05A947VXQBH65nckl5AVLgwEQlu1ll8jHmw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hgWXX-0005sX-Kv; Thu, 27 Jun 2019 17:42:23 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hgWXX-0004ZN-I9; Thu, 27 Jun 2019 17:42:23 +0200
From: Alberto Garcia <berto@igalia.com>
To: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel\@nongnu.org" <qemu-devel@nongnu.org>
In-Reply-To: <w51a7e3domn.fsf@maestria.local.igalia.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
 <w51a7e3domn.fsf@maestria.local.igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 27 Jun 2019 17:42:23 +0200
Message-ID: <w517e97dogw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 27 Jun 2019 05:38:56 PM CEST, Alberto Garcia wrote:
>> I would consider 64k cluster/8k subcluster as too extreme for me.

I forgot to add: this 64k/8k ratio is only with my current prototype.

In practice if we go with the 128-bit L2 entries we would have 64
subclusters per cluster, or 32 if we want to have a separate
QCOW_OFLAG_ZERO for each subcluster (would we need this?).

Berto

