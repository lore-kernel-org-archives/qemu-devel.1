Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED9CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0441206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JuWhzkaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0441206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg4mQ-000400-0r
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 07:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1jg4lm-0003Tp-B1
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:07:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1jg4lk-0008Jp-Uz
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=z7IUJEVN/CdskMS1rnq2KsAJU39tt5ZDAa8PhW4Wglg=; 
 b=JuWhzkaTWVJJx2jnHA1fbh7BiZpy+r3Ni2yjfZqRcTh42xnKxhnQ73pRmCPcTgLtxiD2uAoCpRtCY582o+YAHsrJhDY73aaHgA52mqzo2jHIZs76uKMxWeVLGlvLpYHXdgYbT3tE7fJUpwHEzF9puEA+n+OFi5PSmpjyzIWHjFBrItYJi4UOExl9JSEIZmkAvqJfO1WImeIfk5TsPWw811HKHksK6TuxBCANgBKZ1rhGfB1UQ/1aaSzeWWFP/6ZMiPA4Ss0rDWmfHuOc/eJTiHks2s83wJlTNMVI4OFs2hgnMmbzAwaFl/1RYo7+oJ2ZDAmG5ZHoW1rwzz2dXsKi2w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jg4lK-0003Vd-Sq; Tue, 02 Jun 2020 13:07:18 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jg4lK-0005FF-Iy; Tue, 02 Jun 2020 13:07:18 +0200
From: Alberto Garcia <berto@igalia.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/5] block/quorum.c: stable children names
In-Reply-To: <9df6b3723ec30cb749ceaa555d82a29a6d79496d.1589199922.git.lukasstraub2@web.de>
References: <cover.1589199922.git.lukasstraub2@web.de>
 <9df6b3723ec30cb749ceaa555d82a29a6d79496d.1589199922.git.lukasstraub2@web.de>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 02 Jun 2020 13:07:18 +0200
Message-ID: <w51k10poheh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 07:07:22
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 11 May 2020 02:26:54 PM CEST, Lukas Straub wrote:
> If we remove the child with the highest index from the quorum,
> decrement s->next_child_index. This way we get stable children
> names as long as we only remove the last child.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

