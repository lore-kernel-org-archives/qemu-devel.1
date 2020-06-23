Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F780C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DB520702
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ANSLwaDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DB520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jng3N-0004Ts-DM
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jng2Y-0003mI-Ff; Tue, 23 Jun 2020 06:20:30 -0400
Received: from mail-eopbgr00109.outbound.protection.outlook.com
 ([40.107.0.109]:21314 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jng2V-0006tQ-JK; Tue, 23 Jun 2020 06:20:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV72uWF41wAAeVHTcRkSVlxJehv1JEnhY2ua5iV1J/qEAIrUnZ5iSPKQXgGgRUHwealQwKz81JN0ch09NkdEvYI99PJxjH8GcEB0Rt6lgyQ8QTB2at9GhkkMG1OmeY8uEz8uLxixSD1jmJMKJTMolf/x4M+6pugRj1LlcHcU2mRustYJiFNNxKhQXO0mE31L1i3ORjSH/wagC9P0F0RITksQ04V/X67ezA5Q3oHwx5kaXytIQxTFccjTUJySPcdUpUyRISJWRvmRksnx4h7hnHv7kCLbYPiFf7GsbUi55qZSxyPYY6JERsiM0rXhkgevWxElaqYvIy2gs5FTshHjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsrZCY7vuMUQlZqLMcFSbpxphQ7mFMqKq2cSpcBXfL0=;
 b=juhVSWUjcLqKUlyOsE0a4lArJ2DnsurNqoeRF34FvWWDv8t0ZYgCwZaCW5IGz757GmJs2NlO3F6KEJdGsC/Vj7UkG1I6i63nLfJxLXDBrjHHJANufFiXlBRvX3tH5Rm+ev6Jp9XNKRDlhYP6Vufje6LTHET+sdmzEh5+/QiHLuLwt57BAtXpUGKYKmZRX+nNQhIyrh529YW3x0HsYy7UucOktL6TghaCVgBd2l15XOXa1AxDjZ7NN4BS31zYus7aBAjox8shQ1RZhpBvTwIa/y8ds0IYKGcpVrLTEDwCGGbV42gvDKXD2MolW3cFcgXPEuBuiVvsWS3A8xTYd42N8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsrZCY7vuMUQlZqLMcFSbpxphQ7mFMqKq2cSpcBXfL0=;
 b=ANSLwaDWOl5D5w0oBRk7UoCMqhEHQfeWe1ANo0rauZX6xmAiPpKN4WQ/U2DTzd/knka/DISyPfkbMyD9CQv2MMXuxwuswkKbOTe1DYhQ11NxtMioyDLMOr0iE77BNqdYHE66McIduTPvbL4I9tSDQH7tImpxz+yy+L+Cx+Dks3Q=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3158.eurprd08.prod.outlook.com (2603:10a6:209:44::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 23 Jun
 2020 10:20:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Tue, 23 Jun 2020
 10:20:14 +0000
Subject: Re: [PATCH v3 05/17] block/io: support int64_t bytes in
 bdrv_co_do_pwrite_zeroes()
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-6-vsementsov@virtuozzo.com>
 <w513686o0gq.fsf@maestria.local.igalia.com>
 <7b5f7192-9a03-da06-1583-039b671c1e81@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <58dd9502-9356-3fa1-e37d-b9ce8b646b3b@virtuozzo.com>
Date: Tue, 23 Jun 2020 13:20:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <7b5f7192-9a03-da06-1583-039b671c1e81@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0091.eurprd02.prod.outlook.com
 (2603:10a6:208:154::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.117) by
 AM0PR02CA0091.eurprd02.prod.outlook.com (2603:10a6:208:154::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Tue, 23 Jun 2020 10:20:12 +0000
X-Originating-IP: [185.215.60.117]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea23b13e-d07d-442a-ecb2-08d8175f047f
X-MS-TrafficTypeDiagnostic: AM6PR08MB3158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3158C3AC0F86D4FB6C5C2499C1940@AM6PR08MB3158.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sESOeuEVea9YKsS8+RHiqSlLDSy7CFojvCzowESQ+wDwW7g8Pv1lROOkrh2bVdRBJaDuZm3sIBKSsEselsF/6ovmEHBJQDFN7ORNKzEcvxWZh6wHaJyuRiAEVK+fbEslf72y36SWFVIBei8/ENknvd7IPiF+X0Kq5EE7vhCIxjLTVadV9Ev7L6BYzRZ6DtDncDDa+mX6EnooNoD1I0ZabBsdjuNGHf5iuk8zAoOoJZNsihhS++f5JFfNqNmljwA2u1LK/cN1thgaa4QKosIv5RFNP0+JiU0BxHSdCZadsBXwIXeFC6pnPSMkNpQnfq8F8f67ajniRWXWUHDamLYzGgyiqLY28hn6r/Pru7QL+EG0ULMpHArmhR05aqFFfxeK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39840400004)(346002)(376002)(316002)(107886003)(16576012)(53546011)(2616005)(956004)(4326008)(16526019)(186003)(110136005)(66476007)(36756003)(6486002)(66946007)(31696002)(66556008)(7416002)(8676002)(8936002)(52116002)(86362001)(83380400001)(26005)(31686004)(2906002)(5660300002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ahnH1KvBiRdrOeJN4GvMoc7wroRQUdX/5s1cNd1wHBGzF0lWkTWONUlZD8aSFzJD9ZFsJOb4/F84L9eWyZ5KWa20VsfsJpZ2wlD3ueKLSWNT8NEUzsWo7L4HZUhnAi8e8wak6PBFGtLcF//pHsvn3/4S/wBt6RyywqlQpuKtCYSb0YAMHnN4L6Js4NV262KiMga2YmcqmUjwt0IrgNg485yufSPnZ3d9Wg7UJGWwFDsD8AG7iUt/X9/TZYF3TcGKMygUAekn4u/QdfO4z6Ri3TehaGWj38QxUYER64Pu4MEPZpL/u3ByMrr2vsZQxlHBfHILCVSKZfL45zVieWZAxlWyBn9M6nmZk9UnMw9Dq5gmFOrrycCY/rVbDaA5xyaTvxyCFx3BHqynYIjtsciEYGZR5TdW1Q8gE44xCny18p4vImkmWdjNYvoaLdA5yVRTU0MccrFasw0xsIq2AS3HCY8RXc4DlwaAI6H8epy1UFZbIpIaN3ZN+K5Atv1OzJw/
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea23b13e-d07d-442a-ecb2-08d8175f047f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 10:20:13.9123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWmDvGwnaBljt+oQkwHifyk/K0VQFXQ4wjvp1lPk3gD3VlT5ibhF60yLX3K8dFKMh1tx2vdcnq3MQn4M7yXJJFsUNgy6cNvKSNcsFXct0uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3158
Received-SPF: pass client-ip=40.107.0.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 06:20:25
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org,
 sheepdog@lists.wpkg.org, pavel.dovgaluk@ispras.ru, dillaman@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com,
 mreitz@redhat.com, den@openvz.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.05.2020 21:34, Eric Blake wrote:
> On 5/11/20 12:17 PM, Alberto Garcia wrote:
>> On Thu 30 Apr 2020 01:10:21 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>>      compute 'int tail' via % 'int alignment' - safe
>>
>>      tail = (offset + bytes) % alignment;
>>
>> both are int64_t, no chance of overflow here?
> 
> Good question - I know several places check that offset+bytes does not overflow, but did not specifically audit if this one does.  Adding an assert() in this function may be easier than trying to prove all callers pass in safe values.
> 

Hm, it's preexisting, as int64_t + int may overflow as well. Strange, but I don't see overflow check neither in blk_check_byte_request nor in bdrv_check_byte_request. Only discard, which recently dropped call of bdrv_check_byte_request() has this check.

I can add a patch for overflow check in blk_check_byte_request and bdrv_check_byte_request.. But what about alignment? There may be requests, for which bytes + offset doesn't overflow, but do overflow after aligning up. Refactor bdrv_pad_request() to return an error if we can't pad request due to overflow?

-- 
Best regards,
Vladimir

