Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203E2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA53208B3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RlmsLmhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA53208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kay1p-0001uB-LQ
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kay0q-0001MV-E4; Fri, 06 Nov 2020 04:26:28 -0500
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com
 ([40.107.21.91]:52193 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kay0n-0003Gl-Lv; Fri, 06 Nov 2020 04:26:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9nwX1DFvmlh8bCGeI6agmksExACv/NpfvtVRZfYSAKA40dS7SFWLsHxlt+zo+9RhHUxm1Cn41CZSxVvPD/tyh58Ngy/p4EzFHZkae2BQyL+msKf+pdhE/KtCOP1pKAvZlYFZD+Dj68SWS+Qs6yBBUhpesjjb1HbJnMKEbXWxNR5a6oTJA4TLdgif0NIHz11PlvqKqTWB+xgAep1g8lqhhyAP8/3jgSzEd6IJ55FArSIGv2bTkoqMuhg4L3U7s4rtAyr2dDwH03yFX117iOYh/Cz56/e/UQxzLEs0730CjOjlL+iVPAH6MRqsEAWkNuvN6eCLIlYaDtBnZvKsW+Clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpXWvJgdlGyt3ZeSQKIIarR0jp573s+GEnJOYDKGn4s=;
 b=Ekm0MZjiicvF1ZR95yM0STc4q0Y9p0zfMyM97xgkhm5pxcKnzJcr2wW2mffFGNCk9NGQ7BJo9FX49bfQXRULSIaZWWhknQbwe0OaEGv0ItjNHFn/UOCKblrgaC0FpCNft4AbkXmJLGgrrOGabcbjAq3RRXHYhuKZ10d4dl4i9/+/c1mrBY2o/eBFncwhcU6xbRoSqqizUfL1ugvXHCKE+JQgOa6/aZK6QzhteIt0t8T2u5kHEaDOJ0nvwLCa2wMKr5BzIQoxo7HJypBRFoWqCHz4rdBNH91jc4s6KLxVASI1p2zlGHg5Aa6Ic7wyCO5ydTls2WCaioPX6ooasQPWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpXWvJgdlGyt3ZeSQKIIarR0jp573s+GEnJOYDKGn4s=;
 b=RlmsLmhTyD0o6G1QLNYeTD0oNhkIXopzSg6vcVUO+cAzmoDsUtpccU+kS+aZBQ1CIrrH04+zYJui87FO8ak9O8elIw1ZX87OiCMaBqGIuJQ1RyEf0pyO0dRUZiGqFm1TF2EWA96TKgCIWSfSoTJU2D379dd2oclLaZGTK6bH7iI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3720.eurprd08.prod.outlook.com (2603:10a6:20b:8f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 09:26:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 09:26:19 +0000
Subject: Re: [PATCH 1/2] block: make bdrv_drop_intermediate() less wrong
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20201031123502.4558-1-vsementsov@virtuozzo.com>
 <20201031123502.4558-2-vsementsov@virtuozzo.com>
 <w514km3j0od.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e494bf92-31d1-fb5f-fa3a-0456b757a2b6@virtuozzo.com>
Date: Fri, 6 Nov 2020 12:26:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <w514km3j0od.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: AM0PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.66) by
 AM0PR08CA0020.eurprd08.prod.outlook.com (2603:10a6:208:d2::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.32 via Frontend Transport; Fri, 6 Nov 2020 09:26:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72b39bab-8d34-4a3c-c9cc-08d882360505
X-MS-TrafficTypeDiagnostic: AM6PR08MB3720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3720E3888DA19004F2CBC5FAC1ED0@AM6PR08MB3720.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nZ8CVB/7emBrvqOjUX6TzEAE9fbrb8tMl4imseDDRhTsEBYJy3JLhRyxeN3xylmOf+yLcNBGCDL6qu60RjOd8BQCKBhVef8cDvQ8lnOatyNWyqBPjrUF5uXNZAucunNDhJMYcxo+r7RC9X1KvaaPZWAg67n1YH9ebqc63IrwEKvYH8Nqyd+1ajBe9mk2SEW2KXbAsae4RXBtgYYqylr62CEQOu+Pw5kz9O3PtIlP71Ohnf35m8XNhInJoluwN9XB1YkkQ55tle0oE7QA3sxBrRfLMtiWchN1Def+5AxM4Jw9LhAXe0FZ1oVv3IezISNrNZFIzPnGIMahdEH4S17EIuTmBkaTOJIoUCNEzUvjjPeC+mb5fPscXj5T4a4d8i0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39840400004)(376002)(136003)(396003)(83380400001)(86362001)(16526019)(478600001)(8676002)(186003)(6486002)(31696002)(31686004)(107886003)(5660300002)(26005)(2906002)(66946007)(4326008)(66476007)(316002)(66556008)(52116002)(16576012)(956004)(8936002)(2616005)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: c1ecX+/fr15Ta57J7ajjH7rsB6Q4qtBTx7gigm7NkYkDj+gzmWY9m1fqN5NJ6TKGUAXAzNmaz18tk3Ijb2MPrBoVTO8XTKdoabHNuXiLI4L6x8okGpiEotQH8PG7KjGFJGz8i3KCrC0g12PFZ1D8CZmQBADf+uSZknnsVKYZs1Y+CeGaImQ5iLFDGgKXFMOHsSohDBMptJnnTc3hH9/tfh6MWY2P3kCx942A4vXDgFeZlTYFW3mf8zZO2rpVUlTZJcs8H5gjWj7WIQvsuqCUF2ErcuD0ZQyTXsBlAb0tDI75P8M2OtR93vnNG2+EXd9+RRtdeBgTZ6RqzlLzNexWlLm88W+dqMplmpTd40RgbanCYupRgYku7UGZMoYicU3d710b1CJA1jKL5B5863gB5Qru2atdfdabk/+ENDOfEVaAnUg2kFogyWzJdM1DJwN9j6cTT/eChyDMZASoc9UQFj2YHetHIRE6MizsygNPP1xsBAeAzrLBJ8mtCkwzwWvPNjSjKoO4X194JT91JZqcKbEBVpuNUs5nyROwFRSagImfwiw7cYol72wy7zXypPhoJRK0JpRyrI0ctJqGg/9Av8Elm+4b6mOm4tVevnON07gqNiH2PSQmSL0Jj/o5KdD8UXzGoPus4lQVA93FT0R2Qg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b39bab-8d34-4a3c-c9cc-08d882360505
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 09:26:19.8678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHWbW0b1Vpe6Cl1Nq7IaFojAG0V4Jy+uanvuo3pWINPsi0EN//RO8JVXuPzU+CWP6MPBSRJhqSM+rSg0j/gHwW9Bt62kdFn+K691gyehM3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3720
Received-SPF: pass client-ip=40.107.21.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 04:26:22
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

05.11.2020 18:14, Alberto Garcia wrote:
> On Sat 31 Oct 2020 01:35:01 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>> -    QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
>    /* ... */
>> +    QLIST_FOREACH_SAFE(c, &base->parents, next_parent, next) {
> 
> I also wonder, is top->parents and base->parents guaranteed to be the
> same list in this case?
> 
> If not you could store the list of top->parents before calling
> bdrv_replace_node() and use it afterwards.
> 
>      QLIST_FOREACH(c, &top->parents, next_parent) {
>          parents = g_slist_prepend(parents, c);
>      }
> 
> Berto
> 

Hmm... We should not touch other parents of base, which it had prior to bdrv_replace_node().

On the other hand, it should be safe to call update_filename for not-updated parents..

And we should keep in mind that bdrv_replace_node may replace not all children. Still, in this
case we must replace all of them. Seems, we need additional argument for bdrv_replace_node()
to fail, if it want's to skip some children replacement.

So, I'm going to resend to add this parameter to bdrv_replace_node() and will use your
suggestion to be stricter on what we update, thanks!


-- 
Best regards,
Vladimir

