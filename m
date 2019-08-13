Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60CFC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11C920663
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="if1CQNI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11C920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVnz-0003dV-Sg
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49757)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hxVma-0001cV-9t
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hxVmZ-0002qt-0m
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:20:08 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:50613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hxVmX-0002Zm-SM; Tue, 13 Aug 2019 08:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Pp7j3ake9Twj27K/AYPjk4E1mNmMMWRUgGjTMmlIq9o=; 
 b=if1CQNI+nayvDOCo9zrpAusZkBfmUDziNxGj9ortFu/uScSOAYfdSCJpdfOqWaJqlvtq4A0PXIE2yuiIZOGsWvwaS1PJakNf5/BpyL6ATpMpGSH42Loni2fWdbuM8R9X/os0Qt+uwQQM7R+CZDCUHNO0D1Jrirl80QQNmS1KiAygarRUm5BklQ7s+PS/++nc9jJUV/u43W9ndueE35U3FmP44VOiRGNw+LdA4dcM44o+nx9/uisi8lq7C7zfgCRHx5j7/gi3poDDka3Pn3qubVDrpEBzC8eaG/duO1jksNJHN8iYzVLyFes+bLuPZG3jGTDt9IFQ+s1NnOEHax/xxQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hxVmD-0008Ot-8T; Tue, 13 Aug 2019 14:19:45 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hxVmD-0004Jl-5V; Tue, 13 Aug 2019 14:19:45 +0200
From: Alberto Garcia <berto@igalia.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
In-Reply-To: <1564502498-805893-2-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1564502498-805893-2-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 13 Aug 2019 14:19:45 +0200
Message-ID: <w51a7cddzq6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH 1/3] test-throttle: Fix uninitialized use
 of burst_length
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
Cc: vsementsov@virtuozzo.com, ehabkost@redhat.com, kvm@vger.kernel.org,
 mtosatti@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 30 Jul 2019 06:01:36 PM CEST, Andrey Shinkevich wrote:
> ThrottleState::cfg of the static variable 'ts' is reassigned with the
> local one in the do_test_accounting() and then is passed to the
> throttle_account() with uninitialized member LeakyBucket::burst_length.
>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

