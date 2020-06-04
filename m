Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B4EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBC7206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GP4t/maW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBC7206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgopb-0004dK-F3
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgooa-0003ti-A0; Thu, 04 Jun 2020 08:17:44 -0400
Received: from mail-am6eur05on2139.outbound.protection.outlook.com
 ([40.107.22.139]:18624 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgooU-0004EY-1y; Thu, 04 Jun 2020 08:17:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlcaW2lxwU735+HH7vWG58tr/6VzbdiydcLe4rtTVpRIBUDouaXINP069/k65GnpttBkVLjIfWJ/unZ2Znl3N5xkU+mscTdicaoM9JUr9dars39qGGDRudUWwlUPRNy9M32JGDwPtXdnTu+/JYsB/efV3ESkndcsCWLnWkmc2/YshSRRI/K0q1u3W1ZvnmEXtAJurRjB+MyQoR4o+jaQWpJS72GWzrsP68S31yhSTvSshiXNZkBhYi1BxTHXvjm9i/5oD9kxlVOgBcRO3YZdHgusOEn6jGqcQtjtWMKE2VXaUTvg00grqMKw5NFSpLiqsh669i9yOo7AnF/NTv/6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhglOWES92YeG9PZSJaSgsZDd8A3KCxgQOnXMBQXOdI=;
 b=UJsaw2iET10PIK1mUTFhPdtJZSsxcrmRldG2pNuTsEOm5vZvRwlJQCyxZ5v6Lv5BymGKW4OXZJ0ObHGtfdV/yzQYMgucvSZYKqw09oiJ/SvfD1glrC8CmwGBLGe/5IhRzapaAX7XfI4alPYNxhXwfnB8LF7wn78N4/+WMxO5nipd7+UI/ul/CYGWVi0VOIc5B3FZTmGvXHP7o5D9b+H9ZB0yIl60+hsXHtgBIl03fXMx0o83/eWDeqqZCqv3NqpSYrUWppmpXVo7irK7GhxX+oR/CL5xnIbxiP5Ttp++RDhdmZVRKkIEfALubOgL+0OmesCA+RT75UzPe4ebasY23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhglOWES92YeG9PZSJaSgsZDd8A3KCxgQOnXMBQXOdI=;
 b=GP4t/maW0OpvJsN5jDM+NVqwwAxGT7r+xUYS4008PG3WBbYAsxilIKM9lnhJKXN5pPpz41x8+KsEHIg0yNtaP60xru/SjkxMEmfhGdOkmrI9tkpLqntVkKoe1EwdtnzAnQJlYDrgiO4wCXdWyaFD1zioGkizfNW7KhPlBt+ENWo=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5416.eurprd08.prod.outlook.com (2603:10a6:20b:10e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 12:17:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 12:17:34 +0000
Subject: Re: [PATCH] iotests: 194: wait migration completion on target too
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200604083341.26978-1-vsementsov@virtuozzo.com>
 <c6bbfbd1-4a57-15ea-bf80-0ea5a1d81c64@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <13f76b1f-82b6-427c-73dd-f9ced28b4d5f@virtuozzo.com>
Date: Thu, 4 Jun 2020 15:17:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <c6bbfbd1-4a57-15ea-bf80-0ea5a1d81c64@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.190) by
 FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 12:17:33 +0000
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4cb973a-e852-4d4b-b2c1-08d808814358
X-MS-TrafficTypeDiagnostic: AM7PR08MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5416FD3489A79FA2CE2402ECC1890@AM7PR08MB5416.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kC2LfWs3+bGiDcdLC5IDIhkXO6N++iVsI6hzuQK9Eth/YjrDrFv4To0I+0xR4isZMtIrv/7dWvvOM7FlR3+cI53C2vxRakRreNCwZ7wijXvRgIX30en9s0x4lNcieWybEkaf4FvQ0f4n5EZ0zCmqVQ9Ev2VCdhjlsaGQtUTItvP4K9z35a1ASgSx0t+OXVnMO26HItEhQStaITaXbEWxFFRz7keZMrzrE58wkgCt2Qy0IajB0BZzYl0Tvi7qqOcesV+s9CQZJqmqm2ySredYdhOA1IpavOhHc/UnJqbFRLnyVCbwXosrlggYN1UFz5lMPGg+mGsiQzsaWOXv4WryAEQfuXnlRfu2QTEt71vlseR5Q4mUiju8WSyNVekVxD5m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(136003)(346002)(376002)(366004)(396003)(186003)(2906002)(8936002)(2616005)(36756003)(16526019)(7416002)(478600001)(956004)(83380400001)(31686004)(31696002)(26005)(6486002)(66476007)(5660300002)(86362001)(52116002)(8676002)(53546011)(4326008)(16576012)(66556008)(66946007)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RGl7P3r/55RH1d62yMX1zvpPHWJ8hXZPp3BM8OVzgWwx/qe7btoKaVq/Zq+0CWTAAlG4X2+1guYcs5q768ZgRKHUUIcKEEXzaelWoWlVDknJufkYvo6MovtG6I0KuWe8a1bBcEf4l6LaJ+GpVhUxJtnM6DG9HonhIybloElkOWRPx47xj6t3p6Ro1EuoDcewRutGmsKAswWsise0UWhLCGbjVoEGEAyBmeswKBIHFHBy3zDYWCGgWNNRKpewkdHARmdazHpNaNEFCU1/vTdVYlN57Tpw//Op6WouNurQhXwzVXtm+Ftc+cfp7LuFE5ZNCTaC2nR74shROVq2LStZote0c2dPLUK95run98IzOS+BbWq0+eZXLTrpU16d5CLB65lYDv/N8GPQt0guru5mbS8Q8YZYDtStVuoXfDfvMMZXjunQfcBseSzCNmY1Av60wwgO4ipJjy+OaV42t8IlgJb6rYjf08zTZ63U5+COpR+LPwQpof+tVPYx/g8uS1qM
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cb973a-e852-4d4b-b2c1-08d808814358
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 12:17:34.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx4hW4uyBZ7R+X4EZy3ufABBZH/WoXwM7c3Uo4dQwrVQ396zyCpJDZViTioOxxmymkScdLuuEtTFW8KGMqtuOi3+gc0994kqXuYZItwHE6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5416
Received-SPF: pass client-ip=40.107.22.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 08:17:35
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
Cc: kwolf@redhat.com, fam@euphon.net, thuth@redhat.com, quintela@redhat.com,
 alex.bennee@linaro.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.06.2020 15:04, Eric Blake wrote:
> On 6/4/20 3:33 AM, Vladimir Sementsov-Ogievskiy wrote:
>> It is possible, that shutdown on target occurs earlier than migration
>> finish. In this case we crash in bdrv_release_dirty_bitmap_locked()
>> on assertion "assert(!bdrv_dirty_bitmap_busy(bitmap));" as we do have
>> busy bitmap, as bitmap migration is ongoing.
>>
>> We'll fix bitmap migration to gracefully cancel on early shutdown soon.
>> Now let's fix iotest 194 to wait migration completion before shutdown.
>>
>> Note that in this test dest_vm.shutdown() is called implicitly, as vms
>> used as context-providers, see __exit__() method of QEMUMachine class.
>>
>> Actually, not waiting migration finish is a wrong thing, but the test
>> started to crash after commit ae00aa239847682
>> "iotests: 194: test also migration of dirty bitmap", which added dirty
>> bitmaps here. So, Fixes: tag won't hurt.
>>
>> Fixes: ae00aa2398476824f0eca80461da215e7cdc1c3b
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/194     | 10 ++++++++++
>>   tests/qemu-iotests/194.out |  5 +++++
>>   2 files changed, 15 insertions(+)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Will queue through my NBD tree.
> 
>>
>> diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
>> index 3fad7c6c1a..6dc2bc94d7 100755
>> --- a/tests/qemu-iotests/194
>> +++ b/tests/qemu-iotests/194
>> @@ -87,4 +87,14 @@ with iotests.FilePath('source.img') as source_img_path, \
>>               iotests.log(dest_vm.qmp('nbd-server-stop'))
>>               break
>> +    iotests.log('Wait migration completion on target...')
> 
> Do you mind if I s/Wait/Wait for/ here and in the .out?
> 

No objections of course


-- 
Best regards,
Vladimir

