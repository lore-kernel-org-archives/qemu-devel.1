Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861A0C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 00:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EA120768
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 00:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EA120768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpLXV-0007OR-Jo
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 20:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1jpLWs-0006tU-6s; Sat, 27 Jun 2020 20:50:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2526 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1jpLWp-0003py-P2; Sat, 27 Jun 2020 20:50:41 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 337E7F1C562C7F000B4B;
 Sun, 28 Jun 2020 08:50:27 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sun, 28 Jun 2020 08:50:26 +0800
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.226]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0487.000;
 Sun, 28 Jun 2020 08:50:19 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 05/46] virtio-crypto-pci: Tidy up
 virtio_crypto_pci_realize()
Thread-Topic: [PATCH 05/46] virtio-crypto-pci: Tidy up
 virtio_crypto_pci_realize()
Thread-Index: AQHWSkaxvNpRd0EgTES5AOCv5MWRMajtNxoQ
Date: Sun, 28 Jun 2020 00:50:18 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DF6592C3@dggeml511-mbx.china.huawei.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-6-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-6-armbru@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.225.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=arei.gonglei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 20:50:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: Thursday, June 25, 2020 12:43 AM
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; berrange@redhat.com; ehabkost@redhat.com;
> qemu-block@nongnu.org; peter.maydell@linaro.org;
> vsementsov@virtuozzo.com; Gonglei (Arei) <arei.gonglei@huawei.com>;
> Michael S . Tsirkin <mst@redhat.com>
> Subject: [PATCH 05/46] virtio-crypto-pci: Tidy up virtio_crypto_pci_reali=
ze()
>=20
> virtio_crypto_pci_realize() continues after realization of its "virtio-cr=
ypto-device"
> fails.  Only an object_property_set_link() follows; looks harmless to me.=
  Tidy
> up anyway: return after failure, just like virtio_rng_pci_realize() does.
>=20
> Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/virtio/virtio-crypto-pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Gonglei < arei.gonglei@huawei.com>

> diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.=
c index
> 72be531c95..0755722288 100644
> --- a/hw/virtio/virtio-crypto-pci.c
> +++ b/hw/virtio/virtio-crypto-pci.c
> @@ -54,7 +54,9 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy
> *vpci_dev, Error **errp)
>      }
>=20
>      virtio_pci_force_virtio_1(vpci_dev);
> -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
> +        return;
> +    }
>      object_property_set_link(OBJECT(vcrypto),
>                   OBJECT(vcrypto->vdev.conf.cryptodev), "cryptodev",
>                   NULL);
> --
> 2.26.2


