Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0905C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 17:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B0420714
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 17:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m8tSt76J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B0420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Wxd-0008CN-NI
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 13:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k9Wwx-0007Cx-C1; Sat, 22 Aug 2020 13:05:03 -0400
Received: from mail-eopbgr150121.outbound.protection.outlook.com
 ([40.107.15.121]:48300 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k9Wwv-00006l-9b; Sat, 22 Aug 2020 13:05:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsyAGrtElUL1TYwgtbp+DEn55zH4Xrcd2Sc/+81MOUi1pLExdS/kfOq6U4ji5lgcxLq1cdHxQMYF+cdHLjTVcvEmBeVxcgZPJ+DruyZILIVsJK/4j0+4IGnryeSQEJH+nqkUd6UQgXyM9t1ftpY6nq2YgjuBu+3rRDiJqEiOGyBCFis25t3Yn5pureKJh/noVcWxqlfgFhr1EtZmS0RXCUhT0WIK8+M2qyYnGl0R+ZYh56gXMwlRCD+gTSrgqb75IMYGf5WUyrWiRhMGOr1c+/MGSNJgeYYNY0vYHGhgH9UcKyv8eW8htU3qeakuCZXYzCKVv+laqdL3qaUR+bMYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYUCuDOSDfYuZv/E2RA2MuRBY8JNlwbgVOFcqseBxB0=;
 b=TlFGfebqtmZnQmj9WZEjUKXgI8tVUDi9ynsX6MmGp2SYxOgT4yNFRX4cM9/btRVLTkebWw88cBI/rSf26/5E0EKpDOdKgm0Dhmh+yVETn4d14FFwkrHZ2VLT8mDd59YmvYKsL9dHm381SAKS8jFjgUVknUt26wvAuo9C9oUP+r1vAUDUUUlrTOjLmlJx3e3G2D9qi28iwtmWE/0nk//qOu3hz0HeXe5qkVVJGTg2GdULnTJbx8AfbZMEL19LTqPj+BE5j+Y/YR77c1IC1ftWG7gombPL6eOk1EWQB3KJYPn2d16K0KUiYDfktDPq1MVA57b3fwES1aEIiK6OhiSGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYUCuDOSDfYuZv/E2RA2MuRBY8JNlwbgVOFcqseBxB0=;
 b=m8tSt76JH1pI70mXQk4fjqUPTAPfSmLJ9j7947KsURBN94baNHhXU/WP4lWBH05qgW1nlKY40sbix6uleQBrJy2MxWJw2kzgPKdCZa2rL55Fd+bwv6VaOZcmWubxMqMFBMgTfTwPMcT614CIoUVdrmby2RjqJTCInTHFEgjafOQ=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3541.eurprd08.prod.outlook.com (2603:10a6:20b:51::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Sat, 22 Aug
 2020 17:04:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Sat, 22 Aug 2020
 17:04:58 +0000
Subject: Re: [PATCH for-4.2 v2 3/3] block/file-posix: Let post-EOF fallocate
 serialize
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191101152510.11719-1-mreitz@redhat.com>
 <20191101152510.11719-4-mreitz@redhat.com>
 <d85c544c-70c0-6860-0b5c-a2d46d740d1c@virtuozzo.com>
Message-ID: <de210b71-47e9-e119-3ab9-1dbf0812a4b6@virtuozzo.com>
Date: Sat, 22 Aug 2020 20:04:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <d85c544c-70c0-6860-0b5c-a2d46d740d1c@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Sat, 22 Aug 2020 17:04:57 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d079814c-0756-429e-6fa6-08d846bd7ff8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB354138CC2F3E5A14F7D699C1C1580@AM6PR08MB3541.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0sXpukIyWOKqaiH8A2wP7U/xIR0wXYM5KJmOZBQfM6BkHdzVMzUJM3xGJZjAHLj/JAI4JKjjtPYG6TSAj3s8rHK4M8MxrY/gkBM8atL9ScMRauKWI6r1gwiw5nA5+2zu7cgZw7uedplFQcqIL4Ew57UFJQ0T+ICFjXM1QfOseZ9rP8mFG4lw8Z1gnL8ELM8mx+3c7VZIaES+M6YMwLza3UYhHkyBVsVE4LcRM1966Ls8kmuLzTjZNi94+GG7h0LWZaz2jorxBjGUEAfTk/+LQM/angBjZzvOgI0QVSjXtGj8LuoJJAHlLBODkTNAEp0TXLXXRSle52DMh29lr/gx4RnEyEGVHGTKS5Glo20d2xNs71Nig5LCVCWMtUnilgm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39840400004)(366004)(346002)(376002)(396003)(956004)(5660300002)(8936002)(66556008)(26005)(2906002)(478600001)(36756003)(66476007)(8676002)(54906003)(66946007)(107886003)(52116002)(186003)(86362001)(4326008)(16526019)(2616005)(31696002)(31686004)(16576012)(316002)(83380400001)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: G8EAPYvnG4CJfbI71qFU0tz8gnN2Z2gsAs2xfskj2+uPBI5Z0RDQ1W4iN85MMskZfilNJM5yHEclvi9cfMO7y5NWx8mc6POEtWP/LSbZGRSnTIeRVByXcZSJKrCfhiPAJEOUiKx4cGIp2R8sUZulgQqZhSS/HmppUy+M70ZlkIryqdFKMOcWJRy+tEckup21YugFB+5qt9MDWMY5h1LTMmk+bj9Huc392TC2wYsaYdye+M69AanyCLaq0p/R0gsJsN1aVdO7mibvSZK3r7yqD4T5YOR0mJjLP8WpPK8TbbhC8RzGHo6AZ516l9wDxXD/gLWvA7DlxQ/UsbwHWX7qWLbR4dXEzBCGxMASUmPZgHCzzef2Bq3Y43dIWaXLLCkp/HVz/U3xZtcw+iAUrnJNzm5MFP6tWhFJHynn5B0LMkRF5eu3v2uY7TURN5dxIgWuFpp/tKcRXQoewYTakGyS6+MItkx8yoa8KSm2Kt8h651DYBBtFHwU4aHn2Z4Q+E1i+03zgiU3Xiud/7kkWKxsc1vlGugRYqnFOGvuRM7rpjZhMJ4laStxFT3JVd6Y9Uc0uaOJW38isqRksvod97e4hw/vYC3fSi+w5/xaIJvQPA0OxnRxpjeQRUJogb/Kl2beLZx0BoCqAhgHiyKf80/3Lg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d079814c-0756-429e-6fa6-08d846bd7ff8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2020 17:04:58.4130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek8BvPBTARQSROvgh3bxZDVwbRU3T7OD2B/uFJwMoGKxLLH8IsOecGtzHWvsI2GUhHcU0pXTaGE5L+iylyl+1as3FZuAAnS0pn0CSaRfJMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3541
Received-SPF: pass client-ip=40.107.15.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 13:04:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

22.08.2020 20:03, Vladimir Sementsov-Ogievskiy wrote:
> 01.11.2019 18:25, Max Reitz wrote:
>> The XFS kernel driver has a bug that may cause data corruption for qcow2
>> images as of qemu commit c8bb23cbdbe32f.  We can work around it by
>> treating post-EOF fallocates as serializing up until infinity (INT64_MAX
>> in practice).
> 
> Hi! I'm doing some investigation, and here is an interesting result:
> 
> Consider the following test:
> 
> img=/ssd/x.qcow2; ./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 50000 -d 64 -f qcow2 -o 1k -s 64k -t none -w $img
> 
> 
> Bisecting results changes between 2.12 and 5.1, I found the following:
> 
> 2.12: ~20s
> 
> ....
> 
> c8bb23cbdbe32 "qcow2: skip writing zero buffers to empty COW areas"  -> becomes ~12s  [1]
> 
> ....
> 
> 
> 292d06b925b27 "block/file-posix: Let post-EOF fallocate serialize"   -> becomes ~9s  [2]
> 
> ....
> 
> v5.1 ~9s
> 
> 
> And [1] is obvious, it is the main purpose of c8bb23cbdbe32. But [2] is a surprise for me.. Any ideas?
> 
> ===
> 
> just to check: staying at c8bb23cbdbe32 I revert c8bb23cbdbe32 and get again ~19.7s. So [2] doesn't substitute [1].
> 

Note, it's all ext4.

-- 
Best regards,
Vladimir

