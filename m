Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FECC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6591A20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jeVxQvZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6591A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54819 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFw2-000736-Ja
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:56:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hRFqh-00024w-Dg
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hRFqa-0002JO-Tw
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:51:00 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:53305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hRFqO-0001xg-Si; Thu, 16 May 2019 08:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=NpDjpkIXbpLSRAyK6nU3OS/GTh89ltsPjsD9PfRLpJM=; 
	b=jeVxQvZfCvCr5Ciu9EubLO+fD8d4pnY3eJrfwraB9YRa0Rm13r0NSvPtkitG13K0ISLwna2dM5n33jcRe4hHNzfQTKIcts6+Q5m4lpEjXZgwv+cQSSoZld+tUtikncHukrJ6ta0ikJLo4iO6MMNuD7Wo8mvklB2VPNcgpdJtq1M/Y33PISYpoDcRoKh1sc6pkahFLMmKFqcEWI0t50Zjoa86XUrG6Y7WN7jM191kjikxtorp3Ch0GtPubj9AkrMP//mLDwzw//PoMGNn7A6LpFYkf9c5/kIl7GnqY6egW553v0AptKVVJQlz+7kAJZ80wzmDtUwK750iRGd4CantJg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hRFqN-00069f-3h; Thu, 16 May 2019 14:50:43 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hRFqN-00076A-16; Thu, 16 May 2019 14:50:43 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <20190515201503.19069-3-mreitz@redhat.com>
References: <20190515201503.19069-1-mreitz@redhat.com>
	<20190515201503.19069-3-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Thu, 16 May 2019 14:50:43 +0200
Message-ID: <w51bm02v9zw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH 2/4] iotests.py: Let assert_qmp() accept an
 array
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

On Wed 15 May 2019 10:15:01 PM CEST, Max Reitz wrote:
> Sometimes we cannot tell which error message qemu will emit, and we do
> not care.  With this change, we can then just pass an array of all
> possible messages to assert_qmp() and it will choose the right one.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

