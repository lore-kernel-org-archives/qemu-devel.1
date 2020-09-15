Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8361C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B952621973
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hsKadRUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B952621973
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI7pF-0003Dy-Nf
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI7o7-0002gY-02; Tue, 15 Sep 2020 06:03:27 -0400
Received: from mail-eopbgr80092.outbound.protection.outlook.com
 ([40.107.8.92]:25345 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI7o2-0007M6-P1; Tue, 15 Sep 2020 06:03:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXBUs2TnHn6TJiceopPPfwtox9tDv6TFpTK67ZRYucPxVPmczBi9wao7HkB90vxwUhAFAGQZ1cgRKWa5Wzl5un1B3fnQvzldf4lv7LhSELzig2CwRnZHI2HUN3T3O0WVvx5L4Q31iunMC08U75bveM1R2hXECMqJ218+TcVNsc4O2X3Z6zf63Ux6EJ7QYhzNDKi97AMYGZ+jXLB3Zcb29I1i6Rq9uKcU5xlRDgLx+L1Yz9rYF1ml2T/IRlMfgWGL+NToFvPM2anINJevbo/oazSzZHWZmA1FWOQsVG+WUuhBUk+ATyw62gsVVOQr0V4bLWbgS0BSE68YZ+Xl41ngDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGrblzAYd3sa77v6zfsMATKnaLUH2PUF4Mb+SygAx+g=;
 b=bH3hBc+eWP2LepHronP3uZ9snHlqj3rdmt7gCQp2Gdzrd3csr5ft2R184AVwdztXZC75Pxo9bq/qxjyr4KeiGTrdV8bakP5pXx/QIB9mGARfAyHMpM92WjNTKhXbnxFpmwG/M3lW882rQimG/eAfpcTBfmyoxW3Q7ESWGIZhgz4torwSxGp+Vg12gApDT9nRU2Zndu4HbRIAOyMCChQ2QULkbNvGcZBXHsIH+kArY+rO3i+nhcHa7vP0UIy1ffScAkqS7jgU5Eh3/7Z1OXwl3a9pku1hZrZvuDA7qi4ZPx7Kmife/FgBSl7EeHMQHGnJM4P0Qhdk0KbJcfPUB/wTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGrblzAYd3sa77v6zfsMATKnaLUH2PUF4Mb+SygAx+g=;
 b=hsKadRUHnZJD5puwtQu5JKt4GD3/xQlODppnuqRWdPjS3CJtj18xCAN1Nau/0D/BKL1luKmfpSRm5wstCBZ+bg0vCmVltUTn6117LNlqV5nspnBgDhnqFqhBZxrWyPHzDShWiFKaqs1BIefD0v0d+QQJNT3RCZL/wzkuWtle+hI=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 10:03:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:03:15 +0000
Subject: Re: [PATCH 05/15] spapr: Get rid of cas_check_pvr() error reporting
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-6-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1255830e-1be0-86d3-f830-a48bb9bd87b2@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:03:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-6-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 10:03:14 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5d5237f-e811-412c-b2cc-08d8595e9028
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4850FE862A8AD6B38487A07AC1200@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyZG+v/dkUBaKqHMMjaip1S/7tSBU+jXAmspH5wFjBLuwKUAp1Ud2ehagymScbAabmYSMTcIZgzmz1ciAOuBiBonLr20mSaVpeVItcGZisKIUb9VolaC9HB3wzJZbLQ9cCKNogLdAq3FgVC2fwWMf1l2xRI0Mi+NBSibf2BcHaEodEdqxkerwwyffJr5LTMCMGs7EJ1BYBU5uw+5Z5QvB2uD4sFp3myz3K5G7ItFhY3XG3xaa0AtE4fwlS4xNfbnEuZS7GJTMwI8hLuqc+f5R9SL96Y2eEHNPNTE1Bjawvi1zcTtZdZhQzHmCTEeJQQi/ckMLwBnwTbluCiL5uL+1EKP7dxofPKyhDKFCBILXgffsufQHU1h0NXqhHXfchTFXIPM4QzUtqT9OqLSdTJd20zJs3zFEzFhGKo+/XzgDMccEe2CXTtExha3uF2+aqF5WaWtyFOYZlJG0lc9GENeSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(16576012)(2616005)(956004)(86362001)(4744005)(31696002)(5660300002)(36756003)(66946007)(66556008)(66476007)(4326008)(8676002)(52116002)(54906003)(6486002)(478600001)(316002)(8936002)(16526019)(26005)(2906002)(186003)(31686004)(26583001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /FU69hGk16Q8YCnl6rvty8UTsk75RD04zRd79219bL5zrsEsqoNW1IZmkDu+FfW23KksuUOkUMp9lECEGlvJ8gsbZb8g0qmh8ehLV4XQoWmE5V6dhJRe7rbvFlI37L1YAXYzepSq278xOyl1IbiQ7HMy5kROXH67l0c7PheJF8FqhTurHC8KrnuL3eDZ7u3Fiu2isO1pqvRO5AvLKpXcURt6vD4FoJvgXfyOCk1D9wgiLACnLsq7K0zo2PU+zbccT26C02ATocwu5StkGhI92JVCrmJT6pc8nMbHB4cSU2XDXin93cnJcDbkTaQUt7BKpKfyDBVjsOuFG7ZzR9pjj+Do41UxVo2Qni4Oh/f6pOHVZ8p7ae3ovBkloaxlQOZel/oAbqLj0RRsyR0vLhCRRRE+xnYADHqCcyi60ppZj5SVkjKL5kiioDz3yepakWRirOxU6XhV4X3vknGxO6omDLlTfM4GAxBtVh3j5q3XALLDzBLsFjvWdKw0DyJk0HEvZdWo+4an8mr1LocMS2gSk1W/Rzbpg6gYjrDwT4I24o2lxSW42EMvXsm41S2bE4eGY2dQTX9b5+WQoEgfn9d/fle/jaH79OSyC3eFlxfA3MeP8a75w5D11o2Kh+X2YlmqP/5qciR7VYa009bmTaaH4Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d5237f-e811-412c-b2cc-08d8595e9028
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:03:15.4862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcLrdQJFTntpB9PParPMxSwJKI191XohO9UttxEKvkTtx6kqvgPUcjcOrMi+FLUqTLphlsHu0+JWabZscUTGQNXtHrBjQuQdGE5MqcmiFhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.8.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:03:17
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

14.09.2020 15:34, Greg Kurz wrote:
> The cas_check_pvr() function has two purposes:
> - finding the "best" logical PVR, ie. the most recent one supported by
>    the guest for this CPU type
> - checking if the guest supports the real PVR of this CPU type, which
>    is just an optional extra information to workaround the lack of
>    support for "compat" mode in PR KVM
> 
> This logic doesn't need error reporting, really. If we don't find a
> suitable logical PVR, we return the special value 0 which is definitely
> not a valid PVR. Let the caller decide on whether it should error out
> or not.

maybe then rename it s/cas_check_pvr/cas_find_compat_pvr/ or something like this?

> 
> This doesn't change the behavior.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir

