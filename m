Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11739C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00A920756
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="El5vKN2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00A920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5ruc-0000qu-Ul
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k5rtk-0000CC-2U; Wed, 12 Aug 2020 10:38:36 -0400
Received: from mail-eopbgr30099.outbound.protection.outlook.com
 ([40.107.3.99]:10529 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k5rth-0005BN-B6; Wed, 12 Aug 2020 10:38:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uam0opov5p93ws8ewXPNyxL4wXl1anprI/LIQyFewVOmL9dqwGFwvYZqbnqqnpeSWpxLwAhE1XpeAjKYC2AbOIQ+ZmgZb/7Hae0VCGIz/cLRQfnDT03/FGKSfG1ZSp8CexpINwX8YruCYJkVB6ItZ9lKpalivBhax43iV5I1C7OqjjaWBvlgxhvMYBLS7If+Zrbh1q7+hZkYSyFetwNZtS9UIY7CgOO8CDFk/gR5DlN0XFizusnOA13/HwqV2zTYBShzGBXRvFFeuJHBXmwGHtSWb2Fho2JZfeuqSBO56oQqnpftWST+PFsuJApMCgE4m9JUmKeJrxFZvNBiZlX1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRa4vyPdED1F2DmVuKJnu83BxamzCubHstNQT+ZrpRQ=;
 b=K7OXy4qL/yqXay5Q0w8Txz1giDNbJUsOKmw7n6nJEwptq0GONsMald4h3tbVQCoPRXySk35VQjv6PUlPyxe1XXBVN3WgaLQtRJdAaa0nvuQzJp/VBCHS6zYfSxlg91kLpTE4B0tnbb/j4BeerwLsnB1aTI4R9pMvrEWBK772Q4QSHj2pbNcctqPAvtdasrQoxf41Jl4pSdWGujp1p4b3dRvqVD+Sn5iNMO/Ws1PXqdPniMPdxiOnZceOzKOykBKx0zMYqMSRIx182DVtxnTlh5L1Kx2QP+xQpr0vzfFpNjFCoGOInMfgEKhZ3JkpNZJBYgcTuIRiLgOTkRFSYZSmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRa4vyPdED1F2DmVuKJnu83BxamzCubHstNQT+ZrpRQ=;
 b=El5vKN2+amQlldLo4Y5vcs2HFO7Tnkx6lZhBxh2QmJFg38boyNYCTyGPCa1i70hWvpzusBgszwxwqWfEExC4JHmMC2gDrVT3ZUEUQW/F2kCowQ88LcTgaPyLlKXLy+JDteYNqKrE3fuzpKLq5d5248tnsb6Za45r3kF5a3pd/vY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Wed, 12 Aug
 2020 14:38:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.015; Wed, 12 Aug 2020
 14:38:28 +0000
Subject: Re: [PATCH for-5.2 v3 0/3] migration: Add block-bitmap-mapping
 parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200722080516.126147-1-mreitz@redhat.com>
 <9fb447d8-acc8-2338-630f-1e33e08aacd8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a0dd7ae5-1f8f-c07d-e6a1-508743885e55@virtuozzo.com>
Date: Wed, 12 Aug 2020 17:38:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <9fb447d8-acc8-2338-630f-1e33e08aacd8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0902CA0013.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.146) by
 AM4PR0902CA0013.eurprd09.prod.outlook.com (2603:10a6:200:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Wed, 12 Aug 2020 14:38:27 +0000
X-Originating-IP: [185.215.60.146]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa558a77-ec2d-4b6b-7149-08d83ecd6097
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-Microsoft-Antispam-PRVS: <AM7PR08MB538264339B4F7C189B292CF3C1420@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMEi6JP48ifu3RfmfW97bwCBTjL1RfIXjD68/GNp9Ip/CL3puRtGI9Nl++FK9Bat08dyWmszgdpXVDC6UGf9PuBNAfm0sLsI/k+0FjmkKcwlNJK7miExLHGSogoY6YfkEqUHeuKa1I7xiZxq5w0vnS5zaXAEzjGlqKMv1Djs1oUgMdrcGQGrjAdHn/pvxKgEMCv75hUKCizhtctL+1SxTux8FhAVbU3wWkLobWx7aeGL0vlTS1y5NwdXlOVv8m248dtar4yzn9Kcs73ognJga+SoUpW9eqRgS8C4zlcTgT/HXEqPZKOJ0QfZ31qY1sEStQkyQKtSN4VDPrBrgF8cyKriVw24l9ricZTZ7NqRgSh4AsS+5lBC3FITA7eYbBzwDQvoUIhA52c++MhbkTHhuhs4CnGK7d709KT+aVm93+TJHsvMOasQQpic0Q+pW6aKAJhokIj7FoxekDK1R6SwNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(346002)(136003)(376002)(366004)(316002)(26005)(186003)(16576012)(6486002)(8936002)(83380400001)(8676002)(31686004)(54906003)(966005)(16526019)(53546011)(956004)(2906002)(86362001)(5660300002)(36756003)(66556008)(478600001)(66946007)(31696002)(2616005)(4326008)(66476007)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ReSXjDyXtBr2kRKCyUbAVL+Ldr9iDDTrS2qEoMcHZazw8X0Ukp2lPWUvddSkTt0aUnJjX4mxRDV/S1agTWnh29Ox3oQrZbISuD+iMCfkCx2D/6oU/pL/CD8XGDg+v9kb3B2eAXCL1PFvqmlnxDrM3ERM8t37N29O8JOWBrG3opFMkzH3hy9BH7NuzUYphupGDTkQh8Dw6A6pxvVm0rG3+qjnK+ToThaiviF8XBb9YSeNHws081TjtN4+lvxVRDR4AM3jSATjDTHM3VEVXYy8RpaT2yaLMTtOmCTKnQm9UfL8bUWLLEPp7D/lInvI/MJjD21RUFj2w2cP7MhtZ4/SALehEHPEegjVeh7HSIpTrQRILqcqAo5kDrlFREE4qbBUNwvh54vJCM9ncIJ5dVJd0aIIWyTpOMcF27EIQMcihQamppDYTQej/obVVIzjnd56awDlChMaiDJWoBskj4xak3QuH+9IUj3Rb1bwpHp+6FAcINhTVgc4N3EYJ+6RimG71lpfY988unUk3TJV5BzzQBnvOhX+AS0q/H8nc5GsBKjD9mzwSvueQMAPPl1GpAEbQUYphF0Y0o5PfajZVYg3tCjmzphxyHwk/nLsqQq6/gF89akNZMI+L7Xc+c2F/xk2/6tIQFJSJfPgrfTYHifDHA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa558a77-ec2d-4b6b-7149-08d83ecd6097
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 14:38:28.3656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwXzvo0piRS0itihIRtkiAgVljjSSpCKRvpHV4CamadUtBQiwE35ufVm0BaWvvQaKsZ3Fy8mgGH7Ij5I74nvpifBo4HK8h5f/4cOoyQNbfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.3.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:38:29
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now this doesn't apply, as code changed a lot after my series
  "[PATCH v4 for-5.1 00/21] Fix error handling during bitmap postcopy"
merged first.

I feel my responsibility for the mess with these series, so if you want I can try to rebase and post v4 of this one myself :)

12.08.2020 17:15, Max Reitz wrote:
> Ping – seems like everyone found v2 more or less acceptable bar the
> failing assertion in patch 1, and some aspects of the test.  How about
> v3, are there any objections?
> 
> On 22.07.20 10:05, Max Reitz wrote:
>> RFC v1: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00912.html
>> RFC v2: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00915.html
>> v1: https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09792.html
>> v2: https://lists.nongnu.org/archive/html/qemu-block/2020-07/msg01179.html
>>
>> Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-v3
>> Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-v3
>>
>> Hi,
>>
>> This new migration parameter allows mapping block node names and bitmap
>> names to aliases for the purpose of block dirty bitmap migration.
>>
>> This way, management tools can use different node names on the source
>> and destination and pass the mapping of how bitmaps are to be
>> transferred to qemu (on the source, the destination, or even both with
>> arbitrary aliases in the migration stream).
>>
>>
>> v3:
>> - Patch 1:
>>    - Add notes on the fact that the destination won’t ever know about any
>>      bitmaps that aren’t sent, so you can freely drop what you want, and
>>      you’re completely free in renaming bitmaps and putting them on
>>      “other” nodes (whatever “other” node means in the context of
>>      migration, because that’s kind of one of the problems this series is
>>      trying to solve: The fact that you can’t trivially match nodes
>>      between source and destination)
>>    - Fix an assertion
>>
>> - Patch 2: s/pass/time.sleep(0.2)/
>>
>> - Patch 3:
>>    - Add copyright line
>>    - Use format string instead of %
>>    - s/pass/time.sleep(0.1)/
>>    - s/wait_for_runstate/wait_migration/ on the destination to wait for
>>      the migration to actually complete
>>    - Replace the “info migrate_parameters” parsing code by a multiline
>>      regex
>>    - Test what happens when the destination has a mapping that isn’t used
>>      because there are not bitmaps to be transferred (which breaks the
>>      assertion in patch 1 as it was in v2)
>>    - Let verify_dest_has_all_bitmaps() actually verify the bitmaps on the
>>      destination instead of the source
>>
>>
>> git-backport-diff against v2:
>>
>> Key:
>> [----] : patches are identical
>> [####] : number of functional differences between upstream/downstream patch
>> [down] : patch is downstream-only
>> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>>
>> 001/3:[0014] [FC] 'migration: Add block-bitmap-mapping parameter'
>> 002/3:[0003] [FC] 'iotests.py: Add wait_for_runstate()'
>> 003/3:[0046] [FC] 'iotests: Test node/bitmap aliases during migration'
>>
>>
>> Max Reitz (3):
>>    migration: Add block-bitmap-mapping parameter
>>    iotests.py: Add wait_for_runstate()
>>    iotests: Test node/bitmap aliases during migration
>>
>>   qapi/migration.json            | 104 ++++++-
>>   migration/migration.h          |   3 +
>>   migration/block-dirty-bitmap.c | 373 ++++++++++++++++++++----
>>   migration/migration.c          |  30 ++
>>   monitor/hmp-cmds.c             |  30 ++
>>   tests/qemu-iotests/300         | 515 +++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/300.out     |   5 +
>>   tests/qemu-iotests/group       |   1 +
>>   tests/qemu-iotests/iotests.py  |   5 +
>>   9 files changed, 1011 insertions(+), 55 deletions(-)
>>   create mode 100755 tests/qemu-iotests/300
>>   create mode 100644 tests/qemu-iotests/300.out
>>
> 
> 


-- 
Best regards,
Vladimir

