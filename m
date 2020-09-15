Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB603C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB95321D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dIX7QCHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB95321D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI87m-0005Q8-Td
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI87C-0004tX-RF; Tue, 15 Sep 2020 06:23:10 -0400
Received: from mail-eopbgr20125.outbound.protection.outlook.com
 ([40.107.2.125]:20647 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI87A-0001VN-J3; Tue, 15 Sep 2020 06:23:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DftkndK9RaQpx5YKvFbayrpNBukyUKuCl9ayV/DrfBA5PFJCaqUR4CUMC+SkRgUA2c7WFpLjVdl/gwNwGZPuYkNiNr/71L3rnX17GZh+gSPE0fYFIYXlZy4PFpsoSG5+mq79TyVasm3V8JACntAUi0chTTKN6mHcPc+gfFy7wamatCbGdRzqeXO2AdJCzhV6BAquuznx4CUj+3FHN3qUpziRLqQ4d9oPehHvfgPGqSM0HEthXKW2V0VYmiy8df08EMVP6vAxpH7g2epdRAQ3SkDvi13IKD7XDP90sGD43cOMTv+LkCe8zJ4RpK0jfM8G/3Lg18wbFtRpJD83ZmaiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpYRn9uOskpFtgGyTtd2ZUIYagISIjWaMhyjhqndw2Q=;
 b=VG8/GN/QcFgmGrnSCMfCGknOn7QWGlHDTQpYYdoblzbcrK0KDSNq3wuNb0cLwj0o5PLGkzj3QroFyrZf+3EqtbyHzcvuGZRUdznugIABaR794t7yZFdNWe1j+TBWEr4UbPLuT92zanFpsgQhQzzpl3MVg7LC5LheQQNrgVNsxv5o0aPzQ09fiD1Hcp/NwGmoooDGPNrHq6eE4jAX0tGraEtAeCKi18zkNCsEnchat6Bp5FZUH23HWkEjFCWIFSTOj30DRSecO8jeb9uI/zfSq50ZquzcEes2brM1q/sxJXD7Tz9XrTXw3IXNzZJoeyaMryooYo3xv6MANFlomgY4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpYRn9uOskpFtgGyTtd2ZUIYagISIjWaMhyjhqndw2Q=;
 b=dIX7QCHhdefwd6fSdAGVpZhMtQPxWwGeNyFTKmmz48sGCwfYg5j3Pte6x/PJvAwaOHPQxAOnZH2WKjb8Sy47so57ABco3KjAi1ptUiybv+RcFN2z/kyYbemwNG2OZi8QITprWEGPFNKS61y/9hg0RDkdOaPo0dXGRixQpOfnrYg=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2450.eurprd08.prod.outlook.com (2603:10a6:203:a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 10:23:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:23:03 +0000
Subject: Re: [PATCH 08/15] spapr: Add a return value to spapr_drc_attach()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-9-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <078ae0aa-eb64-f54f-ee5f-f67a0b17dd5c@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:23:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-9-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Tue, 15 Sep 2020 10:23:02 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e136a691-5806-40bf-c9d0-08d8596153fb
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2450:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB245021C2A0484D41D669D04DC1200@AM5PR0802MB2450.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rO0bHEJMg0dovl40iE6Po/jNyUf1xkSAPPzgiGxFzgXXn8Ln14oLpl5WeOJIha3W3bG3hHoa+NeEYGTINQof37kIcNUB2ZLEjNqcbzSFxHcdgOfCqmmwK3mzcwLqD23GvHlTYyqYK2NWQBS6CS36o/e7vWCdWl8OutiIjrgwqOfpBC8DDlxIH8ZoKtaTKbcBDTOKSK2UncF8TBWN087pz/w5bXasTaXMsxm7UjRo5rtcbtFW+8LTWaeVkWAwF9Wk48PuMOWy6JzGwREC29I6GCObbTdhB+BRKqEwE9I6o9LgDjMz9iTW7y1FGOR3+Wtr1qn0BBNzNvI5ldeYjAagP6GGTz+cU8+Wb4OK3gNxyytXIch8hJOlOEN7yB7zhz/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39840400004)(396003)(346002)(366004)(66946007)(66476007)(66556008)(52116002)(86362001)(31696002)(36756003)(5660300002)(4744005)(2906002)(8676002)(83380400001)(26005)(2616005)(956004)(186003)(16526019)(478600001)(6486002)(16576012)(316002)(54906003)(8936002)(31686004)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EOIYQBxA5G+PNYADya/wwmaTqtyKIVfjBl6rcsDx6olW5DURXbV0V+Ws8+BdBrcpOEtVa0PDFsUHHz8xDN7l4OZpn4WkKHLVCdMxGoHRFVvYU2gD7Y6QecjqvZUcSwJYjWKX7wNTYY6IjdJmFRg+zSE9V0Wbtnhd9oRGOrfFdNLLMfp4Fz6w74nul2bIJ6a/1jM7UCdtI4M9Ceaqv13qJuvk/6zGXExMpjRVGI8H6l/ALG877nC7ZwWeBI2+gqDzYfeLi1TqKteNUxRKfgU1/TUjAamtuAq7QYedvKBwafJOYE7pYVAR2fB3YqgYMU/1k7oUXxSYztiVdPCF5EoBsm+ajyatVHSNlVwP4elSNEIaICtTBfy6IbiKgss8Q8tHUtv316vmtpAGsPuKQUGtDUYNXEnKHGjUULMNYKFhf+YavC//HmVDncyVMJQlZ7RJuVlVUeBYhfHHp7ICxuubbjMV4si+evxKc+IMDqozrO+rx37Xz1GiJMYkiXH4OEikHRsKf6xo5E4tqFQ9bUWh/0SxziHyLEzroiHfO04Rc2Z8zkQPulLk0iilpPJvYe/FqwCCXojzRoMnhd2sZwbANZTvoDjz6nB5oqlWf9aFBajgpjsNDKwmy7LZT55x4a/kgV/OwbzwkHOw/jyNWhK7FA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e136a691-5806-40bf-c9d0-08d8596153fb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:23:03.0208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5yODdowczN3aWErLvmdqpce9AJQJQa00v56/TCgO1linHKmMDD1kPwOXNe0RGUeFq0/GYndzk76ej7xuZpUNN8xZWzF/dd8K/d+nwgwlZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2450
Received-SPF: pass client-ip=40.107.2.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:23:03
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

14.09.2020 15:34, Greg Kurz wrote:
> As recommended in "qapi/error.h", return true on success and false on
> failure. This allows to reduce error propagation overhead in the callers.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

