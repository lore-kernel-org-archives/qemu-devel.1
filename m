Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB0AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 22:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE2A2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 22:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KUPYq6/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE2A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixeZm-0003bv-Dy
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 17:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1ixeZ7-00037c-2Z
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 17:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1ixeZ6-0000WK-9C
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 17:15:05 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:44078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1ixeZ1-0008Ro-NW; Fri, 31 Jan 2020 17:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=UufLl6Et6FOyybL8qoIctrbSqszBRkT6+aqgd8vKKfE=; 
 b=KUPYq6/1B4Vrtk+0l/VmuQIfgVUsv8Hy5pOmXJwCzK1iCa/UAAoMOmce/rNk7f2dztrgivKZ4GiCUNk8HNWaRIf9qyVVxz4D2R6kBYWkQdHFUH3c21MCCF19aQq/UmMHrFPe3FKBcwXLBFQO7350E5YryTiOj4llsM/pohpCQRw8mVRMSO/uBpZCDqMpXaOVUThQIE/nRkAYBnimjN8krtRw1Msq4kbk1Qcr6aqQWVNJ5Ek+2GslclBPP3Bolo8Nz4302o/UOPiXX1A4qyLIqBqa1USNjCYVUjK8Vcvfl0gKYLbP1ifJYMgUAcYzL/BYeosESsv8xBSHth6D5FvarQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1ixeYu-00067m-D6; Fri, 31 Jan 2020 23:14:52 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1ixeYu-0005Fa-3b; Fri, 31 Jan 2020 23:14:52 +0100
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v11 2/2] docs: qcow2: introduce compression type feature
In-Reply-To: <aa9050a1-b071-6e08-bb91-8b513de09180@virtuozzo.com>
References: <20200131142219.3264-1-vsementsov@virtuozzo.com>
 <20200131142219.3264-3-vsementsov@virtuozzo.com>
 <ee6b018a-be33-ed77-c4b9-4894c685d30a@redhat.com>
 <w51mua3zg16.fsf@maestria.local.igalia.com>
 <18578060-2c1f-6c63-31e1-dee51387210a@redhat.com>
 <aa9050a1-b071-6e08-bb91-8b513de09180@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 31 Jan 2020 23:14:52 +0100
Message-ID: <w51eevfclyb.fsf@maestria.local.igalia.com>
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 31 Jan 2020 07:15:33 PM CET, Vladimir Sementsov-Ogievskiy wrote:

> I'm OK with it too, as well as I'm OK with the stricter variant, when
> we don't allow incompatible images with zlib set. I don't see any
> serious difference.

I also think both options are fine.

Berto

