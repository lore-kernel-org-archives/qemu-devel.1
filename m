Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F2FC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD2C2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EFLKP3qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD2C2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48403 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEZIW-00046L-6X
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:59:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEZGw-0002ua-8k
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEZ4G-0000qI-6O
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:44:36 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:56904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hEZ4E-0000o0-R0; Thu, 11 Apr 2019 08:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=XejLSE1nut3zaBgZH1OLm5dpFZ/n16G22jV0sczcypY=; 
	b=EFLKP3qgcuf9AqFJshhkP3aNXxA6VDf2ERcu5ctkjpqmJT/eGPs5hk3VRk2UkxANi70gzCcUovvKV6vgX/gG3Lw6s0gJVvlko+z+TD/tT9RMyS6IqhddRUXOq8O4vsAn9XuVu8cs4P2XBYgDMntKb3mNBqc6HV6jILl2HegZpkEk7JUmRgQW04NRmENNtLNC7fRFGhCOzzEfJI8+SET0PaM2/VzdQ6XGmsx0CKqlKgYTne2VqfW6sMChRlY1sPjCCPas68ERSxzN1J8hA55JktqNjJYk6ve28HYWxlDIgk85sRrDqRT+nKipcLIvvY5WJopV6Jsivm3q3J5tOnsl5Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hEZ4B-0003r8-1Q; Thu, 11 Apr 2019 14:44:31 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hEZ4A-00044j-VF; Thu, 11 Apr 2019 14:44:30 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <20190410162918.9343-1-mreitz@redhat.com>
References: <20190410162918.9343-1-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Thu, 11 Apr 2019 14:44:30 +0200
Message-ID: <w518swgvhht.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH] iotests: Let 245 pass on tmpfs
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
Message-ID: <20190411124430.0DrwEZxoH-jYjKcQzs4TyE9aZkhHTeCs04l6U0ncgZM@z>

On Wed 10 Apr 2019 06:29:18 PM CEST, Max Reitz wrote:
>      # Reopen an image several times changing some of its options
>      def test_reopen(self):
> +        # Check whether the filesystem supports O_DIRECT
> +        if 'O_DIRECT' in qemu_io('-f', 'raw', '-t', 'none', '-c', 'quit', hd_path[0]):
> +            supports_direct = False
> +        else:
> +            supports_direct = True

I don't see any other test needing this at the moment (at least none
written in Python), but I wonder if this is something worth having in
iotests.py.

The patch looks fine anyway.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

