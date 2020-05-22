Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E90C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9312420723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="septvrOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9312420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAEX-0004Lw-NX
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcAD9-0002cu-Pr; Fri, 22 May 2020 12:07:51 -0400
Received: from mail-eopbgr150114.outbound.protection.outlook.com
 ([40.107.15.114]:22661 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcAD7-0004lU-G4; Fri, 22 May 2020 12:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpAzohpZmEesYInmM5lR+6I7eEYcdCBX+lh4TpHRxVODpos/LlAr+ReIGv+jKjO6GCTnKSyhaWy/jypgD5Of+rXGOR9MfMoO00pEVSCcajUqyOCq/7VU54Un7R+gXj3ku0COlu2NbdnyxxcMKwvFsw4vC2bzeX8M9JOIT5NYpL7tIphlPNc/1o0oj1gQIhrSXw3d5vMug55mmCVH7grzBd7d4J1rkfnjT0C1/PCm2OBMPHS+hgEXVysIFcQRUtrippE3Wa+rtqC7ttKpeOamjVYQPXeVJVZvyC8wgEkZo/gu1IAy/BfMYzTO49KVWlrBXK187lnLY/zl8EBtUOWTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXMishnbVu23giIuCoGuXdxXU+41nbaY7GUPLv143H0=;
 b=baflJFKFiYeJAOl0JXTR4B51QdU/pw+A4LLLVJeu6Onn7SfzXcdmnWKu2IiK3YX4HhJQfar8HcVjFDJwwxQmBpE9AH2dzI1m05542h2Vqo7qZGAQ48dW1I5l8V6zUahD+0fBlmtI/SmlvU2sWvY1yZnIEfk/i/2YPQQc1Ow+pAaqdGsPZ38L3Yry4Rx1vtcsDl7/V8wMf8LLdSenKj8c65IlEUmK3Bf8q8ayKXOUOeFU9aZiUZm8vsii2y4mgZkeFETpE2pslZOckHRXJncYOCOsMlAhyX+dMEHv3Roh0w7PK8Z11DO5Sg+svYamiIMz75iP3bgDURV1iBXOkR7k9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXMishnbVu23giIuCoGuXdxXU+41nbaY7GUPLv143H0=;
 b=septvrOwSHSapgyUjg5SxL7ffqoPHwNHnsfZO2rIEb8nwYjb6uyr2eG4xCtA9wtLds6Xw0+0/kPRnKl2i46vWx6EEhbSGLiH/F9QZ6a/iEpaSAn2qG2mM6mjCJ8EBV+p4FpFc4Xu6L8Vh5xTVcLA6czwZ6AKiyR5Wy4tAQLP1r4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2784.eurprd08.prod.outlook.com (2603:10a6:802:25::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 16:07:43 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%6]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 16:07:42 +0000
Subject: Re: [PATCH v4 0/6] fix migration with bitmaps and mirror
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
 <5f7b47b5-5b91-c82b-8057-c78fc7e225a2@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e1b1e8ea-9d29-1d63-8ebf-0d821c9e7e0b@virtuozzo.com>
Date: Fri, 22 May 2020 19:06:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <5f7b47b5-5b91-c82b-8057-c78fc7e225a2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0104.eurprd07.prod.outlook.com
 (2603:10a6:207:7::14) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM3PR07CA0104.eurprd07.prod.outlook.com (2603:10a6:207:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.9 via Frontend Transport; Fri, 22 May 2020 16:07:20 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad1e863b-2587-401e-c476-08d7fe6a355c
X-MS-TrafficTypeDiagnostic: VI1PR08MB2784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2784E28A9055FFB6A36BB361C1B40@VI1PR08MB2784.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrAKcci2pi+hn7h/aAc/FmbGMctcaZ00XmY+SjcaERxTdJHM9iym+BuP/i8xm2yvN7dUoLJrOXJzq3FUZMaH/eZvNu6TnR+eWyQlSNuxxE6A8t8ymKnMyI6I5pdBdQSJb74Zm/Ukg3wppvtjYToWf5/zOSs0EYjgESBKJSG3dTDNgFWBHk3m/ko7dDFmOqP2mCbEjNEaf2DK5MdHr8hU6M64XolH38vqLx8MKipDr8dv81WwuMkT5IJrtIgm+LhG3dx9K/tY1ONErwe7vrZTJHz8p74A3UvCWUyvwVgTzW7mlzSBXU6foBwqZ8Tl5aux7bMPgurTsqBXur2BwspBfVUjV0gYTzeQqj39fcw3BGvbFWDrU9t+mJ1nRCb2tVaY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39840400004)(478600001)(66946007)(36756003)(16576012)(4326008)(8936002)(107886003)(7416002)(6666004)(2906002)(31696002)(316002)(5660300002)(186003)(66556008)(52116002)(8676002)(6486002)(16526019)(26005)(31686004)(956004)(2616005)(66476007)(53546011)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PWlyH00SPHW7HDf5iJFQEWh8RsT4ZKHQv1Fs51gyGTUkGOKchXzXLXyQPHMYNbqHV1FXDKhbOueutkfCWNd0Azff5K22VB2n5bpZwm16UwrP2UltzOG79kp+ftamskDrxvz3P32FBXq8MzKd16dW2UvIRrUEfx8HSs8Rzkfu5nV8DjdnZw1XPLs0Roa/9PPiFY/vN8alSlQa2B5Obh6CT7/1e+/08IYq0GPc3bqixjym4iG9aXWyppSPAFd+WHgsDEIL+UuUetujD9qTzHoozHVXTt9VefaHPHsaMiqWW/QRzS+tebFRU0Z+Fhkd6RQT+W5o4OBHmuq2J+89mIrOMxTciDbOGCzFuC4VH0BrYuxtpZ9kufJkAfx20jnN+ico1Gzhd4YqR7jSN3KlXVixRfTIYD0XG1p+tnm+YKcpCe4i76/mb9SpcPmXdanJ5vsGwlA0OK3N/pV9aTSSXYfsAESFBSSOnmyUmy8c3zc37/9DNZAqk91A2F6rL5T3jVDg
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1e863b-2587-401e-c476-08d7fe6a355c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 16:07:21.3516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlq+kwkVjrSn9/Qwri11C2HOA3iyYzlYFA6E0G3Ot3PhWm9JisksVVb+TfZLe0cK42/jiaJPDcNTNCTT8PX561NxqqnY7E0lTPqtBLgH2pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2784
Received-SPF: pass client-ip=40.107.15.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 12:07:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.05.2020 18:24, Eric Blake wrote:
> On 5/21/20 5:06 PM, Vladimir Sementsov-Ogievskiy wrote:
>> v4: (Max's patch marking filters as filters already in master)
>> 03: careful select child of filter, avoid crash
>> 04: add Eric's r-b
>> 05-06: tweak error message, keep Andrey's r-b, add Eric's r-b
>>
>> Vladimir Sementsov-Ogievskiy (6):
>>    migration/block-dirty-bitmap: refactor init_dirty_bitmap_migration
>>    block/dirty-bitmap: add bdrv_has_named_bitmaps helper
>>    migration/block-dirty-bitmap: fix bitmaps pre-blockdev migration
>>      during mirror job
>>    iotests: 194: test also migration of dirty bitmap
>>    migration/block-dirty-bitmap: add_bitmaps_to_list: check disk name
>>      once
>>    migration/block-dirty-bitmap: forbid migration by generated node-name
> 
> 3 and 5 have rather long subject lines, as shown by the wrapping inserted by git (3 even exceeds 80 columns on its own, even before git adds prefixing).  Should I try to touch this up in my staging queue? For example:
> 
> migration: fix non-blockdev bitmap migration with mirror
> 
> doesn't lose too much information, but is definitely shorter for 3.
> 

No objections, of course

-- 
Best regards,
Vladimir

