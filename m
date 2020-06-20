Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0389BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 03:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07262311B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 03:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WVVz45jK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07262311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmU5J-0000cL-W6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 23:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmU4b-0008Hj-Io; Fri, 19 Jun 2020 23:21:41 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com
 ([40.107.7.134]:38502 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmU4Y-0003zK-P0; Fri, 19 Jun 2020 23:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKutzWQ8dXcZF/8XeKnTHjTLHWG2mVcBhMZbo8DAsFGEdctzKZ/3p7uJkYfdrDhFg3EO6q8oskGcKubV+yKcn8VL42pnj+p1RJh5h6Nb6V9RYMgIn69WIBMT4sv2HOGY2zaB2H19JvuTC6TU8LK/fYHshjkG8nL2rouZUnpUVIFEalbiTyMObcPRg1qRUfMZSWx/6Uzdahl1tOh0dwegg/8mFXhM5o7e1oCrdJIepTCZeh+8bZJ37EWhXad83Fccz5CPuUBT4HXM4WDoHEaENzWYcETN7vJjnIdG1aPfvlEJ9CYvQW6vpZCjVHKc006f65UPb8NdLaD2Zoz7YS3OwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boIyH3v58RRnQBqEDp8laZbUmJTlmwzBe26C2IBwKuM=;
 b=d4gRElMQe/oRKYRcnwr5yj4HxHbFXAUkGx7bsIDaooYOkHKpYi0HfvOG6Yo35olr/5PtvSl+ktouAdahsrgxti96Zq9VVwHs/YC65S0iv1QY7x7sAJw3Oomlj10bq4M24wAlLRQ4MzVPQr9lrrgJWYOdUlgwXQ9UVWHo9QKyMFJaFQH0V6MdFsrAa5KDWIrxFFuyMcDG6VV3rA+4SNR2cdoCf2Md8QwEwLDfiEATdsKaJdiPoSWBULnBM5aB1/wrA4N7oY2w5mPVkOLmu1WMAK1uzPvtRckpDrm85J4Opl7IAi+3pQPVF0u6Dy8nLvLOtNSq+GHfaPHQEQ6bX4fS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boIyH3v58RRnQBqEDp8laZbUmJTlmwzBe26C2IBwKuM=;
 b=WVVz45jKzkCuw7VhR8qQVub4qObv+QThiHCdMCw7dsOe90MdpbagDo3KGrVRZ8hS+7kx41EyHbvIRIzodDBdjoTvseLKGqXjKWpvKS1lobysec+KarrwJiiL3mPUaTit+//c2aLQx/3dgAFGhvIc5xZZf3K4g+ehcug81sTxMMk=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Sat, 20 Jun
 2020 03:06:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 03:06:32 +0000
Subject: Re: [PATCH 4/6] block/block-backend: remove always true check from
 blk_save_vmstate
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200619100708.30440-1-den@openvz.org>
 <20200619100708.30440-5-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e5bba828-b161-75f3-f03f-a1bfd1d87abd@virtuozzo.com>
Date: Sat, 20 Jun 2020 06:06:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200619100708.30440-5-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0019.eurprd03.prod.outlook.com
 (2603:10a6:205:2::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.122) by
 AM4PR0302CA0019.eurprd03.prod.outlook.com (2603:10a6:205:2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Sat, 20 Jun 2020 03:06:31 +0000
X-Originating-IP: [185.215.60.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79edaccd-a2dd-4330-55ad-08d814c6ef37
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54961D08065A63797E8A9773C1990@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sitbLTxeaJPSj4jcGpm9kVnKm35ZIDx1pqL5bnYdHNLsp7HOFyL5X2snGmqhEiMgv/H+DLdq2e11KaJY/TsbXm3s/KVvTHAgP+ScrHYVC76zPaHXrZ7Rqn4R8mPi4RfGK30/qKzxynkAj49zImcKKRzxJUyKSmRaGk/uOAL5jlqkTWld0UVf9kAPy07P9T+aQGcJ3OXbrsvdOPsljPZqXJ7S7AkyZd4HhL0s7fTAPJh1kRuEexsykRtlpwpR9QjYILjBbA8Z8tSdUuyX1cF1NelSy6Pn6yYaKMGOalKQb2C6yaC6a+v6eMBk+KPe3ykByIFtss85xlVM9zbVg0T2ZQLCEV7f+fdDOfuoNzEzyYidPF5pJCdjd/X9m96GXnnt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39840400004)(366004)(36756003)(66476007)(31696002)(86362001)(8936002)(8676002)(2616005)(66556008)(66946007)(6486002)(2906002)(5660300002)(4744005)(52116002)(31686004)(107886003)(4326008)(16526019)(54906003)(16576012)(186003)(26005)(478600001)(956004)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8hVuwFSMZ/yGGSNnD3wkj2Osiviudt1OGe96CUOyw7z5QqZuMDxMgDbxYhbq6iVhQihKXNJkD+FB0Qbh4tcKUrRPdKYgvlhvcL6u+wLypxP+nHGU4pAh3LtgrJ/+bE8Z/XM9Khz5o6jIs3n2Jtd6+HlWCcWFGPxnyYfCxne813VOwwoH1V54239YwGQisRnYQrpWvdBNOmI0ElF7HEqWIXcnlRSHKyNws0uJhbXES/l1Os17O9OHwvWKZ2DunmGTj7H1iHr/qcoMzNiF6GUbTL6QHkTrYQvP0SHf3hLmbOF3hi6v/Xovkmm3/FhFMZXXOl/zWrEqiIm89hY6CMo3r//znfD+DzQ4KwWyiiZaPf0QbBCKjTEB7iGRJdHkIMs3yGVGnYhpGEUQs9AN1SOwkDM1kDC3SKRwfHUtnWKPCzO514UqQS0WQG1qV74s/f9DndCn0Tyq9x4yMlVNq01IMRZg3JAIf7wW8BctkKo/GaQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79edaccd-a2dd-4330-55ad-08d814c6ef37
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 03:06:32.4168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qROe1QjN2B1zQFO2gv+w21qX028ZtCGuhHsr0ijVBUhQ3UsD9IBlKcLyaWyXOMyw2Smwo0cqbo3a1dIAMIDcGOFL/V/jtDiu2fl4yZw8Yz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.7.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 23:21:36
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.06.2020 13:07, Denis V. Lunev wrote:
> bdrv_save_vmstate() returns either error with negative return value or
> size. Thus this check is useless.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> Suggested-by: Eric Blake<eblake@redhat.com>
> CC: Kevin Wolf<kwolf@redhat.com>
> CC: Max Reitz<mreitz@redhat.com>
> CC: Stefan Hajnoczi<stefanha@redhat.com>
> CC: Fam Zheng<fam@euphon.net>
> CC: Juan Quintela<quintela@redhat.com>
> CC: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> CC: Denis Plotnikov<dplotnikov@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

