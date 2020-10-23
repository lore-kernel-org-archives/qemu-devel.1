Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282FEC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F652168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VJiy7kBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F652168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVy91-0008U0-FM
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVy7w-0007Sb-Jc; Fri, 23 Oct 2020 10:33:09 -0400
Received: from mail-eopbgr40119.outbound.protection.outlook.com
 ([40.107.4.119]:23548 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVy7u-00021U-QN; Fri, 23 Oct 2020 10:33:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfD6N5GOIzLcY1EOUOTEYZr2f68Z9yz3Gj4s+dx6t++pxL3pYMHG4iPyWOrO9XXifp9ggUyJNQqkdbm1V3K8ND1JOE0G3yFlAn+2kp+rZrtMKItIGhbM2f/0EIKTI4kXG0WqsVnKzBsANxPMAavVmb6F0G2OZfC/tywGGCdG85HPWi9jnkvaaLPtZ9/3g5aJZQgHw0ikAX/F/akxt9/5Z8VUaCM+bLs37jF+B9lKIuNTB2vmeTmj1+lC9KMmnSb2u/lIJfpPFdPqn1VYivhxzxUl80GIsgT6nQwXMLG6VJkdPbk4t+5ysrNv509bzt9aRxaYPATH2IlfP6XgTFe1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j72KVG+rRK6/ExgH40LIdeOntKIOpsReyUtlVtwfKMg=;
 b=XXqMQa72z4X/fPlccLO0iugItUyweTCuOaeyvKnWe2MC/gxyQ9M4AywdItPVA7PyhuaVZ94qjvEZTeHRKxN0wsdqieLqhTFhxPNJ5Vos5IHzNerCJUIcxoBRgREMJcsnF6X76/JiGLQdg5Z9/Cjf2vZCtLYfWzjHGao5S2zjQwteMf5V4xRkclnlnTFH7hUm7F5R7IKpo3MYUTKaEGL0LIp82IcyLFacTpCbQgkMI20cUS5+WFfgVsMPPm07S3ndayvpPG9YF+1446VKmqdZnT0o6fb9VrdW2ICWK4J37OL/fSPuXsAJbMw3/vHni+Zk3ztIRfgPDMjnKVyB05kJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j72KVG+rRK6/ExgH40LIdeOntKIOpsReyUtlVtwfKMg=;
 b=VJiy7kBRGF6VMVaY5Idf70g7YCnHTP8IDQqS3HQCe9GC1BCXGz4V3SLa/xeJre1r4IynitfOruzjLzxv0hrZ7iVvMzqJKmtyFCHoiTDEe3ACEptmCXdac3inySh/sers+A5CFPaOlbKTFMyXmnoh27/dh4lcfxnP8HeCIH3NAMI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4407.eurprd08.prod.outlook.com (2603:10a6:20b:bd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 14:33:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 14:33:01 +0000
Subject: Re: [PATCH v12 03/14] copy-on-read: add filter drop function
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <68676cb2-0945-20f0-4f40-23a2471b1ef1@virtuozzo.com>
Date: Fri, 23 Oct 2020 17:32:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.98]
X-ClientProxiedBy: AM0PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:208:be::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.98) by
 AM0PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:208:be::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Fri, 23 Oct 2020 14:33:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bb40d84-61ba-4966-6e9d-08d877608b65
X-MS-TrafficTypeDiagnostic: AM6PR08MB4407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB440706CA34492C2C6A980141C11A0@AM6PR08MB4407.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6f4ju+orxDaYMR5LGtMzy++2TLu4BBiJwZx+Qte8DGJHnGcXMucsyQRTvgFjoqI18dfTRykn6TeqBpvsaHwVMLaGeMaoAocXiJ6a/N4nUiyw4z8zfAtNBePeqB/SYabkBfYFhv97febfmPPtzD8NGon8xqR/ChgwkHCMTm38cusYDTUvVhPIlb8BJ2VeHs2rgYLWp8zNHVp8ZKn45CzOmqYGLn4NKu6OSoesXt4LwJV/C1JwsGBoYrMHpw/3u4Vn95rZw9GaY6o1NWSrSq0FrE16wzwuGHkq0IV2mVTPlzaHPhxyrI1aCx31cqCHyij3piOlKueqIJm7jK2cdEEL/KDiZ7u5H3KlsgfitzCVpstW1TPhPxvXeUrvoWBX4Dt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39850400004)(316002)(83380400001)(86362001)(107886003)(52116002)(5660300002)(2616005)(31696002)(8676002)(31686004)(956004)(4326008)(66556008)(6486002)(26005)(16526019)(186003)(66946007)(36756003)(2906002)(478600001)(4744005)(8936002)(16576012)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jax0uuVHitkRfUY4ixeBKgHub+va3stTO3TspRCAkryz0UO9M1iyNrCreZtQno7j0ip+d+s6dePZ3ztCXYDUEpyvWVTqaeupxVe6uOg0N7WWqWXAXFNI7KhZgXJaV6spDj0FR9lfUXJkafr+uYu9UajfW8PJ/MuDeqo/QZBK3HKP8Br7x3gTQ/tkg7649e222DO3TsFH97v8vZrGbiYPDR1yQjphlV74AMe8Rs5QDNn4j3d72nwsBwtjQEJ+LgLl7o03zN9Y4LEkVGqQ5DRq3kVSPJqzfkv6RseZU6VAsRVXEkSU3vFmNL+PbfnBevgit1K2Rk7x9uItx2CMzi5mce/C9DBgC844aqO3yxrsTnrMDiiGfLP62rbj2GIr1sM/pX6GEK8wrmTvftCL54+zcdwtF9WsP6FBnWZU1OhrXeCBu441KSH+7o84XWql+aANF5+RbObMV46I3EG5vw3w7H7StZTYa2RbRTANTE3M0wQDogdzLf2kN4x9OTweKJrgxciSlYmeI/F0DWGUV08tWHVYFUX0r/FPzwoYL0B9g6stYBaZuHNrs9d5k+UCGIQemRwkIXF5gm18KfRVs0COR+5VgfTAwtsaX9Od7vBfR38axCngx+1b9jOo9UF3srYed2txzW4LPv3HQfbmL7Z1AA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb40d84-61ba-4966-6e9d-08d877608b65
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 14:33:01.3077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Sr0wWMZzo+zvmBba4FJjjIVeEGvwjSQ+Gs7GXozt1a2lOXm1VT9rX+x67bEi4gU0IOVy54CbAyEiSqXCsyzY3EQbVp6jpMt7CfciAyLqmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4407
Received-SPF: pass client-ip=40.107.4.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 10:33:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001,
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

22.10.2020 21:13, Andrey Shinkevich wrote:
> Provide API for the COR-filter removal. Also, drop the filter child
> permissions for an inactive state when the filter node is being
> removed. This function may be considered as an intermediate solution
> before we are able to use bdrv_remove_node(). It will be possible once
> the QEMU permission update system has overhauled.
> To insert the filter, the block generic layer function
> bdrv_insert_node() can be used.
> 
> Signed-off-by: Andrey Shinkevich<andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

