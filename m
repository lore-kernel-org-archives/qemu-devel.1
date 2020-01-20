Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564A8C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133842073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1rcNMj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133842073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQ11-0006CW-1B
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 00:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itQ03-0004wp-Mw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itQ02-0005fp-Lu
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:53:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itQ02-0005fI-Ix
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579499601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1MEWERI7pid8EKgC/A7rUFac0H0nin36giL1rweprGo=;
 b=X1rcNMj4ssUZCbiNW2/usnbXuYG3fAw29Zr144A99eTllxKGj3gv89W9uyjVdCpTACbEqA
 EJIjKt5/8ed4pfF7ZEM63nsP9rdE/hYOoSItICI5YAuyj3nIRW0gajmxVA7gBu8eXbrSzR
 nyBCiddpdfJ+5jdizU1GD9VfU/SE268=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-p1qOAsSVNvC-YKto9Wm2vQ-1; Mon, 20 Jan 2020 00:53:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B274100550E;
 Mon, 20 Jan 2020 05:53:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 677E484D9D;
 Mon, 20 Jan 2020 05:53:15 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Add missing m48t59 files to the PReP
 section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20200117165809.31067-1-philmd@redhat.com>
 <20200117165809.31067-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f5181fa3-e830-7d04-1f4e-0673d2202eec@redhat.com>
Date: Mon, 20 Jan 2020 06:53:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200117165809.31067-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: p1qOAsSVNvC-YKto9Wm2vQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/01/2020 17.58, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b425d030d..c162145bd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1084,6 +1084,8 @@ F: hw/pci-host/prep.[hc]
>  F: hw/isa/i82378.c
>  F: hw/isa/pc87312.c
>  F: hw/dma/i82374.c
> +F: hw/rtc/m48t59.c
> +F: hw/rtc/m48t59-internal.h
>  F: hw/rtc/m48t59-isa.c
>  F: include/hw/isa/pc87312.h
>  F: include/hw/rtc/m48t59.h

Why only PReP? The device seems also to be used by Sparc machines...?

 Thomas


