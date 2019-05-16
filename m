Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A2BC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D3420645
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FmrpEFzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D3420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRG6b-00070f-Og
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:07:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hRFqx-0002Le-US
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hRFqu-0003IM-RK
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:51:19 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:53595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hRFql-0002il-Gz; Thu, 16 May 2019 08:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=MKW3h7tANg4Em2TnypEdRr/B9AmWSeBAQjkzeX1f70o=; 
	b=FmrpEFzx4VPXbCnKOu60ePcYLtLhzE8e6kpEjiF6TF1Ukbowt/6gapBfUTTGQYh4aT+M7fj82d/0FQONBNUrtMKIB5iLZ35vqRmR5nM+EH8laeAkYrHX+ohMS1btGANAp2MQ1intzSWRUWVJrMiitV9eJ4LkwVDmQIxSd10QP8xIHVDqAJjNwnRL/c9agDJaaEaaJmVl2k/G8wH93LZvgedkBuqxu85uTlKlaCIWc3+N0FOOccFbywIx2lc0+//afXu/PPD5y/BSzWks7+h3fDQTs7LFwgEXUvWe8y6qU51JlpR1R7IW7Efe9h9BetZmsAA2UrD8Ml7iL0YLNjgQ2Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hRFqj-0006Av-Fz; Thu, 16 May 2019 14:51:05 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hRFqj-00076w-DD; Thu, 16 May 2019 14:51:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <20190515201503.19069-4-mreitz@redhat.com>
References: <20190515201503.19069-1-mreitz@redhat.com>
	<20190515201503.19069-4-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Thu, 16 May 2019 14:51:05 +0200
Message-ID: <w518sv6v9za.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH 3/4] iotests.py: Fix VM.run_job
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 15 May 2019 10:15:02 PM CEST, Max Reitz wrote:
> log() is in the current module, there is no need to prefix it.  In fact,
> doing so may make VM.run_job() unusable in tests that never use
> iotests.log() themselves.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

