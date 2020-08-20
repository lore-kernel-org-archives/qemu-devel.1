Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2C2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82442054F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nBYYg936"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82442054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mxa-0007zb-4O
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8mvr-0006qr-25; Thu, 20 Aug 2020 11:56:51 -0400
Received: from mail-eopbgr20113.outbound.protection.outlook.com
 ([40.107.2.113]:31556 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8mvm-0004Ke-FM; Thu, 20 Aug 2020 11:56:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCf7laaLOoR964nBBgI7R521MZOc36SZpdAgOA4dIkrarriI2Z0hgb/+4ElEhaNo/RAQ/Csa12ZVSd42Rldf+Slu+eGo/OYQwqokBJObcD4oBER3Z5rnlBznHvyxTzrkMt3KDreExcpprEGQ5BjbVsBPbCYo1+DaIztZnvde/sOKsHdFNjKKlO9ANDE+ePvsi6lV5/JD0yinvWc/FiLpEKi9YhbhUX3l9JLy4qrnQK+oSjFuY4R+oeWbZwwjbZdPTD+fj56pMWjTRlbvoALvMzG0MQIHbDJbnraWTNBPWyIdS5xp6jCOrsaezXuWYl+JqrVgkT7CKqgtBWRqS7JoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImzHWk8PWGaKiYuxPejhLjrOydu0Z9iMPfXOKylUWdQ=;
 b=SulWpYJ7bQUd3ITErefKaoA9A+fiObRfGTg1lGNshwti46N7QgzEVJXZ27mEHJHb/K/4+81MweMOUdCqk3GTWdo6whu7LpVMNeUZTIXql2uk8FGOPA5e1FJSLnvmCQQ9N7a7Ya4nqbL5xeSjXUyKCLfN8q4Mc8K5bdOMyyFryx20pEpFOhMe3Dlu07VSb9JrlI/ZkFOEY1xPNw5978CFERxAuKXWcuc9Kkj0IjNz8xncMraDVhZrhStpOjqqG8ccZxlgHgHXJxkW18cps4+KstpFfcNhk+dJQI8/stDsZPd3cBwULvBFvyYmTInQcmR8vuFrAMTMTXI/xSMj5hzi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImzHWk8PWGaKiYuxPejhLjrOydu0Z9iMPfXOKylUWdQ=;
 b=nBYYg9368WmuN/60RCQv+W8pNfUkvlEjXSxpdSVhYbRvLuvF8zFWpAHRpjkUZwuFbmoHIgQpdF6nJSbF3inCyRMfln6CJuElBVgQ6uu6QEUWU72AaGOHBMzk1VaZyrp3zBMN3jVTae+XE2c97rhbfGX/5bOegr1ppFZ8jxFWmhw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5032.eurprd08.prod.outlook.com (2603:10a6:20b:ea::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 15:56:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 15:56:42 +0000
Subject: Re: [PATCH v5 1/3] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200820150725.68687-1-mreitz@redhat.com>
 <20200820150725.68687-2-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f541197b-c3d7-aa5b-525f-01d12a2e77dc@virtuozzo.com>
Date: Thu, 20 Aug 2020 18:56:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200820150725.68687-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0074.eurprd05.prod.outlook.com
 (2603:10a6:208:136::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR05CA0074.eurprd05.prod.outlook.com (2603:10a6:208:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 15:56:41 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f33627d-8667-497b-c6c7-08d84521a182
X-MS-TrafficTypeDiagnostic: AM6PR08MB5032:
X-Microsoft-Antispam-PRVS: <AM6PR08MB503209C8B7B7BD72379CE00FC15A0@AM6PR08MB5032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvFmo/FgB74s//nkKENcurBmlOL+AS1jHVdZqyxGMNJgUtUEiYH+zCngVtGfWCdQ9aAs2KDJUO4OCDHYKI11uFRCQ/ngHUKUFvrSfkKVcJPuUjRT6JfumGcv6qyPDwIUdlmeFilNIBt0UuLGiyy2UCERGVIduy8QTMPY/eEjzZyG3Y/fpCMt9meb15S/WSb/NObJ/OMUmZAZE0cphqpdHlcDjIBsZvL4s/txj5TKRj/2pC/2w+TSIV25p2dANIHL5fcsG/ny6jpud1XnIZxFUsZn1S5n8RnHjZIuRDnjtlxK5vwCcSQIjFOBQyEDLAYs2XQbcB64eGu+4GCgCcey4ouDjjwps2hue/oxTHgLzB/ARA0naupmSHA20y6B39WH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(396003)(366004)(4744005)(36756003)(86362001)(31696002)(478600001)(52116002)(2616005)(16576012)(316002)(83380400001)(956004)(5660300002)(31686004)(16526019)(8936002)(4326008)(6486002)(66476007)(8676002)(66946007)(186003)(26005)(66556008)(54906003)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: y6gD6Ut0gR9YMVhNeO72QkC79O9UApYpmoY3ECgJSBmCWtap007tTN0ZUezTqKi+ifS90sWCyRZrG7kERvQ241OVzwiqJ0zyuYsmmLL1oSTM4tPG0WdfpOQjny5Kx0obs2rDPKV6peT5vj8APghsmqA1EDC8mHdErE61t+w0UegEFM+osNbVic2FrGNdI2duitnU93QA1frXzaH3rY/XCt7WJ5lkqvEQbAvv0ND4y+IXEiEpeFxQBqsFhoR+hrZdOjgZAiaTGi8tsu55oog/KJqdTG2kp31gIIRPOy9OQqvFH2+/37WOPAnCYKtL9A4KmfpcfH6CdqzQ/VPNOCic7K+piDJFi8qdi7+BpZGirpZQlgKCZn/5Yi/IRpk2vRGDTBINloJGPdeVq+JoKMBjTHdxlFLA5+Z42pGTW7QmM9zXICn7G7II+Mji9K5JuCtkUFGxicl852byAyJLD3Kycplg0WM7SZRS1S9ox91AevWpD/t5d3AY3OuG5fqwVMEVKIt6EXoFkPh6764I3mmrGSRvSUoj5IoUp0aji3XEy0pB4NuntDl8K5c9scsnymyKRKyqx8WGYb/r6Uu/9PBXvAp/8ZdcxEH/Gwd+frP0TODt2MSTiXTdzBu3R33fkk5n4rDv/orskrKXIEBiPgR4Ow==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f33627d-8667-497b-c6c7-08d84521a182
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 15:56:42.0587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNazv5AI7g6tWV8EIGMdRwIFyfN/psd/1jCjfsRtJCx+nD9iqtO7Hodns7DdLNJv+szi/HPrio8JnBBzql5PQs0m41ZQArtpMobJRdlBTZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5032
Received-SPF: pass client-ip=40.107.2.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 11:56:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.08.2020 18:07, Max Reitz wrote:
> This migration parameter allows mapping block node names and bitmap
> names to aliases for the purpose of block dirty bitmap migration.
> 
> This way, management tools can use different node and bitmap names on
> the source and destination and pass the mapping of how bitmaps are to be
> transferred to qemu (on the source, the destination, or even both with
> arbitrary aliases in the migration stream).
> 
> While touching this code, fix a bug where bitmap names longer than 255
> bytes would fail an assertion in qemu_put_counted_string().
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz<mreitz@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

