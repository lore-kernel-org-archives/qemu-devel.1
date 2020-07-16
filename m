Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E6AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 11:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D9720760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 11:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJ+YISaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D9720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1oO-0001n4-BH
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 07:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jw1np-0001LN-NI
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 07:11:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29505
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jw1nn-0003gd-Kd
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 07:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594897906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFiLuc5XR3wBs/vyxAIIrKUNG0idjdaeKKJacGoDj18=;
 b=HJ+YISaJW/Lfuid3Ifr2wrDBVN0iQR0kSIVYqazGcxpOCGvs44C/jLYeqfR7IIk6Ph0pte
 EebMYORFM8FxaBayz15Z9FLr1Rk8lOsdBjyCOA593NmQAfHl/FRgRHEa/FzR+wNVAnuAji
 GKRn8I/GvtnJso8sJ6UZ1JQs3YeI8m4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-UZLHo_YvOtKSs2Ig2wXwgw-1; Thu, 16 Jul 2020 07:11:45 -0400
X-MC-Unique: UZLHo_YvOtKSs2Ig2wXwgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D670C1800D42;
 Thu, 16 Jul 2020 11:11:43 +0000 (UTC)
Received: from gondolin (ovpn-113-57.ams2.redhat.com [10.36.113.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 765842B6DC;
 Thu, 16 Jul 2020 11:11:42 +0000 (UTC)
Date: Thu, 16 Jul 2020 13:11:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2] hw/s390x: Move S390_ADAPTER_SUPPRESSIBLE from
 'css.h' to 's390_flic.h'
Message-ID: <20200716131127.6eec15c2.cohuck@redhat.com>
In-Reply-To: <20200715131845.30469-1-philmd@redhat.com>
References: <20200715131845.30469-1-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 15:18:45 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Not all s390x devices require to have access to the CPU internals.
>=20
> To reduce the include dependencies on "s390x/css.h", move the
> S390_ADAPTER_SUPPRESSIBLE definition to "s390x/s390_flic.h".

But css.h is not 'CPU internals', it is the main I/O subsystem?

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/s390x/css.h       | 7 -------
>  include/hw/s390x/s390_flic.h | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 08c869ab0a..7858666307 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -12,7 +12,6 @@
>  #ifndef CSS_H
>  #define CSS_H
> =20
> -#include "cpu.h"

FWIW, we should just be able to remove this #include...

>  #include "hw/s390x/adapter.h"
>  #include "hw/s390x/s390_flic.h"
>  #include "hw/s390x/ioinst.h"
> @@ -233,12 +232,6 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, u=
int8_t isc);
>  void css_register_io_adapters(CssIoAdapterType type, bool swap, bool mas=
kable,
>                                uint8_t flags, Error **errp);
> =20
> -#ifndef CONFIG_KVM
> -#define S390_ADAPTER_SUPPRESSIBLE 0x01
> -#else
> -#define S390_ADAPTER_SUPPRESSIBLE KVM_S390_ADAPTER_SUPPRESSIBLE
> -#endif
> -
>  #ifndef CONFIG_USER_ONLY
>  SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
>                           uint16_t schid);
> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
> index 4687ecfe83..6bf9d73728 100644
> --- a/include/hw/s390x/s390_flic.h
> +++ b/include/hw/s390x/s390_flic.h
> @@ -17,6 +17,13 @@
>  #include "hw/s390x/adapter.h"
>  #include "hw/virtio/virtio.h"
>  #include "qemu/queue.h"
> +#include "cpu.h"

...and we do not need it here AFAICS.

> +
> +#ifndef CONFIG_KVM
> +#define S390_ADAPTER_SUPPRESSIBLE 0x01
> +#else
> +#define S390_ADAPTER_SUPPRESSIBLE KVM_S390_ADAPTER_SUPPRESSIBLE
> +#endif
> =20
>  /*
>   * Reserve enough gsis to accommodate all virtio devices.

Whether the definition of S390_ADAPTER_SUPPRESSIBLE belongs into css.h
or s390_flic.h is probably a matter of taste: the definition of an I/O
adapter is in css.h, and registration of an adapter is done via the
FLIC.

I think removing the cpu.h include might already do what you wanted to
do?


