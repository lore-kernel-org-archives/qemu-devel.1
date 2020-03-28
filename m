Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C8C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 07:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411E620714
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 07:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="JS0305p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411E620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI5bg-0002Rk-Bc
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 03:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1jI5ao-00021t-S5
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 03:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1jI5an-0004ht-S8
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 03:09:18 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::11]:32984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1jI5an-0004VS-6i
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 03:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1585379353;
 s=strato-dkim-0002; d=aepfle.de;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=f9NwwzB7IUYmbHNgZDQRU2ZQCn7aO4IC/eRprZ+7i5M=;
 b=JS0305p6BCjb4KglJFfuDqezEg7Q7gODjGZvaKLG8x6uJyElxDj8JDmAoGgi071hu8
 8n3uRTt+ENCDx7iQvYJSkuxXLugDfg1wvX0dpQGZQXN+bIy3vKkEP/gfy4ivsk/MfmiG
 fZh1fX1BUbIZWtydQ1ux4xTcsdQSj5j4gl0ap89bZWkxhriV4mUQR60xbyvZil1SMC4y
 CPGaXJ6kW0UWQ61BExgAI+EN0GYnyVQ/cqYUUW9dugYxI7OCc6K2pvsa7C3bRwoQBgVm
 TqXwD9yur1eDcbrw/wK8zKiv46trqq8FEJh3oLPal9x9lZQ3POrLYql2B0j76sH7KKJi
 2nvA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS1Wwg"
X-RZG-CLASS-ID: mo00
Received: from aepfle.de by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
 with ESMTPSA id 204e5fw2S79B5rZ
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 28 Mar 2020 08:09:11 +0100 (CET)
Date: Sat, 28 Mar 2020 08:09:06 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4] piix: fix xenfv regression, add compat machine
 xenfv-qemu4
Message-ID: <20200328070906.GA7942@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200327151841.13877-1-olaf@aepfle.de>
 <90544ada-060e-169b-c0cb-94d869070d97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90544ada-060e-169b-c0cb-94d869070d97@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5300::11
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, Paolo Bonzini wrote:

> Looks good, I would just do the following adjustments to have more
> consistency between pc and xenfv machine types

Do you want me to resend with this change?

Olaf

