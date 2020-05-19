Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1875C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA352070A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vUgEnhMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA352070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8rJ-0002SW-Gp
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 16:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8qd-0001nW-Dv; Tue, 19 May 2020 16:28:23 -0400
Received: from mail-eopbgr30110.outbound.protection.outlook.com
 ([40.107.3.110]:4086 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8qb-0002GJ-Gx; Tue, 19 May 2020 16:28:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtvmI5UdY11LPmBS/u6WBCDwaEHW2GT869Y4iabHYYWNKtOTYnv1IxLjN6/dmq6E+HgsWPBeSijwnO/SspU1rBZPyA+S73PAM6eNd+rzt9gP7ZcFTCBOIqEDlSDTmVc4rhDp4TQaaMkCKhMSqRUiQ1q0+eC8s6ksY7wKCocLrBuxCViNqvVVSsKu8dB0rVzZMWx07zz2vrWN8Z0NZVs6SgYp9TWHyxFEPqSsjxmKMNAuZqduR7JOJ7YMbiLpKEkNr5E+jcpHRtt2pfQ0+NLhJFPF+c0VnlNlcQG5v3Cd45ezCCNxJEV5l0hZ6LUhRBUCJCSlev200BUrIE06HvYR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOzdbpBA4ccLTPMVeEM9nt3UmeT6jOwzc6DFpAz0/u8=;
 b=Mh9IntbOhud+dj5YZVidC4qaOl5jzT9bODs2731QUi7hbDloBkaNZZ6+7q+Vou21o3gUSTnOmyczttBUXOTNkDViLqStA+VR8FtAMxVe8+hDBSRsQ3RrfNdVGgAH3kLc5izJLIbJRj2Wovt5VauO71+upeubq/V6D4Ei6RbLvSOY7UrCNAzFi8qIVmouW5SjXIhiUsKt6X6DunaCswOTw0YUJ1xtqqZN9S0kwxCTX5tSO+lfKPq43S/2XufOrMRjZTKov2nDSe167ahbGnZS3yOn5BBU60q2OQpo6Rqok33ZFhssYEfD6Pk+vw9xmehXECbTKkHd6bz6mkXQnI5OoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOzdbpBA4ccLTPMVeEM9nt3UmeT6jOwzc6DFpAz0/u8=;
 b=vUgEnhMouRxYvz1M1fjzyAfKeueBwT8b+gqXvtIRFcEDUfRwtQVUfnKsGRA6GcLmhVy40L1pd9lwXjImJvMGIcKOdgFfzleYqRyjMYdeaGqAd2T9QSJUG3Ho1rYfUZvlsXtfx4jzyYKFCoBYnPpN7kE7yFkSRhLKOAnauklVEOE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4352.eurprd08.prod.outlook.com (2603:10a6:803:f1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 19 May
 2020 20:28:17 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 20:28:16 +0000
Subject: Re: [PATCH v2 0/5] fix & merge block_status_above and
 is_allocated_above
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
 <1cfe5274-b3f7-e02f-8257-9858fdd4bb94@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <423cb393-1dd6-30e2-7f3a-4579d7f1bb99@virtuozzo.com>
Date: Tue, 19 May 2020 23:28:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <1cfe5274-b3f7-e02f-8257-9858fdd4bb94@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18)
 To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Tue, 19 May 2020 20:28:15 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c058da0-f0c5-42cc-8de8-08d7fc33298a
X-MS-TrafficTypeDiagnostic: VI1PR08MB4352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4352EE32D104426F3B88897BC1B90@VI1PR08MB4352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m82/pRsUFVyX6FRel8QE596PmbkNGBdH00wShBJU4wk1ger+PCCuVE+I1a9KaJr7/rnr6gu9ixNBuIUYDonIwfvpHmRRaaEBVNTDyiHfd2zgndEJraUUuEJJCy7ib4BZcMRxtA/1QNdqs7aQgvb98AR3mhYY1BJSd9jsHmMb0CmgWSS74RBQXHyVYgD7PhNy0JL0Eaj1R39t3iq+M26y9qhFkd+bbnKZLFP0Jv4T2eoOVA7SB+a/8HwOywHVdlnvBbb97LeLQtYj4ZB40mgeR0pGsLJBleVkVOYhZhkdGLc+PU337W4GqfydNBW1vAu1/Y227yRYNsZS4igyE+42X5IBwPCPSegyXNRjL2CFImV9UMJQfrxW0WR7LHZHR0Uz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(346002)(136003)(366004)(376002)(478600001)(6486002)(31686004)(52116002)(186003)(16526019)(26005)(53546011)(956004)(2616005)(8676002)(66556008)(86362001)(66476007)(66946007)(31696002)(4326008)(36756003)(107886003)(2906002)(16576012)(5660300002)(8936002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QiuMCogcPMAkf5rkYTHY8u8tFTFySyanwhX1lI2CmIXoT9iaVpOn3KlUKExBb/Oj9mP5bGW0jNq0PjGeVkBpCwl5YN32Lv3dNSHEf0XpNCHEESopyIGvvg2dfuKrQbyvJEZ+pvlLKfHaMN/RHgrIndIl0wAFOfIQ0zKim6jxUY/uUm/FUAxl39PE5cBFbEGxpoQFBUMX0NhzLv7dCYCHW05KmoRAc7VqcIIJvJF3S0i5GI2edWBmyccY27PrurUGLn47Si0SA1m1Q+xiKjpMzeBGZ36vG7D/emrk3eW1vWcA1JJSe8csKIOLvvwBjC9nmQA3q9ZoPgvffsBSraRLmEq9AlryyQwca2QyKdggOitALSxG96kfonpbQGkirXvHSrnv0AK4jIXD1evxMwL4xmOcgL96U2sGjrx2xQg/iPoPXZKXyQug8P9NrOmkkR1jk6i3QIkGks0wbuJ+7ECflqCFwga/XvmIx6KryRLM7QMT+RnMaBHGdDZXIl8MxOm3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c058da0-f0c5-42cc-8de8-08d7fc33298a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 20:28:16.7897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caf+CRmxYAWXadXj3IyKws6He6xOZ2GxX8PdG7y9NOXDmyiHauZQfxzNIN9evzWsXphE5Af1OZ2LKs8CUb/uuPi1Izr1AKb925SPen0bpes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4352
Received-SPF: pass client-ip=40.107.3.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 16:28:18
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.05.2020 23:21, Eric Blake wrote:
> On 5/19/20 2:54 PM, Vladimir Sementsov-Ogievskiy wrote:
> 
>> This leads to the following effect:
>>
>> ./qemu-img create -f qcow2 base.qcow2 2M
>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>>
>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>>
>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
>> read 1048576/1048576 bytes at offset 1048576
>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>>
>> But after commit guest visible state is changed, which seems wrong for me:
>> ./qemu-img commit top.qcow2 -b mid.qcow2
>>
>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
>> Pattern verification failed at offset 1048576, 1048576 bytes
>> read 1048576/1048576 bytes at offset 1048576
>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
> 
> This no longer happens as of commit bf03dede47 and friends.  As such, how much of this series is still needed for other reasons?
> 

Oops sorry. I blindly copied cover-letter of v1, and forget that it describes another thing. This test above is unrelated now. The whole series is valid, it fixes another problem (see 04 and new test cases in 05).

-- 
Best regards,
Vladimir

