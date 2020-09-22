Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6752DC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E7523A62
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E7523A62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKX6y-0006lO-6W
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 21:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1kKX6H-0005uX-0y
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:28:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2980 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1kKX6F-0006N3-44
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:28:08 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id E190A5A9BC6765A03F71;
 Tue, 22 Sep 2020 09:28:03 +0800 (CST)
Received: from DGGEML423-HUB.china.huawei.com (10.1.199.40) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 22 Sep 2020 09:28:03 +0800
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.148]) by
 dggeml423-hub.china.huawei.com ([10.1.199.40]) with mapi id 14.03.0487.000;
 Tue, 22 Sep 2020 09:27:57 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 02/24] cryptodev-backend: Register "chardev" as class
 property
Thread-Topic: [PATCH 02/24] cryptodev-backend: Register "chardev" as class
 property
Thread-Index: AQHWkGQfWwRZ0H7w8Em40/9m8Xvkealz3lCQ
Date: Tue, 22 Sep 2020 01:27:56 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DF7820DB@dggeml511-mbx.china.huawei.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-3-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-3-ehabkost@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.58]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=arei.gonglei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 21:28:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Tuesday, September 22, 2020 6:10 AM
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Daniel P. Berrange
> <berrange@redhat.com>; John Snow <jsnow@redhat.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>
> Subject: [PATCH 02/24] cryptodev-backend: Register "chardev" as class
> property
>=20
> Class properties make QOM introspection simpler and easier, as they don't
> require an object to be instantiated.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
> Cc: qemu-devel@nongnu.org
> ---
>  backends/cryptodev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei


> diff --git a/backends/cryptodev.c b/backends/cryptodev.c index
> ada4ebe78b1..3f141f61ed6 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -206,10 +206,6 @@ cryptodev_backend_can_be_deleted(UserCreatable
> *uc)
>=20
>  static void cryptodev_backend_instance_init(Object *obj)  {
> -    object_property_add(obj, "queues", "uint32",
> -                          cryptodev_backend_get_queues,
> -                          cryptodev_backend_set_queues,
> -                          NULL, NULL);
>      /* Initialize devices' queues property to 1 */
>      object_property_set_int(obj, "queues", 1, NULL);  } @@ -230,6 +226,1=
0
> @@ cryptodev_backend_class_init(ObjectClass *oc, void *data)
>      ucc->can_be_deleted =3D cryptodev_backend_can_be_deleted;
>=20
>      QTAILQ_INIT(&crypto_clients);
> +    object_class_property_add(oc, "queues", "uint32",
> +                              cryptodev_backend_get_queues,
> +                              cryptodev_backend_set_queues,
> +                              NULL, NULL);
>  }
>=20
>  static const TypeInfo cryptodev_backend_info =3D {
> --
> 2.26.2


