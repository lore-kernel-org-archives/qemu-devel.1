Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03D3207F5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t4BK4qyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03D3207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1PUB-0006XF-2v
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 03:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k1PTa-00062s-JQ; Fri, 31 Jul 2020 03:29:10 -0400
Received: from mail-eopbgr00129.outbound.protection.outlook.com
 ([40.107.0.129]:6460 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k1PTX-0006i7-S6; Fri, 31 Jul 2020 03:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu306IDHDFS95OQjJoXrKUR1W3l2FRjb+lL9RmjoqYT/vpwS+EE85vZ5YqorqusdiaD5WFa4Fm92j5mPch5Em9SzrTAOKHx17xzngVwCNeISiYNMOiDAsOYCwj5o1AVDgm2yCqLojKB+GCPg4xrnZ4Ir/a8A1/e1+JuU/ueNQI25uSA2TWZMSbXNHvLc68SgpHHTkdEcJZRmIjAoBBg88ryNv042o+GMXgU6eGjEBCthIhY1ebgjsAsSCPUES1lqxDT6B8GhX4W9oTnTwsRu5TM9EkVN9MGkAkA5UhhoqGNF0IzkZxNjz1Jeh9QoHtZ3fVFLfmNCUiC7Cq5nWWRtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcfYXOGnBTrWICaA9V6eHgczOu3KpnQd47uxSHTYk28=;
 b=Mw7SuItAjlOzx0wFNc87/bdP2LbmGW/FUtZRV6g1W8+cCqoqZbOZuyusWPaahCSjB20h2v6o5V7CYJsrAuReIblesfHtYhNBN1BXfK2ObAVudGs5Mdj+rW4Y42WFjd82PGzjB1iP04Ots6nthG08uOmpRmMUNqLFitlBzVmoJfTx+ZoowU6VsMHdnlTuuLkpa2YiExfIIOEChxdeEs9poLQ9/ElxlJzSKjye/dWhLxuWHcmMcSywS/eqjZcXelr+vE2NarFdY6+aGhFJy0Oj5LTU9xtqgnRL4drq8Ymtmphf1Eh7mAWcoa+fZ/U0S2tO9FscS2nF/S4wFzLo2RQO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcfYXOGnBTrWICaA9V6eHgczOu3KpnQd47uxSHTYk28=;
 b=t4BK4qyzIung432NxzFAuEVm/UoVFjszkUcX2r5Ug43YJcM5DJ3UdczcjfDjkqkBFdfS/gkhzq64Sk93O4sEHOgu21w/o/GAZa7YSZG5n38TpcEEihuE6IHepfUAe6TE3ntRJaDfMzyug+6VhCmis8kx3C5ehyV3OYzyOrSOxL0=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 31 Jul
 2020 07:29:04 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 07:29:03 +0000
Subject: Re: [PATCH v12 01/11] iotests: add test for QCOW2 header dump
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <644c25e0-2d5b-1eee-68aa-245026b9c94e@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <a0405d81-a42e-5638-9290-58b211d5e874@virtuozzo.com>
Date: Fri, 31 Jul 2020 10:28:57 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <644c25e0-2d5b-1eee-68aa-245026b9c94e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR01CA0142.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::47) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR01CA0142.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Fri, 31 Jul 2020 07:29:02 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b020c8f-8896-44fa-736c-08d8352366b1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54930807DF21C2299D8E2DE3F44E0@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEW+X/MBKZXszc9k6rVydkhc0JijONip4+QgXYCLZ9KaqL9TOTQorO78TWu4uuNVMIHlYF7qFyAvzQvbVzgHIl9FHoSmj5xsi9IJlhjuwxvOPrVs6kogpYN5FAZGdiavgXKU6w6Ihhqryr98cWcHPkB7IJT8BXJLVyYyRDoLhqtelB1wP1dUMfl8Yp/wa6u1RSQGfyqLKlhM2+iniKvyLEGzstR7lQhnHZdDPyb6oiXOtIgVqHEol/mk/R8v2kQ5KuOosODBo91aNnpMEaUyRF305yCMgjbXpl24T9KeuDO7d/ftWeAMCe1mo2WUwyXfz9219MB3RKvsPGMFmmRxM8tju10H2s+e5e29FDYvDyWoMFSBmySQAIYiOUYAI7eH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(376002)(396003)(346002)(366004)(6506007)(8676002)(53546011)(5660300002)(66946007)(66476007)(8936002)(86362001)(36756003)(316002)(83380400001)(66556008)(44832011)(52116002)(956004)(2616005)(107886003)(31686004)(478600001)(6512007)(6666004)(26005)(186003)(2906002)(16526019)(6486002)(31696002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: n5pMOReHEdRBj1LNexXnyciydXvPs85FotS1TaSZBJ9yiEF+34oIgONFl53svmC68wiYfUvKkXyqTkFTKieOr+W2xY3fPiGHaMRlVI9tAetM+oOxGEbma1WFGdja+DAol5VMEawLY/ndEr6JnOHBimP3z53mKkejjD0W91BMd31l4Osb9a7M3qvN7O2Gdqedhz594p3TjyEFnnQVzEiuUNwBOAOAnbAL5Dtg0U+G5cEVJqipQweeUQM7YAkU+mbAcM9AQkvJTy/NyIs7vb5ZRnP0fAAwbOJnLxxaOhldwRk/hPoZzPjP0A14ButRz4LPZyuiI7GPjr/0tyA4CpjJneBbz8g+YQwCKclcZ4s6ekUTpTkUXae2hjcgdMfNzjOETKBhaL0BgMNE2lhJuw46ElmxIxEKTGjE+sa6M/ysS+PEglv2fty29WwXRwMJuV8JfwUsjmxgXJx0TV0TgLOs1HDuAEGzw3Xwn4SGA53ReHN/NxuW6PTOEP54sOnZZ/Yh
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b020c8f-8896-44fa-736c-08d8352366b1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 07:29:03.8216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QB6dwyr2E9L6rIMfgvwEB3cjSuQgFigAVmtpsVP6QlmIBRvUvGYR2fi6O1nHi9FVsPohtCULVVEaIXHStiK5PX0XpGsHvSEv2GIe7Wv3Y3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.0.129;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 03:29:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30.07.2020 22:05, Eric Blake wrote:
> On 7/30/20 9:15 AM, Andrey Shinkevich wrote:
>> The simple script creates a QCOW2 image and fills it with some data.
>> Two bitmaps are created as well. Then the script reads the image header
>> with extensions from the disk by running the script qcow2.py and dumps
>> the information to the output. Other entities, such as snapshots, may
>> be added to the test later.
>>
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/303     | 59 
>> ++++++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/303.out | 64 
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/group   |  1 +
>>   3 files changed, 124 insertions(+)
>>   create mode 100755 tests/qemu-iotests/303
>>   create mode 100644 tests/qemu-iotests/303.out
>
>> +import iotests
>> +import subprocess
>> +from iotests import qemu_img_create, qemu_io, file_path, log, 
>> filter_qemu_io
>> +
>> +iotests.script_initialize(supported_fmts=['qcow2'])
>> +
>> +disk = file_path('disk')
>> +chunk = 1024 * 1024
>> +
>> +
>> +def create_bitmap(bitmap_number, disabled):
>> +    granularity = 1 << (14 + bitmap_number)
>> +    bitmap_name = 'bitmap-' + str(bitmap_number)
>> +    vm = iotests.VM().add_drive(disk)
>> +    vm.launch()
>> +    vm.qmp_log('block-dirty-bitmap-add', node='drive0', 
>> name=bitmap_name,
>> +               granularity=granularity, persistent=True, 
>> disabled=disabled)
>> +    vm.shutdown()
>
> Would it be any easier to use qemu-img bitmap here instead of firing 
> up a full VM?


I agree, you are right. I'll take it into account for the next version, 
if any.

Thank you for your R-b.

Andrey


>
> At any rate, this is a nice starting point for tracking what the rest 
> of your series improves.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>

