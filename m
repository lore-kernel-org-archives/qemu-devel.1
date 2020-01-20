Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FF0C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3E12073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej/ARJ27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3E12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQ3G-00007Q-Mg
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 00:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itQ1G-0006cb-Mm
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itQ1F-0006Bk-ND
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itQ1F-0006BH-Jv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579499676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=4EkOUPDmnZw5vrmCcpAKcV3iNLZ563Jg/RVQvolZcPQ=;
 b=Ej/ARJ27r9B80UvgEJI40h8719y+Sx9vxAIJrmf+pBQbVI1MP5hniB5qtSzIMorgPRIKRl
 XzvsKrp9i1yvtzSjLlRlogMUk6k5T5WYf+RevEK+b3u85pEB24Z32gellh3eXDeZrinEiL
 0D0NJXT6/E2+Ct3H+0XJM9gp3tIJ9+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-qBDv0p9UMLSLMjMy1lqzuA-1; Mon, 20 Jan 2020 00:54:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D0131005514;
 Mon, 20 Jan 2020 05:54:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A19460BF7;
 Mon, 20 Jan 2020 05:54:28 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Add missing m48t59 files to the PReP
 section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20200117165809.31067-1-philmd@redhat.com>
 <20200117165809.31067-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8b6ec2fe-7939-a9d4-8064-e0031eb4aa99@redhat.com>
Date: Mon, 20 Jan 2020 06:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200117165809.31067-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qBDv0p9UMLSLMjMy1lqzuA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

You could also use a wildcard instead of the three lines:

F: hw/rtc/m48t59*

 Thomas


