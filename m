Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B2CECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839392054F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YI0UHfWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839392054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIAX-0007qF-JT
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iFHzw-0005bY-K5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iFHzu-0007MN-Fx
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:15:24 -0400
Received: from 6.130.60.178.static.reverse-mundo-r.com ([178.60.130.6]:44975
 helo=fanzine.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>) id 1iFHzq-0006x0-KL
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=hZQkpikDxpS3+PDD1sN6F8XhMmVMK4kTAeA7WwXijJ8=; 
 b=YI0UHfWq61P5ShbvW11xYYDTWQyeG3N5/7QQaL8zUcKqz04zZegFh03DwP+dIHlQ4ddydBNG+fmGn2so+8hJlfmgdpNwHD2pr1bG67/0yQcTYtgQa2T1VXSZWlEoyGWkXWDybgWazgL3lBUM924xt+lfi5Km+GWTgVhnhjBiL9Ts87xUjVUcCnGS4pvB4AcRLnWCkB+YGHsqtRsNYNMWLF35sq7tl3cjO8atvPVbO/OdoxQ+bzmJDIHZFm2lTRNBvvLWem8wjE6Nr2Dl/bVEvhF9fCJaka5bfC80qsI8LCGG5lMyf0NCfCieEg5I4Ss/OZaj9IlYpvmHkZ6/LcQG9w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iFHzX-0002CI-Np; Tue, 01 Oct 2019 15:14:59 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1iFHzX-0007me-La; Tue, 01 Oct 2019 15:14:59 +0200
From: Alberto Garcia <berto@igalia.com>
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH 11/19] hw/ipack: Declare device little or big
 endian
In-Reply-To: <c715521dfd61c48283fd34794286fa1eb2ce9fe8.1566829168.git.tony.nguyen@bt.com>
References: <cover.1566829168.git.tony.nguyen@bt.com>
 <c715521dfd61c48283fd34794286fa1eb2ce9fe8.1566829168.git.tony.nguyen@bt.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 01 Oct 2019 15:14:59 +0200
Message-ID: <w5136gcr4j0.fsf@maestria.local.igalia.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 26 Aug 2019 04:21:37 PM CEST, Tony Nguyen wrote:
> For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
> targets from the set of target/hw/*/device.o.
>
> If the set of targets are all little or all big endian, re-declare
> as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN respectively.
>
> Then, on inspection:
> - if ununsed, re-declare as DEVICE_HOST_ENDIAN.
> - if max/min size=1, re-declare as DEVICE_HOST_ENDIAN.
> - if just a bit bucket, re-delcare as DEVICE_HOST_ENDIAN
> - if PCI, re-declare as DEVICE_LITTLE_ENDIAN.
> - if for {ARM|unicore32} only, re-declare as DEVICE_LITTLE_ENDIAN.
> - if for SPARC only, re-declare as DEVICE_BIG_ENDIAN.
>
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>

Acked-by: Alberto Garcia <berto@igalia.com>

Berto

