Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D79CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C917F21548
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KHzDq2Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C917F21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlrPj-0002Wu-4R
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlrON-0001XL-3S; Thu, 18 Jun 2020 06:03:31 -0400
Received: from mail-eopbgr60102.outbound.protection.outlook.com
 ([40.107.6.102]:43262 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlrOK-00014D-Us; Thu, 18 Jun 2020 06:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWduh5Ggg6z0/w8nJDcOO+DQ4NmBGlQyV6pnd4pD75X0D9j1R1rRJ80+SR65Bm9exJZle0LmyxHp7v0cobqvbFKQBDEN+haP4DQoVPSHYSWOzCo1hujMV9rZodzzlUEq1GHei4agYh/iuMxh5DV9tsVLygCGzBVVoB/CsLt9kN+xFuzXh0WCBUDKMb3PQ3wJZUOoirQu3yRby9htfZliacsGm/m2SEicbt+0CWUhXRltPbfcdLxNO2vROmRKtn1yoMfU+6GCw1gmapzID/X5aenZT4CKKfSZK61bY4/yhmEWGAuV2EVHA4y5FRABXwTSKldxpptjTdmt/AIqaBCgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv3PKPtGKnceEQB4xJSeBmF/5Vpj+ZRcf0lHYYYcYGY=;
 b=MwBKEDsEfPcANy4NnYRY0fBLSDYbjW3ZLkJvbS7CDfmfgZnJJ14LcEkcIvagw/CVRiBPmH8+yRM1YnjxfYZLARrK+5/UjQswhXUfjLrW4Fgn6sHHu77uPdPf7R+qWUS6mIYsfhiqiWdHLddpA1OS68JNJ3DIWENKy4NmRAl3tyUSDukjgx+pPufQ8Zvi5cbIy1ve69co/ak0IWZ/5Jq86NJ5o4JKg3TjSUKkSIW7FpPcnqks58aVONhKmjL4gxIE2aCPzBzCVQO4owUIPs249QQa59cf98y6R1BJkOzKa/hFg8KiirFaK+sl1feVZCBkTbtODQDo2Q/5YBZuRsN0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv3PKPtGKnceEQB4xJSeBmF/5Vpj+ZRcf0lHYYYcYGY=;
 b=KHzDq2SqR188piF8eZmc+5st5y/mA4VwdQJCL1PWeoJxqKXz2jcf/IRM70iD/H8MavmWOrg5N1WOELoUpuYDF1B8IzXxonVtFlts6oJTPxapj15GnIjimqUZ7r5Li1JFnMMjK6uDyVHiwQYEgicSjW3vo5AnHPzymK3t1YSsH8k=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 10:03:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 10:03:26 +0000
Subject: Re: [PATCH 4/5] block, migration: add bdrv_flush_vmstate helper
To: "Denis V. Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200616162035.29857-1-den@openvz.org>
 <20200616162035.29857-5-den@openvz.org>
 <091af0f5-c8e9-8749-c329-287fb100f2b6@redhat.com>
 <fc13f3c5-3f6b-047a-60a1-1d3a445f7db7@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bac0399e-12c0-ba42-3a50-9112f8b70c57@virtuozzo.com>
Date: Thu, 18 Jun 2020 13:03:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <fc13f3c5-3f6b-047a-60a1-1d3a445f7db7@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0023.eurprd03.prod.outlook.com
 (2603:10a6:208:14::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 AM0PR03CA0023.eurprd03.prod.outlook.com (2603:10a6:208:14::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 10:03:25 +0000
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fec67a6-9ab3-4799-aa6b-08d8136ed7fe
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5366864EC21C3CD2B898DFD8C19B0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhFN7iG65gNcepQhVhgrR/4n0j71+cieHU5+1Jsh4s6VbH/C0bfz7Ny2Sveo8DN6Q7s9uE8hbSrsTVkbf08yLFQUjSurBKT8uURlOJ7Qg2J+IT1EQj9inY5aA8T6yo3lwCt+B4rtcPDMJ6muMLr79BrlCJ3SUFLXQI92tWSFheQGXIQ1UKRYeZv/zZbQN5SukkyhZu6ub8Puna9veM/u2dW1Ebi3cug4oGkgm236tMfcknXO1z3z36q/TvryCegsGeMpS51HydWpgGcbT9ebyuX8QJPwIWTKcLdZoNDa457PbHK+fgqhqP1XMbfitV6irT0QYigx9Zg3Yv4lVZstJRATXU0jZvEu6UUt/Ek5vyMpjiXBxobZXrwYYErNJ5kg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(39850400004)(376002)(366004)(6486002)(956004)(2616005)(36756003)(478600001)(86362001)(31696002)(83380400001)(8676002)(8936002)(31686004)(186003)(2906002)(26005)(316002)(66556008)(4744005)(66476007)(4326008)(110136005)(52116002)(16526019)(54906003)(5660300002)(16576012)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QuFSUOIeO8kzOOReO+w2GHjS0ml0wuZVqBLM2YrVgTO9L8WnXWB1dbCUfpJqCcSxYPJeG5P6fAPsAe79pZHcGfYywHb5sTqmRtAUwusMbWcIM9HUOCL+DeNFEzMBMXhCTM8ltkWEM1cEpT84QjcDo7LMwQAeMxyvKg+eTYtttih56eR+4LtP5HVsuZ3gxL1v7omz+/2OCCOM6PB7QGkfI+2RZpXjSS4Yqf+X+10VRaw+9JNGomxkZUZYm+ph0x8s3wYlxyvgSaSR/TJ7njSvHMBDSJ3+5rL4w+APeZnbZ3uvQUYuklAxr3Rvooo3S/oJRdC0IJpDUNnO387/dgYEQ4AngChQ1+CNnYG/vWv3ucA5z0zOCCRzCxLD1IdKBHPvd1bi44HjtF+Dg38lef/51JezyFnsRxtFVg6BD9OrVd1+PqCwqxcjTXeEwqMo7A6hTQF8tWqMHGRHuAdlzJG6JB8r0VjP8CKsy7LgfzZcSrk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fec67a6-9ab3-4799-aa6b-08d8136ed7fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 10:03:26.5032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaMyQZndq2ITilCvEjl+GgdIS6mBOiLqqEe3TcJMM2m8RLVqk9KODAGaTEmh9HjcSi8FMA8Hir61o0M+jIukKk78qGa0ppMyc2lVdpAXWKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.6.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 06:03:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.06.2020 00:29, Denis V. Lunev wrote:
>>>        if (ret < 0) {
>>>            return ret;
>>>        }
>> ...attempting it here, at which point it looks like the only reason
>> you need ret2 is to preserve ret long enough...
> no, I would like to be sure that intermediate state is always cleared at
> the end.
> In the next patch I am going to put intermediate buffer to
> BlockDriverState and thus it has to be removed in any case.
> 
> May be flush would be a bad name... clean or finalize?
> 

finalize sounds good for me

-- 
Best regards,
Vladimir

