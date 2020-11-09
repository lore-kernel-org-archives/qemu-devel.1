Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC5AC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3284206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tD4a/UF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3284206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8yF-0003vs-QK
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc8xG-0003Fl-SQ; Mon, 09 Nov 2020 10:19:38 -0500
Received: from mail-eopbgr30094.outbound.protection.outlook.com
 ([40.107.3.94]:52990 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc8xD-0001YP-7l; Mon, 09 Nov 2020 10:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da1YYspnJuFza1mRqQmSSv9FsaqE3e5G90dqEV1ewSy/GLw0hHy6AgzJB6oqWTuX02sZ28eJ7jV59EiNWw16bJgCseopOdQUtaTvjaYbKbEOuWLCwxborJeuaWctXBjqf4Noa1rW54vRSw0yiTMNHm8GMZBYK/2OgaXQIWWrbfkJYuN89fwUUpvEWcSrQsHRIxMgH1Mf220zDvpL7GR+sou4gV2z+m5HOtaCl+5T1lIm/oNo5Z4CnIgyzexwf4/A9qTfW3oZOEgpa0/6Gh86PvxTi1K1cnan9TsAtBMgmY81mIeI2U3JxcMRqUhu8R8qQ1pGpS4UpIncEjCiXm/GTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a1UEaBQplOh24M8favTmaGgDMBxb/oUR1CCFfdox1s=;
 b=bVA0xhqmgFcgBtQ8AC9zf76sFBMqpO6xajJf3/Ue0SInM09ElxLxrPbRs9jCfhDdtLMEpkyqKmVsTzamuR94rISNmDCY/7Mlcv9TY1tG9YiWZXE3Jf7+t1C79NRuX804eic+OJWcwFahR52F2O+KRe2RAKHzqbzgn/qAjlcnt2q6DreRkJf75bDgIUdWomK5+exfndU7cTLBosz9sXjwpWFA2fw/jXG8xGNBZ4m0u/is4MSr9prpafPkjkFtrXEHnGYYZpf4imeTpeXZ+l/7hzJ7zJH1BOyw4vYh/APuwBjCu9NnUOGUOimnZur1wUdlmGjVbjEAdPZBnalCNvmfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a1UEaBQplOh24M8favTmaGgDMBxb/oUR1CCFfdox1s=;
 b=tD4a/UF5aW08YN67JOwrrh4UU4p+PaMe0ad4ANUSdPHxV4AtocCmMGQ6hDmGbgP8mkm68A45DuYxjM9q6mCES+as67LXJ9k6Qt5hcBUmZFpMnx83fSCBcDK/IbP9SHgNedgaZreQi/29picybS9UQIhjWzIdJZLoExbe97454BA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 15:19:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 15:19:25 +0000
Subject: Re: [PATCH v2 0/7] block: permission update fix & refactor
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, berto@igalia.com, den@openvz.org
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
 <cdf7dea8-67d1-b0e1-b8f0-8e6333f586c7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <631680d8-6f3b-941d-8d32-683b1290a059@virtuozzo.com>
Date: Mon, 9 Nov 2020 18:19:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <cdf7dea8-67d1-b0e1-b8f0-8e6333f586c7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM8P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM8P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 15:19:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bffcc5cd-d5f2-43d6-3f28-08d884c2d7b8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544832331A26BE7D76ACF272C1EA0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFx+fk3St9uH2ZDlnxKFoKhOJUL7bhGpvvQUAYhlNaLrxJzwsiNwBVUtVsWpywkSf4clqWAt7aSvfxWLOuUHpiGKrQFCam6vDY9L6CiR3IOtMyPxoZzup58WpI3V8JsZlovDzbTrjMhVb1X5PCemm9LhvZ5Z4NdOi/rQPG33obawQkuGZ2ow8EFzjG6izSTbTq4CPa+49CsccOVn6PI7oADlvHKT23QsPcB/Dl/ye9E4Fw6yjPm+YqsSL+m8bBc5MfBSF5YB00r+BAwuC8cNEMNoRfsiqi6AwNhn5AFWhUCawqUX4Ox3a/YTnoVVANmbOvFm3sr4agxvvU8ui1mrG2/SFSmhR16/ECmVoos1Ji65BxJBk4A4ryBHE0nO4c60TsTmEzGdAm9Hsnu6n73KjfA4LT2vIPGNzEpKytqQnGjrqY6jEKEu1bc6hXRJ8/lgWUyMCPCu74vaPxVA+2ia4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39840400004)(346002)(366004)(376002)(107886003)(16576012)(31686004)(316002)(6486002)(15650500001)(36756003)(16526019)(186003)(2906002)(83380400001)(4326008)(478600001)(66556008)(66946007)(66476007)(5660300002)(2616005)(956004)(966005)(26005)(52116002)(53546011)(8936002)(86362001)(8676002)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hggSIpyi03AcovQLHwOqs1G8emqncKQ1UpM38zryoO7+d7UNwHZnseS6JIxwe2b9ZDhL5QoWOGYVXYkx5GuM6U3o9dNQUXEG9h3QU1PfL5nbcEyAztOovXSjEhtY0OSNcytBdvplcb2qOPDRmvfibSYfWjtXrkyrNExFoTTZI6aBKSk/b8Z8JX8BEdK8soR2Fc7Gghrzr2nrKw5vXls119DjjR289FfFC2C7E8T+3JxRMTQMwRR0tpaJK4bWiHfpWmdd8p02ejxqQ6tAv+ls8yEUyO5/kXyfrxdLi8Zwh8cJKaC9DR8wVjOS2p895T3vQU0iCh/Uh8PAGOJKIrJCN4sIckwkeUWGbrRx73kyj2MnnP45FqvU7DLNCOf8tg8s0i32ydVp9PUy2h8Pi06CrxjKxyIDglmULKr1imlPdDOAnNC5GzpDbBinYiYm4feasurG9Z3T2ySVtBpjoI6P0jocwcrTFcfKU9Yoy2DDUhNo5pKC2eiyh+mgURMpO34ZlHU25ufkqrfpbhmgFs5j+blA5J8KEKDyn2DvqyBF9eHicQnQtOfcc04JM7YdOk5JxAeCcsycTDY4/xE7rwi+R15WeXK62fPcwh3316u2Xf0idU5UOYA/bGXArzY7hf0FsLMCIVcrE9OjESKu1oOFKw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffcc5cd-d5f2-43d6-3f28-08d884c2d7b8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 15:19:25.4217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3knWeXoomLqjZ+vtFVTvSj8UMXOOsrYtHb+2FAbWe/f7w9h759Hy9kMOjDOrgyQc9jmzlEY3tPDA2B2sgm1IdRE17U5tA/EV3sK8Bodkzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.3.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 10:19:32
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

09.11.2020 17:41, Max Reitz wrote:
> On 06.11.20 13:42, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> These series supersedes "Fix nested permission update" and includes one
>> more fix (patch 01) and more improvements.
>>
>> I think patch 01 is good to have in 5.2, 02 is probably OK for 5.2 and
>> the others are OK for next release. Still all may be taken to 5.2, up to
>> block maintainers.
>>
>> Actually the series is a first part of my work announced in
>> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg08386.html
>> to bring correct order to permission update (topological sort),
>> update permission only on updated graph (and rollback graph changes),
>> get rid of .active fields in block jobs.
>>
>> Supersedes: <20201031123502.4558-1-vsementsov@virtuozzo.com>
>>
>> v2: all new except for 03:, which uses suggestions by Albert and more
>> strict version of bdrv_replace_node.
> 
> Thanks, I took 1 through 3 to my block branch:
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
> 
> and 4 through 7 to my block-next branch (squashing in the fix for 4, and fixing up the resulting conflict in 7):
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next
> 
> Max
> 

Thank you!

-- 
Best regards,
Vladimir

