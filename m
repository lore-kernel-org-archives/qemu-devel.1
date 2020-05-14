Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB8CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE28206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ILqPy757"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE28206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6hc-0001Dw-Kt
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ6go-0000hc-HT; Thu, 14 May 2020 01:45:50 -0400
Received: from mail-eopbgr140115.outbound.protection.outlook.com
 ([40.107.14.115]:5188 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ6gm-00086X-4O; Thu, 14 May 2020 01:45:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpIbxdKNu9BL0jFK35R5ajP9iChLLVPjDDEF/TIC+u5QfzfGkI02KKNibErfh0jSKY4XLthXMfmdSax1aL6VcZpnVcCFCNN5xvdFmKarbRYoEveKmhFJMT59VKH9CUtFqpmSpnbtorFdgcsGhq7kk7BC09GxieU94YWNMb6T3vki7y7QwOTWk0WWBxs1x+mp1Nbm9L3WJ2y54mF8HE/nBe7IEsJUqWqYPCalX/EZHb4Y3PbU7qZjuM1yDb4IzmIQZ9dQLtQqfrxlInzPTqOgpZGzRDcDB32j21OsyH6yT7Al/Tfb9fZBjejesr+d4ZG2t8SHH5sHVJw9k3JnPL7r5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAZ6BYRi4lsitnsugaRtGIL3RZmzPN4rdCwcAERt/b4=;
 b=GBLBZPRhVGXD8VKvDPQP+qg8PIA9Grp8GL7qaGc199kHLPomuqae89aUD2W79nArPk504IqXa3UNff3qGq7G4QY70DWAl6Spj742xZz7Rpg6/3i9jC1MnkgzK1gWZo/FXSgMTCpiW7K3DpJKBgb56kHCIItcvfUh/C0+mOixUr5FqqUexHJIyfO/OTvb0V9wljZwr7zkx5gOzPknFJPzfS1pDspk6R1FP20Uk8mNRDdUCvIdBZrmQRuocKhU+Y7YQkeSS23ladIU+oXOvPghoya4d0+9alfN6eGR/NFrxSvSrth18+yQnCZe3r53hRLooHzVTPH87ywzNxguHhsGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAZ6BYRi4lsitnsugaRtGIL3RZmzPN4rdCwcAERt/b4=;
 b=ILqPy757urLsfRsoZQXYUVl5gCG1eEgmIEXX9XKRhEh4ZRL/M/atMuDSAcqdDDku3wmyZK5U/F1Fx/L6u+v+EmQZldaUyrhDLCdmiEnM4M23nmGlWEfKIYEcYxsWB/GO07JhPqYghDzClRWGfFp5LrybB5n2Q0GszKEBVwBrLRs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 05:45:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 05:45:44 +0000
Subject: Re: [PATCH v4 4/9] blockdev: Promote several bitmap functions to
 non-static
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4d41794a-5cb9-0333-01e2-82c8e1a69218@virtuozzo.com>
Date: Thu, 14 May 2020 08:45:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:200:89::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM4PR0202CA0006.eurprd02.prod.outlook.com (2603:10a6:200:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Thu, 14 May 2020 05:45:44 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87674c5c-cbeb-4e8a-f596-08d7f7ca0b8a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54470984E50B453EFC2342F6C1BC0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwFVmhaaIff1GqlHIuj8oUOEvqPxYJ4+8LHs///pOmD3N4P6bxl4LhWn6oikP23Y9e5tAuo8876uMIaqsFbPZeE/P3tBwTIlwj899I7jf+7o5hatnyuVQp1+FwtXfmLtPUehw7rSMB4nLkMLXxRSjoMBBYlqSA1xDH5xDORueLA5zTo3jenmNhDqnJpXr0IW47GEVhleO/0XbJkkKyMaFvGNOvnyx5Y7nnv118XxvmitwrOp4PTg54attdAhsP1Gi20/G8sXvmuwBe8rfj4wKC7jdOmqHkn2J3LlLmdXEh6T8CosookjdykN9cJymOp4VbQU2VcBhPDwSbRpa3IFDYNdEwgaV3h4wNWrLyMcmOBTpFdWqqHIW9+UGyrzrSLzW8LkbIPGDNkzCZ5KPiTzXaGjJeLmVLeBK8LedpP2NGa8+BYzkXgQ6X/bFwXXsBHvYjCWOGOjneUnlcTWCRZwMvbdZ9vEa74Abv8/GFse8Mr0rem4z4WBxvJ9KQeEKHK2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39840400004)(376002)(346002)(316002)(66476007)(2906002)(4326008)(2616005)(26005)(52116002)(31696002)(66946007)(478600001)(8676002)(86362001)(8936002)(5660300002)(66556008)(36756003)(16576012)(31686004)(6486002)(16526019)(956004)(4744005)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kraGjyxr9fElfGhFh7o0WHE8PQ9M2RC/SRIrM7TBTnawlYSe/YpjNdNAh7MeTjSkyH+nHgg5dsLC21Xftvc9Oyy/FaPDLSHNA/VBb/hgaC/ovOHeogJno87BfrNQ35fbW/hUlhPcadmaj/z1ttXtKUM6Edzkb+rwT0sxHcMSczL9aQJ5ZcA0Tk6JJEMrBRxNcumtVRpQymYfe/ndks516f3urOJLuKeSFbXk6i4MMskBQsUa19xdUGh394qmVj9IA1Kz6FVJ/lz53wh8WW26jMdo3o9rEl2Ko0GuKm9/jqoXA/fuQjeYDspQaQj6UnKKJcldEJcT6V6QDJRReEod4f2j4BM2IJk8Gmvhrxe6nP+BWP5WH6yq8jrq6xAOQCAJKKecOPCsZD3khvH0sau421yhQ5oGRrBBg1wXTBntZWhDbt/i74S9NptNe2zlX/2tXy542Swib2/JVz+syCdNf1zx5VSnSJjiSyUm9/UWRL3UhFkEWQaqY8PZgHco8gf1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87674c5c-cbeb-4e8a-f596-08d7f7ca0b8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 05:45:44.7077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfEMMJl+6etJvgxi0JdUl2tVC5vbAuVP2HCYAeWJxxtVV/5mVqVu8QOl5N1MGi6LbrV3SAYT45ry3l+/nD3oSuXonEzKhbXoeNqprawW3gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.14.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 01:45:45
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 04:16, Eric Blake wrote:
> The next patch will split blockdev.c, which will require accessing
> some previously-static functions from more than one .c file.  But part
> of promoting a function to public is picking a naming scheme that does
> not reek of exposing too many internals (two of the three functions
> were named starting with 'do_').  To make future code motion easier,
> perform the function rename and non-static promotion into its own
> patch.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

