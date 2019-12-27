Return-Path: <SRS0=GTQb=2R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8C2C2D0C3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 20:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC3D20740
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 20:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcCUZbK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC3D20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikw5Y-0004Va-KG
	for qemu-devel@archiver.kernel.org; Fri, 27 Dec 2019 15:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ikw4y-00045x-37
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 15:19:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ikw4v-0004mE-6a
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 15:19:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27334
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ikw4v-0004lp-3J
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 15:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577477960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tGWM1Drw0pH3EnsWa8wvoNmfZ3ftXisi4b3JqdKtT8=;
 b=RcCUZbK8czZnm+7VfjwTnUmObKGsqHMfgnRrt9maH/TSvyk6To7rxHN90RUEQxY8yoUVlU
 Kevj9Ufvb5YkzxG2d1F1qRz5ZU7y8eLOx5mEErlw/jeaHjnUu9+JhdNaHJmybcY1jCX1Hz
 yP7NCg3G4TFWkvo0UNdoQ7XaOKMPAFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-CSO0AQn2OdWeMASVw92jBA-1; Fri, 27 Dec 2019 15:19:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DA16800D41;
 Fri, 27 Dec 2019 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-24.gru2.redhat.com
 [10.97.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 688EB60BFB;
 Fri, 27 Dec 2019 20:19:07 +0000 (UTC)
Subject: Re: [PATCH] hw/i386/x86-iommu: Add missing stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191220154225.25879-1-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <8370b9ad-5928-091b-6c7a-52b87bf47179@redhat.com>
Date: Fri, 27 Dec 2019 18:19:05 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191220154225.25879-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: CSO0AQn2OdWeMASVw92jBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/20/19 1:42 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> In commit 6c730e4af9 we introduced a stub to build the MicroVM
> machine without Intel IOMMU. This stub is incomplete for the
> other PC machines. Add the missing stubs.
>
> Fixes: 6c730e4af9
> Reported-by: Travis-CI
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/i386/x86-iommu-stub.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
> index 03576cdccb..c5ba077f9d 100644
> --- a/hw/i386/x86-iommu-stub.c
> +++ b/hw/i386/x86-iommu-stub.c
> @@ -32,3 +32,12 @@ X86IOMMUState *x86_iommu_get_default(void)
>       return NULL;
>   }
>  =20
> +bool x86_iommu_ir_supported(X86IOMMUState *s)
> +{
> +    return false;
> +}
> +
> +IommuType x86_iommu_get_type(void)
> +{
> +    abort();
> +}

I cannot say the fix is correct, but I can attest - with it - I no=20
longer see the build fail when --without-default-devices --disable-user.

Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>



