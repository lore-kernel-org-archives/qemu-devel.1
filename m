Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAEFC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B5C2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igcD6iqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B5C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokrA-0006or-6B
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iojOp-0004Ll-Rc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iojOo-0007Nl-IZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iojOo-0007NQ-EW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=9MB1EpwF/3QQ/vJ0P9V4XwfNz1wYN5CHQ5mAOEIgsWc=;
 b=igcD6iqOM8T2TukFvz30JZooeK5i4+fssuKNLmen1Sjqt4jHOkX3+CEW3cCPtO5msGyFus
 xM2RsGSElGcU3sieVeDjuscDdvIg1ss6UbAfbHp9OCLK3nVxSlMFLKlhuwAGWCn1mHXOYT
 IM0BCaHYm6CQrJa4nKjMiS5lqm7DY8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-FdoqD2fZOFKOIrQZOzg5-w-1; Tue, 07 Jan 2020 02:35:27 -0500
X-MC-Unique: FdoqD2fZOFKOIrQZOzg5-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4DCB801E76;
 Tue,  7 Jan 2020 07:35:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89F8E1C4;
 Tue,  7 Jan 2020 07:35:20 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 01/16] libcflat: Add other size defines
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20191216140235.10751-1-eric.auger@redhat.com>
 <20191216140235.10751-2-eric.auger@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <cab416f2-4e86-4cae-97e9-d78cfb7f2781@redhat.com>
Date: Tue, 7 Jan 2020 08:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191216140235.10751-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: yuzenghui@huawei.com, andre.przywara@arm.com, drjones@redhat.com,
 alexandru.elisei@arm.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/12/2019 15.02, Eric Auger wrote:
> Introduce additional SZ_256, SZ_8K, SZ_16K macros that will
> be used by ITS tests.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  lib/libcflat.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/libcflat.h b/lib/libcflat.h
> index ea19f61..7092af2 100644
> --- a/lib/libcflat.h
> +++ b/lib/libcflat.h
> @@ -36,7 +36,10 @@
>  #define ALIGN(x, a)		__ALIGN((x), (a))
>  #define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
>  
> +#define SZ_256			(1 << 8)
>  #define SZ_4K			(1 << 12)
> +#define SZ_8K			(1 << 13)
> +#define SZ_16K			(1 << 14)
>  #define SZ_64K			(1 << 16)
>  #define SZ_2M			(1 << 21)
>  #define SZ_1G			(1 << 30)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


