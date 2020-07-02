Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0B7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3BB2075D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vTjozl7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3BB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwnR-0000uv-FL
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqwmZ-00007b-Us; Thu, 02 Jul 2020 06:49:31 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com
 ([40.107.6.111]:4480 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqwmX-0000Nh-7T; Thu, 02 Jul 2020 06:49:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzsEkap34EK/7pLRmAfZcmQnJo9RZyhd+YC9/G+CJICrJPDpZfomYMASenRt5EmKbMEVYf72zOyUtbP26+S19o75tp2u/GVjfAK1/CS1o7DsnH1xCh9zu024qWM+3VO7veFhpfVPjbxazt5ydtGeV5n5Tvq4GSd4fzhTPiHgOaEH5VoAQfNLOj5MpDO0bbOq3xnC0LXkynst37xy1gq/cD8hWLvxCHW9geAQkvgJhpY3SfEMob2RsQS/DftmkOyPzlSvKBWbfkC62UicXZ5M5xV+b4BiRKdy2ASmUHt0CjwsU/pZ1fHXpCmTpWW3PCTUkmA92stocCkVFT/NO5cGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knIuqIX45BPTlNQRJPcmW0Kj4R/iZNHKvqrGmixvxEc=;
 b=Lfzux+iGAVldHlB2H9noY5gunzFBiFAyjaC7PWRU8U+itlu9ImnT3LHZyQ1koTumG0F9aezXkW4PLO2lf8k4lIlH8CWQ1uC6y9K0/8Z1JaXXYO4Zxt7GT2kgxixllpt9asdN3MXppLWBWpNY1WgI253A+fuDc674BqixniSqYKQvm+bjEayZplSAFMBXfNeM3nC+gczQzuqOBnDX4mHB7c5bm5AixrUocJUFr/oqdEUnaPCDPFbd4KadQzMtuKj+rYvHDPUSGU5P4D3FBr0/LbNpQh6KbUz1kmDuR7Huj7Jm9X9iSe2B1hOJ2bctWlSjcWPfaR06M85/oH1BXqVySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knIuqIX45BPTlNQRJPcmW0Kj4R/iZNHKvqrGmixvxEc=;
 b=vTjozl7CcKMlVSlvuzUqPdw8yHtPhuEgb6A/qoghC8v9ky2P5DXYMXY64rdzn7/kQLyfn95st5TwjDt8YDB69I9Ba7FyoAMTTj+8y+rtGmOho64JF99hWzhMbaooiKewIHIsyD+jGYCFYkBVYhBYlulHVitKUlnsZVr01MVUNH8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4788.eurprd08.prod.outlook.com (2603:10a6:20b:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 10:49:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 10:49:25 +0000
Subject: Re: [PATCH 2/4] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-3-mreitz@redhat.com>
 <635e40aa-f289-da2f-274f-17c9d0e05003@virtuozzo.com>
 <02586cc8-138c-2bc8-c79a-cf3371a5afd4@redhat.com>
 <72cc50dd-d204-0de4-21cc-11d4d78f7c47@virtuozzo.com>
 <889082d7-c917-ba7c-6da3-e854d8c44a32@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5171e8a2-0cf0-d8db-4dd1-0138fe2b15f5@virtuozzo.com>
Date: Thu, 2 Jul 2020 13:49:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <889082d7-c917-ba7c-6da3-e854d8c44a32@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0022.eurprd03.prod.outlook.com
 (2603:10a6:205:2::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.54) by
 AM4PR0302CA0022.eurprd03.prod.outlook.com (2603:10a6:205:2::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend
 Transport; Thu, 2 Jul 2020 10:49:24 +0000
X-Originating-IP: [185.215.60.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb06763f-6eff-44c8-2424-08d81e75962c
X-MS-TrafficTypeDiagnostic: AM6PR08MB4788:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4788B34B1758BA63D4B98FEDC16D0@AM6PR08MB4788.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEsXGZhZbfmQDzZRmttGHP9afL7BuBO0fyxMZwlspjvTrwpTv9pEspXC33KVXFt79in9/HP763MoXwreJgpvNIgep41swjYdPDgs53c1jKTXCwyTtArcOHwLuRqpUsykS2tGZMLfhxFUK9mtENauMwmEFVNm5do7cIH2pCypXgj3BuT1+tzEswYJXs3NAx9yDPSZqULHbn1maFvBZY1FZO4ZB2yuaZOWzbk2BwedFF+4WlO51BTmYrKqXJ2+ggAFcu3zDo1nCA9441aqeA89IaLixERrjbq+lOEDarB0k72/W8drDllYViNpkL45L9vygnD9heEmMNJTpKeI38G6sSePn4KMrl+6FBo72lnCyuCsfQcClfu9kDyTSi7p3OFZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39840400004)(376002)(136003)(396003)(66476007)(66556008)(186003)(316002)(66946007)(16576012)(2906002)(86362001)(478600001)(36756003)(31686004)(8676002)(8936002)(5660300002)(16526019)(6486002)(54906003)(4326008)(26005)(31696002)(52116002)(956004)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3fX2zRXpKF84k3lQkhv3qOqG21W8KUEiyEG6Y7c3V0lPrQXzeL6Pw+Xwux9Iq4qD1LmhSRSMDncFtSPhZ+32ZtpV5KSfxIV/yHe4VV6YfeW+r+W8h+oUwvCOQ1t/T6TzA4xNeTdvNuuIT6639LYnjhdPDbmtcmSAwPm5HvPbYOKZlaiGA45nyOUh8yV51sHTUmNZS7VhnPjf/GXYfE+wRYvElmFQ6fwAXck6G7afLlhonlgomg3R4o8De0IWO/87RyDfkcEQgFRncX7SK6osGQKP3eNR4GU2izVYsm6vNsojsLYFl1LbKbadLi8tjPQz9rPG2Xc61RM6uP376BIxUnlcKuAZE845yKsKDVgDlTREYI2aviKI/UtIDZl85Ji1DC/2+wTH32jFlvqLYHGAj78MwuM62/7tGb0I8yWFn5LSJ6An+5pbTOVItWo10jYJRWJlwRBRXNlTME6sB3f1PVp7T9QsWKWOdw6xOj/5AMw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb06763f-6eff-44c8-2424-08d81e75962c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 10:49:25.3860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPjcYCq8DwvACuiLjjmvzMSdByogf5oX9htQ1UEwP/8+PlVmIfQI5zutqd76ExHOpRKEtzv7U/tj7zO+xX4LUph3becjUfVEj/NX9PIuVuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4788
Received-SPF: pass client-ip=40.107.6.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 06:49:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 12:41, Max Reitz wrote:
>>> I don’t know if doing it differently would actually be beneficial for
>>> anyone, but OTOH naively it seems like a more invasive code change.
>>>
>> I don't see real benefits, we can go either way, so, not worth rewriting
>> the patch.
>>
>> ===
>>
>> I feel like a stupid reviewer:)
> Huh?  If anything, a stupid review on a design-changing patch would be a
> plain “R-b” without having actually considered the impact.  You do
> consider the impact and question it in all places.
> 
> I don’t think I need to mention this, but that’s a very good and
> important thing to do, because it forces me to reason why we’d want this
> or that design.  Without being questioned, I wouldn’t have to reason
> about that.  (Which may be a problem in our patch workflow – authors
> don’t need to reason unless questioned.[1])
> 
> Sorry if I gave the impression of dismissing your comments.  It should
> be my burden to reason why I took certain design decisions.

No problem. I should better describe reasons for my suggestions as well, or
if I have no one, mark it as "thinking-out-loud" instead of recommended change.

-- 
Best regards,
Vladimir

