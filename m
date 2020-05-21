Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237C0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68402072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wifHLVrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68402072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbjRj-0005D3-0n
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbjQf-00040e-5L; Thu, 21 May 2020 07:32:01 -0400
Received: from mail-eopbgr150108.outbound.protection.outlook.com
 ([40.107.15.108]:28387 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbjQc-0006uS-Iy; Thu, 21 May 2020 07:32:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DquPg8ZG0hmC0D7paikWaAahIA/xI63jDAUUiXD/7O9PaSUY3zI4QHTmCtKbyeV0W8GJApfyAk7H/dV0b/mBS2GAfly4xMI+Xn7Gp6R1zP5qP3TiJOLByuYz/FUcmZItfoTxCw4wxzGFK+E2fnf65Ka2ogjLp00kOagb383quSgvNcFfPDf+O4eR6rCaIXA1f3cgWqQTe2xI+SK99KPCMjDhn3CiZ0TeiAh/A6TSP4hQ6xt1Nz0RN/Z01yX8gov39cI+QeJUSz61OASnPqVSzIiotBtMYZYzqjrP7RAxOkG2Azdh/qdDpoBWx47/jH0yunQmeY+xXyqkI7eVWEhL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7XWgsUE6tx31q/e7BnMN4r3sqeLteMtqbaZ+2qbBas=;
 b=NgYdxlOufSW6FVbTakIRvpMARmD18qKhwABvUGiNOgmYOSdivjUreFqFCeEyNz/ySp6j1bdezXoiswzZ+cz93tNawdEFeLc4uNVFiMbKesAXj3zEgS7XcrqQFnyGEJI41mK5NVX6Au8wLNFQOAStBcVjf/GzTpeMQyr+co+ineAaDWOAkxTLtCj751cX1WkJwCH8jaSaNyi+M6f+w/STIuOhr0Yun5FPcdbjEMRnHpT99o7Nwp3PrR6e6vE9bXJCdzEC8lgLLxS/xAPsRdM3zolGceXjSxsJe4sUKA+ywQfuSwshGH2bG9DxTEpiK604UAupOWqnNNKXxbxOZXwVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7XWgsUE6tx31q/e7BnMN4r3sqeLteMtqbaZ+2qbBas=;
 b=wifHLVrGfawReFfYrKknNI4aojVf0HSyWD6p5leoG3FfC5XXl00TpDVoel8QQzSa2Yuq9pFjffGt/Dnihm6qML+hp23EaNuIw25xzmvIcvOv8VXZJzuZWkPGTOOMwEkQK/8/lkZPrLpJ7Bm8vA5EXPSPQ4gBmECbKbin+9dVQ70=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 11:31:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 11:31:56 +0000
Subject: Re: [PATCH v5 1/5] iotests: Fix test 178
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a2eb09cc-6a89-1604-47d5-5cdf87c07699@virtuozzo.com>
Date: Thu, 21 May 2020 14:31:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200520220118.1037094-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0035.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM0PR10CA0035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Thu, 21 May 2020 11:31:55 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 639c3910-465c-4fe8-fcfd-08d7fd7a9133
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-Microsoft-Antispam-PRVS: <AM7PR08MB542931E02A321BCE1F727B05C1B70@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OKssfyRyCnigTiUiQBqTpy5Tug8z9cw3tjgax76OHxZwmD+pnx7ZxU2TT156jYlopaXQJZ/lUXWb8W7iRepWYMNt4yGau27im2wj/mqVjzFYnGxg3BhTSwfzyjCIBGoQI88aYohF2crBrRFRr/+ukbdFMM9Ai9xMP9Mvr+0dhLY/NzpL2/OlFsy/KYtCV6dwoCTmXOXOw1ePWwDY0v7ldx0r/oe7U9prlrKtHWxrAFmJqPaNP5lkMhdkoaW1NKvkuI9ElulGzfKNQ7+Ze5lxgUsgEXHtDvW95TT7z0T57cRAUP8CCMJG0dA1N5isV1El/d+A+7t/ViqOqwEV6wbESXveXu2nixDYlKWHxKPO0Wg6OOAUWc2WmCpox9b6pC6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(478600001)(956004)(31686004)(6486002)(66556008)(52116002)(8676002)(66476007)(16526019)(186003)(2616005)(4744005)(26005)(86362001)(66946007)(5660300002)(36756003)(4326008)(31696002)(16576012)(8936002)(2906002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MZp3HGHqevSz5otRIPpcA4htZYWjM0i2dC8+T+C1RhoeuGZfmoqRhDI+xlfD5P29ihWMhyh02IWrZYD6UXPGKoEv+K7nLAIp8UufTN6n8GRiaoV/Rw9BIe2URSsNWIkOqKxwgoftRY4fDjJuaMeaMFqARP0E242iOYAAZ+8UDjPdhDtvK7lREG8BuraSa6dbL8f/gpJm0CRgWqggcHFfgH1P1XyNstLkr0YkmNWzivCmXIrySqudVJpLLgWZZp8oXBU4o4F3D+y3zWAvMZDyu1bNJNvo3eqcvjPtuI/8aoiSn//WboOHaAMrtkVoz0fxSPRkUmMCfWiXY2oWukDmDlKP1rgmtAmbYrNt7AC5xpMSzkGHM7I2H19vA3jpRc82bcybNxzjkmot1Rm/hFYP95pV5v04gw5202wumTweyfB0Bh7LktJQjOUCYoWPb16YqC9yUTI0x+k60Sy7KXbvQZHog9IGDz062PvXbLzTNe7AKC9+ZClmh0MyZP1l8HYZ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639c3910-465c-4fe8-fcfd-08d7fd7a9133
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 11:31:56.1051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRuLqr8K62apdKqtIAUIZEDONjlzw4oRZm/DBMw/2XwJoc0+gs/XUGdmQpCxivZqcDn4kFhxeqChGsSszoCca9TxOqabW2HOaeAZUGDYO6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
Received-SPF: pass client-ip=40.107.15.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 07:31:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.05.2020 01:01, Eric Blake wrote:
> A recent change to qemu-img changed expected error message output, but
> 178 takes long enough to execute that it does not get run by 'make
> check' or './check -g quick'.
> 
> Fixes: 43d589b074
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

