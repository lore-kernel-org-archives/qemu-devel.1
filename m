Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3378BC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 05:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB700206F9
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 05:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IRsMzL/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB700206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWD3t-0006XV-4E
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 01:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWD34-0005bw-OW; Wed, 06 May 2020 01:56:50 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com
 ([40.107.1.139]:19446 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWD33-0002wh-RH; Wed, 06 May 2020 01:56:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzyxuJzUIzHYrgEwOpVsgWpse2I8rsNDSBPLy6eRo2bclzJ6khEp7iobCHR9IlBHYxQA3ZE5dfJhbPKeSpGsf6U52y4KwD7LGgTI/UvJCWzHEyrM9T2zW6ROax3h/zuBujY07hvtvr5a7HV80j89VPVIieGzO/C7i5dMQJdZ25euWG3wqvzCtAXycTRUQJNUrjvGHtUYaSzcrx/B91ahodxgwqfhlFpmGE53gfY/TKXU+0F2So/GD2Zikb2gnIQom9E3+WJXmLo2lYsTmAbyTeELSiStAPrdE7DfXBTS9pQ+g2HKTKG68U8pivVluBCk9BigQdOeXC03yZAtGbpwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNbNLOImoOwYC6tU7BCpyOCwT2bzOwN2WblXsLodN2Y=;
 b=bXBWEBsEtXCPD6A92G8McD8ITM+NaVz9sZYeSlwPkXMx8fzg1BjI1fZ4rf1mxqfPVtVXOUX6Zr32jvTtqP+kOA4c55vumPd6uMpLoMfSwxTTcqHKDV6Gu5JNXFbJ/ci/a8Ge9nwNGQFBWHiiK3c3u453yW+AFGN1MihLC9z87O7PS1qqtp4zPleebRGzbGF0js8wmWbRsDt47Rjz6Zx9ykTJ/q4i1iq8POIKh6JXBCLp+ACxwxgYD7f3yQow9OZdc7vvlnf1g2vF+oKcw0tqNKI3nA4lH4/4K6ivmpw64nq25UtOj80nXC3+6ibRBrQoI3mZiGAAkodi43nW7A+jig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNbNLOImoOwYC6tU7BCpyOCwT2bzOwN2WblXsLodN2Y=;
 b=IRsMzL/zvHbyr7H6z5vIRhJ+N+/j77f+N8Kh7vTjVun0p7X/AXT9Gr4zos6rZuKM+XR5KYAVk4da4v+ljEOQUI8VfRcSXEXdcl6Y6yvO59XvKN3o5MuZrnPTRURmzonpiLSbvAuAi/Q2pPo78r9b5RTskLS6HTwRyeaBr06utYY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Wed, 6 May
 2020 05:56:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 05:56:46 +0000
Subject: Re: [PATCH v4 0/5] block-copy: use aio-task-pool
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200429130847.28124-1-vsementsov@virtuozzo.com>
 <de0737b8-ad7b-fd1d-7499-4211e06af905@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506085645021
Message-ID: <b704b48b-cece-9788-dbbd-312d4c0a17a3@virtuozzo.com>
Date: Wed, 6 May 2020 08:56:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <de0737b8-ad7b-fd1d-7499-4211e06af905@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Wed, 6 May 2020 05:56:45 +0000
X-Tagtoolbar-Keys: D20200506085645021
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cbe3bb8-f26f-4889-d0d9-08d7f18242ab
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54485221C019D9D1144CA1B3C1A40@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujMNAnmRcrUDaqzNYsvqvujyErOm86f/YJmmyPI2J2gPUt8OYPIFtMvZXGpwTTnN+mwUrnzADbiM6cHw+YNpTfW5olrneS9QyNufKaRkoyyPyHZTIZ53KbNI6tomtw4FHdRMCPQYlJfGctAsKTB61iSlwwZ7SuXkDpKdSY7iKeT2DzJ4Fh2tXy2s1+av9obcr4cQiAA0b6xRC9U8HdRvSNK5P73TZ9gHgJGdTUYPh+pSxc5mIUxd7mMhhrWngrATcB8WXnvrSAWPqpLIUWrhGA2AP7/mSM3Y3IYpuxQ1H+gLsktC/Hc4uefVeQOK1mLTl3f+O6vHaTZRcl5i8Pv3+1pgwgazDkVUOAkCSdxrvSoirL7sL6bkydTNACiIPIGwBl/xfmJKLSupgt08hV6gmC9JhamhZZUJErpoL388k1YrQYLobFFpVQL3yI998HC+8kb2pQirgDLp9m1mkGvmLORnd3WuOxxuI5A2k7xXvRYD24d90Fp8vgPb5ef/Q3PlXTVtmHGDfaiNK2hBHLH4MHxx58dbkC/d7qoJE8I2TztHdsF08IRHQF249TNlNygXsIWtOfEz1sgXmicHiiNAfnolsK4dn7r9KO0X7e3m8WhgY4dhbiRN98KhXwKVkOLD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39840400004)(396003)(33430700001)(33440700001)(66556008)(66476007)(36756003)(66946007)(8676002)(2906002)(86362001)(4744005)(5660300002)(31696002)(8936002)(316002)(16576012)(4326008)(52116002)(966005)(31686004)(478600001)(107886003)(186003)(6486002)(16526019)(956004)(53546011)(26005)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2KSx+WP2bhrc1KM+IjlqmFnO6g6fUzdJU2tuxmeKHXoUKD+w/7PIN8BLvvuN8yUntCfXH6bNh8PtKF25JQUEk6vs3lDxD/oRcL2pT8v4z5/Xlkyq5uYNV+mDQhynfzvaMPRqH5jWf2LfgQGpV4DRBaYWqSzBSx30DM1NODmCnYlbHRKz/eQlfYojeWKjDUSqCWCOKEWlnrx4vO9nkqyyjJnqXUJ1+J/AvTwPhPRENgljgQkc02PDPpKcSRcsAeMBprLqcQ0QRgsUYmngZQ+RbjjgijPjijybKsY3BsgA87RK3iLZBmnl5H8G/4DLSIYT4PcRsmQSBCIkWD183vWDRlC7D2vqP+Zc+IR6xx/i9G7JU1xb9LPqjTNQjy/vE/EkAHD4r9D17FCmZP5a1OwAI6YSUZ9y5lMNoUyhKApm5XIxOfKK4OOb2N+aQ2CRKrO+rMWw7bNerYCCXGgevQZe1V3q7pJkzlx+K4JMcZcM7n0fjkg8VBEoLRa5e6QCbmmODDc1wt0TJw6L8KnCdjQUn0SceoZIgqxjFB78Tl4dK9zlGZ1+DDkkbGyKZgc21wCj4KK7YdDLo+ydfvaUuJ2znZX/nbTW+nE5b1kcLSikfJVDALJHK5ac+BauoWGcSalt6PS8wj86sGEvAtSV9Qls5cYtoswm9/Ah4rdAiMNRG+E15sExyf4VHaOY/c/iivPGKvOInl57EAmDuG5s9IvlTJIPlrpDIp6Qh4YJc/ZLwdt8CzVfSLBfB5zbJuVsCU8KMNZa+gBqBVYuHh/ttp2UkPhb3ln85TYwJu5PKbQcSvc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbe3bb8-f26f-4889-d0d9-08d7f18242ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 05:56:46.3729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jg+QwewphZNGST5H000lbEs5cVSsUQB8JLOmAsmPUENoKzI3mGOU3D7mJv/o0xufeKSmaiOd0VNyNLRmxhq9NfxYVWjzTAhwZfsEqz4l15U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.1.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 01:56:47
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.05.2020 14:06, Max Reitz wrote:
> On 29.04.20 15:08, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> v4
>> 01: add Max's r-b
>> 04: move variable definition to the top of the block, add Max's r-b
>> 05: - change error-codes in block_copy_task_run(), document them
>>        and be more accurate about error code in block_copy_dirty_clusters().
>>      - s/g_free(aio)/aio_task_pool_free(aio)/
> 
> Thanks, applied to my block branch:
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
> 

Thank you!


-- 
Best regards,
Vladimir

