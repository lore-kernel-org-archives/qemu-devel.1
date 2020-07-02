Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1C9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED61720890
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xy2XMIqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED61720890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqytd-0007gA-7j
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqysu-00074g-OU; Thu, 02 Jul 2020 09:04:12 -0400
Received: from mail-vi1eur05on2111.outbound.protection.outlook.com
 ([40.107.21.111]:12161 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqyss-0001aJ-5B; Thu, 02 Jul 2020 09:04:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnu6O0gxm9u40O3WznPnGSdP89DrfSmUB0GfhEuqzWRgPnHhtbIOITShAAzQvzgdVq3lx8/BSPe/L6kAaX3n7wZtutvGM5ESVbMjwlqrZ+bnUxPAUwpLIXahZzpOAkAt4uxTCnilcNkUzYXR+8mgBsEC8W6g8LOVmAaaWVpVN0tjpYfwSWElomsCB5AQbNWKYcZcnbQ7oBbGQzNH+OMXDZGZy/mwJrr2Veor58L9PK6+Y5/pQc6MIq7cWOlQZRoPTRTSFHSvuawgCWXA68hX3gaMYG0SdzlE/WUdOD+cml6tBtLLzfai/6/NtNup23bPZF9Pw1IUgyzaKximfxjfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuQ52ozmJwKf3ca7wFmg5ULsKyzU6NeCCaiJs8mQNVo=;
 b=majF2apTnyQiupDnvkoUArU/s50mfEM8IhBB3y3HE4g2w58sAglXNZUkmBRltEwG7CYdKcExyxFFwRVBm/DLImMUZCKuSgkwoa07dWxnOq7quZUHp2oBgwW2hyHwCKIT+bdOxuQOPCGJUEPtEN8zeJfd4oKNawFOgkQuwjmQSvvVGs7ayPvF4ykQWwIP5w4jkSqGjrq8Nq8AG9cKjWs4HXofV7leRk2+/ssGTzB2wAT1whD9OQjRyTp3b+qVgP26nCR0V3tzh0OAH3w4ShXGrfx1mwjnmNxDS3JR4oSih4+OLKiZ32+CX0PiIzrCfeXck+htTLF3eNGJS0SCvLr+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuQ52ozmJwKf3ca7wFmg5ULsKyzU6NeCCaiJs8mQNVo=;
 b=Xy2XMIqbqT8rxNiMOXy6mXrzvemoSir6E+kb2z+UqXFhxDMGjqW1eUg62EyV9lM7fk8WIDk3eyW3IrV1M+pS/yJ8vywvEzKwNx73Ueiqh9Cw2OmM3Rj8dkYLhKscCdYEMtjcdxGDr6U97DmAD5iNGCxyvQotM9ysSLHTkpXbLIY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4786.eurprd08.prod.outlook.com (2603:10a6:20b:cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Thu, 2 Jul
 2020 13:04:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 13:04:05 +0000
Subject: Re: [PATCH 2/4] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-3-mreitz@redhat.com>
 <635e40aa-f289-da2f-274f-17c9d0e05003@virtuozzo.com>
 <02586cc8-138c-2bc8-c79a-cf3371a5afd4@redhat.com>
 <72cc50dd-d204-0de4-21cc-11d4d78f7c47@virtuozzo.com>
 <889082d7-c917-ba7c-6da3-e854d8c44a32@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8c1cfa41-e0b7-c66c-8f71-786c0f7deade@virtuozzo.com>
Date: Thu, 2 Jul 2020 16:04:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <889082d7-c917-ba7c-6da3-e854d8c44a32@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:205::31)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.54) by
 AM4PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:205::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 13:04:04 +0000
X-Originating-IP: [185.215.60.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5b2cd79-04c8-44e5-6fbb-08d81e886642
X-MS-TrafficTypeDiagnostic: AM6PR08MB4786:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4786363172F2F05418F8AAF8C16D0@AM6PR08MB4786.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOFShT7Hf/wHLk6OoPJQs+3aljZwWX5DXMDXMuOg8gcbOfBgahumgpj/lS7CJJHy/YmjJAcF80pETyirjXC1W+eelNUaiv9OljUxmQ8Vhtj45XK8rBZQdmPSw7vg/fdS3yB0pkCZ1TfuVYJc9N+TBMsHrnWHS+7PmQ/d9OQsNoGjCTsMC6wPuHBbqG6pBFLv7CzQJdrbLieY/dd8xOhXlJHZ5+Z3Fs6gCY7SNlYBC01aCqLwYViWq1TpkuMeyqKpZlLtwm6P+z/tAHF46JODfaOjAEmVRwan7Qy8NUSyyyTONyfCAn2Cx2+2z1ib2DS5mWgEvHzyN9i4M+hfF6OWprtX/pY8gnyp564shbuq+S4F+roq8SczHBlXpw/CKS4w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(376002)(346002)(366004)(136003)(26005)(6486002)(31686004)(186003)(4326008)(16526019)(52116002)(2906002)(316002)(54906003)(8936002)(16576012)(86362001)(8676002)(36756003)(478600001)(66946007)(66476007)(66556008)(31696002)(2616005)(956004)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: P+7dHlI59jCUci36KBtm+UJaoGHGjEw+IFHMmG/xdatEF8sBRidzta2bNxNy+bhjVyCmz/L4O/Vb9/r+cXwMVwAxT2et/RfalN36yivF/Oyed4E98yUpsK8TkIBGAuQYI5G2o/gV+oTh5LZCY8IVePDztlegpVsjNgubvdZICVSDAtzz1wLb6iYzX+n34qVfK/q+3lWeCAu8xTtBWjMA9ynWRMVd+HIUTtxi5RTe7AkOtAQL23DzBVB9rzOU42nNNrUI48bjBvO1rJ9m3REj3rF8Su+ouitTT4v6H4k4i1mMACPTx/kZYRhxcA+QtxTyCIdPZvZhGnpCDJarHQCCrvUYv5wICfSc1f5g4qN9Htf259SaqyNW/b83CyZG//w53y6YBmhGxXpfAayHYBhi1mmDPm25ck96sc54owKHbzYisodYYGC7T3PEmqrTiqQsA/k1Hd+r4FgxDuEGOmiyT39k8LNqnvVi84TYYuujv8hdWj4FD+kdMPgJIvvTdSmP
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b2cd79-04c8-44e5-6fbb-08d81e886642
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 13:04:05.4882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvtkiaBjadHnkNFYFeZM70LtNU12e5PByoIFsWc9zwF3AQMyh2rSGyfCkovPcF2Ri0jl73FnBE7PbBsWd/NWQVgHj0PmsSIsG/wizS12QSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4786
Received-SPF: pass client-ip=40.107.21.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 09:04:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 12:41, Max Reitz wrote:
>>>> As I've said before, it may be reasonable to ignore bitmaps not
>>>> referenced in the hash-table.
>>> No problem with that.  We just decided on this behavior when we
>>> discussed the RFC.
>> Sorry for that. The reason for my changed opinion is a recent bug from
>> customers about bitmap migration.
> No problem.  (My original proposal was different still, where
> non-specified mappings would default to the identity mapping.)
> 

And, remembering, what my series "[PATCH v2 00/22] Fix error handling during bitmap postcopy" is for, I have one more reason for non-strict behavior around bitmap migration in general:

Bitmaps are migrating postcopy. We can't rollback in general, so we should ignore any error during bitmaps migration, as it's non critical data, and we must not break already running target due to some bitmap issue. Failed bitmap migration should never be a problem, the worst consequence is necessity to create a full backup instead of incremental.


-- 
Best regards,
Vladimir

