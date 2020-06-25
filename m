Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821EDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4651D2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uslqljHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4651D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXGg-0002bl-Fr
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joXFt-0001kX-6a; Thu, 25 Jun 2020 15:09:49 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:39585 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joXFq-0007cb-0k; Thu, 25 Jun 2020 15:09:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1g9/xPQEQjeOXFQOa3aWo731f6AuOfXmV5FgLGFQqdyLqDNrDm9DkizBrQ67x1v9Gv7sTQHbJlDK6CA7zjp6aaQKYUxg9fSiJe3bnSUmMVovRF7yGXuetQs24WfdJNF/E5ywi9TFNBee9fa/7BME/UOOXUrQ2PrGKVIqqv7/7aw12GNCKivYTs7mHYPQreeWuexsJ1z/n06iHaD4hzdCkh8GSg2M6RaobPF1iZGy2cYIfQEqp+/wQxF5q3tpYV6ououIH83+BhxwxZYVHDarTWjn6sawQCD77ngnmgC1BENYaoWEXohDNRZJl5zm3h/Tz4/n3bh0v6DAf0dA9EGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B0a8bcIft951YEnj7MUx8eb832h1jnHLIENUim58Os=;
 b=DeTIeSJ2vt2ux7TxBfpkdRyPYElm7hbZ8EJJZjO81/oNKd7DA42okgtcD0N2Tn6ffVX6oRnPhWyDiNowLSuSvB8LFWz0sKs9c5kydnpPLpWLim0KnAcjC+b597z8Z/OR4Adikt1a07VT0r8Dntsr71pKh5p3jSPbVW3H3bv0ZGW7pPB2UuUsXyQm1UI74QkRzeimciMnOo9ltnYvwTFjwz9tRXLTvkI+sBA58NjIxtXkz9eODdnf3NkQNGJAY6GmYXey9TIetpRJIKovh0kfUT3j9mWCbzpYAfScNAmk5s4YyOex/85+kmaGVkFNnslJXIu8gv4LgZCRUB6pi/JK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B0a8bcIft951YEnj7MUx8eb832h1jnHLIENUim58Os=;
 b=uslqljHwgBHBxLgCDU0di+FBzy/2ijM74EGWeHNjOIy1Qlim0kit9WaKSKmW32b6V6hNFes7dFqtPa7OI6CyaXhMuAYwTovG3un4IaJl7jRa1f3/bC+nLa5DQOLli+9ofSVsZC1gN8JsRBS1brBoijtn13GoQ8Ajm0wqwAK9rbA=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1780.eurprd08.prod.outlook.com (2603:10a6:203:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 19:09:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 19:09:40 +0000
Subject: Re: [PATCH 04/46] macio: Tidy up error handling in
 macio_newworld_realize()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-5-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ff979e91-3144-24fd-7f70-7c1137b4962d@virtuozzo.com>
Date: Thu, 25 Jun 2020 22:09:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0039.eurprd04.prod.outlook.com
 (2603:10a6:208:1::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.69) by
 AM0PR04CA0039.eurprd04.prod.outlook.com (2603:10a6:208:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 19:09:39 +0000
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf13ab67-5a98-45ee-1880-08d8193b4f88
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1780:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB17809FA7CF63E3B027218A45C1920@AM5PR0801MB1780.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDie5H2UAcOwOpE5yfEB7eJ+H2Vmbib6MCi53K5ngdQ/PwpZS/vPJ9BKqOd1LVYwGd1cPuS56PGmCCmSur5v9+DYQcmtMZCe+vGq+rBPU99/xyq12318l+kFwFlO1XNt8Umcy4W//AayuBKthbSjMZFGksQ2ipk3MNvoenDDFlWdkCjqMz2Hlge6yoyDeSPBjxPDJSjX3P9/1oohmbgQZrvig+0PZ0CMgdAn+I8ITlz6kz/VNP4dBj51zA5xSAtAIAu1g5Bp+I0PrmLyPJ292ryIH+LMXm26ZneTBp5GAAAzuFrRRJxTgxqMZIYfpeXwDH60Q46dpclLhekKBt/6h7saav1OTY5v8lB0HFh8EFCX83eNohb0GDL9wKWZePJh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(396003)(346002)(376002)(366004)(66946007)(86362001)(52116002)(66476007)(66556008)(316002)(478600001)(16576012)(54906003)(4326008)(8936002)(8676002)(36756003)(6486002)(2616005)(956004)(31686004)(5660300002)(2906002)(16526019)(186003)(31696002)(4744005)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eG5IMUan87X81hqw7X6vxemVaRAotbVtKzCnWQOYjMX271Wl2GQ/lh+9X70WP8IUMakeykMfe7Ora1hCivU1pTNjJbJFgigH3Ms3GEhvZV10vBGKkAISxUG2d9TTYdmNo4Wdv5GpaH65b3RrKum0sDCSuWRkpsqvP0KgpL6JWnj1RxKYmnuDOOjq1xzH5Hvl63Su846KQ4xFkydqZgF+lPNJYFZnB/+YQQS/T2VNcVkoKhPRr7w1v5KEd44IbXiUyDyn0sqGorK7dz1WGwkDp21mxMqAsTWTEAnyFoDgLeb5SMy3o/AXtB3j/PqBnzHiOZI9jEAZF71pcWSGmSTu7ZL5rTDTKmLb9GbeRcPbBtOG7MavZ5OkNtCWYq9aS0VojyLXBrftWHyvWB0jHFK/k3eh5BCTUvDAS+oV+6R3G643OwyQ+UuKnOxoDcGnPaUR2UVwX3a6gmhVwmtOGoDCk+nP6FGeLKI/+9sW3zR3hS0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf13ab67-5a98-45ee-1880-08d8193b4f88
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 19:09:40.2393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0NWX2yzITjteSr0FNlgDaZCSXE6rn+L5SDVcauD4g1lhVuIaohwI/EIk5sKe7ECD7RrSD4UIKnskl8De2FF1K2eANh39GNQTBC2hjc1ztI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1780
Received-SPF: pass client-ip=40.107.13.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 15:09:41
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
 qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> macio_newworld_realize() effectively ignores ns->gpio realization
> errors, leaking the Error object.  Fortunately, macio_gpio_realize()
> can't actually fail.  Tidy up.
> 
> Cc: Mark Cave-Ayland<mark.cave-ayland@ilande.co.uk>
> Cc: David Gibson<david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster<armbru@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

