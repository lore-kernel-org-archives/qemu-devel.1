Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A9C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 22:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366332072A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 22:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IgBuTIAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366332072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTYWJ-0000Sw-Bp
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 18:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jTYVD-0007SB-Dz
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 18:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jTYUk-00038V-Lb
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 18:14:54 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jTYUk-0001qO-39; Tue, 28 Apr 2020 18:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=pKeshuFaHoNUGO+/aISBPKJi0fNizPJYAY9u1yjoKWQ=; 
 b=IgBuTIAmwjkNALW2Kuet7knEc8xuyR8z53WZmRn3HqMYZgWwxXw+/8WwXDSJMWNASKa9dcbb8waIG5eb2d9ajGCwLChtSzJ0XacU+ZW+pS+y9F5y6ViJVBOQyLfa0YLLr2WsaJLn65XQXlfJ9nlCI1gJgLDGwpywS06WDaSnwMptdmO1Q1+hIM/w8Iqnzywjx2as5pkINUWqey8Ta+lPIFEHmBcysd8izN41yCZXkVJPEpQaWNe/L4syBexGMZ6xoSztmuMw7/P4A3EEhmArCOMoh0tJylM6Zhx65WOcbRBoH5h8nLPtqNdf/XmFb4yTBf3TV/wFiR/cYdcluxN1XQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jTYUM-0005pV-Ht; Wed, 29 Apr 2020 00:14:02 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jTYUM-0006W6-8R; Wed, 29 Apr 2020 00:14:02 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Comment cleanups
In-Reply-To: <20200428213807.776655-1-eblake@redhat.com>
References: <20200428213807.776655-1-eblake@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 29 Apr 2020 00:14:02 +0200
Message-ID: <w51v9ljw95h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 18:14:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block I/O path" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 28 Apr 2020 11:38:07 PM CEST, Eric Blake wrote:
> It's been a while since we got rid of the sector-based bdrv_read and
> bdrv_write (commit 2e11d756); let's finish the job on a few remaining
> comments.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

