Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B4AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993EE2074D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993EE2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k69Bc-0002Wu-P3
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 05:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1k69B3-0001yI-62; Thu, 13 Aug 2020 05:05:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2094 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1k69B0-0004Ce-CI; Thu, 13 Aug 2020 05:05:36 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 21A0373400E79736B731;
 Thu, 13 Aug 2020 17:05:24 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 13 Aug 2020 17:05:22 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.170]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0487.000;
 Thu, 13 Aug 2020 17:05:15 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH 09/11] usb/bus: Remove dead assignment in
 usb_get_fw_dev_path()
Thread-Topic: [PATCH 09/11] usb/bus: Remove dead assignment in
 usb_get_fw_dev_path()
Thread-Index: AQHWcUTHhXDTZfvtm0WvjC1m5FN5Fak1vs4w
Date: Thu, 13 Aug 2020 09:05:15 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B8A08D8@dggemm511-mbx.china.huawei.com>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-10-kuhn.chenqun@huawei.com>
In-Reply-To: <20200813073712.4001404-10-kuhn.chenqun@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.50]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 05:05:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Pannengyuan <pannengyuan@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>  hw/usb/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c index b17bda3b29..77d3f7ddb8
> 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -612,8 +612,8 @@ static char *usb_get_fw_dev_path(DeviceState *qdev)
>              in++;
>          } else {
>              /* the device itself */
> -            pos +=3D snprintf(fw_path + pos, fw_len - pos, "%s@%lx",
> -                            qdev_fw_name(qdev), nr);
> +            snprintf(fw_path + pos, fw_len - pos,
> "%s@%lx",qdev_fw_name(qdev),
Sorry, a space is missing here. I will add it later in V2.

Thanks.
> +                     nr);
>              break;
>          }
>      }
> --
> 2.23.0


