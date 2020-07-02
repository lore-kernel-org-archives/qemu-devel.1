Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09689C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C200E20780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c/QPfTXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C200E20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr5E2-0001Pr-2Y
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 15:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jr5DN-0000vi-BS; Thu, 02 Jul 2020 15:49:45 -0400
Received: from mail-eopbgr140123.outbound.protection.outlook.com
 ([40.107.14.123]:55911 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jr5DK-0002u1-AZ; Thu, 02 Jul 2020 15:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx+lARwol+aiGZ9wiEtO02pZ70M/63FApZ8y5ha6wTwwCdWnT+B55e+DtNowmAl+emVI0pRuI+XqaTnwosaXFpCRhpluVnws4lPmD56KaROGofPc2MtLovdNzLUsaOzuDzfHcyxKmSHNZPCpEH3oGWXFElTlyjPnQmCW86XorRV+0Gw8bS43cSGBdROPIaXzuzigf+/Mrmtcf8zMTXam0P5SZmgw2g68Sfo1IAChEhjeKxBgzhiDLLxIlPL0G7zhuK7WAp8j158n5GKr3hd4S/iwVLBc9j8FF0YQm59NtaZ0IwUeMt60EgsjbS2FPnr6pIjiXxBY/+WRe6qH9Mvd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHIOALwU5WEDOH946aty6I5yh6gbXH8yDlHhquQrVEY=;
 b=cneSKfytEQ37z/hGknbvWsYjZyu+tmO9c1mdnvd2U0X9QZGxAIh/tT/3XBcy9j6xlOzMJOOLzN72SQ5IRdq970tI1651X6Rw5Pc9l1BOJ8TFPYEaO+A0Xs6bj/YZqjO1IxJuvqbIxMD05Yj9HypW0v7V6s8TDMdAtdKGm8yWQIb3ijqKGfC8Oxm+PYlOAeFLRYOvv8CkjrgEzy24NRlZf8Y6+aNZ7sWRH36Nbbz/CJOg/pMMV1wcgB2gv1tW+sXT/iqTT8jKbaeV6Xf4VBTe9DhfJQ8c+I8+Bl2AMD9bCkInhHgLmZHw9DMv2SKjAVrdQpBVoDIWw62orMkL+Cgifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHIOALwU5WEDOH946aty6I5yh6gbXH8yDlHhquQrVEY=;
 b=c/QPfTXfWa8tDjadAKqAjLc7ZBMlJXXothraWkvLjrBUDNIPKPxTtWYm/ltDW1FJM8LpJ7xqfIopTkaeu5ZIOpNL9yB9e/V5T90kmWP/Nj7m/e3dscU53qSDcOytzxHcuVvOiaavqwQyjex8sEJavTBz6a+t1+8qbnBVksD++KU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4785.eurprd08.prod.outlook.com (2603:10a6:20b:d2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 2 Jul
 2020 19:49:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 19:49:37 +0000
Subject: Re: [PATCH v2 11/44] qemu-option: Replace opt_set() by cleaner
 opt_validate()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-12-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6bab7bd8-fbba-c99a-4965-d351242d2f8a@virtuozzo.com>
Date: Thu, 2 Jul 2020 22:49:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.54) by
 AM0PR01CA0146.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Thu, 2 Jul 2020 19:49:37 +0000
X-Originating-IP: [185.215.60.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb5ac3e-0f87-48f8-0cd0-08d81ec10d75
X-MS-TrafficTypeDiagnostic: AM6PR08MB4785:
X-Microsoft-Antispam-PRVS: <AM6PR08MB47853E33B7352C0434344B38C16D0@AM6PR08MB4785.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0YhwY23vKW0RpO+wlGyAcIOJ3LKBEOMvkej5JOash7BDdGUDHSxQuBe5TUsmaVbUsyz9yDW9C5whANdR0uX5GWDjmCph6mLPhUg8MjuaHGIPLEGUp24XQaknmcKo+09B0Ez9oPf8bb2SIeBQ+uNNwdKX52lmRYy4/k27MGJ7GQPp8z5++0LlxanAnTiA1TvbpcWqD9ZivPMrUYx5tEBGdqI6NXx5xT0Ntrf/UzGDXsbeDi8dRgsit0gk82d3OUfNJ8goYsGuY0WK/QzAJeHfJ4alDDnlxt8Hgd9y6fHvZ6Nbt6eNypRo4gGhCaIKM7fO8UvCFYb4W0vA8MiRNQzLDw1PIQkMwB0ohXCuLr9wzFVrkWm92QhXg858kkBJv7F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(136003)(376002)(346002)(186003)(31696002)(16526019)(83380400001)(86362001)(5660300002)(4326008)(16576012)(316002)(26005)(66946007)(31686004)(2906002)(66556008)(66476007)(478600001)(956004)(36756003)(2616005)(4744005)(52116002)(8676002)(8936002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: POmblQB3WBvcxFVH0a1kkEdvZqKcyz/uLVW6RS6Sp4VkAMXmx89xxqtXl2I8PR6aed4KRg4w4A35dyXuMAUHVEl7U+G1evlXsd7e1e2WE6eNlJl6mSE6lysK6IPfNUwn8DMvnOsNVLQC/CBW03mJ+LrRNFNFKOtdwKp5zq1IpD64qsCBRJNdBu+aZcp9pPaaaJgbrpjGEoTl4Lw7Cx4VgUwRioVZRPuy09q/a57FyPAtI986yngb7SNVqy7HHdag3llOuIchI/zoG8DFAxoWmrXLn2Ubyr/Dr2vtZJhV9j2/ALcD6FxjVJeNTzSnBbxGhVQxHvFltMUJ+nUsGN+wPbrKupzytSc9pFDNtttoF3TE8zcaYk2YgRwMei9BTp0maaJKeJuMoMc+dQ4dmddaNP7ioCcs5GYSyBggI1/UFqKGhouEELH2JDazTXA1QD0AlOd1lkJGfd4YREanv6K+5Y3jJklTTFoAo21T/EU6RG8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb5ac3e-0f87-48f8-0cd0-08d81ec10d75
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 19:49:37.7087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slNzPQuZW1ospn6zuq/W7IosbHU2vekTV6ri/SIqfUEJUUPyM/275/4rXIaiZgvKZUrkL6G3Wy+S2A663MW+S6Wm+8y3g9RVfY0MebCx1mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4785
Received-SPF: pass client-ip=40.107.14.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 15:49:39
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> opt_set() frees its argument @value on failure.  Slightly unclean;
> functions ideally do nothing on failure.
> 
> To tidy this up, move opt_create() from opt_set() into its callers,
> along with the cleanup.  Rename opt_set() to opt_validate(), noting
> its similarity to qemu_opts_validate().  Drop redundant parameter
> @opts; use opt->opts instead.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

