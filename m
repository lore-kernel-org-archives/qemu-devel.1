Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A511C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251B12070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vyQUlq+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251B12070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTJE-0006jW-BN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 11:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsTIJ-0005m3-VL; Mon, 06 Jul 2020 11:44:35 -0400
Received: from mail-eopbgr150128.outbound.protection.outlook.com
 ([40.107.15.128]:35943 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsTIG-0007T3-NG; Mon, 06 Jul 2020 11:44:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNj9Oxe9ZHvucumE4fAmsrUimwiINNgj67B0W6W9wFzdDnILg/He+JryjzUJ6VYXTJEXcuHW4a4O6VsrBfDQghYlb+ihzZOJoSvk6E2AVvG6ATTGaxlTOs4lXOpiW5vsox+Y8EgVC9hSPRDx8qwuiDp+yFfeYfYNHR4vzax8rab1RZ2TQoWbBiGHT/lyN0cxLtjsSKWV7iZH9hH2nVBgUbuuxq5MeLu2Icocbv/1DnvAbBXW8tVsfmEShnJFnTNYRh0jaDydZhwl/Dms1CMBecAxPioz+ELj5/bgUgMGM2tT0BJWFhP/vuf//cCQGT7WQCrh6Z/S+kbKjPu7adVC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4/i1xROj5XLAwppl3oNO/0MeZzSr3/K5bRWesn9CDk=;
 b=Jo6cb6kGAYF+R2E0ghYVWODseYQuu4lMFkrcImsyfW3AddqfGWwsnTkkN/O9359bBGPoBjGFzY6rj2+vX8ESLbNHtabthx5e3t1CY6MuPFnUW4Y9AaHoNJdRIN9r4y+iPxez9Z7ookPPQT5YdkAGhoojasjf+CUX7dXSutG4JwlHCtZjkP5vrIOOeS6q97MdClT3ilBDrZdvMm2tf3vXCOP52pz8cI5oWO/s2cXLi8d8svCxCIJza7z/ueWnfmgyINFlpIhhKayFypl7VQkrPwD6e+ospPlmqqPUMaxZvZKJkVnTWYQPGVeNEkbBlVPuSo7oVGwxcHHUUqwPD+4YRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4/i1xROj5XLAwppl3oNO/0MeZzSr3/K5bRWesn9CDk=;
 b=vyQUlq+OpKFYR7p1QIuRvk4YJDv9psEfOVNsfClPOshjaRFwjENxpI7h3yu92Ca+YRvZB1xbn7B4s6h0gOYglQxkbmO8mjPyUy9Bf+UnKJPGZvtoweJYnoEfJ812pOsc9xxhHCgT+o5PistQI+6S0Fq1DtwxeqC3iwRThhsgXLs=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3287.eurprd08.prod.outlook.com (2603:10a6:209:41::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Mon, 6 Jul
 2020 15:44:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 15:44:28 +0000
Subject: Re: [PATCH v3 26/44] qom: Make functions taking Error ** return bool, 
 not void
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-27-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4659ff39-890b-4739-1d69-a7e19c257774@virtuozzo.com>
Date: Mon, 6 Jul 2020 18:44:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200706080950.403087-27-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.58) by
 AM0PR01CA0166.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Mon, 6 Jul 2020 15:44:28 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd3fe03a-a7df-4ead-5312-08d821c377ed
X-MS-TrafficTypeDiagnostic: AM6PR08MB3287:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3287B34A8DCF5EED8EBE0A0CC1690@AM6PR08MB3287.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jo3C75TUUsqKCRdDuo3LKQzYQLJ17K2oYdEwwUN8yNIHhkXAyjMheJkEFFljG8iVGi+MEdcwnYzoir3kawa5e4kfJz/bmr77sxqEAH4R+1dmijSsMXhsQxKOEbKFZ70fdjzvpzcI7PLgHrlGMCOIMRiZRlptcyS5z6WnPBaXct45/UIkjDSdhw900tuCmNt/fRKnowrsRZzcnbKW94KWtYLlKbR0uIMBg5sIh41QMKjuKIpw2zRmwiPWWr5JpfLDgoGf3lt/4lbXs3sIoMUPnJrNYWIxzkW5EiHeR6Ahq+3c+QHETCMbSotkEz0soTdRBBn/t+jSoHorhDjDH+++5a6Ay+xWFubplL7P73dF4AgbffvVW+gSAx/9HM8fEWFU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(346002)(376002)(136003)(396003)(316002)(16576012)(31686004)(8676002)(66946007)(66476007)(66556008)(478600001)(52116002)(4326008)(4744005)(36756003)(6486002)(5660300002)(31696002)(26005)(86362001)(8936002)(2906002)(956004)(186003)(2616005)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kTMmimCS7KOg1uGNU7IotSHJRRAR8Z3lpmAN2lBqxAz+tyEvGOvOCmGJskVhCRklnihkFh6zw+estcotIxGeKXSR/RVbLQ0YUU+YCkZ5i9rwpzjcwozzg00/T1VuM/GqWVqBTj117k1eNWLs3LqiWWUeCKYGTV55A5slndfgFzxijve9g8EGWJ2aoHrsnImUTKKyK/lApwSzvUH5MGF7oRg2yKUhudi8ajycUAgFw3srSG7iUsKHyG8JlA+0rJlZ6J5wmw0rGBa+dpUgbwdHLnr99T5rmEWsoVl2WEm9Df9KLwutotyJu6b3ahf48z8o6D4E+It+1iWj+gHOY9VCYaDvueys6ub1q9NzsZ37/MsfAGqvH3psRteIiuSgHEcXEzfCE69BQ1YNShpsP99mDG/kkbTIatejsHYAcpGa9Sss4jZFYOLovtwPN7YqwPy9AIgq1Ac9pzfQ2MPb/zyhcGRbumoc0VF1y0qWV0m2ARE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3fe03a-a7df-4ead-5312-08d821c377ed
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 15:44:28.8411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWcrjjRT+gVbzo1ixU292Mbx+Mvc8tF5JTZuSPb2gAPbkVmpUW7FjFpuMnmXp8bPFkMHmId9iTDgawPAaygkFhnkyLHaAWm39ePhQ58TT/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3287
Received-SPF: pass client-ip=40.107.15.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 11:44:30
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
> See recent commit "error: Document Error API usage rules" for
> rationale.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

