Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A53C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19852233F6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KTne042L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19852233F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpq3m-0004LR-D9
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpq35-0003O3-9z; Mon, 29 Jun 2020 05:25:59 -0400
Received: from mail-vi1eur05on2122.outbound.protection.outlook.com
 ([40.107.21.122]:63824 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpq32-0006lk-HC; Mon, 29 Jun 2020 05:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkYzqx0Egj+ry6SfSRm9vH7dft2LCoSa6n59sL2t1gVx1dlQ7FW8ZQbpZKfKvyxMZUMZKdwsQkdwErFAwKEgUFRDKeZJs7zWq+qWywTIkcKGKu0DlBsCkD7ArKjAzxD+QXbwnAcHqTJDWu7MDDg/cgTAPPtBMsqdWjT/XwQsUpmE49ewEambP7EMKLRzdksiA8Hfgo9MWH8CTWr5K69E25t3kFVnOthPnJEkN+K4NMfdiPBoz6Kfh94IWVvRWII8y/0rY5d16zbr03O1Fx++H9hABSfDIYjbgEtu9L0NGUEAnW33vy8bE6UvlkXpFvGO9HdwH/Y3XVQDCWK6md1UBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MkUrhtXHVkY9kE8bm4bQEsNFaOJPKMfjTNvyytcXHU=;
 b=QglRpS/M0cgcn4FWFJin8qa7DdNDJCe/4MmgziBE7z7ohtCUhdMkg8hKLIDUcLckEPP8BlowmzJ7TBifwSg7RR4CNrshltYA9tB2Z8a2gZv1zzOjXF2y3EpC2uMBe9q0cEt4P7p3aus7vcYieV0m8HaGQSZL5K4uQiHT8WIsLMYEsC+xIrXQ8ei2bytxZsVWxFcNr5Yqt2yK9h95l6+TZKzhpeq+iH0pEuwYPgxuCrfFFnQq99lrF6c5G3Ux6vl20dfC6+BRGKyAZtx+7f5ToQrCxUMsxw+qPjtkS2lo5wQp9++a2lpDgUVktRkzRockhcTbcGuWNfDWNA3w+lkH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MkUrhtXHVkY9kE8bm4bQEsNFaOJPKMfjTNvyytcXHU=;
 b=KTne042LGa02SbJmhYvxPkYqFqkuEaj7ClFaHR9Y4q2ZFA3nvm0sBUTqKAX6qPU7YR2CCBSZUrK/3HfehQsjaAOXzvzQHb+Tk8BhdnFs5ssQ4ty0ituVJPgMidQl5gmOKnA7HgSWDDSNgUFXxVniA/YNRIi58tPIwAkRH7JhZFM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 09:25:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:25:50 +0000
Subject: Re: [PATCH 11/46] qemu-option: Make uses of find_desc_by_name() more
 similar
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-12-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7e1323d6-2c16-119b-a7b2-7b69c40be36d@virtuozzo.com>
Date: Mon, 29 Jun 2020 12:25:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 09:25:49 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 690f3a7e-1035-4cf4-36e6-08d81c0e6981
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5253FDEF574280D2CC6DF87DC16E0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:138;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8WchWD34nE7fbK88LAfXPpfMtilgkSCP4V7mG/EUuvCHM7M8Akn5ujX+YpzTuKy8TkaCfAlF5158InUNAcNWPvOIYFEOq+fe4gQ7AdP1s6QA/czSYxyIT8pPjCN/JA0hiUHScPVinhu+srI6qm11xvFsxvdKLQn5Ek5lRy1NVjml3rCcD6/xRlOsdKisJpUfZAj6a/0EWiuU2BTsOuQJT6q/OKK0YNHP4S4XFru9AngvHsV8XPQMHmK46tHt4L0BTjkgeS7RAwd7o1RaKpHF/+X8D4VSwzcOv2zTcF80OnEjSFLv254EKWR/uRIfjAtSs+2Fd+pRfHwdn4saU25TK2U4E1ybP170gW2YPIOEzL4dM3lNGxK9cETmpb2BvJp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(136003)(396003)(376002)(366004)(2906002)(86362001)(5660300002)(558084003)(316002)(16526019)(8676002)(8936002)(956004)(31696002)(16576012)(2616005)(31686004)(6486002)(66556008)(66946007)(66476007)(26005)(186003)(4326008)(478600001)(52116002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mKxxNbXpDaOUv9NrcREhztgzwZQukf/C75yMEk8eSNtSV3tDrpGt2uhiXtYUxEBL4OrCvld3DEnOP0VG6tlT74bxvQIEwc2UGCpUWrb5n5B8ARZ+x6wkWxkJY8Nh7/M84xIZCezj8kqQoeLT7YzyFiCHRXXxBEz9M0+uH17ziGQGhaSvHo2nsBb+lA5fiXX8LIeZZw5z9jc0kW0en6lHN9OwaqXUcNc8JZfM7n9g678m05lcYNGkmZnuYvmbpcpfHuGylBs/z5uWjfKgVZ7JYfdCKhPSJNGd/7YOvsBnBA1VE7Jw6G0dz/c1PUgSepUuS4+SwX/H4mP+a2MRU/53VwP6rOKc9ye80YaLNXy31EPTrAp/0NwoJr8ZLL1Zs/jtKUZp6+de1ctVeQZrn/Ot11thc5JnKL8fCCeZIcEzJfIU0ckTEN2jUmYXoJrBJxC1zMGHxBX6A8ut2DPjRYMCEH/SLZbyI1bpRO3r/n8MSZo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690f3a7e-1035-4cf4-36e6-08d81c0e6981
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 09:25:49.9186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyJnpn3JTgeK1WuWlkluaitZk4xOqK8+hOH9kYk5KGnKkxnOUeGx6AaWpKXoeMdbSsr/vDPh7GM9m+jwPdaqrba7us8tDAnZnCeC5hk6Z+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.21.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 05:25:54
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> This is to make the next commit easier to review.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

