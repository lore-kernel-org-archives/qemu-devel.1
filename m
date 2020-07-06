Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B94C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6319206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oKNyXu3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6319206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsSuq-00025q-39
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 11:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsSty-0001YN-Du; Mon, 06 Jul 2020 11:19:26 -0400
Received: from mail-db8eur05on2114.outbound.protection.outlook.com
 ([40.107.20.114]:52320 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsStu-0002nI-Vl; Mon, 06 Jul 2020 11:19:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEHbgw6XqORCkzH5pCNvJvYeiRivGNWAwy4kfRpshqpTkuJfQXx0BPCTMf3xUT4JGR7I0Fr+UdsakwGYqMy0riVUZp5Qbid7QA+ia+IJRAL8VHnknbbVWEREnAgM5UdxOVYiDsvqhAmS+PQwV8HqdJpdoGIUdA6hJAuHuYUQTsdCfgwFAempsECvSMgqfm6Qup3wjQUoXQ12zNYuWtlXVXoBPC6mdJpI/15du4rm3ZdjIXzKLSv0ax+LQEM7R/uwUoo3tbCdsVzKDgif2tO735kCJ0Fy7/WymZiZOEwJK+0ZqAtNjUxQ8OTU8CXASbp0CuHI1RvrJ3i68txhKeWUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKo6lXeP9e2147ciaGJ9jxnYqSMDmkEOKUcaA0JRMHE=;
 b=dtNF2zq88JKHeI0SezLqHIq6NaC/DkjrbjciadRAc3mQCTkgMX2iHSkFi4jGXBiYxPJG9Xh5OeesCiHShWNNdtdHomCRiKwcRCn9V0gmHIxQhaaQYCUswgBD02x4lNTdLrGD4Aak05gCgZ/igN/0nSCsdnRLr68rx+kfWKZ+7tUko/MGNFOWzgTO+lvXw6vOlIbfq1zhq72rjr9RctjPucfcRw5LYjfrIMU0KmoTkhGqMZ8XYmNwuHnTDxJy8ncRM1f5wnC+ak9V5MOd0vgvLYZcGcfqv2CprXwmMzdWpK9pQTgcZO3oR06TrwvQpQKhEUvLRbncJZy4Lzux4J+DNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKo6lXeP9e2147ciaGJ9jxnYqSMDmkEOKUcaA0JRMHE=;
 b=oKNyXu3zrXGlDcTbkQIBmL75Ve3oTUDSYXF2Foy6mNdG4S9KljpNBDff5JRO+IsLB4Wms+D/zABSPrkx+OMu6etye0GWGvpwCvUtNHPfGo9/5VCh3a7QigbC1KbXAcXfSIewKccvG4SCaTKvWVmbFcKilSiYxuyKzVYNbhhaaDI=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4786.eurprd08.prod.outlook.com (2603:10a6:20b:cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Mon, 6 Jul
 2020 15:19:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 15:19:19 +0000
Subject: Re: [PATCH v3 25/44] qom: Put name parameter before value / visitor
 parameter
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-26-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2ead0dd8-030e-2856-19c6-f4ed0b5e83b5@virtuozzo.com>
Date: Mon, 6 Jul 2020 18:19:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200706080950.403087-26-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0036.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::49) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.58) by
 AM0PR02CA0036.eurprd02.prod.outlook.com (2603:10a6:208:3e::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 15:19:18 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 381964f7-848c-44f2-c615-08d821bff416
X-MS-TrafficTypeDiagnostic: AM6PR08MB4786:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4786112520C34F17E999C4E9C1690@AM6PR08MB4786.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gmg3sxKsEl3hv/QJCn4vecXs8NzQ4CwKS+RqjVPjZ8eVLGJdmvS/hLdWs319uN14r4Y4rSBFyfeKj2f+YLAL79AsiosRhwIum//6CaeAQq9IpLSJiXshG3+XIcvMAa/ECW/TwzJ91/5A52O787F8ExklPN5r7/KJ7EGiUQvFJTJBD7Vn+mr00Xykd+KZyuwd12dGY3pcV3WiapO5wW7RtxOQ8D2JJpuXd6HU5HUCGaJLLQ7JYBHomOLaA8XQR/5UqEWi/129mV7nCaEgJZQKVmF9COvs/yuyuYWht/4vQXq3hbSzYftaiU0sHNbryjQecoxFF87mLGUSafZH7MY7I+1Ar883cw9H/XtpTeO6eUBNiwWQGFukYiR2Lnl014Ym
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(39840400004)(346002)(396003)(26005)(8936002)(16576012)(316002)(16526019)(52116002)(8676002)(186003)(478600001)(2906002)(31696002)(5660300002)(83380400001)(2616005)(956004)(6486002)(31686004)(4326008)(66556008)(86362001)(66476007)(66946007)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UgTIRVVGOVp7ZvAoVWaMXedzhZoxsk3kPTU6mUp1jxLL0HU1tpAbOy5zJg+FiKcjmx21GbyEJUgyipKC0yl8fMLEYRSWHfFI23geyUKA2Lg/uzi9U0I30apDu/kFNRM1HLZoMAuI4AiKZzvIuOguGsYeNpVESu+lztqJPayPkTz0dmf569EvdkmIR6+3PGQ2IagqsminjrxwNKpU5NG+bGYfgYWEUmxoICPqou4Zv9qV+FULu0ggYiPgPJuDcl6+gnokw7c2EkB8YgydwqVKEUYzVbSO/GE8zHJ2cEQXLNv6UWntStiYtD5Bgcwdjg3er8XV4KdD2AR0uCCq8i7+Z4rl7qgPN4h6YNEyWblz8qaRta8EULxVUNaZnUn3JFJUefNt4IXaZ+SKBVgrf0sTzURqyy/6eFvelHAu3lPcnWsIlAk2xyQTjR28lQmQLnA2j3Q77LRR+D25PKbACcFMtM7zL5Z27t2sRPO+tNg9miA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381964f7-848c-44f2-c615-08d821bff416
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 15:19:19.2151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwcTLWvZJLoVE80LOVofplTs2gjoidsDQMSEZsQ82yYD/kHEUHSDp21WColT5/jMJgZBoN9DGQ5PHPU899p0/7/oCQ9RLsw5fVbp+P1Z/DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4786
Received-SPF: pass client-ip=40.107.20.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 11:19:20
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
 qemu-block@nongnu.org, groug@kaod.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.07.2020 11:09, Markus Armbruster wrote:
> The object_property_set_FOO() setters take property name and value in
> an unusual order:
> 
>      void object_property_set_FOO(Object *obj, FOO_TYPE value,
>                                   const char *name, Error **errp)
> 
> Having to pass value before name feels grating.  Swap them.
> 
> Same for object_property_set(), object_property_get(), and
> object_property_parse().
> 
> Convert callers with this Coccinelle script:
> 
>      @@
>      identifier fun = {
>          object_property_get, object_property_parse, object_property_set_str,
>          object_property_set_link, object_property_set_bool,
>          object_property_set_int, object_property_set_uint, object_property_set,
>          object_property_set_qobject
>      };
>      expression obj, v, name, errp;
>      @@
>      -    fun(obj, v, name, errp)
>      +    fun(obj, name, v, errp)
> 
> Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
> message "no position information".  Convert that one manually.
> 
> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
> ARMSSE being used both as typedef and function-like macro there.
> Convert manually.
> 
> Fails to convert hw/rx/rx-gdbsim.c, because Coccinelle gets confused
> by RXCPU being used both as typedef and function-like macro there.
> Convert manually.  The other files using RXCPU that way don't need
> conversion.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>



Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

