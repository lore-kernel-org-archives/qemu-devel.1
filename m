Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADD9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C179F22CBB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="xk0tDahI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C179F22CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHZn-0000MV-Pl
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1kBHYH-0006bc-15; Thu, 27 Aug 2020 09:02:52 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com
 ([40.107.0.105]:56606 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1kBHYD-0001QW-5o; Thu, 27 Aug 2020 09:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRk+OlO++35+kQlFr7MAifUWni+fndnX+ZbN9nuxJ/oQteb/F1Qa66ixlRs8/iUrvMIBSMpcyRPNmrnVLiYT0Qim3VYoahkkcjfI7wyDENfqzDMj4AmA6BJ+ps8z0D5begkPtldR9HrC7askY0blFT65acri0cARokjDsifmwF0WNOTkELb7ODeIiPu/UyxG9NfRejUR61z23TqVlPWOVaORmjO6TOg610Wi1aTVFt/HD7BDren4luaLTu+afx8G4AmsONUUc0O9lFq1VlqMzQs5GYGfaAaOcSPqbr/19eENbUFgwOgRscKh8sl2bguQrYVgsRJZn9f4cAut1dSVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZpOUmLgHSdKAjrZl9PXwzqbPXc54zNEKRdgjL2jdyE=;
 b=VjSklE9s3EM+7GAlkcVKlnstb4nXzy8uxgqgNPcrCWXF+v3yA2B3cNRAGvSW02xyBd4Pgn0SrfmSvCRi/j5eZoKWKKpCdqnP6cWGdR7uec2HkxbXSDdHGuRLmSbgbsP+40iYvaxCac0CpI96sFGMkDQhX7UeNFukDqxKhhC55UfrWKSQSASOkVChdPxawQVnppWj3PmQJeASc1GU5iM44f4CR5FyI9xzRE1rn0KPRt2iV7qhUsI9D3komnHv51JOMfpvdWm2eAS699YMPDaQ80q73e5bObF3aorw8owWRSLPeJqmp+8GeHL6SU6CB++Ypju2LIk7GzMhxerLbSz3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZpOUmLgHSdKAjrZl9PXwzqbPXc54zNEKRdgjL2jdyE=;
 b=xk0tDahI+na9cTtNOqJ8UAd7T63Ujutzil4y7FOV3N039UcQIMmsPutah5YOV2tWC0PRPmlg/aJLvz5RlfGgpwOBmQaCTzlOEz22SVJXRKjhtHZPEFx/fU3Gl/jhZ/Rk4QFj/aAgZ2HSyGCXFnukaRpzm6yQAnhLc/FKjYC90Js=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM5PR0802MB2450.eurprd08.prod.outlook.com (2603:10a6:203:a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 13:02:41 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 13:02:41 +0000
Subject: Re: [PATCH 4/6] block, migration: add bdrv_finalize_vmstate helper
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200709132644.28470-1-den@openvz.org>
 <20200709132644.28470-5-den@openvz.org> <20200827125846.GA1429165@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <a5e7f90b-629a-69d1-d9f2-4d57802ba617@openvz.org>
Date: Thu, 27 Aug 2020 16:02:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200827125846.GA1429165@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::47) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0102CA0034.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 13:02:40 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a1038c8-4a2f-493b-44ce-08d84a897b5f
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2450C1519A4E47028B861A71B6550@AM5PR0802MB2450.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FDMns44FDDa4WcJSlR15Hz51MAYOJj4xjSTXXYrAjRlHoXZNvm4aqQ7mSwikC6NbTyIvAvzdMS1On/cat8hnetA7DRkGYMXAgafkPtAB5eXjMQPqKUE1prvc9CEQB0+D0kguZxee9/mZ1WpdKBHLG4DkQmgWZKwI5ZH7N2FKwkYjc+KT3x5d2fXYVbPPek8UO7ASqJgAMNj9Mtk3WKVUUBa6PWfDAB0hIVwNcTr42A56CB2wk3NFIK0BqEk4meNZ0Z4+X786osSwOMMVymGNlhfflQRL1B96vPs2IG279jRVA7frCTbsXGJxl0x/DbDPQBM4Dde8r8YmgA4uW7EHYNhRmF4XvkZW16R9yQHzpTewXTmDTeNAtz6LQsoicKK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(26005)(16526019)(2616005)(5660300002)(66946007)(956004)(66556008)(6486002)(66476007)(316002)(16576012)(478600001)(54906003)(42882007)(31696002)(6916009)(8676002)(186003)(2906002)(83170400001)(36756003)(53546011)(4326008)(52116002)(8936002)(83380400001)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qnZuMmT22SVnSYPAWQ636apWh+ISauz+eV1yPOXV4N9eNaeMTy+BIELWp3lHwcE1yllj+r25Tb41s+ZPzwAcgPUBjm7AGW2HTuhALKNrxGHYP5JDx1G0OaTw1fUJbeDaWyAn5OTRdpQWBd0OtEI6i+yfoZqjllxA0SC9cBuH0BJojaTfCPyQZyDUqYHPZ7MiazMW4VoHcJOR8WWpoq5hto4H9XKsVSJzKhAMs6HQIwlQL1VmSa0r5y03JbApqI+7DwgwtbHdYnZx5TcrlODnzISuJVE7jyElh9NmX7OF/wvyec8zERiIPuLXox1V+RaxNGhDSsmOPENAgw05lSza8awrv3CTcYpGWQ/Wdl4ooCQPGubwZag65AUfwAiTgLS+dxYaba0lotIvHXyxENTfDX7v49iY4wRZQ/p1g6lKnVcQMyXZaLbTBn+kMEWb6K2Ex5+kmEWkfy87M1GJt4w+cMp4fXFUyi5jOLayGcBgjb27FpDkpHRnxD7E/H/dO86ve97+f5AOhJrn7+OVdfx6L0uYi3TK7I7LO6MlZwLO9h649Sj+YfH5hdjPVPm3lySdrUDygNqolE/xVC6wPZMbg8wQbJv9rlzMnoQB8v+jnDtb73h5umv+T+1zLfMGC3OJ2qofR9tYMxuo08CVi4wlHA==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1038c8-4a2f-493b-44ce-08d84a897b5f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:02:41.5210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvTYOhrE0+0PEyCjuCqCvnsPNFI0/8fx9sNUlUOAl4P44U55tAQnRRYMNKChMjraaSqEhknpcqx3NYfu0IUgpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2450
Received-SPF: pass client-ip=40.107.0.105; envelope-from=den@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 09:02:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 3:58 PM, Daniel P. Berrangé wrote:
> On Thu, Jul 09, 2020 at 04:26:42PM +0300, Denis V. Lunev wrote:
>> Right now bdrv_fclose() is just calling bdrv_flush().
>>
>> The problem is that migration code is working inefficiently from block
>> layer terms and are frequently called for very small pieces of
>> unaligned data. Block layer is capable to work this way, but this is very
>> slow.
>>
>> This patch is a preparation for the introduction of the intermediate
>> buffer at block driver state. It would be beneficial to separate
>> conventional bdrv_flush() from closing QEMU file from migration code.
>>
>> The patch also forces bdrv_finalize_vmstate() operation inside
>> synchronous blk_save_vmstate() operation. This helper is used from
>> qemu-io only.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Fam Zheng <fam@euphon.net>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>  block/block-backend.c |  6 +++++-
>>  block/io.c            | 15 +++++++++++++++
>>  include/block/block.h |  5 +++++
>>  migration/savevm.c    |  4 ++++
>>  4 files changed, 29 insertions(+), 1 deletion(-)
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 45c9dd9d8a..d8a94e312c 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -150,6 +150,10 @@ static ssize_t block_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
>>  
>>  static int bdrv_fclose(void *opaque, Error **errp)
>>  {
>> +    int err = bdrv_finalize_vmstate(opaque);
>> +    if (err < 0) {
>> +        return err;
> This is returning an error without having populating 'errp' which means
> the caller will be missing error diagnosis

but this behaves exactly like the branch below,
bdrv_flush() could return error too and errp
is not filled in the same way.

Den


>> +    }
>>      return bdrv_flush(opaque);
>>  }
> Regards,
> Daniel


