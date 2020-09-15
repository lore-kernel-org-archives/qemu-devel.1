Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C8C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E0821D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HmfWgTX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E0821D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8oG-0002KQ-Ex
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8g1-0002c2-IV; Tue, 15 Sep 2020 06:59:09 -0400
Received: from mail-eopbgr140098.outbound.protection.outlook.com
 ([40.107.14.98]:6467 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8fv-0005xv-Ev; Tue, 15 Sep 2020 06:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1dBzK4m0ZXZL6u7XIRprzx7mI15DMlpYByuoGKwN9dQ41fr143kWp5nMIXSDvdc0NWIQ6saq7DxpJ90m3v+7pBkKiT2Nn9BtD62e4cttPpfXoX1aL0MAm0+/BULliNXpTaSdvB2SM7bfP7Vip0M9QlTaYPjrBERzuYYekC4ananIH4uSgh1doX7lG8eGiSS7XV3MicxaZdxmNzJEtcFtKPM77NPYl8QJop1eEzpVdw2gBB7bRwzq/f4DxE8qo+GcPQZ3LZZwgJQHgni8UTZ7AT4HXXZYnFCQUH2Z192a7QxIvVEQ1yQQg4vjF8ifSG8q8DyMmCjyb6LrNZEhTv1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83g+Hf/tzkzPLUjBhkSs8Af/YlfDzgt0mUmIO7aKAjQ=;
 b=CgkihJF+Tw6S44U+9eChDkViGbwZuYu22EtLrnLsDflxPWbxYyvgqUZfZSpe7mUk13z7aHytL1nSE3wlk8OiqN2IteIKumXk/yu7tHNp3OczPf9gGCtkqpIHw0yidK3ZnaNrGJAp3AArvui3AnR/1CioniR9L10L6c5/KHchKTTTqLh6qKr8bPw/5LniUVCG8c2mzM+iho75ngt+tv5GAWU9qSI4giJoqXGBwEom/PxVOrHx+ShCmCItRC+60JwbNuEAXrLiNLihJuGOSWkdzh40Q+FKsAZB6Dl7aZ5yBWB720E+yCCeG0XJteslLuiQIflifljKw55xq8En8GbJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83g+Hf/tzkzPLUjBhkSs8Af/YlfDzgt0mUmIO7aKAjQ=;
 b=HmfWgTX5dmhT+AfnEYNCFoLBW2iSS6pEvN4R4uP9IDMlZvwTOxDDpOVPdPNRfGnV8ZmDaC3DR/3U78fxizfkR3FYgrD8ASfUpq+uyb3h4MD0n+L2JeLVv68QUgApFZhvTWFfuVgO+CiTWPJoPqRMHwZa+eIzOvSFh5+e++FpjC0=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2099.eurprd08.prod.outlook.com (2603:10a6:203:4d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 10:58:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:58:55 +0000
Subject: Re: [PATCH 14/15] spapr: Simplify error handling in
 spapr_memory_plug()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-15-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <11f0dcb7-7923-0164-df69-4911b3293663@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:58:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-15-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0059.eurprd05.prod.outlook.com
 (2603:10a6:200:68::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM4PR0501CA0059.eurprd05.prod.outlook.com (2603:10a6:200:68::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Tue, 15 Sep 2020 10:58:54 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4eb28e8-affd-4d78-57d4-08d85966568d
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2099:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2099E917BFE90C576F14AC15C1200@AM5PR0801MB2099.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pA0bUlgvoLe01TUHbIlzkWeCVwU0NTxQXpad1L6CUPr1qgG1JizrM0gMHxug7yzSCBeiAsWZoKB7BdbQr4RN47ESHGqjrNOaRhouPIXNVwaF8bkFZsQiYubmYeURbV4lyTDDpxzVnsWgCqJXZuBlLFntVbysWZGo4nwDS6vFnhmTBs0gr9NWTn5FvXJqSTkVhIdWma7Kb+fLUrSkBu72ibTx0L8N23D0XmkX6tew0kfkNuB3eShaLujnppCAfxDLOwDjyGGl7bJir00RKThmRML28u+L7SPssnt9PVJuYV90Buc9hJ2xzcDmbemYYNL3maWgB8uxNhyDj8EEp3vH9hQ8KgYmZnNYxmgl1516/s8ykTOZ+sdKt5RfnotQm5Ym
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39840400004)(346002)(2616005)(6486002)(186003)(26005)(52116002)(83380400001)(16526019)(66946007)(86362001)(66476007)(8676002)(36756003)(8936002)(31686004)(2906002)(31696002)(4744005)(5660300002)(54906003)(66556008)(956004)(4326008)(478600001)(316002)(16576012)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jrGymSJ++klhTnxrwq/kgYLnyWMVAU9zisNT4O3rxxlS0gPN6nAlL2Du6o+z0jzbJE0lGLmBsPoqQRf7nhikMwRUUPrGlMzGitH8nPQcPS2BmXi6TuXDYQALc9DCNgf52lEKLGU3R3nV/y4mRfQSs/C/adkEcrRNxlBYQ6oKTWbaOSwqsYJ9186oeL8qBjnxY2kccqHNIC4Qu1Vxj9r7O/37YqfsNQlcIBX10wUqtT7HlxyG9/SnZiJ3eipFCB0zSUKfOVeA3qMIcxdsRwihU/r+8Jc2lNMgU1wZuRd0fLJNbzLp0s4Fnp/ihhB+ZPnIR4m4xXNH3raeQcifiCLQv97FGcRYPvdgfv1MZLsvrttO/ALqHB7F7hJxH0c+bIBSn68remFixsBUeWI52TVGcj2/VhyXwHkEyamoDpKibx4Zek+3dYwQNzYVbYFhZ4+T9ZWC5tBiMVhLH75vcHCSubLz4mMQxE2FVyc5a9t9Uv099MSH58iz93pb45Uok0ihr9vo1kuHc4N/52q1QGzwOuFp+U8BbTVGW542QSs7h7N/7QZREJ8RBj+n3ZvOm3v4XLilvTYvUmnCh2+GgqyKNOtbL/HOEIbVLV39uephiW1TIn08K+tCwgbfDxiDzoFfRNQt+eP+/F9/dzh5K3Yi8w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eb28e8-affd-4d78-57d4-08d85966568d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:58:54.9253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+lni21r0OyxwzBx1BEL/gGSjEgO1hbpvldXIeWAYna+GpuS9z/hbVgrZ1x2dgWmH/jswbdNlcGE7cHQ34zCaILZTGbI5c+sfmYhou6IkWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2099
Received-SPF: pass client-ip=40.107.14.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:58:57
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

14.09.2020 15:35, Greg Kurz wrote:
> As recommended in "qapi/error.h", add a bool return value to
> spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
> of local_err in spapr_memory_plug().
> 
> Since object_property_get_uint() only returns 0 on failure, use
> that as well.

Why are you sure? Can't the property be 0 itself?

> 
> Also call ERRP_GUARD() to be able to check the status of void
> function pc_dimm_plug() with *errp.
> 


-- 
Best regards,
Vladimir

