Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C60C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7382063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vcZFi6VU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7382063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4VY-0006RC-I8
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4U3-0004VQ-HS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4U2-0000NC-G1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:11:42 -0400
Received: from mail-eopbgr60115.outbound.protection.outlook.com
 ([40.107.6.115]:13897 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4U1-0000Mz-NQ; Mon, 27 Apr 2020 10:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSRjpdbNCDEG764wkccudZL65gE+EE6fpPmrosivtqbTIUfs6r2k85r8KZcnmbb7HcsOUp/UEFtE3ltYTsFIBdfffFD0LSBSzfmisdKUA/OVgw0fTKOtDABIw5oPJl96+Qw8kYwNKwuToay1gyXrG1JHMIIi12Um7qnd8bo5d8HFvRnj6jSwGsQT+hdY1vhvmmHHo7KidMIHylaxjVxLeM8HytyvZrfO3+hnYN+5UpB0DVmhD9y8zPQ9HYToP22b8luahY/BNLy5kcf0/+MewEiMlu1T5/zoSP3Vep7uOtBypS+R/0RcbNYXbcaVnFNarJrvs0+M51esg4Jc2rsKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpT6KTNDJiUUfbGUFV6EYwRbb/DwnyUNRf4dAYJR3fg=;
 b=Mm17GkJ7XQZUIt3LuZiMjY9W7FhUAwySvVGEyKu1BB+jUycOqmnkbMgAoaB7JDkXKNE+6L/lQYmEBkeQ0Njh7bPMi3eYsRVh8BW8lz7D0ZwZJFqXkoaAcSnhLpyxXnCowiUnk2CB3/AxQ+K6/AeSN3c5pm8phWaUsds8br6jBvYPDYkY6oUqk8O4J7sZx/x5BcRqUvMAcnKf18BYou2tpOeqWICacPGAH1RIOvsKTBXQowh81lM8uSqzXN/u00hom8X4FnhnPkGh4EPcKGPu24yBIL4rKblF+h2O3tU/05KHjuxu3RRKvhzVi8z0p1K0AX5GHtVD6xM/0tdphCnaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpT6KTNDJiUUfbGUFV6EYwRbb/DwnyUNRf4dAYJR3fg=;
 b=vcZFi6VUnP4zaHo0ftHnQAvu29maLsTmj1AuIvaRicncZ8CtJD18YFfu3g8BjXbybaz/CrTOWjKP74fyiGRAgwWwtkCnmzlYMRxf+UsTC4d2dssyyUi+w6MHLRG6ZKQeqxSHiyqlX2D0NtrzaAiUxk5P+NXzQ+AZnqtvzmqUfTY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5509.eurprd08.prod.outlook.com (2603:10a6:20b:10c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 14:11:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:11:38 +0000
Subject: Re: [PATCH 4/9] block/io: move bdrv_rw_co_entry and friends down
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-5-vsementsov@virtuozzo.com>
 <20200420160456.GD7321@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200427171137150
Message-ID: <4bcb40ee-41d0-4d80-7798-6feb59f0bf7a@virtuozzo.com>
Date: Mon, 27 Apr 2020 17:11:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420160456.GD7321@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM0PR01CA0115.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 14:11:38 +0000
X-Tagtoolbar-Keys: D20200427171137150
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d9e48a7-b000-43cc-85a8-08d7eab4e705
X-MS-TrafficTypeDiagnostic: AM7PR08MB5509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5509D5F59FB306F85487902FC1AF0@AM7PR08MB5509.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39840400004)(36756003)(86362001)(31686004)(6486002)(4326008)(66946007)(81156014)(66556008)(2906002)(66476007)(5660300002)(26005)(31696002)(4744005)(316002)(16526019)(8676002)(6916009)(107886003)(186003)(2616005)(16576012)(8936002)(52116002)(956004)(478600001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQVWZKTkhXAJrL8kaH9TREkdCL3gB8F/27JfJWIRK+XyZI8aARs9JcAvmj5RC+fb5NfTUIBh5ek2cfR0BqyOZF1S7Dhi4oTz4IdP77+YdfMjbwX1lZBjZeNcmpVjQ0YzSxHdTWNVLwskE6N7fAsJfd+6bcsMiso9Vrfgxp+4NilXbprseEV64WJiFdnb/581KV1oLqrlLCbEfgUhLRuTJfmH+3lMWB6IN+EJRZuSFp12hisHqIxW0+GSesmTjb5SdCVWEjXnnsV1qtUP+scY9H8eoVKU5WSVi1y7Zk/SqwvlilcQYnVP34/UDCQ/t+4yWH+UwnsjtX6xLkZ23JoQ7g3p/P9nN4/lmHus27KD1PHxR731/yZeUB7NVGTfvDIcj5yyVhPDnKfsJlVyi82HGOZgJaTXqJWRiqOTPx96hDBcTcjStrTGAZRleEUL0R4T
X-MS-Exchange-AntiSpam-MessageData: D1fFa8546xw65dxFBQlncFP/WzzsMdi03mrrL3b2tdRy0iQF49Sx8q2wdtFytqhgYMQdj3A9VkI3AfbZduPzJ14aEY1CPTdPh0zEyyx0yz+Ejh9cw69pkmKQYQ6iEKUKGoX+d3TH2SjwSQx+HYtZNNRXrdii/hWhoz+TDBgcOtdg2i2MpUD73/guJZ3/scrb/z5thQhVJspzRIBgwwbzUr1NsspIJRhHl1FHNLW0clLwHrwgAjJtmLlThTc2qz0y0wgB0tf8SZWX3z9ogg1EFUbuKt9ljhGfIzzm32Z/toOZsPI4dFtK3ZIpPJaye+Sf0VPBezhV8Qv9GL7rRckszpQwrUfq0hmDecJqTrATO+WKxHhfADiL9Bq+v+piT33EQ3K3WmbXn3jSoIrncylj38UHYszkHIAM5/dfrwvzAYW/LsW8sLMYNNQ3IA3RKKEdtBEE09fXaO/Qw+y8CeYD+x88y8UhxSAo5TgosbIGlNEv8eZVp30G9H375sDJmdzJGtkYZRCEWUKHxKUqMxKclan7c4o8qgR7aZ7Swe3yAmUAP2l9uSJQY8LdvrnOJGAkB8QOs1GAwf8v64HkfiMznqPO+y2g9GiB84D9sUDl1BKAeyXyLAatX1d9F04xlzRriAKiaF4bojJanbIlOk2zNgo0M9E0N287sxvd+7nO2cmJ+ziBYY3QBwqLoiTvRRop336TT1beK/Uuz8a2wvq6js4Y+cQ8wk+CMj65WtJ7TLH1qwWPExgYAturJErN6AThY+FVSzP0mf9Jm+elVLc0qKaJrX7KvS5xk0EWnrQcuw4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9e48a7-b000-43cc-85a8-08d7eab4e705
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:11:38.8619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqhoDeb2br87Di+nRczuWe8z0TpgeTyNWuECRHX5D2S1HKZ8x0hzZR3E3UlUSgpHZc6UeaKejKU0KAzN3jyHBeW7/86o8TRnBhb9rSfbh0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5509
Received-SPF: pass client-ip=40.107.6.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:11:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.6.115
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 19:04, Stefan Hajnoczi wrote:
> On Wed, Apr 08, 2020 at 12:30:46PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> We are going to use bdrv_co_pwritev_part and bdrv_co_preadv_part in
>> bdrv_rw_co_entry, so move it down.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c | 361 +++++++++++++++++++++++++++--------------------------
>>   1 file changed, 181 insertions(+), 180 deletions(-)
> 
> Note to other reviewers: Comment formatting was changed to conform to
> coding style and function order was changed.  Otherwise the code is
> unmodified.

I think, I'll put it directly to commit message, hope you don't mind.

> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 


-- 
Best regards,
Vladimir

