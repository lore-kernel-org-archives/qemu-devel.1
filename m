Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EED7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7598620B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JyjKw7Uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7598620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8cL-0004uc-KP
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8X8-0005D6-87; Tue, 15 Sep 2020 06:49:58 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com
 ([40.107.1.139]:61509 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8X1-0004uF-Ng; Tue, 15 Sep 2020 06:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndq+5ODr7DuNrMyOaLyBJy1uwP/R0nQ3YQF5UFDiATuW5E08gFsabFIZ0CyYjLhXjLR7RiU2aYbh5TQFhoz1BMQCL1YabPtC1kTKn0SfMBntxezvbFw+ujpBFrmMnj8TiCOYzCTfZbLlhefR2rnFPnDEisYevMEvPBW/+KFGwB6K43TUMC9rcdqvTGlvdEyvZVTUJlbG+rZB6m+JCqlGqACJuFHThwHiiA6mr7qtubDDh1bruIvDobG86V1vEsUT5K43F2HMUgorUxaIPt+X3oUP1mqY2oVVvIiWY6MQ0tVh2YN5T8KP547vHZXBG5MYiG0uVYVJNaBs2RfRjJHpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynBohAISRB6n/F7k8omEo3PbNn9G3knn9nr52N8FvTg=;
 b=ft/JD20UViOS89b2Ol8oqo0yaoQA44GAvBrBDi6wbnDpyTHXk9KXuZfDZLS0OpsS/Iz8k8Nm/33qYz0aSeLJS6wbFwewvOmSySca/whSznASbVK5Yhf1cfzkM4gT1vlvwYgrVWtRnBFWJhxYFm+wE50zEHEBBBYk5u+QgczieMRSWTW/7mLtbeyaVdFeZvVLnYnTmhX4m33x7qS8otNjvelksl0z1HUnRszjieKZK+YSmN8AqXTNrcMQAusKOf5lPWqGQc+cLtIP4ciIsgQQCcB2iEpad0HYhNbn7cTbkuoVjaSYpSiOeiyBY/chFSpWhggckiMB5wkkPtyHrzFpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynBohAISRB6n/F7k8omEo3PbNn9G3knn9nr52N8FvTg=;
 b=JyjKw7Uq+GqtyRAgUCS55lQEPxU3EzYnWUKedrczd0GsLzVW4EcPe2+lFVCwusdl6Xk8WffVXcVNjaC4P4HqoSWJToZPvKjyNo+sdJMvx9C+OBebccgkkLdHz8+kgie30LWLBjJW0uJr7R9TK1oaC+tqPWgxNixtwVrGCTLdNPk=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1969.eurprd08.prod.outlook.com (2603:10a6:203:4c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 10:49:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:49:48 +0000
Subject: Re: [PATCH 12/15] spapr: Add a return value to spapr_nvdimm_validate()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-13-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6b4ea6d4-a9d7-04ff-fa99-cf2adf58e041@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:49:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-13-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:208:1::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:208:1::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 10:49:47 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e490cc42-7c71-4f3b-7a8a-08d8596510b6
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1969:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1969024D50A6F8D2AFCA72CFC1200@AM5PR0801MB1969.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNB0HQG+Cbt5IRcTNwzSbRd0/Bi52sURvVUzSFc37NPLcwHKyGWNBBjVWTTMr0hQedZ111W9B/FyF+Hye/olKveO2dYuQSFbPSl3JKLQb0EO/fah9c/PYwUF0NovGEH//keEwehSaaADbiAylQF18uLydig/MO42i9PvvfrGnWDDLNpSoThaqG0GhmC1Muu85+n0qsXPHeRHKuv5fOyLd9a8Gnz900huMLEPsV4UkQ5GzMFyESlPm2/GUOuAF10tGJ15uH/JdaIvCwMouiNxjfYb0Ou+6TlK+t3IJB1eQwQps4TfDpNBIFCTB026r7Y1IJVHmlb0pk7kF0TrbZZZhi/adjPrQwhaAFXB0mvmX0twvShXFk7PkpizTSPEDIXZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39840400004)(396003)(346002)(366004)(136003)(4744005)(54906003)(5660300002)(83380400001)(16526019)(8676002)(478600001)(86362001)(31696002)(2616005)(8936002)(956004)(31686004)(6486002)(16576012)(26005)(2906002)(4326008)(52116002)(316002)(36756003)(186003)(66476007)(66946007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zLElo0434/HgMNT6WmqnEST4hWpOuE46JMWvWsY3zi94GOAki5JHyu4e+urmlbGTi7cwAF9EFTCa8wszMaUgMGRXdOIuYTiW6mk3tG11VJArGu1373EpnV23y5vK5rdViH5qGpL2+XGi0+hwLVpOHp6HOhBgrsMHQmB5t/AzRiTIsmoVWkao0hMWpqCBYmWRCQcSfFZaDPTixTamY4FxysxWXKIxZck7pQgj4QUK0y03j01jFrVlQESdv3ENXg3P/RARaGheuCRBQBKzpIeOTznFWJydCEq9im0YID4ioqlO46YmTIaW5pFDQfYqlk1kxK8+NB7zdttZ6iGYgYn4vVjYyLS79Ur2WuaJ7xH9DtwLk2HJC/mMQJINiW/KjwKWCNJ6QCVkaldqgdmrTWEu0evT2qXOMXwSieNSWwNoV29FCyV5bZ9pSSYj2DzL7uiqw1auz+sXkZQ6uigHxt/TuldTxwfccN7Kv8wB1c4bFyT17M/8MSXKtVxZkw8wHdnP0/WjX/gLKd6Uzj4tElvzpEepIowRFyAXx10WdcSqxijj8af+pK4lvTV5RDy9WK9tl+SAPIVCqidfPzCIMm3JD+UHwo6+L59oq4bgQY0PU5/av3UNit0d4HYNZGAofWn4CsOXjGvzX574nrPyzPrlPA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e490cc42-7c71-4f3b-7a8a-08d8596510b6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:49:48.1352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BiePdWjM8ML08cOJX1/CFXeE91nrm42+aKNdcxqSOHFFq3eSegApAoYniNcHzjltbGw9ORuVXHf14a6R4VxDM5Wm7EcsiCaqbywvkoiJ4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1969
Received-SPF: pass client-ip=40.107.1.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:49:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.09.2020 15:35, Greg Kurz wrote:
> As recommended in "qapi/error.h", return true on success and false on
> failure. This allows to reduce error propagation overhead in the callers.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

