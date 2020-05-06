Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA27FC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E3C206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kHrJXbwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E3C206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDI0-0002yn-M2
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDHQ-0002UY-2K; Wed, 06 May 2020 02:11:40 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com
 ([40.107.1.121]:19435 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDHP-0003H1-BI; Wed, 06 May 2020 02:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch6eWNMuqH9ox7ALUaxJAb0ccz5ah5Xqt2nAVdqMXXUd//qQIJdZST3Pv1UB9qY7/37DzRwUO82yl63QJ0lzILjsq0j2zCPGQsC/A0pyILfZqjfJ8U1+CiHIABphsnSae5al72YdbhRC2xMMPBRH7YnSPHWo5ywbMtrnp9LcweXl7tytLen2jPSExvEhTshx1Djf1VE/Da1C9Qn+A0qXUXuqlHivo7LLxoXGfA9uwdFd0UwVdV6V7kh2roSMQ+9m7wVWpOuG0WQdLXmGt4Unh50hkKq8UsGjmYSWrfV18FdXLSazgziomZ/Z2vXwT/iKj2hqWDF9TX3e8fSPCJ1fiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez8rjGF9oFnUE8iTYGIqDHHxGi82IupilXrHANIpwmI=;
 b=f7wYw7+AB298S7Y8LmH6IDgKq7N5XfLgKLDEwYbpcTY3RuQENMNLjZXMq8L9Bh1z2DflTUBMKwAeFyFwc5gIHVD9HgcMfDaRHq0jStrRTSFT6+YirHk7UxDINAdcnZVanqHbJv5so7BMUz3iKKeMKylqX1XqwAj1iai20bWvybo5UK/9JAEdP7KJrlH+i2ZPzFfGvAH2T0Q/YirwMTTP7WbCxUoWCzCfQs++IMjNfs2aEg5Ezwjhr7H1WsuQtqMdpHBC1koKM/QSMMzHJIKVeTxAP8m3RIIJ1TTV1m9d6NqQETftPuQEEkqevU+H8mvyXId3Yd0hGhOvfyJtGUlh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez8rjGF9oFnUE8iTYGIqDHHxGi82IupilXrHANIpwmI=;
 b=kHrJXbwZsdIIBj+LVIfTL6q3Kmf6GkPaBzNxxv5VwP7kyCXBjB4ML2hVBLD1ZE6OpArUp25RhOj4IH9TA/wnk9rm0T6uZwvibL9t6zmGgJyhus02UQ9erZ/0IgWFMw7EtCiGEi6RJKWem8f66qGBKqENWL/7xXkq+q29IPyqS+w=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 6 May
 2020 06:11:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 06:11:35 +0000
Subject: Re: [PATCH 0/8] iotests skipping
To: Kevin Wolf <kwolf@redhat.com>
References: <20200430124713.3067-1-vsementsov@virtuozzo.com>
 <20200504163215.GG6129@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506091133969
Message-ID: <cb05d45d-d15e-8d47-2fe7-db442892319f@virtuozzo.com>
Date: Wed, 6 May 2020 09:11:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200504163215.GG6129@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 06:11:34 +0000
X-Tagtoolbar-Keys: D20200506091133969
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 518f6e84-d032-4778-03c6-08d7f1845482
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495D610E3A0AC6BC8F7D64AC1A40@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vRTNpJpJ6cKXBzh9KvfwWLg3ZVCI0+w9VewVgw0hZ7zElbladPHoHQLCwhmGqkTO3i2FQk8Mfb0PZz1yrJTbvzfxmWPuT+kcLVuKq3Qna4UcXhVe0zrV1J0uPAY4ZmX1Lx7ZaAGwR91i8TyiqKZPxnDmC0Z2UApUbKhV9boZfHjmS/OBaW05OT3m1sY7EwUZbZZknq1f3AkV3pi+x43eUDcqgAQCL5xqezos5IYqnaJxzIH67Mogd8Ua9fJG2RbjBqXxPzfw87j+YaBF76UjZ41GHkN1CULNo6ZkZUX2bHkAq6mVtBn3h7iNdjsJEBhXa//yLRNFpY8kLNCWlfI48RaYetQ3hRyohQ4sZQTN/oqt0pYKxX+UTkwWHz3J2Pn0vXWiwQk7QXdsIzdQRylC1ngce3KB6m3x3E8Sp2KWPWNQbaODjU5VB5U8GYAvaTGSeP/DJ+ooYqwg7Gbto1f0KX6YvU77t72xnJZLKOJRZw7mCX+OMUxBDG3FOGuWdH+yhQK8wyvc3ObnmUo2fzOphHeCxi9tDaDZNq2a7KF0D4H7ZcJ4EQv0RaZzXE8wf61
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(396003)(346002)(376002)(33430700001)(36756003)(8676002)(86362001)(31696002)(6486002)(52116002)(26005)(186003)(16576012)(31686004)(316002)(8936002)(33440700001)(2616005)(956004)(16526019)(6916009)(5660300002)(4744005)(66476007)(66556008)(66946007)(478600001)(4326008)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XeKZKqt4Fme1WnxZF8rlKQVAd79nXAPcQQIlIjj7VpLJWFqG5gMU4/7QdP/oZrtEHAhjH5XlbumtPVeFDUodxHCSfETUUh89BUckN8FjZa7rcN8GGJAG3yOQtAQULH4yAlYZHRzfsmH8piPi08nf4WgnzourdWlBdrCC3ySFcgnxs0PR3+ekiiaGXpO/GL1USO0CKM7GyuQBG0B4fwjbsyWcnl7LWJC42z6+h6RnDmfpXl60g+MhPFCcJQgE7LVejILD5TT9vklLpdjNInWYxf6eAJogXRXfInd7/PRtmAP6Oax/+ruybasTh5ahaI6oFYllJ+uKWROYBYnWzCNsEynVOQl7/n+po1tFEYaArcb8SfaCANjXJIp2SjnUmvKTJE/NCGQA3YFa2hz/eT9CyAHTVckKCgWiw7z82SP0+a+uFnvKXIAOm+3mC+2FbCQ86LBQLuxqnaoriqNmwHOkKZoZpdsVXPw5NTSDtH6ERgFkZO7e2oE0CvOLpHFBtsxNvjROG4YAiXyF/VNsvggrp11vkOX4FIgXJBvq/zekccbYqRX6jQ6ATWgKN+Ey5WgxYK8Legcn0y7ZnzEPRtDSoYT0umYmML2d0Talbrp4l+nkVl4rTSB+dr6XCCn9nDnryWBQsJACgULy4hO69AhSWrKC7KZ7ZvOtAxEk8EjYlFwpN9Wap281HpGVNBDYBRB9J15IkcrWCODKu2nQVYO0e4iJ//rhx/eCW/OnmpwuM7rn26lVEQhI2DayxR0BbKKsOr6NPHQ1tBQr3fuCR+pt4ksq9X2anXTN1wKGeIgsYrw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518f6e84-d032-4778-03c6-08d7f1845482
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:11:35.9176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l53PXksWoyqRwCi+V0I3ZblT9OJAOGQr7R2WDe24q/fvfdmEONTsULE+memxWJczj3aNvWCuABw5xcd5W145nkGAALgGAEorPbBbpzRmBAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.1.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:11:36
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.05.2020 19:32, Kevin Wolf wrote:
> Am 30.04.2020 um 14:47 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Hi all!
>>
>> This series adds a bit more support for iotests skipping due to format
>> whitelisting. Not pretend to be something complete. It just lay in its
>> folder I don't know how much time, I forgot to send it.
>>
>> Still, now I've rebased it on master, let's take them, they are useful.
> 
> I agree. They are certainly not complete by any means, but let's just
> take what we already have.
> 
> Thanks, applied to the block branch.
> 

Great! Thank you!


-- 
Best regards,
Vladimir

