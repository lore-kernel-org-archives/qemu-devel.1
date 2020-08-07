Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE01221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZHQYTfUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE01221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xSp-0006ms-PY
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3xRu-0005fA-2D; Fri, 07 Aug 2020 04:09:58 -0400
Received: from mail-eopbgr130119.outbound.protection.outlook.com
 ([40.107.13.119]:20031 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3xRq-0001VH-HF; Fri, 07 Aug 2020 04:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhfbM70R4YMvRqCRSLz72STlBWBToUqw2/fjN2vXLY+aBRifsRn9NEFpqqOFuZNdWpbAqrbFFkb7rO0kh7QG6rxD3MifRxRk54Q35PSCwMt+tF0dvF/fyT+0l8YBdjMLssnsoW5m1FzCbibbHW/tfP2Y1wrco0VMYRE8tkQJ6IlErgP7jy6h76x7KsGzpCTuGroUBj+9VvJK8jfFeqBMQ4eLw/Bd+H/8WmY+IZt41/USk3oA6vcs45PjEUqJIuiAYFR7uYMTFZ3MytV6zyu/1OH8n9NMlORLOnqOF2dqYrpygnd5jPJ+g7UVYPg4Z3FwXZAMcKYHhq43i0rkNXk7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMr3o2tnsIMDm2T1QDerSAqu+sJ97FOGFHKxBw7YhyA=;
 b=Onp7GW3URHREZoUiH06HATAEKxSpNW4cH+VMU6y1QK8cEm7OSVuU8jjQDH83BQ+90q5ETUouo010Eee6Mh3ZfVEajJV7cXf8gkjsx8DxheqsQvjBfjTfcY9cMXg68IKejMl4SekPgy+t0vgxITSo8zNRu1L/VejVuK367SHGPKI9UBHh1qR9e2o+epT4xQGLlbIkN6+NNShz/j5q9nYu9ZAZEZbXE8Ge1Bq5AI6ijUGrPoLeWDI9XDVndgQdJzW5t2M8FkpxdQ1iOG9hH2afYobfHdh1WDpQn5ARc1+Wk70QSNyw6F7H7800y8f3ht6j8H53yOBRvOJuXKAXVdG2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMr3o2tnsIMDm2T1QDerSAqu+sJ97FOGFHKxBw7YhyA=;
 b=ZHQYTfUuSzSQIseHLbumjFBhYVdM9qRI6xZ7C+ZAxtU2JmtD1RFrsYFC0Ih+Ul6HcCHECyNHzvgvDppd0vcThqdtfMRNQ0hoDeGhY0p5Qn5gGQiQhrZklSow6p3WJstJDXZZtDXNemRKkIcfOFfnSFCgx67/t7CNpX/cLikQi9k=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Fri, 7 Aug
 2020 08:09:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 08:09:50 +0000
Subject: Re: [PATCH v13 09/11] qcow2_format.py: collect fields to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596742557-320265-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596742557-320265-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <552171df-3015-4f88-48c9-0862bb0b8396@virtuozzo.com>
 <c718f884-579e-c658-1ba6-a584a4598e82@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <16f57b1a-b1ee-c974-ad45-7be32b0d73b6@virtuozzo.com>
Date: Fri, 7 Aug 2020 11:09:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <c718f884-579e-c658-1ba6-a584a4598e82@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.177) by
 AM0PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:208:d2::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.17 via Frontend Transport; Fri, 7 Aug 2020 08:09:49 +0000
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ce0babc-0af9-43a4-60db-08d83aa941a8
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29812E589DAAA6B318EC2122C1490@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46D70GOihm7Nwqs2ErkQJytyLngoBKG+JbIudxWh+UKume/1PSGkch6f2fFmImPaeC8Mhd19nG2Hx4pXWXJpVaUJKLZ3qKXyH+de4zbArQSWxcpOeC+BEpyJuSR12ZBOs+lpFcPz/DB/byxvhwM4whP+KIf27qNjWSiZ4XiKLXnQKbO9h4sC56sR4Ud4H71vYrGKeNOJC0Epm6xRtCKAo8U9sp85zh+fbBRVQf8AIzpRvb2acZOmXXt4YbFflKmmlYrnxuUqVZKEnAGVTYuhGkE6sSvdAbTUV2LNXxGwq9gpVj5o51hfwqqs0RoS73xHtdo9L+eHFDNdzsy9v/rcODSsCTe5koeMh4MmodeJ0D/0FEDUdiN4QpbCKht2qMJz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(66556008)(66476007)(956004)(5660300002)(66946007)(2616005)(4744005)(16576012)(316002)(31696002)(107886003)(4326008)(31686004)(36756003)(8676002)(86362001)(8936002)(6486002)(83380400001)(186003)(26005)(16526019)(53546011)(52116002)(2906002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xg533FB+4jp6Nh9I3n3mp265nMN5ve4EhkYIl/FcFxbTkoAajajV6TyYvjESvzI+tdHdKi82EvTOROxVCL5L10JadR0uW2PP5L7X+hBilaWgSrtJSTs4Ai9inHRSgHUC4U6nn6A6tYFw7+xkG++PTyBFZ9a0EDvchm+mT+P+AQkhSF2pzacepM2U45glMLt11fNSShNWq7tpFGAmMwOeRVVNScs5J8O1jrlvKPQwgRgRTmE3FhXmX4feehfca40CDTplijDbwzY3xJXtkUhj9YbygmjUVb2sAfWjVmKOL7q97GdkdXpWclnkn9MIy2S4vTUjCqROiiYHIGRxEGEstF3BoVvj3ILsHyvFGvCNbhI8f0BbSO/OQWdM5OyHWgjBAXPxqZHNgJgdbtkr943rgAdSs6cSKP3sn0CfF758/8WThWPR1e1zijGycA+rnxxF2LT6ulC6TRYYSfvS0Qgfe8SIRwgFoEs/bl6ZhpOTEzTGap/zf+AT/Zv/+9cMi0GKdipDiYQO2jRpGrkuPrZgbMvmEBorUEx1k2xjXwLag2bVRbPMbkoMTUuC5Xef06wsqVbBRZ1twoV83lz4HRkTKi5xfSHqdUCro4VfET2ch+qvP6SqKNvsZNZ+vfPMzpTMoHLB2cEIlry72Ouf9ErH8g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce0babc-0af9-43a4-60db-08d83aa941a8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 08:09:49.9956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ5RA1vZZ86beDOLp6X/4WkHNtl7vxctj6tYuyWtkOjJ/tCd01tyfJuZQwB7YAKXlGqgNAzDNV35AjRR+Q5WfVFimpZmQ3Gfu2tVsOEIOjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.13.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:09:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

07.08.2020 11:03, Andrey Shinkevich wrote:
> On 07.08.2020 09:30, Vladimir Sementsov-Ogievskiy wrote:
>> 06.08.2020 22:35, Andrey Shinkevich wrote:
>>> As __dict__ is being extended with class members we do not want to
>>> print, add the to_dict() method to classes that returns a dictionary
>>
>> to_json() ... that returns a json-dumpable object
>>
> 
> New version to release with the commit message fix?
> 

Not worth resending, it can be touched when queuing.

> 
>>> with desired fields and their values. Extend it in subclass when
>>> necessary to print the final dictionary in the JSON output which
>>> follows.
>>>
>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>>


-- 
Best regards,
Vladimir

