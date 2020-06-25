Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79124C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4769E20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AZCLLpGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4769E20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXJZ-0005Pa-IU
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joXIL-0004Kt-Ok; Thu, 25 Jun 2020 15:12:21 -0400
Received: from mail-eopbgr130134.outbound.protection.outlook.com
 ([40.107.13.134]:51783 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joXIJ-0000TC-FR; Thu, 25 Jun 2020 15:12:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqMK6E5ZGmNZC34ujxnS1hWe0J5Ijh9aW3p0qmjBKOX1Ih8dAeV9HEKJOPea5lOR7pT5pjnT/8rYAEBd4KCNUN6hNZIq6MDKcGozUBfhc7lvRy/UE2KNpvaoQ3ogSkjnXZFQpcR4+TgGKAOwDZqnK/kkFQYIFzIcamrc6EIW0e/ZABSJ6GT83EsYW14I8BAFGM+aKxftewNihBfPNy20TGN9zvO8JVgoUNTC40Rtuzc/Y2kPBC5MaK4kfzqYMRULBD9SPaNE8OqTSHyJPLba7QgPm1HIImT9qx7b4r1vcL9rk+1Jvj25r+iBhVzJWAVxg6YAEzzf3mr1pwACu9gH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EEvhHFsfCD3XUrf+5KxdF5Zt8zk48io/W5FH3/Wav4=;
 b=R22DJQRsHk6NumHcP+pOLYg614yfdpx+iHWtWGakkht1iPNi0BofSn7v7wTqr1UAzs7plVn5xmVbCaLtdK1fO9wYW/3ipouBaGwHRBB80DtyF4xaOHrzkJe72nuayvhF0NzVe/Fdi+P65U+UCHrmKz4y0D1kaBnmLuVdHuaP30ieISKUDqAOoOIVsjLmE1wCFUEPFi4FLqbm9V8w3YJp5MDOmgUNtUZKq6XiNrAHpnGdYtqPh1EL7EnMw8glgXbfhhxcAlYFkV84ZQmPmt3iYz/1ZgX1PP1lErCqY576Mcn/ZM/MmOByyLdVi/7Exr2beT6QEJE5Xju1BNn8Kscs2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EEvhHFsfCD3XUrf+5KxdF5Zt8zk48io/W5FH3/Wav4=;
 b=AZCLLpGvPK2X2XkGafbSBhyXzRvW0YAAVqfaIPlitNXwXVa+Jf9bOOJMk9cRzrhv8E1FzgsMam5tWqZB7l+e67z1II27fqDolt74cPm1INqNU4Ez8o6M2Hpie4e0uQPdEPXteeNIMtc701szfJZQcYXFNlvXYoA5Qkozvfe8m+Q=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1780.eurprd08.prod.outlook.com (2603:10a6:203:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 19:12:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 19:12:16 +0000
Subject: Re: [PATCH 05/46] virtio-crypto-pci: Tidy up
 virtio_crypto_pci_realize()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-6-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d2e1d520-0ea2-4f2b-eca6-b7a30d1de3d6@virtuozzo.com>
Date: Thu, 25 Jun 2020 22:12:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0126.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.69) by
 AM0PR10CA0126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 19:12:15 +0000
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1238db7f-48f8-4c42-a6e6-08d8193bac6b
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1780:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB178029E6E8C9F3682B827191C1920@AM5PR0801MB1780.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +drk8tfWb65mrfR9/O5o+mdCUe2gqDOgTmo4fR0bDBKQdNug6Q3WYeD/oUe/k34qxheVzquibLCL89qpjOgdPfIt8zqrfetDwntAww4yuhplwAyFdiTWrjVknPbsW2xDAawEixLWIUvR2g1CR6niZaC5BjbmHrv95kPIMRjm44YTab5DSHm4Pz+M/hWCeGgsrm2lVLlYGoypRGLXEd7r0ww5AnKxaI+nIIbneNTi0AaqApPKLdNczbWSJU4WnSR1TPm+1haCPV31DFV11qp1lT7yETkaKMR5LS+r44QB1Mr4LeQ/9EXCJiDOr6DGkARZxTJJpR7ZhLaBkConclee1S0G3teoSJjZjrnHxii8ibKriA1/UwjjUiTHhN87Kd4o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(396003)(346002)(376002)(366004)(66946007)(86362001)(52116002)(66476007)(66556008)(316002)(478600001)(16576012)(54906003)(83380400001)(4326008)(8936002)(8676002)(36756003)(6486002)(2616005)(956004)(31686004)(5660300002)(2906002)(16526019)(186003)(31696002)(4744005)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: waSdnQaZq17v29uk6F3ikaCyOTcTgvNEFssiqIpHfq5buEpK2ySsFEYfC6PV1mVfxLTy8dvKYjOQlzt7siswubHj5VVb5y3C3N81E0lejRUaTO8CrovyQgxiLpYZZvXOYxTJPrXu69a4+GSfTiKtgqL5AfkFQmqXxQ9SnMW5UUb3bN0GYnyU6qL66MaiKayNMqych4gDaTCYBA8LBWaA6qbHINRsY6T8IV8nzvRLdJ1fc4V0kyercgxFmmXaiwrbHL07Oy9J9XQwPTgB3KbepPGkB76vnQMpkIdr9eMZNsmRJFPPGz3N6OgaxF+8pxomBrNXv3rqDd8h9leE2yu+C/rzqPs+bzciYXD6LRSdI3FQRKo+YUjIatAXTu5OSID6yzRfcJXQ2WPOhJNKUt8GOJS3zq8frMHoppnCvr+tgB3PFB9A6peaUxx0RciXg2ovpYZEp0+hVxOxzpc0guDhScOvC/c7JYhnFcnVZiuYhvujhYRDUFoVhoYo2b99wz5n
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1238db7f-48f8-4c42-a6e6-08d8193bac6b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 19:12:16.0810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi6xpD8tBZMYblBaEy+Dy9Cx8MpQBrv+bUkMBqGm56DW0NCIMsoloHso4fY7YUTAXrGx9wkEPFoMWNNCOfAlcwLb0t03mLbAoxLoriLjFxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1780
Received-SPF: pass client-ip=40.107.13.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 15:12:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> virtio_crypto_pci_realize() continues after realization of its
> "virtio-crypto-device" fails.  Only an object_property_set_link()
> follows; looks harmless to me.  Tidy up anyway: return after failure,
> just like virtio_rng_pci_realize() does.
> 
> Cc: "Gonglei (Arei)"<arei.gonglei@huawei.com>
> Cc: Michael S. Tsirkin<mst@redhat.com>
> Signed-off-by: Markus Armbruster<armbru@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

