Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CCBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5327520671
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t+damD9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5327520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYwdK-0004Ma-9w
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYwcG-0003db-6h; Wed, 13 May 2020 15:00:28 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com
 ([40.107.6.111]:28384 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYwcD-0002vC-PB; Wed, 13 May 2020 15:00:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky4mlCHGBfpzCZwpSDnEoTKaekba3Yc61mihWyfq36JKM6so69c1bPRjoMfxHgKfQX38ZEOuC9pKRpN6EmUmf+yb3D3BLyN0+CCpyTMEz52a3IEEYkCC7ZDjlfK9BG2wyJakeDVbHCycidiB6mvy9Y1I3YWEfvpmsy4Kw+y8SipgqlZApNGT2to9IfjwekshTnMEanlp4UIhjPspZMbiTvItlFOKd+O1mnCKKYr1RJGkvEeFcXylTWlWF2LiHSTY/W94BpPmPr+fDFlVKhzP0DJ3scY+gKjFXZkkkSA4cXsLb2ClNMMWnp6TuXMOcKVxWXqPG438AkfwPba+L17Vrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTVOApGxsymLaIWfH6A1aiGFN1LFy+JrHNstSfuxTXs=;
 b=kv2/i+/SAc/58a9ekc4h+ZZGNenBlR0h90ZxBrCKFHiWfXi0v81jkWdYXe4q9YRugRoD2gD8E1QJylxHhHAK5av5Xe09Byv0foRhGWm0gqcZYwaVGd5Iu4Dv1+kXiMfxGOeVUoe2tA/a/YK7u0SHZ/n+qTU8HpN54vLPHhdmu8UVTazKD4FrQAAoaoapBqW763S1zj5bmVSRNuEABLHmS4pz9eBgpA8wD0NA46i/YK49dKlXI7sj2a8Qye2B+Y2tDMldZc9dIwoSc3VpPDhz0MKww4EJInCg9mRqqF5CU+Pw/la8qZM9rI/fbjJsNMEL8GhIauHz399gJ4NAH1HZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTVOApGxsymLaIWfH6A1aiGFN1LFy+JrHNstSfuxTXs=;
 b=t+damD9fpq1vjlqzpQd0W2jekPYD7FixGAiJ8q1lXVITLCYqbvzBVXjL3ushcYeb7OQW1WtzRVp2i/VjwPZmDmsF2CbZxfB3gEe1y0h4RqcfXEnP8ygfrcPQipNYGl2zsevTqcwboISfn2sEoAC46vmAOAfyL6Vm9FwaVPuf8T4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 13 May
 2020 19:00:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 19:00:20 +0000
Subject: Re: [PATCH] bitmaps: Add myself as maintainer
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513141407.185198-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <84a44a11-c11b-d9ce-67eb-7e3b5af64c5a@virtuozzo.com>
Date: Wed, 13 May 2020 22:00:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513141407.185198-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0097.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.179) by
 AM0PR01CA0097.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Wed, 13 May 2020 19:00:19 +0000
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7317f07c-c8e9-4a00-6685-08d7f76fe1f5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-Microsoft-Antispam-PRVS: <AM7PR08MB543086F60CDF77407CAD7242C1BF0@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBHBhE/AGQPRPYNqedIPZR+ltPv6shR1CIFteu9KMs3EZ9Ww3aN5w3zHnqdECGQTtiPlgmQNjYU8eiewIJ/4cZ5pzM1R90a7emrVflDm4fy4+qRLJ+AYPPhWq7VTuRBbdV9Jjo/N5XWOgqRmvnw7ucPl8tcY85Ij2jTirXQoNLsYOvLyh2uQnZxoeTTG5gStW9LTfnpfpES8swY5RkyaW0B4YpYck6/mI4ULIISNUqj8gU052OaMkYXhKUx55bosBvJYDJ8+GIUh2KdGaQNv5enYsfQGK0skTRoSt9e3m2JhNO47i6CU9ZG2cJranFur+tfu2bBJqBN4/cT+wuFfkOedz4d02N2rQ+16IlxD0b0i4y8i7WJdmHlwYb71Cpf8xwHVx9j47fvYJ1NlwbQkIwqTMQtg7bxJ64L/jGs9hfRqR4+GUVSGCkpYDYZ8tzxhniGKnxOpGQbbiai1DnVsxdPI8e/bh6mnSQqpuD1I7ocbtlZGX9aIRcb9tA6Ypg4CRk0cfIDxQGTL99Q3P085s9zLUlgJKzKZs93dwj6jeRdcLyGRH7/Oc/BTEH5cj6RsXPZB1xvvB1aGpuI62GluDZfwTy0s4udBAERF63vCjrnEq90cev7tnq+Sa//fwjX3X4azBXUzv+UxyIQLh3iVJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(136003)(346002)(376002)(33430700001)(66946007)(33440700001)(66476007)(31696002)(956004)(86362001)(2906002)(2616005)(31686004)(6486002)(66556008)(8936002)(186003)(5660300002)(8676002)(316002)(16576012)(36756003)(52116002)(4326008)(16526019)(26005)(966005)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xwBSRhUs65LWYyjYW2AxVwvbFz5FKgzYxutjVCMFGS2Q6YCXL5rlmH324vYOYEnsGxe3Yo77v5Cyah/KO1uOAi3RorjeahPf1h8TeMxC2XzouLUkyKBmGeuLomHRlhWrFvRn/FX5UyvSU/Joqjg0ges+QAQ6tavX4+lnynuYAetEA7Vqbyh/FKq4aZDcK1MY8SQopN2pz/DCDs76utfiK9GPolvkrUo63bsGKT7UWyq5rpgYXzFLfKAZhABIKWT5zYjchRG7S87xqRRDjJWxbrIXJCxFJYtWT+uW0GajciCzSSDQqkta7ml6zHm2UBbI7wc9lzYcJjHCYiaJxVaFdjuWy9zFDf03P2R73lPO8x5Y2gFTvvX7XLc3j/kdX3wfHEf+/B1eGHJ15Ae/7YyCjtfX/xRcSHL8kwVWbj6m4k+zmljb+SvxlhnA6sTBcJso3zUea0umqiV4W+vSyzUEtt8083BGfR+1iz6CCV7GiREaUhu9W1GK5olO809/hE7x
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7317f07c-c8e9-4a00-6685-08d7f76fe1f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 19:00:20.2363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ItIQV0cg/0mgbdUdHAQ2Deef+eJqZ9WpJgzQ/7ePvuGLqxm5WgT2jDckd9jZtLzPbNo61q7luGPLV2s0hyKEBq3tZqpoLQOmTkBkm8j+6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.6.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 15:00:21
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 17:14, Eric Blake wrote:
> Dirty bitmaps are important to incremental backups, including exposure
> over NBD where I'm already maintainer.  Also, I'm aware that lately I
> have been doing as much code/review on bitmaps as John Snow, who is
> hoping to scale back on this front.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Hope you'll review and pull my bitmap-migration series :))

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> 
> ---
> This still leaves John as maintainer for: IDE, Floppy, and Block Jobs,
> which I did not feel comfortable taking on at this time.
> 
> If this patch makes sense, I'm happy to take on my recent 'qemu-img
> bitmap' series as my first bitmap-related pull request, once it has
> sufficient review.
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6a8dc1e69d42..f7caf7c0cc7f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2002,6 +2002,7 @@ T: git https://repo.or.cz/qemu/armbru.git block-next
> 
>   Dirty Bitmaps
>   M: John Snow <jsnow@redhat.com>
> +M: Eric Blake <eblake@redhat.com>
>   R: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>   L: qemu-block@nongnu.org
>   S: Supported
> 


-- 
Best regards,
Vladimir

