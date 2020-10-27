Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CADC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7FE222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ouzJo4sZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7FE222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNnx-0000fm-9q
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXMlM-0008M5-L0; Tue, 27 Oct 2020 07:03:36 -0400
Received: from mail-eopbgr140130.outbound.protection.outlook.com
 ([40.107.14.130]:28605 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXMlK-0006oQ-6u; Tue, 27 Oct 2020 07:03:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX4BlFpHHGSR3OKmBaSnSighvJ89w6YM3rUPuTGKTLw/M1s8PmCG9qaY7mCDnKQEopdoXTTlEcaJxH0Rp060ahQLa313+6rq5/PZasEEp/ohCep8WlIMl3xgMmzWAvCyFDfWLt+vptcHxr6uQPv4z0Kjs9xoMHfoi/uTWuRixpcEwIiP9o9W2i0WonT4FKWBA8gbo/o9HRcWtk07XLSYnt1w6gMbBAxhhRma9TU5LhhZxcDb0o2Z6P3Z5+OkLRrlep5+3oyKk0yhoZg6nwuDYcT4SXL5ZB4uFSh9H+Njbk828mVWb03LR0F6sMywUTwWPkinFqTcqemTk3j3HWBvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JJ66aXiGSOJKQJgqB420uDQRBxfzYo92yaR7J1Ms1c=;
 b=WaK/z2wVJYyV91Y5FAELjAiBsm4fxhWPlgmPM0N8UfZSSnbxypkTYxoEJZbuikmQZSN3Aj4brPKkfyczZEYDmc8bB1dWfzWZi8Hlx4bvjsyRUFAxFvLbasOlgy0XjAcG1qQceZtwSokbe/pr362WlVL9KhcW8plpir1dE6To0F9KGivlL0hOpMcEAHn0ax9D0B+7UVaoVzJv3d1We4J6pKAFP+Z30991YJoiD+o71jPkXHFgyvwdvloken+kACceIWozttuWMGQhVcfBysMnldnUZULQGrXZwcYGwMUmPvrpexJCwhG2nfWHCaJNfVzg+Ha0NGrvFNLr46C5BZXLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JJ66aXiGSOJKQJgqB420uDQRBxfzYo92yaR7J1Ms1c=;
 b=ouzJo4sZsPnjEnsPEsAQTXRWdEPDdn4gNz0uwPeQmKghSP+qo8JWY0obTgQvkfde8mjiN0LuyfF5PPrX482QidNpr0Qkz0RLM8S9ngZ5mSECDfhnFeBIc+4VxKvqzOMKadO6/lZ/tffRATxS/DZ3YN5FeQMmEgQCgoTYiq6UFco=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VE1PR08MB5613.eurprd08.prod.outlook.com (2603:10a6:800:1a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 11:03:31 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 11:03:31 +0000
Subject: Re: [PATCH v6 10/11] nbd: Add 'qemu-nbd -A' to expose allocation depth
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, armbru@redhat.com,
 rjones@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-11-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <68fa9282-4fc7-fa87-2599-f5cd65009cff@virtuozzo.com>
Date: Tue, 27 Oct 2020 14:03:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201027050556.269064-11-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM3PR07CA0101.eurprd07.prod.outlook.com
 (2603:10a6:207:7::11) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM3PR07CA0101.eurprd07.prod.outlook.com (2603:10a6:207:7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.11 via Frontend Transport; Tue, 27 Oct 2020 11:03:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae54f622-dcf9-41f9-f9e3-08d87a67f063
X-MS-TrafficTypeDiagnostic: VE1PR08MB5613:
X-Microsoft-Antispam-PRVS: <VE1PR08MB5613CA5524C267AF08EF9A5CC1160@VE1PR08MB5613.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4m4VXeTeMp5FuLixSWQCPXEIiHSC9qVxIgGp/vre0TVOhRE3GLEjxWtToxi9RTBO3p4cIxTAs8eoIWj1gmvDvx5urHG8NcIW9CFvHs6NzteojH0jlEc1hIxHlzdzeAelXgs/Gvqnr16RMJgXxSqdrcAdRV/RdWImA2kGy98+1KhjKqtPvWjO1OrP9Yb6HQ/V8Fnk9LcMCbpQZkOPUcxTJUjeQpIWOmmS159j1hmDLjy/TuTaHDxu2Ni+BSX4+WmjuoC+Jnoq2Ysaoa7J9wSJY6s5Qm5NfQkIiNU6P3kYvYCCbTlvYlQDuhdxO3jZuPgKR+e6+kI6mnVSZuXg24DMcwCOacZ2kXf4ME2iEYMoMfjdBqG07eKAmWygtyfYM9g7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(2616005)(36756003)(26005)(956004)(498600001)(6486002)(52116002)(5660300002)(4326008)(186003)(16526019)(8676002)(86362001)(66556008)(2906002)(8936002)(16576012)(66946007)(31686004)(83380400001)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fcVHvmBzQsXJV3wLBbZl/bHKPxt/z2lMPDJYxrJDG79b01J3Z3PRq1wXHS+UfaFfrhSX+Ga0QbVKPwCEG6t9AT42BT+/HtFqmLRZzAIblFDGf1zQh8r5euXajVoHSbVn7s5JCC/G7g3igUl0DbtDDN5F5/RWa5eLTHAN/ao2CtrDJnlslArv5sTqiv5mPD6BMKAnHto4a8Ysf5VYaNnXRuliWhg2OE8YPjloSPPeIVkRWsmuWVNrqLomMN8jC6Gp/CxXXebSMamBGSSdkPNHRASmlpHvckFgD5ohOMiXoe6BD1uW8F2iiTrzACW9RDMCH7vc3qBnlU7VPdc1GPCkUtTo84aTRvwWJa8ah5zqPoJS9kMW3D4LBkOiE8WSQkuw1vTessCQeadNZd60nmP06PxYGEmu5GVIKuMfbk7M3Nw7ubN8WKRh9d6uRyi/xYV6W4UiwnAp1QBxgLmbzlWGJuNiw+pQfHQjhcKK5yYgy909gGPiIOWeHAg+LS+8s2jvEKeNk0GkTt15QO2ttUuOVKWsTGj+8jgDcI1lMUC+XaOxnnaLgEztzS2xGYNGY+dhQM2/rOhyKp031++JayFaLVEDuO4QWnI/TukFek3YIZ6XPkrPMYyeNq1y9z10aHilZHfxg8vAe8+RrXYsVUUpuQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae54f622-dcf9-41f9-f9e3-08d87a67f063
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 11:03:30.9156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNbCyuA8MbDXOxGb1ka06XmIJ/vwQPn/i76gPdMNL3qL8FfHUwY2oBpBrcZxM3cZHw58vaCt7mPtN3MrryeljzS/i/GqXnY6QClvqwDNvzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5613
Received-SPF: pass client-ip=40.107.14.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 07:03:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
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

27.10.2020 08:05, Eric Blake wrote:
> Allow the server to expose an additional metacontext to be requested
> by savvy clients.  qemu-nbd adds a new option -A to expose the
> qemu:allocation-depth metacontext through NBD_CMD_BLOCK_STATUS; this
> can also be set via QMP when using block-export-add.
> 
> qemu as client is hacked into viewing the key aspects of this new
> context by abusing the already-experimental x-dirty-bitmap option to
> collapse all depths greater than 2, which results in a tri-state value
> visible in the output of 'qemu-img map --output=json' (yes, that means
> x-dirty-bitmap is now a bit of a misnomer, but I didn't feel like
> renaming it as it would introduce a needless break of back-compat,
> even though we make no compat guarantees with x- members):
> 
> unallocated (depth 0) => "zero":false, "data":true
> local (depth 1)       => "zero":false, "data":false
> backing (depth 2+)    => "zero":true,  "data":true
> 
> libnbd as client is probably a nicer way to get at the information
> without having to decipher such hacks in qemu as client.;)
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

