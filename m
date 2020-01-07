Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C15208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3QGxYwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C15208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqK6-0007Aw-LP
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ioqIs-0005lP-04
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ioqIq-0006JN-V9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:57:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ioqIq-0006JE-RA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=wVAt2gV1StjWYUg2pynwSyqGXRx5om7LQn0BCLkNYv4=;
 b=V3QGxYwTRWlDKzzlQQocIgP+AR7ZnwdyPVHBvSNoypHQGF4R/XoljUziVrpdH9wkWkbn1G
 W1aTtp7yTe+Xrze/pRCKkqELG0500+X6xX3tNCfq6NOTAsd4XGRNUkqWktIGdUzxlm9cs3
 SptPogVcCZqcxrfJDeGl+EZ4BuER3nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-4LvwHyvjOc6OBLCuZyBn2g-1; Tue, 07 Jan 2020 09:57:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EED3801E6C;
 Tue,  7 Jan 2020 14:57:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F1C07FB63;
 Tue,  7 Jan 2020 14:57:28 +0000 (UTC)
Subject: Re: [PATCH v1 1/6] hw/i386/x86-iommu: Add missing stubs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200107135311.5215-1-alex.bennee@linaro.org>
 <20200107135311.5215-2-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3c8073ed-6e26-73d4-433f-e7ed6a36eb81@redhat.com>
Date: Tue, 7 Jan 2020 15:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107135311.5215-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4LvwHyvjOc6OBLCuZyBn2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/2020 14.53, Alex Benn=C3=A9e wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> In commit 6c730e4af9 we introduced a stub to build the MicroVM
> machine without Intel IOMMU. This stub is incomplete for the
> other PC machines. Add the missing stubs.
>=20
> Fixes: 6c730e4af9
> Reported-by: Travis-CI
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Message-Id: <20191220154225.25879-1-philmd@redhat.com>
> ---
>  hw/i386/x86-iommu-stub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
> index 03576cdccb4..c5ba077f9d1 100644
> --- a/hw/i386/x86-iommu-stub.c
> +++ b/hw/i386/x86-iommu-stub.c
> @@ -32,3 +32,12 @@ X86IOMMUState *x86_iommu_get_default(void)
>      return NULL;
>  }
> =20
> +bool x86_iommu_ir_supported(X86IOMMUState *s)
> +{
> +    return false;
> +}
> +
> +IommuType x86_iommu_get_type(void)
> +{
> +    abort();
> +}

I just ran into this issue today, too ... good to know that there is
already a patch :-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


