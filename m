Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715ACC4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C62D22255
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VM/5edN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C62D22255
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWFa3-0001GS-Fy
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 05:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWFZ1-0000hN-Mh; Sat, 24 Oct 2020 05:10:15 -0400
Received: from mail-eopbgr80135.outbound.protection.outlook.com
 ([40.107.8.135]:46115 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWFZ0-0007Iv-1y; Sat, 24 Oct 2020 05:10:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbSabHttdplllkFsPsrxvQ0gLI/YwdpQcB1G76J/v0k6Q4YEZ0zQtwGaw+Alsm59f700XaTlyyDlngSkxDA3FR3wUVhzSjT6QudVbs2//0e72ObolAsxsMi5Ogq4uA8q4uF8NLhlhlJujfq2GraLzQ/MKAipnm0jtZJObyaF6ZRKaI+Dmk4htdcAb4wrmOo/2KvDCAl52N/A/ye/HZCTDwzywmeij6sCGGvcTOitIWxV18V63a2KjvoygdNyBdT51vwXsS2MORtxL62QXIyBZzIlAJlCTDiigF/WKZLu9msTSLUm4PvoCprn+RHIqRxRuCsb6kWqUJ6Wj6Uooc2TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmfoubW4c4DvgJ18/3Q++GwU85SleHvhjqH4brxYl4A=;
 b=jUbozKZ49Eq51don9gPK8z8wtGrDtGczOx54SqGzuKXAkSLyXEOivNPlklS9nHJKdIL14SgHXVZhqAjGZo0OMJBIv+7zWudw35QdKKN1QXgVLF1BfQxf6C8QdN7ex7JyEdEKcSsX5gXi2f6Q2OW+0SFF3Awd/WjoAizXqyJ+1kDA8QTMKPW05gXNaDZIXs38Tn74WdE5/p2orcN1ov1HFZw6eQV0+b25GSBGjbnkWxvtZn5FE5JnbviBGFlmkMLClaNsleFpvwblts8FCxGcxPsLP+6GwNwe+xgvZBq0xYJf0GiZYFWdz7Wge1Z+YECnF/z38G68Hy0bT+Rehef3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmfoubW4c4DvgJ18/3Q++GwU85SleHvhjqH4brxYl4A=;
 b=VM/5edN9ldbfVOCUNtR2V2bJHMpxbrZ7AfZnu+AZqrbKjp4ORY6UiQFIduAdRcmB9b5kHrMEnCj1mMQEYwlazqZZvLax7oHi/3vGDpQnMk/Br6ovOGILjg5A/mgIFdRzH7J+UsFaBVKU9IpnPaKB1LU3ld2kbYLUj7XRhDW4FFg=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2419.eurprd08.prod.outlook.com (2603:10a6:203:a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 24 Oct
 2020 09:10:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Sat, 24 Oct 2020
 09:10:10 +0000
Subject: Re: [PATCH v5 02/12] qapi: Make QAPI_LIST_ADD() public
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 rjones@redhat.com, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <19cd4af5-d285-27d3-b9c4-5f74368c51c2@virtuozzo.com>
Date: Sat, 24 Oct 2020 12:10:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201023183652.478921-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM4PR0902CA0007.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM4PR0902CA0007.eurprd09.prod.outlook.com (2603:10a6:200:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Sat, 24 Oct 2020 09:10:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d0b44f4-bf8f-4d0b-796e-08d877fc9bc7
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2419:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2419E44D97A9217640715D11C11B0@AM5PR0802MB2419.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMbClUN/oj2ejRaDtgf3jEFMowwTqJIpBtN/xXmXNNFT0+Boisx07XMa6W93RnpPPnBTVEtPtWIzNiEWcWCfXcvaRbYfgS3YshrNAeM35mDjDAomiMHNFxkyt+MARKTjAv9EBQ43K+mUh7i0MP1uCUlYKlUgqkezTGEATwpZmmHTnCEkTuDeh4O92i2vXzlwGgx36TL9qVcbhBHnDWK+v3de8QnIm+GByqYupFKZ3cZrTzmfDOO+uFqJ5pQeoetvS1aXq15xf+tm6CjEyH1eS++ucDa3QkogCRqxMpM143EB6DkFQebUuSmopgijbs+0NBOkYaEaG/m6SrRF0Fyb5yFbQ+TZHayJeNN/nQ5V5xjEE4GANuzD5K1pIcCuUcAK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39840400004)(4744005)(2616005)(66946007)(956004)(83380400001)(86362001)(66476007)(66556008)(36756003)(5660300002)(6486002)(16576012)(316002)(31696002)(31686004)(478600001)(2906002)(8676002)(54906003)(26005)(16526019)(4326008)(186003)(8936002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rRCNG2zF3ReSVzkxbIH60o9qvpV37lcIMi6EuC9tdwrkJxiikxl8rHm8N1uany5l6Bx1B9dlMy8IIinr4EW2D2Y3gGEeFBjHPPbZoe89mcc7ayR32YHjXB05oNfJUOBIabOKix7LS17Uuk+trEc5nfsM2LYEbgZ3xbDFMjTd7zNrUR6kI77OTp3Wg2zncQ5KuhV/woUMzCuACz6jQXHionk6jUmbzTI6oqNndXCsxsud+zYk7SMCVSUct1BRxZUfKUaCSiPZHQlnb22mNiclJFqI7O02JCJWOu8atYodvegPw67B7wV97mYUX4+SiXiKCa39yCKfvkHVLAE0sJ2r6en+yDdl6ffvtovpsoWTPBsDbxhh82qD1y7i79RwAxaD/5xyhqWoiTwNFRFzqhDlTr1/OwYZ/aX1A/acGS1Qyq5vdmwHvma1ExHYbqLUaclg+pyZO4lC8DZTlee0cHRvucjCsBPxCOXtL+tbfzLqa9rx7IHRz/gxqV1/zx7In5jQK7J59K04a9DmFyTjw3Y8njiCbM0v3+mBTZK+3GeM1qGyP99F5SptGy1h/I/seSGfu6qfYUsQod++Rb9hwL3CQZ1uiGsBHM3iwEBulIqPTJJsukOS9iO7KK2AeMm7o9SK1vT0haFyEHL1adK5EoYpuA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0b44f4-bf8f-4d0b-796e-08d877fc9bc7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2020 09:10:10.2965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl7SN7Efd7d3H4YbBEFGlu/kBKYvPfz9J+/o077OtbF8LdnGZRYPc8czrmhsXO2k0KcdWBqodmznWP3lsb6o6dKpYESnTE3/3E2dwavVJjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2419
Received-SPF: pass client-ip=40.107.8.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 05:10:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_LOW=-0.7,
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

23.10.2020 21:36, Eric Blake wrote:
> We have a useful macro for inserting at the front of any
> QAPI-generated list; move it from block.c to qapi/util.h so more
> places can use it, including one earlier place in block.c.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

