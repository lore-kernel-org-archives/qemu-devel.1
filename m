Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A92C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B30214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL+MzRXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B30214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSeKR-0007Om-O1
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iSeIP-0006kC-Ap
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iSeII-0003Z6-3t
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:41:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iSeIH-0003L4-WA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573119691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5Am/bmKOQljdwSN/Vsn1Yvyt/rAr5pOWGpinuz+AfA=;
 b=CL+MzRXSWXnVfya2lFqM8ZIFnTQDmBwJqni1wBUdgQrr4kM6EBH6wyYNds9aoqRbdXYXlH
 y8u/pX4hXcQT6HlkoPZnCnfPqsEp54SJNhkxlcEADnsoOOjxLVxuNHy4KUslthixC8MqNl
 /RXtnE0AZNkavPeyQuxU6lmXaMxuCqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-qjWyVPcHPZiLmzSSJl6EvQ-1; Thu, 07 Nov 2019 04:41:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F7EB801E54;
 Thu,  7 Nov 2019 09:41:25 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9611A5D713;
 Thu,  7 Nov 2019 09:41:25 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4DC9318095FF;
 Thu,  7 Nov 2019 09:41:25 +0000 (UTC)
Date: Thu, 7 Nov 2019 04:41:25 -0500 (EST)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1233611027.10012683.1573119684999.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191107091136.359965-1-stefanha@redhat.com>
References: <20191107091136.359965-1-stefanha@redhat.com>
Subject: Re: [qemu-web PATCH] Add device fuzzing blog post
MIME-Version: 1.0
X-Originating-IP: [217.232.52.98, 10.4.196.13, 10.5.100.50, 10.4.195.10]
Thread-Topic: Add device fuzzing blog post
Thread-Index: IdRy6/XeybAqs1fdsIxgCXr3Qit8pg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: qjWyVPcHPZiLmzSSJl6EvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: megele@bu.edu, bsd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Alexander Oleinik <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> Sent: Thursday, November 7, 2019 10:11:36 AM
>=20
> This blog post covers the device fuzzing GSoC project that Alexander
> Olenik did in 2019.
[...]
> +This article was contributed by Stefan Hajnoczi and Alexander Oleinik.

You could also use the "author:" field in the header for this.

> diff --git a/screenshots/fuzzing-intro.png b/screenshots/fuzzing-intro.pn=
g
> new file mode 100644
> index 0000000..e130027
> Binary files /dev/null and b/screenshots/fuzzing-intro.png differ
> diff --git a/screenshots/fuzzing.png b/screenshots/fuzzing.png
> new file mode 100644
> index 0000000..2f15ecb
> Binary files /dev/null and b/screenshots/fuzzing.png differ

Seems like the images are missing ... can you please attach them?

 Thanks,
  Thomas


