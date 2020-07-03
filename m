Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF78C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF34220772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nOF+cueL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF34220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKpk-0006iJ-10
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrKoi-0006CH-Se; Fri, 03 Jul 2020 08:29:20 -0400
Received: from mail-eopbgr20122.outbound.protection.outlook.com
 ([40.107.2.122]:3093 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrKog-0005oD-HA; Fri, 03 Jul 2020 08:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkcWTAtAVxR+FgAUVIps1AtxEfNUrtRiAc0uR0WLcDa6XeV6w/Hl7V+vc+Q/qC1YYiRlIe2UTQaK6c05ICRvQ1MWV1Ll+EUkDu3xkIBKwblzzEKDF6SNVUnELuqeWKEyw4OvapoCxxDK6Sp9uGUvt1YPeR6e5IzZxCKy9CogC2osInGS3XJIS9Cz45O4I7sV9JMBbG/E3ImHoFWeSPmxLUF7MseQtv+NUDCSmPQlZmcCaovvQg3GFHEZNwH3ZexrHrkvnS0n6a/n477OZ0LBk8ufPig44MaBpgZc6piSVV0IPaMaW0wbK0/4c/x+P5DnF1VSeKjiz8vdSWIp+OOxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWd9OmAhnlM3vlZth+orXxW2gaokpxK3QSwrptPne3Q=;
 b=VkRlH7Z40j5RL8XN1v/rKJqXYMpN+hnzRxA2LCAUaw2iS8wkkxUChaTjanbqhenawqeHR2SO4aRoprEWSm3MNMqhGTcdvFbAFO2VHuQE8IB4NWtgqvEkxF0zQTFdUz8koG1v8WQPSmYIS0P1j+lAd1XXW4Rm8egXjZDkAmYVc3ChdAtsCAE7gkfedQBamP+LbMFGREEWOpTsfMIlrzKxfEwpA/aqxPA4NZTfvHCW9uS+BMwIAtp232q/gO2MpbPB6V7ZFoHzHrm2oafgR42+v9tBPypMj0/5qediH8cdn1bgZrAA/kbxmLodgqbcKN5xi4iZgyCqpZEDIqEISK7lCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWd9OmAhnlM3vlZth+orXxW2gaokpxK3QSwrptPne3Q=;
 b=nOF+cueL6962QgZroeVVpw3A53Ji9bDkPne1u93w1i9nOYaSfDkLwm7xPRHJGg6OJF+JwJDw+AgxsjxoO32u4x1LCJiNQ46gFNGRVooCHumFn9aEJRj5KJKdq7BW5k2GpLHQjWiWOIIfdiVtEHYo7NDK8bafC1vKxoGnCAbZSVE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4914.eurprd08.prod.outlook.com (2603:10a6:20b:cf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 12:29:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 12:29:14 +0000
Subject: Re: [PATCH v2 15/44] hmp: Eliminate a variable in
 hmp_migrate_set_parameter()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-16-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4dfb0f8a-6260-3082-18a1-c3d82bdc6d40@virtuozzo.com>
Date: Fri, 3 Jul 2020 15:29:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0094.eurprd02.prod.outlook.com
 (2603:10a6:208:154::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM0PR02CA0094.eurprd02.prod.outlook.com (2603:10a6:208:154::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Fri, 3 Jul 2020 12:29:13 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a3aee2-a2b5-48e4-f0a1-08d81f4cb266
X-MS-TrafficTypeDiagnostic: AM6PR08MB4914:
X-Microsoft-Antispam-PRVS: <AM6PR08MB49148E10DF962E303850204CC16A0@AM6PR08MB4914.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oC6pEATcuC0fpdlW+KlAmwvtYS9x4dMZcds4U9XVRqyunZyqfGKoR72TqdGZsJPdAO9EqMf465/I+hRJNLIzhWwjzAmuQ10cr/5LWShF/J7fe/7pyo2nX9pvtp8/2Jkjp9DrSHGXsq5MCJznN1DYtZNWBPdaAoRii4+KF7jMPkwX02vro7aqd1M2vNJMtlKIvbJk90ioehb+LeieLQqj4TmQyF7eXwkmD8m7Mjue60+zJ4tTs+bTChu0amd9aA/E3r5htTTFXM/6K+ftBoNNfYWIqIkql0hFpOFU6v/zk27SQa4B+/2Wkyz+dFRn0e3XsowmQ4QkK4oisFvQ84C8JyQXWKcfIPOnCq1L97HavRZwnrs5VFxQviB2XWkzCkIg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39840400004)(346002)(396003)(376002)(558084003)(8936002)(16526019)(66946007)(66476007)(66556008)(31686004)(8676002)(86362001)(26005)(186003)(2616005)(52116002)(31696002)(956004)(316002)(16576012)(478600001)(6486002)(5660300002)(4326008)(36756003)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ma0VIGnm95drNJyr//ID+5bVD/jKhQuzZ/sadQMctwbOfH1Sxx8o4MmL+xAyRsQCqRsk0mfBY6uI/ptt3yQ9lI25M+q/X9xnZBgWF5EMFaTyLKl7/lZULFyXRByoO3bDZBHVhtoJHZSIv2dsvDB6M2Kyxs1AMki2L6cxDmvMiv502FaAwXxhfO6fDQnkeg57wk4kqsoMjtmpkjH1N7NdDhXv165JSD4dcUiSsfmqn9JWGFcxi+B6B+C/cCMOOTtQjti8l6zQ0ub2U3kRH/1LINBXgJIV7xVj7iIT6IKq5Gllu7vzhlPbfqFYOHZmC6mgIv7r4GyBfZLmw3EOGkFuAmu8dj2o5DpdbRbhCJR17t811cS8N4RA+ibLGPEqFzItng7SIUfhfKqhHt6fWeRpYYvZygtmMwjVl7W7SmLIgmfNqH5S7jXonPhQSpzzKVejl2kBZ9ngaM/mNIVXQICNldlkDxKQvNJ1ZsnPZfSfF4z67n9akG4GJvrxP5NGE2n7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a3aee2-a2b5-48e4-f0a1-08d81f4cb266
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 12:29:14.5594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNmzVlEqt2b0+PqJrAhO2ncc8eAIh4XupWyHmk4EBe/vftWPClezBbWSRcBIefNbiIh4g6d8xp6RpVb26DxCXOdxe53ep3aEBuT03YWJpDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4914
Received-SPF: pass client-ip=40.107.2.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 08:29:16
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

