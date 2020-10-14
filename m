Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC61EC43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498B021582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fFQ4IioT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498B021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSics-0002Uq-6t
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSiKi-0000su-7R; Wed, 14 Oct 2020 11:04:53 -0400
Received: from mail-db8eur05on2118.outbound.protection.outlook.com
 ([40.107.20.118]:4792 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSiKe-0001wj-4J; Wed, 14 Oct 2020 11:04:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSZ4I+9A/mU3z9snLzEvUYsK5kQv3Sq1Jjk4G7JOL8KWmWXs63V5Kb2IVaoQ4KeC92TaB+eVVJ5OPt3X0vQG2qR4K9FVHMOC38yxAdPBWoKmalvzk/AKbMVgLZ2qKbCtIagAYspaJMc/Zz2zkNHTPQMs0etc57Mn9B7mEqMRJKt5N2VitEyEGpJ/LyC9DUFOVvzE2brzKzLXt2ytH+NLkQLUjadOKEkLiCvWKOAs71Gkj/cuhs0t8vdxc5OTqImqL9vrYqmbFvweqqimzXB5VYySquSJDLhhEw02JVmOHDKJKZs+gLqgTOa3QqfViDGd4x1tOmpsV6s5dJj753w7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/WbQ6j8/9yoQl+lN6d8/EI4uCtXYHlQhFTscLycn8I=;
 b=kpaaFliZp17WOuMA7mUo7vnsK7V3MItZqJOqVFvF+6c7mH3pGz6CLeXLanZtQtwE7Mzc10cEgxVHPMIcFdhFKEkLrW4e487B44JaRzFfMNzfVKjzU95FOWqmn49T9l7qEvjSyREBX6rSmp3CDRDTMk1ZhsWtMiHhvo16WstD5bDz2I1NGr4yvKIKtrKI+akCm6xW4+ms7xlgLgy3QecA/zOVnME5z+RVkQJgo22fekVeakWEL0/4xLh8mLVr7YF2On/39H9aAJpupcmMIV/fhu7iz1MCNoWm7CjA1NbSt2u3ywkwG6Yn2lHP6zfOMDdC//4WgDn3TmvXHhxAjesAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/WbQ6j8/9yoQl+lN6d8/EI4uCtXYHlQhFTscLycn8I=;
 b=fFQ4IioTFt5iXqDAL8s2vN9jQDGemsB5NqrkeYmZfU5syZLIpmnq204PCrnJkucYVRvKNo3crmFlABBI94lb38ahCjm17btAcfkccvZ8BFystYmvcqjX2RtEHQgMS4uBG7W0W4x6GyVdOmnEJkkI8xduChTnxnBU4l6KEXUWJWs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4536.eurprd08.prod.outlook.com (2603:10a6:20b:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 15:04:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 15:04:42 +0000
Subject: Re: [PATCH v11 06/13] block: modify the comment for BDRV_REQ_PREFETCH
 flag
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <092bf4f6-ef81-872f-4712-016f573f7188@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a8915bc6-9df9-7ff4-90b1-840019b20d96@virtuozzo.com>
Date: Wed, 14 Oct 2020 18:04:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <092bf4f6-ef81-872f-4712-016f573f7188@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 15:04:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 628d4037-8f4a-4160-6271-08d870527ada
X-MS-TrafficTypeDiagnostic: AM6PR08MB4536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB45367AA558E11E328E79C7B5C1050@AM6PR08MB4536.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1UbGxN3xvVBpD7naBKsbOzScAvuZ+VkFu8eYRfbIlfgW/n1zssB7WHxmV4ldLT0BPjxqDrQi1EEB/tRBVAd0mVXIc91HHARW1kI0JVSUaxVcJ1yFCJYaK5F+Mfh7IBBcgjZBUdhQ5Kqbq5/mZT+NvLyBJtelTU505hg1p12s/+LC8xU3eb0Zjm2xeWWmjEj9a39xcsKyb7oEISYIlCPaAlWKH9ESnnLFisCWFm5QjaK+9OD4ZtSSbjpS4HtaGo4Zzm4bHpaJUJ8fhuHYw6M384dOOPpg5llxLwtQsESk5Q5AR6NtUyMgSBm2VJo6ilHggq1G/AEaJ7wNIKVgCc4jL1v/optSXtIBe/KwilDbrANs9xA4lKAvSosSqIsy1Ij
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39840400004)(478600001)(66946007)(107886003)(31696002)(26005)(52116002)(2906002)(4326008)(86362001)(16526019)(83380400001)(2616005)(956004)(186003)(5660300002)(31686004)(110136005)(66476007)(66556008)(316002)(16576012)(53546011)(8676002)(6486002)(36756003)(8936002)(7416002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SlhDmR9mVdU0IhCYaxCqxqHEPlee9oJjlylyH6odCmMmLPtAteGE9JBPspiJTgBWXS/PW/DfvUzOfzqTs4RmfUBuHy9SR2mk1u1qp1cpwNRj77ruVsEtIlK+FLs+6rra+SpEpdfS0hxSTFOWnvVfhNZgBVPR8BroTfK4fkjoy/iNCVPMZFsJqdB5tvs+6q8Hp118P647YUgi0G4ZPY5lsVlePmq2jY/qOy++X72WbpdHJOe8qwEDfzo+dOY4CNYvndDBSJKw4IlNVuEDPCcsUu88xjM/vPRVtrpMZFJLEkMJiHZyus+9rw5AnZKAOCUdmzdO8X04GwjmCv/rCvmXFL56waZ5EYCxoC+KDjfiyid1Ve9nhpzTBEpqkibc4Ej14/oPo1RckkgLD3NAwKFhW1QLucWpcThdrXbtiHS9cKbE5p44vQXVIHusJF0/F7hcDQ/NvLKF/u+uuJm0yC5P9KFxNqS0v9KgNjIGRLSq50szoqt9xjs8mxZSgLgTP2ZTUPAMLwF/Mv0Gl64j89x4oWZpjokBGc6oTCgOa3tF7Ln/LJbFoWF2n3xvXifDM7HSsEpuIu4nmb2D96ib0VK2Q7y/IZbzs6UoxriEXpnLYCTQ95DyX8Wft2/JxLb3Lx3aPHsGq0X/STKTKAdxtVhv/A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628d4037-8f4a-4160-6271-08d870527ada
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 15:04:42.5140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M6nRzkQDAJZW9cIlimhsiR+Galc7xDHmY3NeBatwu1suJJDa6VGgNQuNtJ6/mENia3Y/xnLX7l++VZqGcfQ5FbjEBL7QRto3d1NFf8u7kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4536
Received-SPF: pass client-ip=40.107.20.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 11:04:43
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

14.10.2020 15:22, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> Modify the comment for the flag BDRV_REQ_PREFETCH as we are going to
>> use it alone and pass it to the COR-filter driver for further
>> processing.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   include/block/block.h | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 981ab5b..2b7efd1 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -71,9 +71,10 @@ typedef enum {
>>       BDRV_REQ_NO_FALLBACK        = 0x100,
>>   
>>       /*
>> -     * BDRV_REQ_PREFETCH may be used only together with BDRV_REQ_COPY_ON_READ
>> -     * on read request and means that caller doesn't really need data to be
>> -     * written to qiov parameter which may be NULL.
>> +     * BDRV_REQ_PREFETCH may be used together with the BDRV_REQ_COPY_ON_READ
>> +     * flag or when the COR-filter applied to read operations and means that
> 
> There’s some word missing here, but I’m not sure what it is...  At least
> an “is” before “applied”.  Perhaps something like ”or when a COR filter
> is involved (in read operations)” would be better.
> 
>> +     * caller doesn't really need data to be written to qiov parameter which
> 
> And this “written to” confused me for a second, because we’re reading
> into qiov.  Technically, that means writing into the buffer, but, you know.
> 
> Could we rewrite the whole thing, perhaps?  Something like
> 
> “BDRV_REQ_PREFETCH makes sense only in the context of copy-on-read
> (i.e., together with the BDRV_REQ_COPY_ON_READ flag or when there is a
> COR filter), in which case it signals that the COR operation need not
> read the data into memory (qiov), but only ensure it is copied to the
> top layer (i.e., that COR is done).”
> 

Sounds good

> 
>> +     * may be NULL.
>>        */
>>       BDRV_REQ_PREFETCH  = 0x200,
>>       /* Mask of valid flags */
>>
> 
> 


-- 
Best regards,
Vladimir

