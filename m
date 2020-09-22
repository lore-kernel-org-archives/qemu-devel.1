Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EC3C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6462823A62
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6462823A62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKX6p-0006Vh-Dl
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 21:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1kKX68-0005mP-PG
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:28:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:34570 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1kKX66-0006LZ-B9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:28:00 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id C7D3F58698649941684C;
 Tue, 22 Sep 2020 09:27:42 +0800 (CST)
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.148]) by
 dggeml406-hub.china.huawei.com ([10.3.17.50]) with mapi id 14.03.0487.000;
 Tue, 22 Sep 2020 09:27:32 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 01/24] cryptodev-vhost-user: Register "chardev" as class
 property
Thread-Topic: [PATCH 01/24] cryptodev-vhost-user: Register "chardev" as
 class property
Thread-Index: AQHWkGQcbVbhQtzC10imWyaleWssTqlz3dyA
Date: Tue, 22 Sep 2020 01:27:32 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DF7820CF@dggeml511-mbx.china.huawei.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-2-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-2-ehabkost@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.58]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=arei.gonglei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 21:27:43
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
> Subject: [PATCH 01/24] cryptodev-vhost-user: Register "chardev" as class
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

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei

>  backends/cryptodev-vhost-user.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/backends/cryptodev-vhost-user.c
> b/backends/cryptodev-vhost-user.c index 41089dede15..690738c6c95
> 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -336,13 +336,6 @@ cryptodev_vhost_user_get_chardev(Object *obj,
> Error **errp)
>      return NULL;
>  }
>=20
> -static void cryptodev_vhost_user_instance_int(Object *obj) -{
> -    object_property_add_str(obj, "chardev",
> -                            cryptodev_vhost_user_get_chardev,
> -                            cryptodev_vhost_user_set_chardev);
> -}
> -
>  static void cryptodev_vhost_user_finalize(Object *obj)  {
>      CryptoDevBackendVhostUser *s =3D
> @@ -363,13 +356,17 @@ cryptodev_vhost_user_class_init(ObjectClass *oc,
> void *data)
>      bc->create_session =3D cryptodev_vhost_user_sym_create_session;
>      bc->close_session =3D cryptodev_vhost_user_sym_close_session;
>      bc->do_sym_op =3D NULL;
> +
> +    object_class_property_add_str(oc, "chardev",
> +                                  cryptodev_vhost_user_get_chardev,
> +                                  cryptodev_vhost_user_set_chardev);
> +
>  }
>=20
>  static const TypeInfo cryptodev_vhost_user_info =3D {
>      .name =3D TYPE_CRYPTODEV_BACKEND_VHOST_USER,
>      .parent =3D TYPE_CRYPTODEV_BACKEND,
>      .class_init =3D cryptodev_vhost_user_class_init,
> -    .instance_init =3D cryptodev_vhost_user_instance_int,
>      .instance_finalize =3D cryptodev_vhost_user_finalize,
>      .instance_size =3D sizeof(CryptoDevBackendVhostUser),
>  };
> --
> 2.26.2


