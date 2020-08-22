Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47DDC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 17:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36852078D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 17:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MaTpo3Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36852078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Wx6-0007Bk-Rq
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 13:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k9Ww5-0006JI-PI; Sat, 22 Aug 2020 13:04:09 -0400
Received: from mail-am6eur05on2099.outbound.protection.outlook.com
 ([40.107.22.99]:38369 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k9Ww2-0008Qw-3c; Sat, 22 Aug 2020 13:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMgIhKg5Cns/DzpStoCwjQPyCBHYDZTodXjxfi3/bDECPhkC9tjwJC05LWckcb5sYNb+w6r50mJtYsNAB5KyuEqQyUs04CCljoMKDZZZtBCMWUmlfWSzF3u/RbPRzqAkmLPA4VbInLSh9jLwNarnmotJq0SUs9KlebdP9LifpTRwRFwp+Ze8x+EanQD1DrtH5+yhVd+gv4XJAXaJ/tjqmp0P1NeD1DIelhzaZKOzGNEUJB+9KJ8awGH7HWMQsuJ3a5a/6HCRxEjth6s4c2eqnY6IPGaGm4oJAZc6XErI+IC8q4H7o6n1RPQCMDrOkjA/tuRO//sCpHlwg+KxoKOb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iybsss7OI403Mw74DN7CdChB80ddU93XbMA+P/HNdno=;
 b=YzxuDOcEt9xVRGiwDKkUC14iN4pGMHbW949bSmy4uSL4ATCTo+9+HY/bStvn+DcJoEmmBh/gESw4l1ATAHdsP1Cpwa065tywl4HlMf744zmkCh6ReyaAQb1XYXwOtNf66EmkwBV292+F/QtTDnqR3At02AH1KNbHwJQBWnknxlB8AGKOAmRzLR0AMUs0op2PNsupYsF+btarkRxSKmluXhPK1NxIPe6roWS1t85CqWKJFll1TQcJMHD81/05SsuJKjsaFaRfbqOp50Em9Yk71LE7iawdAxQOC5NfNW1HCKtWTBFAP/FvsXjae4xbnsntaQ9OUapBNJj90mwYC5qcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iybsss7OI403Mw74DN7CdChB80ddU93XbMA+P/HNdno=;
 b=MaTpo3Vl1vPo34rl8O1PjwGojF18x6QvCuYg+fd9PcNb2zxkbZYLretaMlTJYNC5DcE5Cu4l/AkFdzmm48Bg+y0Fc0fM9Ip/KPJy5ILSDNPh0zq0bOkaL3ityPNXR+RbaWYgLEDlYtC+snT7thPNaeKLG0Aw4nvxIZ/prjetKXQ=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4724.eurprd08.prod.outlook.com (2603:10a6:20b:cd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Sat, 22 Aug
 2020 17:04:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Sat, 22 Aug 2020
 17:04:00 +0000
Subject: Re: [PATCH for-4.2 v2 3/3] block/file-posix: Let post-EOF fallocate
 serialize
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191101152510.11719-1-mreitz@redhat.com>
 <20191101152510.11719-4-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d85c544c-70c0-6860-0b5c-a2d46d740d1c@virtuozzo.com>
Date: Sat, 22 Aug 2020 20:03:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20191101152510.11719-4-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Sat, 22 Aug 2020 17:03:59 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92e2d852-b6af-4d36-0f5f-08d846bd5d71
X-MS-TrafficTypeDiagnostic: AM6PR08MB4724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4724FCDF621E6D97144A8083C1580@AM6PR08MB4724.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yxaxmihqq8iTQFgOm0Dvq3f5DhlpAQ0kU8n8jTjZpD0ltzQCxle8EOpvsXi5k0BgXuXH78arZrnK9U/T2/LzMc7OEXL9FnUISiSCau/zVMNKdqTDM5V1cBnPhqej2pesC3mzs7GN1j5x8CVBe8d4cX3Xn6vsvQVRFTJn1CbPLiRdbSggn9phOlhZlikHmCXkQ8pYvFFNou0EisHPkwlcaN1EqVOCPBRskvC6yjKNQ4omoW/gyXOYgxZocQNSvaovA0kjo2ztSMCxYMQwo3vYkaSrp3mGrGjEKkzBMoaXCezfWzvJpbEf7SQWkw8rL3Z1G85u/K1eOBBPhslI5Un9aeXP7MzO+tAaT/10iKbBUMEVzzic5yphtPaYNMQEQgVS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39840400004)(54906003)(36756003)(16576012)(6486002)(16526019)(316002)(31696002)(31686004)(186003)(478600001)(86362001)(26005)(52116002)(4326008)(66946007)(66556008)(66476007)(2906002)(5660300002)(8676002)(107886003)(956004)(2616005)(83380400001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HwOD/04YygWyxJozsde8nkUfd2KARwnHlslWwP2a+7XvmJ6yru4wtQfM5KHy/+SzsaTZD3/A2RewrRZouCLarxFMt3u7bXFNjBwLieEObaZYJZST1Mjy7ns7KAcNnlbDbbepbhebmkvY/0UCDJuZWmXPnR53bVmPfFbZKTfP+OJ0m0fxwYFI8Pr8mltNiUGm8oJtH4iLW8aYF89Nq6rYx8GpTX5dISATGSlfFs4wxl/jQif3pgC+5BQiO3548pR8pAEa7Wgh9OVipAVoK/WKI6egASHSIF6UdcD3G6qG7/MTtVo7WV3RJKL84zQ5GfO2AJF1OiWElQfjR9nFJE5Uln25jSpKDby2tb0CHoV8ZSvb1heJlI89P+ONnM2gVLmkahDAA13UwHZg+ORSQA6ElCdl0BD28zrjm/qSjXkveKYf4BeUL40O8o0IYnldSzcxw9eD4whVcvEoofMEPanUKctbg0TGjOm5MQ3kGxqtsAmaCiLl72IQq41CwCr2ObYZd1gyfCewqFbWDpxGuqbCGooJxcK5p8wCxnlO1ZyZ+XfL1UPACqPjjfyVNBjoHaFHueBCPzU2a7e6kg1/mKU6s+8INiSM+uTKQRNJQl4lg2DPL43wC7yB2jPWFsoW9zNpMWpRqwp1ZcJKhr1yajxyIw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e2d852-b6af-4d36-0f5f-08d846bd5d71
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2020 17:04:00.5310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cc/5IPWxL8ZRBJyNGH46ua2SyIjWrw9UPBU48OD0+Jb7AjYmcC7i2bV7pXVZIM+Lz2jKxq7vlDtgIgqOeAJH3RumGVT5Hkz0qgjs54MDb9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4724
Received-SPF: pass client-ip=40.107.22.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 13:04:01
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.11.2019 18:25, Max Reitz wrote:
> The XFS kernel driver has a bug that may cause data corruption for qcow2
> images as of qemu commit c8bb23cbdbe32f.  We can work around it by
> treating post-EOF fallocates as serializing up until infinity (INT64_MAX
> in practice).

Hi! I'm doing some investigation, and here is an interesting result:

Consider the following test:

img=/ssd/x.qcow2; ./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 50000 -d 64 -f qcow2 -o 1k -s 64k -t none -w $img


Bisecting results changes between 2.12 and 5.1, I found the following:

2.12: ~20s

....

c8bb23cbdbe32 "qcow2: skip writing zero buffers to empty COW areas"  -> becomes ~12s  [1]

....


292d06b925b27 "block/file-posix: Let post-EOF fallocate serialize"   -> becomes ~9s  [2]

....

v5.1 ~9s


And [1] is obvious, it is the main purpose of c8bb23cbdbe32. But [2] is a surprise for me.. Any ideas?

===

just to check: staying at c8bb23cbdbe32 I revert c8bb23cbdbe32 and get again ~19.7s. So [2] doesn't substitute [1].

-- 
Best regards,
Vladimir

