Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8260C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE392080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bc5EuXH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE392080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1DhH-0001wW-M2
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 13:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j1Dge-0001Qx-7d
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j1Dgd-00041s-AA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:21:36 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:34355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j1Dgc-0003yQ-MY; Mon, 10 Feb 2020 13:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=ang7Jt1nAzb7R1I5OW8wFx8IKrIogTat/QTgtHDpG10=; 
 b=bc5EuXH9Ty4LJj/hBgJJOy4JqduCNPF5TXptSMJAlpmfTkS5FhDWO3Yyx5GXvBdHCrVOx3Bt2XDP1zUtisl3sszJxFVBGj1fMIDdYJKMZbO+Axe/J6f3e2NnxyZY8cJ6Uj7H1l/l5ol1Ug2CnsTwc6Jhoty6O9YnbR3K+UaCnOx2nBz0DeSVdQIxjp6z0yCSWYSzcaaXC6Nv3T53zAcfB3wNLiutad+pr3A/OK+7TAs8UkwycThNT4goJ5dHTusO9UBR9b7P+NIMkJzVjWKVLjohUwU2VBirACR02twYs/tbDdrh03KlEDkbmjpq6JDp/KoeUqJFqsOaK3PktCT2NA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j1DgZ-0005S2-If; Mon, 10 Feb 2020 19:21:31 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j1DgZ-0004qk-8O; Mon, 10 Feb 2020 19:21:31 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 07/17] gluster: Drop useless has_zero_init callback
In-Reply-To: <20200131174436.2961874-8-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-8-eblake@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 10 Feb 2020 19:21:31 +0100
Message-ID: <w51blq6fglw.fsf@maestria.local.igalia.com>
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
 "open list:GLUSTER" <integration@gluster.org>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 31 Jan 2020 06:44:26 PM CET, Eric Blake wrote:
> block.c already defaults to 0 if we don't provide a callback; there's
> no need to write a callback that always fails.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

