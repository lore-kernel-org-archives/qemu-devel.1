Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF83C433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DADF2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KWJzOeB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DADF2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0860-0000Un-JA
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k085P-0008OX-LG; Mon, 27 Jul 2020 14:42:55 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:49643 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k085M-0004mT-JE; Mon, 27 Jul 2020 14:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTlLBXxwzx+TP5NvmM/LzYYPghJGZF9XNgb9sa0d8iUhsJhU9aVq7duf6fNxrcJzsYu4LWS7tZzojYsMzPMpxGNRZukpkTEFKSdZ3yoGa5d1nYU7t65DVIGGP7NaXAlU5CNeziv9O3/Sa9SCmm6j9MC3AfeufuYZMyJ/nAjqw9VwVoLXhf6F/piWkZy5KWL7XN5dbWgYPTnVksuAWMHy0Qq0voPsa7OV+jeTihGGb8Ctz5KlsFwK9EKDEgqtK8XQ0z+4GVQ34I0a7/rGYDm9hsx3gYa2Er4ulRpCqNZFpFpA7QV2rCOgcw9I3SCSR9huOLeXt0XOPvSh/yPm4ysBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0YlHkp0n9/zpvcn0Dclr5y2roBwLWu64n5ov+67HRQ=;
 b=aHcF+ZjMKq35mBWzc78mOpau70R7ktY3SX6OeGc5Tl7NLCJ27PgVwKizxFgTGHL+0dtwX6TEq4Ug1PH7KCFziw5qK9LQjySvPcfwjMaOitp7QyH0SQCkWM831K+RNWovQPhHOeViGpUjQ5snvQbQQqD4j2JG8niyTynMzFhSf4lJnAAAB1bZvCQ3uDvHs8zw3f73L1zNKBRUWCGJu2+cQcq0lTX3VpRLNG1hYWuDcR49/uVFsFVkDzS7sm1OCeMCNhTA9XZTilwdIDQ36H9ve7XAkuDnpMSfVL5iYec42IQGzVnWaVOOU3l2DcfePG/6qMi4QzCFNeRKE5ZEyDgN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0YlHkp0n9/zpvcn0Dclr5y2roBwLWu64n5ov+67HRQ=;
 b=KWJzOeB0uXNiQGoKRCP/PWEvkomkM79va8ikWAnGT/0nPfpFCd79n5I5UL6g1AgbDEO3kMeVaWPTsWeSFn5aRBYRDckWei88JL8ltNquZCGEOQReAk+QE+fa1kPyM7fYtp4TkrhHiul0XK5s1/oWbcjkjf4ixYlyj2oowQ+eRsM=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4722.eurprd08.prod.outlook.com (2603:10a6:20b:c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 18:42:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 18:42:49 +0000
Subject: Re: [PATCH 3/3] block/nbd: nbd_co_reconnect_loop(): don't sleep if
 drained
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200720090024.18186-1-vsementsov@virtuozzo.com>
 <20200720090024.18186-4-vsementsov@virtuozzo.com>
 <a4a5d4a2-eb71-ea87-efce-28734b6d4116@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cc6a586a-e84c-fd6c-3b09-c71ea3da4ece@virtuozzo.com>
Date: Mon, 27 Jul 2020 21:42:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a4a5d4a2-eb71-ea87-efce-28734b6d4116@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR04CA0132.eurprd04.prod.outlook.com (2603:10a6:207::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM3PR04CA0132.eurprd04.prod.outlook.com (2603:10a6:207::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Mon, 27 Jul 2020 18:42:49 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98ba1871-63c3-43e1-b12f-08d8325cdcb9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47223898B03FA93045CBE8C1C1720@AM6PR08MB4722.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsyvQwmW/V/gKK7DC0E4gSxrIdFEXLoMBBuYe971QiXfZGMxMTpxBDFRBRBUvUI6dCAIfdtUkaF2BFV5fVt+/U2ZMXPlM9iAaL7rCmWzs7mWTmXVKAWyKOYZIaP8CwukdvKr8qnhIjIazXscfuD2i1QsPZ3+yPsXAApjdr22MATVQkt6Aw+fxdIsIZA/cdU3ebew94wpTrF0r8lpgZmTvjbb0Atiz0yLs2rvb96sgl85ZFx4pkEsz6fKPaEaiytXF7KLqsZJLrguSnXR3i1pfkIXfsYpnE0d7ajXZUWOoNSmUmOVIfnUjvuix12Dc5kvwG1drB0+nSGJ9NnMIy+5Su6L0sKvsDzjb1b3I0Sv3zkN52eW7V32ep2OVI/e20uj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39840400004)(366004)(376002)(346002)(5660300002)(31696002)(86362001)(8676002)(2616005)(6486002)(956004)(8936002)(36756003)(66556008)(66946007)(4744005)(26005)(4326008)(53546011)(52116002)(186003)(107886003)(16526019)(83380400001)(2906002)(16576012)(31686004)(316002)(66476007)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Um18RskaF9mHenFVdeZllfZS06dGTFQxI8PK60KstD9V2ndtKwo6OnQWiC34PTUx/yOW+Vs/xqOtHS0MgxaPQvkGyXBYEuySkj8hR5pEX0svbqrbz2g6PkjseYWmun9oMWUOudTRMLXHMiiCdtF4aeQ3eZcBJRj3tafrmIiuF4+OuhuO/LP/2Guei+OLkAdem9hZ73CCSqz1OhhzvCIyWqxswsVN5iVNXY+0+NXAFrKD3ZhUlrImkHQJxBD/qv7wzuy8TzOYCvehNhY9xsEyDg0adDx5nwHxMzMs6KhDm43MRW47wyb4RUTwej4QL1Jtd3+B7LmLSsEnczPHb8EX8CRaHg0MIHVObUDwPCw5RR0lApEi0XINoeawqmi7pWHbrJpan+F9vKM9IeLDkORF10jEprbhu9ZOZO3mf/Gwio4iSWXEQgHdoiYevUAtd5U/gdAkTReh1OQKly0CAS0hew5aG+1cU8940h5sA0zb+3ljjB5jDwsSnrIjUCxslVOW
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ba1871-63c3-43e1-b12f-08d8325cdcb9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 18:42:49.5507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyRygrAWjV13y4IhdX9CEs5zCyArwKgOogzGDu5OXs+JIrSZetrbJKTrCYYQQqANg8a2YwcRGyDeKvuqAbGnsYAzc9OhC7jkugBeV53TaHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4722
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 14:42:50
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.07.2020 21:55, Eric Blake wrote:
> On 7/20/20 4:00 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We try to go to wakeable sleep, so that, if drain begins it will break
>> the sleep. But what if nbd_client_co_drain_begin() already called and
>> s->drained is already true? We'll go to sleep, and drain will have to
>> wait for the whole timeout. Let's improve it.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
> 
> How frequently did you hit this case?  At any rate, the optimization looks sane, and I'm happy to include it in 5.1.
> 

I don't remember. Probably once? And, as I said in cover letter, it even was not master branch but some my experiment..

-- 
Best regards,
Vladimir

