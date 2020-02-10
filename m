Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C06C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDC72082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X25ety8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDC72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1DYF-0005dF-PV
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 13:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j1DXc-00053g-2j
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j1DXa-0002Pe-Rr
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:12:15 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:43223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j1DXa-0002Lx-9M; Mon, 10 Feb 2020 13:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=nVKjys6282r49N+eQZc7vex3owpAYBKFwpc3y7QanvU=; 
 b=X25ety8s9qYoCt1+nYelLIWkkHBVbkVhzKzCYQcQ17Ksek5vtAwc0Fn7yinryzD40zkhCWgUbeJ9mwAuZ3bss3tzGDxQyGnln7FQ/5WudgkpOpbphjD/As4SyCxnNFHKeWWWw/eEB/Fi1pcvEapMPobbPpmLP40wMTpl3216o+fFX3Kyd0Ons2sieIxGKwId6oee+CZ377jzW8Bhv9nIRrWYqIHFA/3u3JJjdpVGdwVRRSsWtzdd5N+/EhEe2OxCoQ0cRJJU2FIqAfSvzYtF2NjlpjHlc39zH+FNzWcFloVpophOtdbzI56p++vuPxROwMuGamjFX0zekt7Cs6U0ig==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j1DXX-0004PD-40; Mon, 10 Feb 2020 19:12:11 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j1DXW-0002GZ-P2; Mon, 10 Feb 2020 19:12:10 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 05/17] block: Don't advertise zero_init_truncate with
 encryption
In-Reply-To: <20200131174436.2961874-6-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-6-eblake@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 10 Feb 2020 19:12:10 +0100
Message-ID: <w51h7zyfh1h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 31 Jan 2020 06:44:24 PM CET, Eric Blake wrote:
> Commit 38841dcd correctly argued that having qcow2 blindly return 1
> for .bdrv_has_zero_init() is wrong for preallocated images built on
> block devices, while .bdrv_has_zero_init_truncate() can still return 1
> because it is only relied on when changing size with PREALLOC_MODE_OFF
> (and this is true even for v2 images which lack the notion of an
> explicit zero cluster, since the block layer already filters out the
> case of a larger backing file leaking through).  However, it missed
> the fact that encrypted images do not default to reading as zero in
> any case.
>
> However, instead of changing qcow2's .bdrv_has_zero_init_truncate() to
> point to a one-off function that special-cases bs->encryption, it is
> smarter to just move the logic about encryption directly to the block
> layer (that is, the driver callbacks will never be invoked for
> encrypted images, just like they are already not called when a backing
> file is present).  This solution fixes the qcow2 issue, has no effect
> on the crypto driver (which already lacks .bdrv_has_zero_init*
> callbacks), and no other driver currently uses bs->encrypted.
>
> One other reason to fix this at the block layer: any information we
> expose about an encrypted image that in turn may alter timing of
> algorithms run on that image can be considered a (slight) information
> leak; refusing to optimize zero handling of encrypted images thus
> avoids the possibility of that being a security concern.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

