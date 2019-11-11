Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE312C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C4D20856
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VPfN7+xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C4D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU7l1-0002zU-Le
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 06:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iU7kK-0002KP-Fz
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iU7kJ-0004Bc-IJ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:20:36 -0500
Received: from mail-ve1eur02on0729.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::729]:64618
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iU7kF-00048M-0d; Mon, 11 Nov 2019 06:20:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa23RTn6Df2r2KM2S5gQxE6YzavCKGfr343ytOThRhmepv2ffzXIH97m68E3EPzSCpXwjjbd3taShMiu+J+1Q64756wEzdEgiIrU5b4vyL0KpIJPJm0F93v3/CCBMN5t2i9qpqj1nLTyMQKGdeCKVeDejTD78Iwwrx1HYJZ3EUSiOVlumhCbhyxBClSL/VpbskTbbY2JLhgWnlb7QMUY0h/fg1wXpWvs7mcTTkdNHcUT71/ELaD2oc6v3MtAgPd3dann5fqs+Pvs+oWFvx/hIGwIwVMnKChUzIawX6dEMBLwbdSnrJ4mTTJJRb+13ekTe7mq59LWSIG9Ibp68V89KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfKDGi0U4ZCPtoGBaIdeweNtdrVV5x9jB3Svviak4GI=;
 b=MM5r0vrZcIIRB2fuAvMA1Agz0gv2Q1QSuH7m8rMHiItM9R/mLZnCpG/2GcciqNO48R8Sh5VLWwkhPvX1YX9ef/q6NIxnR7JDsExoXEwpzr4ecT0N3plmwUSHWUsPTMRwJWqFuGAVD0CpqgcSrkbnaytsXRT/oygFaHKurtbclF92hF/ZiXm5/xbVSak7GvvVKsebSgv9ABXji4oR7qMq4HKyrGpwGbKDC0qKPjdMJP4ZCP3ojZmtrTTVfT0pDGRBbqFvqfnWu0CJtPZ1dL0Mp89sBI32IscGKL8WQeho61DT4n6jP5xjtAuHNhMtEeJSRuKkX9VDXIBI7+M9Jyqbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfKDGi0U4ZCPtoGBaIdeweNtdrVV5x9jB3Svviak4GI=;
 b=VPfN7+xpuQwrwZgCWdzCnn4ytj25hPMt73wJ97OV8fjJi0Qs23ueZV7ZyQuxnVkZ7r07tBMG2Rs12M/nNeO+nTCJI7ILgao1ILk0mDl9v/wkLWpcsS2J+8hG2KvlsjE29nLWk45snSOZAqHbRnlTJxStYO2bWVF6mBIaPNaAxm8=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4404.eurprd08.prod.outlook.com (20.179.32.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 11:20:27 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 11:20:27 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio: make seg_max virtqueue size dependent
Thread-Topic: [PATCH v2 1/1] virtio: make seg_max virtqueue size dependent
Thread-Index: AQHVljqlxJiHnEjNFk6m2D4OL1pnOqeF1zCAgAAAYAA=
Date: Mon, 11 Nov 2019 11:20:27 +0000
Message-ID: <8f83ed8f-4718-1fa3-7114-0a093c871b61@virtuozzo.com>
References: <20191108134249.19004-1-dplotnikov@virtuozzo.com>
 <20191108134249.19004-2-dplotnikov@virtuozzo.com>
 <20191111111903.GD442334@stefanha-x1.localdomain>
In-Reply-To: <20191111111903.GD442334@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0152.eurprd05.prod.outlook.com
 (2603:10a6:7:28::39) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [88.215.186.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f962beba-c5ef-4cbd-fb40-08d76699276a
x-ms-traffictypediagnostic: AM0PR08MB4404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4404DC1D60E5EFE75CAD32E0CF740@AM0PR08MB4404.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39840400004)(136003)(376002)(366004)(189003)(199004)(31696002)(486006)(71190400001)(71200400001)(107886003)(76176011)(6506007)(102836004)(2906002)(386003)(53546011)(99286004)(6916009)(7736002)(11346002)(31686004)(446003)(476003)(26005)(66066001)(2616005)(25786009)(36756003)(305945005)(4326008)(86362001)(6436002)(6116002)(3846002)(66476007)(66556008)(64756008)(229853002)(14454004)(478600001)(186003)(6512007)(8936002)(66446008)(316002)(8676002)(81156014)(81166006)(256004)(5660300002)(66946007)(6486002)(4744005)(6246003)(52116002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4404;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /F4xSicRzrHiiVJ69rf58uokpx5k2XDoh21SMX6l9gv4xwL5GW3LLmFUCnCxkYmm/LcrIh7TJ8FyZb9LhfMSbY9+/AMpZw6JPT/o8GjRwk/aKps4jwId/8R7n3rGth+iYeHrDj6lPjeVeWJyPXmYueLYSkdZVpHlr49GB1+zW1RsDdEnNYcbUadKgEDAiTZCmlCU+jPCHIFDWNw4ExgwEex8YXa9Yw4o9u550MbxdorN4GawI5aqS27E7elH7yx5XLO3aiUZRMv5+Hb5lvxdGsNVlCnOV2axCyfLXwiiuwQTCCE86hpHHxDeLsA1WdEYMayrPctO6g+LIaax/qy80CpJI/Mia0/0xEItnG1g4ObkVJ+jXpedbx7je5nQD+KMvnd8uyxNZkBi8AUE8k0MPFWcuVhLSdw7DNpydSP3d0wVzo+plcrQdTZOZneix8nY
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <15392E3000E8134ABF1C889ED1A73D58@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f962beba-c5ef-4cbd-fb40-08d76699276a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 11:20:27.5225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tasLVcDKLV3mLo3M6r4TwItsOREItQzM/Ijtkq9K1ny9DPrUYlM13j28kU9fO+YG502YX4H/mCKADvU1Ere+tLC4jE9P92gqW0nNvXGrtXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4404
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::729
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11.11.2019 14:19, Stefan Hajnoczi wrote:
> On Fri, Nov 08, 2019 at 04:42:49PM +0300, Denis Plotnikov wrote:
>> +    virtio_stl_p(vdev, &blkcfg.seg_max, s->conf.queue_size - 2);
> [...]
>> +    virtio_stl_p(vdev, &scsiconf->seg_max, s->conf.virtqueue_size - 2);
> Please extend the queue_size checks to report an error when queue_size
> <=3D 2.

Ok.

Denis

>
> Stefan

