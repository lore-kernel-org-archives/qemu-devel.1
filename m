Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA092070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lUdjDZ6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA092070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbjZd-0006U6-Lb
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbjYs-0004pP-2t; Thu, 21 May 2020 07:40:30 -0400
Received: from mail-eopbgr80099.outbound.protection.outlook.com
 ([40.107.8.99]:54266 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbjYp-000059-L9; Thu, 21 May 2020 07:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mARDPpNMOxlg5TIkvtZ7n0BjcOWE9+OgRqF0pdZgk+rhwpDibqudMmdltk3wXfYrlt/EDW/H6Qo5Xrtj8mvwf4aDCgyh5foVP75oDrAqkjAD/e2YilFnQtWjlE/shOM7sWXHPjYfZSsK+T33PPq4s6Dj85fzs4cisyFTI/kgo50MtQqVwng/9afc9jHihJSMbGUKAXPX/8i9DBXhV8yut/poq6o//1gQT4ezmG5DVTMw/A2qGpv7X9Cr8dKTcuweiiPG6h+H03vgTnYUwg+U3DJxyM051XooGKv3pany90kWBtS8q3rlWDU5x2sD8WaMF40vekjVObjI4C2pULf0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN1lOw4OgUM4IkzquiKGInpVhk+U8GbS3vHV0RuQEuM=;
 b=GSam7jInq+FcsZv1tELUTncYz50dt6p8Ms7SrvmYMlIWH+r3+juGAZYV+sN76z+pOG5udeu581gP++dzpFw8S5KjoEJPIgg7tmBnEc+61CoTvU9/f+c5fah/1yt7+sromFyxaXxJu4BQga84s0Lc3gYOng4N8DflQg3w1D09ns0uFJZoKFYRiBoxvmcmlQtI0+MCoO6D0MPS+vEw6Ks98Bp1r7lSEIdtQoHoqgMYDbfAyL8JqYQY9W3VeQHdMp+qzTBbgqStRveu4kJQtbTuYv9mIAsXsVuxeoZyZwzGfDkqn3qof0aNO493ARRFHKzRSxX9rk5ABHaBzBUnav85jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN1lOw4OgUM4IkzquiKGInpVhk+U8GbS3vHV0RuQEuM=;
 b=lUdjDZ6y2MvWViAbSv9IdiChAV63Bdz8o27DjPJrNWk85u00KGdFn/k1oAEJ7yFCmgvtPvoTJJ/2+FJmaBK6/yTLhmf80MPcakRLmRITtY2wHqZoT9esTrGuaq6ZgeYqvGB1bjZtkaG/2U/v8RbRGxvKWjmla5qvmrSIIqLF0DY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Thu, 21 May
 2020 11:40:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 11:40:23 +0000
Subject: Re: [PATCH v5 2/5] qcow2: Expose bitmaps' size during measure
To: Nir Soffer <nsoffer@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-3-eblake@redhat.com>
 <CAMRbyytCZ5KuqPLXkv_kw1Fbgw-w05s0iApmhP69ev_q3VjOnA@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <295f514d-f4c8-551a-d828-77a70b4d6fa3@virtuozzo.com>
Date: Thu, 21 May 2020 14:40:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAMRbyytCZ5KuqPLXkv_kw1Fbgw-w05s0iApmhP69ev_q3VjOnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM0PR07CA0001.eurprd07.prod.outlook.com (2603:10a6:208:ac::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.8 via Frontend Transport; Thu, 21 May 2020 11:40:23 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6a735ae-18b4-4c5b-3709-08d7fd7bbfdb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5446A488E9F270CF3D9957ADC1B70@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlKm55vhl4ii9a7Bk4mfvmCNsSBBpAz0WakGlrDZmL33yrdeqIONZ0V14oK+pL+7hYqIk7CRV4z2KfkPOgbGSw0EMkm51jjttpvxcOeQkfDe2ooPaT3OvZ1fo9hS+aLMecTQ3N1Qhh5afpa0zy/T+vt8jEvQI8+Qh/5UM18QJeeaD4oF8fGFbcqo23WxOfSzpvURj4kDlh/V0xJnn/6ox+GUFzulDjg+4+9gm7fMFRyWN8i/8mF7448rFkjJvfVWqu9g1kYDIr4gWl3hZ5sZTu0cJorM8fQtEvbFy+FCtmAiqIbzHBGaYlITPguI/K94CHH5ZZjDUzlAuzwIBIf+J2vxKf1/lsvjP7z9gooGBKq3O32o93GfcutJfWaLE94eCZVs83ESHVA5Y6e+zM5IGzgtCy+oBwJTgmihAY6rKhsAc2Q453OrIZomJ0W/quzwOjrqbYJ2RQJ05ywobXC/3fFed4cM+H4in5ML/oFiRzmIP9AzkzAfcDy+qnMKkbV6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39850400004)(136003)(346002)(376002)(478600001)(110136005)(66556008)(16576012)(316002)(31696002)(2616005)(66946007)(36756003)(956004)(31686004)(4326008)(8936002)(66476007)(26005)(16526019)(6486002)(186003)(53546011)(86362001)(5660300002)(8676002)(2906002)(54906003)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eMIb1NEuhoXlH9/wtWAfnDC2wAhu+zfQosV7dyMJVnRKGt4gq0w3Z1ENgi2bIfaUXCd5ZzRUaIH68gpAGItPgh2SARc02BoN1didp+zKzrZexQeG9dMGhjzS8qJ38Dwcu73PrQY1HUYha/YgjrlASaMiZBs9+tcAWc0w8yAG/vAOKMCM6NIbCwfZGItNjqK5II3odWNDJoec8JkUj2qiqhHbuze7S9Tnf1T7KrGX1CF3NKJocOiezlCUIr64O/Hiwg/wZ29EjMEaCnTFLadbHWrOyk01DvXYUNcN1IHMQjeDpypgl4rCBKlh0O2mM9eBCYFg2Px6+MmCi/LZbCIeHZTMuxlvYlO7C0gyGJo9pX7kxx0qZG0lBIlksvljpsYnS8FfUGq0gNpoZhoFhX2GdkzZFu36fjr+gucsLkTInDwvP//H3aMc84+0zMmRJrpvsgKIYy4yCZdDlOj/wL+7rIh8QCv0T9Eu1559yrj20iXz1SGB26gWpBHXo1eRiHkt
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a735ae-18b4-4c5b-3709-08d7fd7bbfdb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 11:40:23.8749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/x7MaTvX4wrCinHiLIjnimKl/ywa03xLDNZOnTXnZDNH7eWWdTy4vWME/DuE9gdWl7E7jj1bQTBUb5betPXYjuYmJfPZgtss9Zk6wgF1Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5446
Received-SPF: pass client-ip=40.107.8.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 07:40:24
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.05.2020 02:00, Nir Soffer wrote:
> On Thu, May 21, 2020 at 1:01 AM Eric Blake <eblake@redhat.com> wrote:
>>
>> It's useful to know how much space can be occupied by qcow2 persistent
>> bitmaps, even though such metadata is unrelated to the guest-visible
>> data.  Report this value as an additional QMP field, present when
>> measuring an existing image and output format that both support
>> bitmaps.  Update iotest 178 and 190 to updated output, as well as new
>> coverage in 190 demonstrating non-zero values made possible with the
>> recently-added qemu-img bitmap command.
>>
>> On the command-line side, 'qemu-img measure' gains a new --bitmaps
>> flag.  When present, the bitmap size is rolled into the two existing
>> measures (or errors if either the source image or destination format
>> lacks bitmaps); when absent, there is never an error (for
>> back-compat), but the output will instead include a new line item for
>> bitmaps (which you would have to manually add), with that line being
>> omitted in the same cases where passing --bitmaps would error.
> 
> Supporting 2 ways to measure, one by specifying --bitmaps, and another
> by adding bitmaps key is not a good idea. We really need one way.
> 
> Each one has advantages. adding --bitmaps flag is consistent with
> "qemu-img convert"
> and future extensions that may require  new flag, and adding "bitmaps"
> key is consistent
> with "qmeu-img info", showing bitmaps when they exist.
> 
> Adding a "bitmaps" key has an advantage that we can use it to test if qemu-img
> supports measuring and copying bitmaps (since both features are expected to
> be delivered at the same time). So we can avoid checking --help learn about
> the capabilities.
> 
> I'm ok with both options, can we have only one?

Hi! What are your scenarios? Are you using qemu-img by hand, or it is used from some management tool? For management tool, I'd recommend to use qmp interface, which is a lot more strict, reliable and stable, and documented. You just need to run qemu binary in stopped mode for it.


-- 
Best regards,
Vladimir

