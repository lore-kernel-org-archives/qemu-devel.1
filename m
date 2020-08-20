Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B59C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56EAC22B3F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vHBJSGJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EAC22B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kkr-0004Nq-HF
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8kkE-0003rC-Hy; Thu, 20 Aug 2020 09:36:42 -0400
Received: from mail-vi1eur05on2133.outbound.protection.outlook.com
 ([40.107.21.133]:7905 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8kkB-0002nS-8L; Thu, 20 Aug 2020 09:36:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqhWvs/c97c1+ul4drSf8ppFcxEc15WqwzGJDMxuQx5AoHz4Ux6ue72Atab0LALm+ro3DifRfmKeTRTRcDTIzDDBRGOr5EFlkyQyVinUF6Xri2exAvPAeJVeL/EoPzJZhestLAEIhnAIG1AQ4l4sH55WacMxV45fFSX8qmZQXzDLBJSNstaK01U8fW/kWNZKCuUwnH0ZhZf/yPK9R1n5AyMfRc4fTDwbCs8g62Wq7YJsERtTjF1w254eGTc6ciWRfUQr/c2yTW0kdDTM9lvwUxNTJ96YD2+bQjhX2hwUnAQrXX2CNd54y7R4cImcharFJNwoJhet5ebjhrFApgaDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PsWCikARkktDCqkdpo1P8QJXmWX7BUst1qh7bnulWs=;
 b=LxNhgkr/f5aoeb7HI+AzkQULzA4enAf1oDwU8WMmEuIGcNlxmxuuJjY1gYbIBeZV4BOVFOzAsU7oCTWBCKPTHWYUPW8A3aMYgzQyFfnOlthSGdfc9LKyUxUMUR5jGY9ZSJgi2cVQYabDHwm+M0woJygGEQYOGl0MvBgiDkc095fO7F3zclNDsUvbmBlsNzr5QdSqQP+ENkKZN8qSF/JnpEiTTSBe9Gh3SLpe6UwM1YAWzR6+XaB7+iKuXAb+v/7BOQ7fhEfzr7lv9xbC1iab44JYe7zgyeZ1T74MQAdgj28MYCy6dXuC1tRyLPIw3yoJ0Hqo3Cyzga1t+jr2GQWS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PsWCikARkktDCqkdpo1P8QJXmWX7BUst1qh7bnulWs=;
 b=vHBJSGJhppEV3HNe0Ahmwt9Cw5N9Qm6WFf2iBCeLdBdVyxsMjHT/yKowoW+kFlQgwTWrqhcqrVC9oC/7muyekmE0Y+ZW6M5oJSTLYGPP7p7e/izSukUj3nEW1xl1ZmEgtII3kAhT+fv5UGYUHSbKw8ZKl2NoaP4f7JsC5HIeX7I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1650.eurprd08.prod.outlook.com (2603:10a6:203:2f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 13:36:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 13:36:35 +0000
Subject: Re: [PATCH v4 2/4] iotests.py: Add wait_for_runstate()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-3-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d6b5fb96-8611-1797-f941-def11739bf78@virtuozzo.com>
Date: Thu, 20 Aug 2020 16:36:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200818133240.195840-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:208:14::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR03CA0035.eurprd03.prod.outlook.com (2603:10a6:208:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 13:36:34 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 217eab2f-b5c1-4d7f-f44d-08d8450e0ec3
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1650:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB16503DC3075C2FFC5387CC3BC15A0@AM5PR0801MB1650.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQr8cDv4qVCYLwPs4ESUP2u7/icpVsuK+R/EOiy2ykcSaU4wyYCiK9ZuDnoOEYp5RJVUnrcc0EJ6RXREYuuDAmZCn8cyqhkKqXGrU6VeXs1cnyn05YVIf8lNlLhkerUF9zvMjJj35lKLSrmyQdyckjeWTv5NAgEr32Q3GCWxdL28n1aCBCsGpBRAnODOCoczH1teUUKGnQZ36zykLnRlmXrSIvjPDhkF4FdNfgrXk5wYRbPvenVbRmeycJRRY/Nv3mCT1DkyWFsmi+4YstghRPfwdc87yaDQ2lcfjHaNe3fVh1kXiCRn6aKRJKGvq8x0wqctHTEHMyMjsXkLxH9iMffc1fja3ULamh3f7b6KJBZ+7227qaz9axakTMjhOZCH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39840400004)(2906002)(52116002)(2616005)(31686004)(478600001)(66556008)(956004)(66946007)(66476007)(86362001)(316002)(36756003)(6486002)(186003)(8676002)(8936002)(31696002)(4326008)(558084003)(16576012)(54906003)(5660300002)(26005)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: duLIPZ2sflslnfaRQehSW+HTKFax4kewPSWzvrJlWubP5W3FT6u8t8CeNOEdDWAtSKIvTDaBqi6731v43dg+kQ9xYrl4/x71WA4pA0BXpd2sucGYXWvpFELCfL4bKReYrEt7FRtGRHrgz6mdlJ85llzt6iSYcjH9zQWNrxsUwStGZ537wKa4+AvB4aAUN0RqNLKn9DgxlZ7ZYvdAfPDtfZR7FmJcIsDRtotEfm3/XxI+PVujSqxSBi1LtZhtt6gULz74XXyqAmDh+3PZS5h3VoWkU+ZLbZ72Ln5ods14Xq2oMRAMplqocFKqRAvsR/ZyKBVb2gP/VZ7V2wSWkxrWlQSGzpu2TzaguNzXhV1E8LDuOjW16dTotHaukLu/Ee6QamoCELq2Rn3GVZ1+c+lYiszI1DOnAG9oSeT5OyGo2rECzQxAJSpc1uDyYy64wtTqwg7yJ8HVPx7ucJXCUe/Ijugjv0IwAJNzFeZlw36+rORXyeRFXW+wFB/7UMq6OMBn6neix0u2RKHJe1VHhqtzJhjiR/EPRRcgrnVtjdGIqaAXnPRI7ASpwXzlaPBAo6ootfVz2BPYnVZmYpIIkmddSmPxSkD5duv7dAWKjLcNLNZYOA0osmm0A36Z8D0Fh8kfsdRmHH20ys82G7ZDsNrZuQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217eab2f-b5c1-4d7f-f44d-08d8450e0ec3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 13:36:35.3671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcbvpXRnxlJvD6fPZRVBclEA0apZ1lWdTdvCsMCSCUS0ZbRZMU9WtX8kKG1Y9X/1d7O65uxE7vrRfXbwYnTeBCnN00Xi6sDg+kr++c16bpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1650
Received-SPF: pass client-ip=40.107.21.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:36:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

18.08.2020 16:32, Max Reitz wrote:
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

