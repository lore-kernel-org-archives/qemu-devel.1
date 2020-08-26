Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3ACC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609C320737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609C320737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAkjq-0006Bn-N0
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 22:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kAkjH-0005ld-NF; Tue, 25 Aug 2020 21:59:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2925 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kAkjF-0004tH-PJ; Tue, 25 Aug 2020 21:59:59 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 376F280CCBEB04E669E6;
 Wed, 26 Aug 2020 09:59:51 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.141]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 09:59:40 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: RE: [PATCH v2 08/10] usb/bus: Remove dead assignment in
 usb_get_fw_dev_path()
Thread-Topic: [PATCH v2 08/10] usb/bus: Remove dead assignment in
 usb_get_fw_dev_path()
Thread-Index: AQHWeu2YfCXkdyEFi0CUe/xr9r5XdalJoXrg
Date: Wed, 26 Aug 2020 01:59:40 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B8E2416@dggemm511-mbx.china.huawei.com>
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-9-kuhn.chenqun@huawei.com>
 <87r1rudc1y.fsf@dusky.pond.sub.org>
In-Reply-To: <87r1rudc1y.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.50]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 21:47:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Pannengyuan <pannengyuan@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> >  hw/usb/bus.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/usb/bus.c b/hw/usb/bus.c index b17bda3b29..7bab0499ad
> > 100644
> > --- a/hw/usb/bus.c
> > +++ b/hw/usb/bus.c
> > @@ -612,8 +612,8 @@ static char *usb_get_fw_dev_path(DeviceState
> > *qdev)
>            if (in[0] =3D=3D '.') {
>                /* some hub between root port and device */
>                pos +=3D snprintf(fw_path + pos, fw_len - pos, "hub@%lx/",
> nr);
> >              in++;
> >          } else {
> >              /* the device itself */
> > -            pos +=3D snprintf(fw_path + pos, fw_len - pos, "%s@%lx",
> > -                            qdev_fw_name(qdev), nr);
> > +            snprintf(fw_path + pos, fw_len - pos, "%s@%lx",
> qdev_fw_name(qdev),
> > +                     nr);
> >              break;
> >          }
> >      }
>=20
> I'd prefer to keep the line break where it is:
>=20
>             snprintf(fw_path + pos, fw_len - pos, "%s@%lx",
>                      qdev_fw_name(qdev), nr);
>=20
> The patch is safe, so
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20
> The loss of symmetry betwen the two arms of the if is a bit sad.  Up to G=
erd.

If symmetry looks better. I should change it later.

Thanks,
Chen Qun

