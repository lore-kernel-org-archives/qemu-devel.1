Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B36C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32BC20767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lFiSsyCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32BC20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOQ8f-0005BW-Ou
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 14:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jOQ7M-0004Wx-17
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 14:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jOQ7L-0000QA-02
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 14:17:03 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:55937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jOQ7K-0000PP-Nd; Tue, 14 Apr 2020 14:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=o4NXLXXS4ovGqzgJn4pvYzN9i6ny8MXwyw3D2zW14/Y=; 
 b=lFiSsyCwfpglLeTEhkrvSRwQNKQlq++oUwjmPP+Ta78TU7njz0DXBwWXxLpujOh6iGweRbHgH8ZR/hWfZxRAGF0HyblDEKJR6uXv5vF9fYyDhxu+C1qD8RwkTCre/yjOR8eI626rGNNdHPC7PamKj5h2ENpRt8AuZBtF/VSVLE5Mrx0LjDul8eRZJN3TxN0IZ1Dye1PNHHxdBxZr3aJuyyDK/VVibKyx6tbu+Qy+60eSnxfW0b1sfNW/nPvX8yTwW/tpdwLNw5LeE7TeH1hS3B1HGBXFiXkT2W09mK6rWS6qXxaZM0fkk+SxzjdcPYozsyYRwv3VBn2LSJPly6DBoA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jOQ7I-0007TK-6W; Tue, 14 Apr 2020 20:17:00 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jOQ7H-00051A-St; Tue, 14 Apr 2020 20:16:59 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/30] qcow2: Document the Extended L2 Entries feature
In-Reply-To: <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
References: <cover.1584468723.git.berto@igalia.com>
 <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
 <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 14 Apr 2020 20:16:59 +0200
Message-ID: <w51ftd6rkys.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 09 Apr 2020 05:12:16 PM CEST, Eric Blake <eblake@redhat.com> wrote:
> Hmm - raw external files are incompatible with backing files.

Pre-existing, but I just realized that we are not checking that in
qcow2_do_open(), only on _create().

I suppose that if we find such an image we should either

   a) Show an error message and abort.
   b) Clear the 'raw data file' bit and proceed as if it was unset.

Berto

