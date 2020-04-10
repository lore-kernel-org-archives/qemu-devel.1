Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A75C2D0EC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 05:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16C520787
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 05:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="En1I3fT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16C520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMlwa-000704-Tx
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 01:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMlvm-0006Pu-2T
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 01:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMlvk-0000pF-NG
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 01:10:18 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:27586 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMlvf-0000o3-Sa; Fri, 10 Apr 2020 01:10:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvuXto+wVtZyPh4XmCHT0Hga3r+CfVStqzR//LmXeD2Lx4cbotmEbctBlI67TeVi+HIKTtQgrlg31G5s70ENAdx+PXvzAkfWK78Y/P3UaSGnBhNJ+3LvcgWUHzSpox1JssxHlDgXySNx/cSBMDstDMzL3ZiQkINsBAuKsPsExwkgrpBDqHd0EUgmZRvfnFOLn/xW23Kei55ie3NVQHd61dwE9u5RUjhX2BWfDAybjBDyoeyAqX6Gq6cWsQKDUGcfWeiAhWB5etQOwSP+ST0VcD2evssscraLmIhf/NLARE/u7/LnloRMIQAWnm8YwHZsFgmdpVDQch6nLpga/7U98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O68cKpr7Au3qG1xfBHpwxwfMr8cg1DpBqoCWiyubeFw=;
 b=hfGwnUEvHbTEwxLDaCiq+k2s6jLf9DzyT39vuSoGVQdX/yrFooxM5QZWz4kmKf0pY0+gEv0ujpsVXL4YAKRdf0lqnPrdJKZVC6RJmTEJtj1hMGz52djL0LtloRUzlopycvC3YJ4Y3XHNCp7vz+URjuQ1+Lj/RHtFl85KuYSSXrWy/8RfTjGWl6Af3rLyxucdRCJJwOcEuWSDMOhR6eaCNAXshYVNdKd6KgE/anTseA40Li+bcwU86DZe6K1kxqFAJPeSU6N4fGAYIjNiWaN5q7Q7FxkZNt17DPmxwm+VSPlKrKQRJXCpj1Tx71HYwxXMHuBhAX35nSty1uy6QVTeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O68cKpr7Au3qG1xfBHpwxwfMr8cg1DpBqoCWiyubeFw=;
 b=En1I3fT5AwqpI5tLOsD8h0wap/Ry0EHr+9mo0FT5g2uGtlB+qvxQjPhqHcbUDWrMqkMrggeKCvIym9minU8PMtpxdbseFpDIKbfK4FVk80A/CjxSm5fe8Ni2sSOoJmBGSVKy5kdtcPvBphEFQp6k9LM92yHfLhkPVTEzFbCQc+s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Fri, 10 Apr
 2020 05:10:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 05:10:09 +0000
Subject: Re: [PATCH v12 2/3] qcow2: Allow writing compressed data of multiple
 clusters
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1575288906-551879-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <w51y2r41u4d.fsf@maestria.local.igalia.com>
 <5bbb126f-37c0-f107-c3b3-667ed43670fa@virtuozzo.com>
 <AM6PR08MB504841785FF8C1149D70DFC3F4C10@AM6PR08MB5048.eurprd08.prod.outlook.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200410081007152
Message-ID: <0d27cca9-5467-66a8-e9b2-79b84c27e76d@virtuozzo.com>
Date: Fri, 10 Apr 2020 08:10:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <AM6PR08MB504841785FF8C1149D70DFC3F4C10@AM6PR08MB5048.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-ClientProxiedBy: AM0PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:208:122::45) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.134) by
 AM0PR04CA0032.eurprd04.prod.outlook.com (2603:10a6:208:122::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend
 Transport; Fri, 10 Apr 2020 05:10:08 +0000
X-Tagtoolbar-Keys: D20200410081007152
X-Originating-IP: [185.215.60.134]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb9bc5c5-25db-45b2-1571-08d7dd0d7087
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55268BFD8A9480E7E8EFDE66C1DE0@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(376002)(346002)(39840400004)(396003)(136003)(5660300002)(316002)(52116002)(8676002)(66946007)(110136005)(66476007)(16576012)(54906003)(81156014)(8936002)(6486002)(16526019)(66556008)(31686004)(186003)(26005)(2616005)(956004)(31696002)(478600001)(2906002)(86362001)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JF3zr+ceLbWrKRvuVWmi6VOB/d730yDYNd5zbDI9STeZfXjoYFiNCEVGwZNyEmxttjKL5WLs4pcuCWpf2vD9VrPitbo2Nn/lvvOtAw5iCint8tlvrEy5sD1FiOMsQuYHCK1EjuC49gYs9X70A85pmH+hX61fYHmokSnnyhtLnkTBRcRU4ZqgXAdG6Cmg6UZXVC4BJizGqvCXZ4PyDnPBGbPwXsNWN85FxHOrPXvaavpjepTVsnR/rqhci7RYppZ/X9c/U9f365HFGL5lgTuQ0bqhCqyNyGcfq7QRcaLBXhfinnKOFT/Zj+fQFyC/0p57yhwwBtDAU0F2UAhSaRSzWXV07+e+eD6RGiVrkS/RGsQpY5vYv+x9qtHTjKsenxtj/LboY2UU43pf40keuQqGps2RXFcJUHtcnfmzJbNXM8tc2C3Pi/Pgi5nwXyhOCOuF
X-MS-Exchange-AntiSpam-MessageData: 1DXT784ZDc4HzDJvhmnup5Eg/WPwW0xIJLsKg9u4g1bf8L4b086OyqWmR0wgXhjUeJFrn5b6QRCJKgjnD+LxkLUb42CSVSj6KUUAB91u8GIMUWq1aClJpqDZmLXF9bpue6HycNcADzoq1XcRz1Od4g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9bc5c5-25db-45b2-1571-08d7dd0d7087
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 05:10:09.1107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbweGgf2AbQe2c/PkUY+wxM3jUdZAZmBq1suXlxi3+zGLO5Zthd2sfz/frsuMSqDnRxCWERA4x861+GyJRnDk7nTZ2uowx9Q9Nq4O7TMtzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.129
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDQuMjAyMCAzOjEyLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4gV2UgY291bGQgYXNz
aWduIGluZGljZXMgdG8gdGhlIGNsdXN0ZXJzL2NodW5rcyBhbmQgaW1wcm92ZSB0aGUgYWxnb3Jp
dGhtIHRvIHdyaXRlIHRoZW0gZG93biBvbiB0aGUgZGlzayBpbiB0aGUgc2FtZSBvcmRlciBhZGph
Y2VudGx5LiBJZiB5b3UgZmluZCBpdCBmZWFzaWJsZSBmb3IgUUVNVSwgSSdkIGxpa2UgdG8gY3Jl
YXRlIGEgdGFzayBmb3IgZG9pbmcgdGhhdCwgc2hhbGwgST8NCj4gDQoNCkNvbXByZXNzZWQgY2x1
c3RlciBvY2N1cHkgZGlmZmVyZW50IHNpemUgY2h1bmtzIGluIHRoZSBpbWFnZS4gSG93IGFyZSB5
b3UgZ29pbmcgdG8gcHJlYWxsb2NhdGU/IEFueXdheSwgSSBkb24ndCBzZWUgYW55IGJlbmVmaXQg
aW4gb3JkZXJpbmcgY29tcHJlc3NlZCBjbHVzdGVycywgSSB0aGluayBpdCdzIG5vdCB3b3J0aCBk
b2luZy4NCg0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICpGcm9tOiogVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPiAqU2VudDoq
IFRodXJzZGF5LCBBcHJpbCA5LCAyMDIwIDk6MzkgUE0NCj4gKlRvOiogQWxiZXJ0byBHYXJjaWEg
PGJlcnRvQGlnYWxpYS5jb20+OyBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hA
dmlydHVvenpvLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUu
b3JnPjsgcWVtdS1ibG9ja0Bub25nbnUub3JnIDxxZW11LWJsb2NrQG5vbmdudS5vcmc+DQo+ICpD
YzoqIGt3b2xmQHJlZGhhdC5jb20gPGt3b2xmQHJlZGhhdC5jb20+OyBhcm1icnVAcmVkaGF0LmNv
bSA8YXJtYnJ1QHJlZGhhdC5jb20+OyBtcmVpdHpAcmVkaGF0LmNvbSA8bXJlaXR6QHJlZGhhdC5j
b20+OyBEZW5pcyBMdW5ldiA8ZGVuQHZpcnR1b3p6by5jb20+DQo+ICpTdWJqZWN0OiogUmU6IFtQ
QVRDSCB2MTIgMi8zXSBxY293MjogQWxsb3cgd3JpdGluZyBjb21wcmVzc2VkIGRhdGEgb2YgbXVs
dGlwbGUgY2x1c3RlcnMNCj4gMDkuMDQuMjAyMCAxOTo1MCwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6
DQo+PiBPbiBNb24gMDIgRGVjIDIwMTkgMDE6MTU6MDUgUE0gQ0VULCBBbmRyZXkgU2hpbmtldmlj
aCB3cm90ZToNCj4+PiArc3RhdGljIGNvcm91dGluZV9mbiBpbnQNCj4+PiArcWNvdzJfY29fcHdy
aXRldl9jb21wcmVzc2VkX3BhcnQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRlcywNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBRRU1VSU9WZWN0
b3IgKnFpb3YsIHNpemVfdCBxaW92X29mZnNldCkNCj4+PiArew0KPj4+ICvCoMKgwqAgQkRSVlFj
b3cyU3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KPj4+ICvCoMKgwqAgQWlvVGFza1Bvb2wgKmFpbyA9
IE5VTEw7DQo+Pj4gK8KgwqDCoCBpbnQgcmV0ID0gMDsNCj4+PiArDQo+Pj4gK8KgwqDCoCBpZiAo
aGFzX2RhdGFfZmlsZShicykpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9UU1VQ
Ow0KPj4+ICvCoMKgwqAgfQ0KPj4+ICsNCj4+PiArwqDCoMKgIGlmIChieXRlcyA9PSAwKSB7DQo+
Pj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBhbGlnbiBlbmQg
b2YgZmlsZSB0byBhIHNlY3RvciBib3VuZGFyeSB0byBlYXNlIHJlYWRpbmcgd2l0aA0KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgICogc2VjdG9yIGJhc2VkIEkvT3MNCj4+PiArwqDCoMKgwqDCoMKgwqDC
oCAqLw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IGxlbiA9IGJkcnZfZ2V0bGVuZ3RoKGJz
LT5maWxlLT5icyk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChsZW4gPCAwKSB7DQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGxlbjsNCj4+PiArwqDCoMKgwqDCoMKgwqAgfQ0K
Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gYmRydl9jb190cnVuY2F0ZShicy0+ZmlsZSwgbGVu
LCBmYWxzZSwgUFJFQUxMT0NfTU9ERV9PRkYsIE5VTEwpOw0KPj4+ICvCoMKgwqAgfQ0KPj4+ICsN
Cj4+PiArwqDCoMKgIGlmIChvZmZzZXRfaW50b19jbHVzdGVyKHMsIG9mZnNldCkpIHsNCj4+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4gK8KgwqDCoCB9DQo+Pj4gKw0KPj4+
ICvCoMKgwqAgd2hpbGUgKGJ5dGVzICYmIGFpb190YXNrX3Bvb2xfc3RhdHVzKGFpbykgPT0gMCkg
ew0KPj4+ICvCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBjaHVua19zaXplID0gTUlOKGJ5dGVzLCBz
LT5jbHVzdGVyX3NpemUpOw0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFhaW8gJiYg
Y2h1bmtfc2l6ZSAhPSBieXRlcykgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFpbyA9
IGFpb190YXNrX3Bvb2xfbmV3KFFDT1cyX01BWF9XT1JLRVJTKTsNCj4+PiArwqDCoMKgwqDCoMKg
wqAgfQ0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gcWNvdzJfYWRkX3Rhc2soYnMs
IGFpbywgcWNvdzJfY29fcHdyaXRldl9jb21wcmVzc2VkX3Rhc2tfZW50cnksDQo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAsIDAs
IG9mZnNldCwgY2h1bmtfc2l6ZSwgcWlvdiwgcWlvdl9vZmZzZXQsIE5VTEwpOw0KPj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAocmV0IDwgMCkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJy
ZWFrOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHFpb3Zfb2Zm
c2V0ICs9IGNodW5rX3NpemU7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG9mZnNldCArPSBjaHVua19z
aXplOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBieXRlcyAtPSBjaHVua19zaXplOw0KPj4+ICvCoMKg
wqAgfQ0KPj4gDQo+PiBUaGlzIHBhdGNoIGFsbG93cyB0aGUgdXNlciB0byB3cml0ZSBtb3JlIHRo
YW4gb25lIGNsdXN0ZXIgb2YgY29tcHJlc3NlZA0KPj4gZGF0YSBhdCBhIHRpbWUsIGFuZCBpdCBk
b2VzIHNvIGJ5IHNwbGl0dGluZyB0aGUgcmVxdWVzdCBpbnRvIG1hbnkNCj4+IGNsdXN0ZXItc2l6
ZWQgcmVxdWVzdHMgYW5kIHVzaW5nIHFjb3cyX2FkZF90YXNrKCkgZm9yIGVhY2ggb25lIG9mIHRo
ZW0uDQo+PiANCj4+IFdoYXQgaGFwcGVucyBob3dldmVyIGlzIHRoYXQgdGhlcmUncyBubyBndWFy
YW50ZWUgdGhhdCB0aGUgcmVxdWVzdHMgYXJlDQo+PiBwcm9jZXNzZWQgaW4gdGhlIHNhbWUgb3Jk
ZXIgdGhhdCB0aGV5IHdlcmUgYWRkZWQuDQo+PiANCj4+IE9uZSBjb25zZXF1ZW5jZSBpcyB0aGF0
IHJ1bm5pbmcgb24gYW4gZW1wdHkgcWNvdzIgZmlsZSBhIGNvbW1hbmQgYXMNCj4+IHNpbXBsZSBh
cyB0aGlzIG9uZToNCj4+IA0KPj7CoMKgwqDCoCBxZW11LWlvIC1jICd3cml0ZSAtYyAwIDI1Nmsn
IGltYWdlLnFjb3cyDQo+PiANCj4+IGRvZXMgbm90IGFsd2F5cyBwcm9kdWNlIHRoZSBzYW1lIHJl
c3VsdHMuDQo+PiANCj4+IFRoaXMgZG9lcyBub3QgaGF2ZSBhbnkgdXNlci12aXNpYmxlIGNvbnNl
cXVlbmNlcyBmb3IgdGhlIGd1ZXN0LiBJbiBhbGwNCj4+IGNhc2VzIHRoZSBkYXRhIGlzIGNvcnJl
Y3RseSB3cml0dGVuLCBpdCdzIGp1c3QgdGhhdCB0aGUgb3JkZXJpbmcgb2YgdGhlDQo+PiBjb21w
cmVzc2VkIGNsdXN0ZXJzIChhbmQgdGhlcmVmb3JlIHRoZSBjb250ZW50cyBvZiB0aGUgTDIgZW50
cmllcykgd2lsbA0KPj4gYmUgZGlmZmVyZW50IGVhY2ggdGltZS4NCj4+IA0KPj4gQmVjYXVzZSBv
ZiB0aGlzIGEgdGVzdCBjYW5ub3QgZXhwZWN0IHRoYXQgcnVubmluZyB0aGUgc2FtZSBjb21tYW5k
cyBvbg0KPj4gYW4gZW1wdHkgaW1hZ2UgcHJvZHVjZXMgYWx3YXlzIHRoZSBzYW1lIHJlc3VsdHMu
DQo+PiANCj4+IElzIHRoaXMgc29tZXRoaW5nIHRoYXQgd2Ugc2hvdWxkIGJlIGNvbmNlcm5lZCBh
Ym91dD8NCj4+IA0KPiANCj4gUGFyYWxsZWwgd3JpdGluZyBjb21wcmVzc2VkIGNsdXN0ZXJzIGlz
IHNpZ25pZmljYW50IGltcHJvdmVtZW50LCBhcyBpdCBhbGxvdyBjb21wcmVzc2luZyBpbiByZWFs
bHkgcGFyYWxsZWwgdGhyZWFkcy4NCj4gDQo+IEdlbmVyYWxseSwgYXN5bmMgcGFyYWxsZWwgaXNz
dWluZyBvZiBzZXZlcmFsIHJlcXVlc3RzIGdpdmVzIG1vcmUgcGVyZm9ybWFuY2UgdGhhbiBoYW5k
bGluZyBwZWFjZXMgb25lLWJ5LW9uZSwgbWlycm9yIHdvcmtzIG9uIHRoaXMgYmFzaXMgYW5kIGl0
IGlzIGZhc3QuIEkndmUgYWxyZWFkeSBtb3ZlZCBxY293MiB0byB0aGlzIGlkZWEgKGFpbyB0YXNr
cyBpbiBxY293MiBjb2RlKSwgYW5kIGluIHByb2dyZXNzIG9mIG1vdmluZyBiYWNrdXAgam9iLiBT
bywgSSB0aGluayB0aGF0IGFzeW5jaHJvbnkgYW5kIGFtYmlndWl0eSB3b3VsZCBiZSBuYXRpdmUg
Zm9yIGJsb2NrLWxheWVyIGFueXdheS4NCj4gDQo+IEhtbS4gU3RpbGwsIHdoYXQgYWJvdXQgY2x1
c3RlciBzZXF1ZW5jZT8gRm9yIG5vcm1hbCBjbHVzdGVycyB0aGVyZSBtYXkgYmUgc2ltcGxlIHRo
aW5nIHRvIGRvOiBwcmVhbGxvY2F0aW9uIChhdCBsZWFzdCBvZiBtZXRhZGF0YSkuIFNvLCB3ZSBj
YW4gcHJlLWNyZWF0ZSBjbHVzdGVyIHNlcXVlbmNlLi4gQnV0IHdoYXQgdG8gZG8gd2l0aCBjb21w
cmVzc2VkIGNsdXN0ZXJzIGlmIHdlIHdhbnQgc3BlY2lmaWMgb3JkZXIgZm9yIHRoZW0sIEkgZG9u
J3Qga25vdy4gT24gdGhlIG90aGVyIGhhbmQsIG9yZGVyaW5nIG9mIG5vcm1hbCBjbHVzdGVyIG1h
eSBtYWtlIHNlbmNlOiBpdCBzaG91bGQgaW5jcmVhc2UgcGVyZm9ybW5hY2Ugb2YgZm9sbG93aW5n
IElPLiBCdXQgZm9yIGNvbXByZXNzZWQgY2x1c3RlcnMgaXQncyBub3QgdGhlIGNhc2UuDQo+IA0K
PiBTbywgSSBkb24ndCB0aGluayB3ZSBzaG91bGQgbWFrZSBzcGVjaWZpYyB3b3JrYXJvdW5kIGZv
ciB0ZXN0aW5nLi4uIFdoYXQgZXhhY3RseSBpcyB0aGUgY2FzZT8NCj4gDQo+IC0tIA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IFZsYWRpbWlyDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

