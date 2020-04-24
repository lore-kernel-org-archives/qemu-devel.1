Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA159C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B517C20728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SK7qVF0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B517C20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS32T-0003VZ-QJ
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 14:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jS31Q-0002pf-Bx
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jS31P-00076z-Ue
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:25:56 -0400
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com
 ([40.107.21.91]:55905 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jS31M-0006ts-Ar; Fri, 24 Apr 2020 14:25:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oG+yYneae9xBTlPSJxnA50OYuuh3zQdX3UyvIy0DaHnTJ7uDXKaGr6Thn+ViCgTOK2YsjXFcgZMrOTP+/JxDXCvnt6lfYxetGWra6Xjm8xI4FkH/c09kCZHESWOeJV1QZmqxjGjTvfydlcLhrB52PIbuy3o1E3vZ50GqCVq5R4Aut94ozAaQfKfcsL4pQIfk9wMtslEqgcJxMnRIbCFySU1F+bYQBJB5cG6mee4jNAjR70t4tYey8r98Cx5GjTTsOIbDnjE1YEoI7S5fGj3v7/xbQe1SlgKghhwLVGGAwKUTG1PgPxEOcf3NA1a9BlNFf2sdu959ertKeQrA9HkcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1tNUwmb3qNw6h131hIjpQay+oKQkEpm68h4Ahtt9XA=;
 b=h01bC7VUFIZChYwHx5mf2Ln0mLX86v+/W3diITAQglFpbTuzb3vCLPVS6ay/A3381VSdoGITEj+1rPEtpzKv21N3w76lUhSf3XgS0CNgW4iubfWC6QXrF4EtopcUp1hnpJiYYACvK7sVez8Hr/e81IvnZ/DFPzaO3P7lXquKf1CEPLIHSFYIC9rjTVcfbtTgQYJXsVZubEcgyiOAD2oj1o67F1Iz/2TWKVZrnSSS1y/A5nYkr3DsuFXLjnHD85/qPrBXdBaH7UMHml4dZ7dvJn6hRbFp+aSM03Tyd+cWqdclnxCtpFae+JdiHczRHCfIraGSvCietClc4OPQCEoDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1tNUwmb3qNw6h131hIjpQay+oKQkEpm68h4Ahtt9XA=;
 b=SK7qVF0bfoO1u88PBW954MAUAXDNrxNQsJZ+/XLUH+9UENmGK1pYYPHA7ZBr9PD6uWJPb4H2bVUKU+kkXQNkX/pjf2KYLEELHg5tR2pF99iAB4Kzop8pl6x6wZlsl4k6IVH2wiCJm6KJhs0ecV8ogtyAeVe0XG74e11QSaLtfa4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5510.eurprd08.prod.outlook.com (2603:10a6:20b:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 18:25:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 18:25:47 +0000
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
 <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
 <w51o8rgn6j6.fsf@maestria.local.igalia.com>
 <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
 <w51lfmkn4ws.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424212545716
Message-ID: <2ed917cb-edf1-faeb-532b-ad5edb39d293@virtuozzo.com>
Date: Fri, 24 Apr 2020 21:25:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51lfmkn4ws.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0144.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::49) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.181) by
 AM0PR01CA0144.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 18:25:47 +0000
X-Tagtoolbar-Keys: D20200424212545716
X-Originating-IP: [185.215.60.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1c2010-5725-455a-4e3f-08d7e87ce8c0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5510AB490CF46EAA0A9EA242C1D00@AM7PR08MB5510.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(136003)(396003)(346002)(376002)(86362001)(956004)(2616005)(186003)(8676002)(2906002)(31696002)(19627235002)(6486002)(4326008)(66946007)(66556008)(66476007)(107886003)(5660300002)(16576012)(8936002)(81156014)(54906003)(16526019)(52116002)(110136005)(31686004)(36756003)(478600001)(316002)(26005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3caOJPso+pS7ymfIlhkTOtTx++WoJHRgvV5pPl9VAPvnStkaKOvzZ90pahp8Qn1SfsWPYeXr7+gr2cKD4Q3adkFuaCJoPYEBL6fYgz11gh9DP4akNLkRSnwbVhlLCilxoRrtzqr4mSe/0skkrsU03/rttd1a1Hxb9zynQFhDoSWXgT/hwzgn/PcN+NuV76x8suWXgA8fL4HPuuNam8spoZD9OLU99jRHQrvake0paDVq1kHWAQbDNX+aqQ16VvYQsOdWUIYyGCeecndAqQQPp2VcxGWE5H1VaxLOQJWIQIzL9LM0MKB2GuucKGA5OBhLpagCkktKw5Y3rTARD45g3SK/bECM7A+MKb6HpgKa9AdJJMQXej8VFqaAfZvhh3Ax4xTo4+nrLBNbVZZVucXMCX0AhzwkmJ7+jaFmrgRIbscqvXIl4KEm0UrRcLj3OjGU
X-MS-Exchange-AntiSpam-MessageData: 1bqgZOCu2CX0H4O75XBdVuQzRtdv1UXVHLL7FmCCw0G7MDZTYddtUecJrLJyePjR9seg1DvW1rR4kYzAnCbLyTR7vQd7eIGAFUVYOg0RXzceqjssKwAkUANkoipl3TeeIsgMUbC8mHueSNnadCpDgQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1c2010-5725-455a-4e3f-08d7e87ce8c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 18:25:47.6681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIBxk9Q6kv71J33ItBPUf5ZIZ/nxJgMpff+WgFHHV6/Il2CQIoKh+abC25mnyExgPklMHqKoSRWrs1HxdvuimkvpCE249wGn0fjWEXjBFh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5510
Received-SPF: pass client-ip=40.107.21.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 14:25:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.91
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.04.2020 20:56, Alberto Garcia wrote:
> On Fri 24 Apr 2020 07:44:33 PM CEST, Eric Blake <eblake@redhat.com> wrote:
>>>> at the same time, I can see where you're coming from in stating that
>>>> if it makes management of extended L2 easier to allow zero subclusters
>>>> on top of a compressed cluster, then there's no reason to forbid it.
>>>
>>> I'm not sure if it makes it easier. Some operations are definitely going
>>> to be easier but maybe we have to add and handle _ZERO_COMPRESSED in
>>> addition to _ZERO_PLAIN and _ZERO_ALLOC (the same for unallocated
>>> subclusters). Or maybe replace QCow2SubclusterType with something
>>> else. I need to evaluate that.

Reviewing your series it already came in my mind, that we are doing too much with the conversion from l2e flags to "type". Does it worth it? All these ZERO_PLAIN and UNALLOCATED_ALLOC, and "case <TYPE>:" lines combined by three-four into one case, do they help, or is it an extra work? We just have to maintain two views of one model.. But I don't suggest to refactor it in these series :)

>>
>> Reading the entire cluster will be interesting - you'll have to
>> decompress the entire memory, then overwrite the zeroed portions.
> 
> I don't think so, qcow2_get_host_offset() would detect the number of
> contiguous subclusters of the same type at the given offset. In this
> case they would be _ZERO subclusters so there's no need to decompress
> anything, or even read it (it works the same with uncompressed
> clusters).
> 

But if at least one of subclusters to read is not _ZERO, you'll have to decompress the whole cluster, and after decompression rewrite zero-subclusters by zeroes, as Eric says.. Or I lost the thread:)


-- 
Best regards,
Vladimir

