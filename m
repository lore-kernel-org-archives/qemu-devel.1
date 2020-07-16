Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E50C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF3F2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C4gj86gA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF3F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzyA-0007LB-Tc
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzxV-0006qQ-L4; Thu, 16 Jul 2020 05:13:42 -0400
Received: from mail-eopbgr20095.outbound.protection.outlook.com
 ([40.107.2.95]:45181 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzxT-0005SS-8i; Thu, 16 Jul 2020 05:13:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+wcR1Mpy0pWBySLPY7CnJQfUKFUkMyxHtMmIgZXeakoUe/El7pp6nnV+nshZoS6yWh3LgmN6XFGGhda02sO+f1jANz+xlw81io6yTKS0tYjIR/gHuQW15oXPzDsFTG7XUR4ZWXIHMx9DICSr0FxvXQrokt4L+ptSIil0B/8jQhGibaKF4MBTBVmQbAhr4pshqNiXLypBkTgzQp/MKcCIWGyYETVs/d6zlDs8FgNMVkYRMVUPyMgFB7t0vctTONTvBvqy7VreP/q9x6boVIMgMUqUvekmc+TlnF0zMyyf+gW8+a87luwKH+DS8D3H2k89f4eW2I/2K/A6IfvW81BxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUpbXqNkWjOrW+HIswqAgbExpezOG9w1U1CNVimVGuo=;
 b=aYrZQvt+6dFwIbwVub2gZD0c4Khr/utkVNkIIXtNQ40gx2JjV1RHo/cSeMcFZlstv+4IzLS7KBjwENSrUTuqOKrHzuZRCB88FX2wBu5gCfi48pZjWM5qSe7qvt7r0ytoIcm2DvU/ORqcNwTRPVbPyUkRkD0446Qt+cFjkjvCVpZkeWlYwfCBn9USUJNZrUV14p+mkk5FbLr7aWyLwsO1tvH/WG87WnA7gwmfcrGy0Kb67l6TXlQ2nuWNxK556m71xF+8xBTGBmupp1IFnq8Sxo3vDF9oSvZkf3xATeXktW7n1nWpJWfyh06FyLZxL4umcq831weKggWe5XT7ARLpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUpbXqNkWjOrW+HIswqAgbExpezOG9w1U1CNVimVGuo=;
 b=C4gj86gA16ZBn1NCLN0WclCXs5esOlRDsEg2WucpQ/Jd7cGnoA+Zqeht/nFa5xvRvSpnSRiFbnP6yUkeYzMGAfrDzW8mv3FY4EWui2tQarwLr9A1q/8NyZdqhX9pwCq3FnwIG73/KcsV/08416ivNw0gGwFYD0kq8GU35jxT2lM=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4088.eurprd08.prod.outlook.com (2603:10a6:20b:a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 16 Jul
 2020 09:13:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 09:13:34 +0000
Subject: Re: [PATCH v8 05/10] qcow2_format.py: Dump bitmap directory
 information
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-6-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a1972f8d-3ecb-1053-e6d8-bf80b0a3a583@virtuozzo.com>
Date: Thu, 16 Jul 2020 12:13:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1593782030-521984-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0149.eurprd04.prod.outlook.com (2603:10a6:207::33)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM3PR04CA0149.eurprd04.prod.outlook.com (2603:10a6:207::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 09:13:34 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeea4a50-3f7d-4275-e8f7-08d829688467
X-MS-TrafficTypeDiagnostic: AM6PR08MB4088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4088B273D15DDE419843E213C17F0@AM6PR08MB4088.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eQd3f/nxKTPlSlnq9bacu9AR8Lgg5GZAlmDCYAWX/AZ3/VOT5+rU020HDw5gOclIb5gK0mWWLGMRCsgXEcl+XKkWzHSrbLF+3QRwwzgGIUZRVZYgIOPtAZNo2UVsyCEGPDn8QMQhXZ+ywkTkfrEBkwIKmGnzlPw7GWvtabM9fOsLwxQgSK3plwgtVTD5W8sI3FvzRFPM4QTct84DdEWWxyFuT8l+oxBPRiy2AB/h0Xa6rtl7EquwqdcSxpEKQqi0xYF26Lr3Yv37RD5sLdFPufoM3aYcGNN8Ch3hcbmaz1hqGoihpbltF/hFAe4VR+3mCqvX/NpJz7DC2oT9HRSsCUSy58wZ80MNmtyzhnoWLf7uf2kbCs+r61DaId+Jlfd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(396003)(346002)(376002)(366004)(5660300002)(4744005)(31686004)(36756003)(66946007)(8936002)(2616005)(26005)(186003)(16526019)(956004)(86362001)(6486002)(31696002)(316002)(4326008)(66476007)(66556008)(16576012)(107886003)(8676002)(2906002)(478600001)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jYS5SoKVPDpZAYTTdRiLnxynJyyc2a5woUI2Yu8+P5YNnb9w6UYQw2rahwGSxhwE+Y0tq94U53ywyCEUfnbYxdrKhLx4iLCWHRAVAzTPrAu9K48KFerjcdO4PhcRYRi1rUKADzqtM6GBimCRNz87mklneS+VFYzqlCPHV07Nw2OxSJAB+PUW6ETsWC/lp01REyyDtZsNyH+ZSci7UKumVFMj0Ln4LMVTiC/sInJn5I/cSb3tvLRubW6zs8t3m3PvHUrg1/gLfFmj+HD/HyRCl7K22N2kcFv2fG8p1tb8G+WrezmAlvMldrZAv3n/S9mxqEVXpyZSDqZN/jgah+m5ZgFrkJGEat7jOfJg5nDqLkBGT2Aq31MGq0wJ3IbuK0cDjFL3yLxIysKcc8cLQiflpgaBhSGcGSbJpkBSzUQ0GtZ2xH5ElOZKbEb3FaGNTrdA5tq1WX1tiRfIV1TbqVyPv8QX0tZij4rm60RJ7Y5fQAbgWv0NG2qL/4QrC5MRLDI1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeea4a50-3f7d-4275-e8f7-08d829688467
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 09:13:34.8790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScQ0lbgOxsZL+pKaC10QXoc0Bg596Lu81SQxnqd9eKpqnQBN7FMgEu72VlOdqAbHGeh0+97Zvz2v+8HQpBvUgIKPMpnsZTZS4XmpSM5+4k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4088
Received-SPF: pass client-ip=40.107.2.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 05:13:36
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

03.07.2020 16:13, Andrey Shinkevich wrote:
> Read and dump entries from the bitmap directory of QCOW2 image.
> It extends the output in the test case #291.
> 
> Header extension:
> magic                     0x23852875 (Bitmaps)
> ...
> 
> Bitmap name               bitmap-1
> bitmap_table_offset       0xf0000
> bitmap_table_size         1
> flags                     0x2 (['auto'])
> type                      1
> granularity_bits          16
> name_size                 8
> extra_data_size           0
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

