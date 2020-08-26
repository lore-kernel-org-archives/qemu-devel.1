Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEADC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEE72078B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ja5H/w2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEE72078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyHp-0007Tt-UU
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAyH4-0006wy-QP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:27:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAyH1-0007Ro-LU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598459261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cUJIiott+NDaKNBjT45zu6Y6bQ0+FXy5MRgP1gEMVg=;
 b=Ja5H/w2Hzz1T2ag+08UJTPdZMBaIAOhW6ZFQNpxULsI89EwjvVu3R7G8RloYyNAyisgELN
 mqcMynqL9vPI10Yn+kliVUXKWdOs/YoFG23NLHeLRrStv0IwkwCZ1oZ0dwZzybzzWD5Dfd
 yWe7fA7KQJuld/rDniSb1BKC0GvV5IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-pc2nQDgQPrmAYT5Dl37I1w-1; Wed, 26 Aug 2020 12:27:40 -0400
X-MC-Unique: pc2nQDgQPrmAYT5Dl37I1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BDCA18B9ED3;
 Wed, 26 Aug 2020 16:27:38 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77A1960C13;
 Wed, 26 Aug 2020 16:27:35 +0000 (UTC)
Date: Wed, 26 Aug 2020 12:27:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/2] hw/isa/superio: Set abstract TYPE_ISA_SUPERIO
 instance size
Message-ID: <20200826162733.GF642093@habkost.net>
References: <20200822142816.1318214-1-philmd@redhat.com>
 <20200822142816.1318214-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200822142816.1318214-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 22, 2020 at 04:28:15PM +0200, Philippe Mathieu-Daudé wrote:
> Instead of setting the instance size on each implementations,
> set it on the abstract parent, so we are sure no implementation
> will forget to set it.
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks!

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  hw/isa/isa-superio.c       | 2 +-
>  hw/isa/smc37c669-superio.c | 1 -
>  hw/isa/vt82c686.c          | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index e2e47d8fd99..83eb21ebb2a 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -182,6 +182,7 @@ static const TypeInfo isa_superio_type_info = {
>      .name = TYPE_ISA_SUPERIO,
>      .parent = TYPE_ISA_DEVICE,
>      .abstract = true,
> +    .instance_size = sizeof(ISASuperIODevice),
>      .class_size = sizeof(ISASuperIOClass),
>      .class_init = isa_superio_class_init,
>  };
> @@ -200,7 +201,6 @@ static void fdc37m81x_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo fdc37m81x_type_info = {
>      .name          = TYPE_FDC37M81X_SUPERIO,
>      .parent        = TYPE_ISA_SUPERIO,
> -    .instance_size = sizeof(ISASuperIODevice),
>      .class_init    = fdc37m81x_class_init,
>  };
>  
> diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
> index 18287741cb4..9e59dc16039 100644
> --- a/hw/isa/smc37c669-superio.c
> +++ b/hw/isa/smc37c669-superio.c
> @@ -103,7 +103,6 @@ static void smc37c669_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo smc37c669_type_info = {
>      .name          = TYPE_SMC37C669_SUPERIO,
>      .parent        = TYPE_ISA_SUPERIO,
> -    .instance_size = sizeof(ISASuperIODevice),
>      .class_size    = sizeof(ISASuperIOClass),
>      .class_init    = smc37c669_class_init,
>  };
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 18160ca445d..a4b84d405d0 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -533,7 +533,6 @@ static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo via_superio_info = {
>      .name          = TYPE_VT82C686B_SUPERIO,
>      .parent        = TYPE_ISA_SUPERIO,
> -    .instance_size = sizeof(ISASuperIODevice),
>      .class_size    = sizeof(ISASuperIOClass),
>      .class_init    = vt82c686b_superio_class_init,
>  };
> -- 
> 2.26.2
> 

-- 
Eduardo


