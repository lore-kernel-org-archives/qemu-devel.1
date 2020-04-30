Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D9EC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 04:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034D22073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 04:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RBItEoLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034D22073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1D5-0004Zb-5e
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 00:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1CI-00044m-Gh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 00:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1CH-0003g4-MQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 00:53:18 -0400
Received: from mail-eopbgr30132.outbound.protection.outlook.com
 ([40.107.3.132]:55011 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU1CE-0003fY-Sy; Thu, 30 Apr 2020 00:53:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUEQZiBg1vYYLV6N2U5pAI8N9z7laxkF04qEHERR24hs65kO1M4LLV4h7QBTpOEtxq97VFsA/IzE2KWiRHfJZ6SkGUElkqNwM2FbYyfolko/wdumyXKfurN2mTGKGbFUHIHMPUfZSAP6qm18CZnpkngetddMtGneqVREVn70Q3fdnTzNOVuc9imU6JOxZrJdoHxARy2CtmdjPI3x5WWcznY5ILU/TiRcND2sXFMi5XKlNmC0nZVLjKgtLkPboNhtDXl+B3OJ++4o/fcXY0db+uN5E6cDevLhIZp3KPY5Ht4TJkpshB84o6yvxYrdNzii7+n0BUYT2xYHM7TMrd9AMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtDjz0HMemhLFTn/TTL64u7270DuZdeGw4zb6qoJ5DI=;
 b=D7TfJR1vOJ1PUbFouolZ8ao9nAIr18wssgjzYv0aNbMkRJYiApyjsaEKbl6ZK/laoX87f+vQ9qtladuDs4q/WvFcNOuyImhaTYeF9HdBOpZy585PCVgZhKOVlXaVIb8d/BDHU53Rdlw5nF4YNWY+xJ9tA0iC3XjgZpwAqgF0NhjjvSsspjZMo12Ma5Ux7j8rWQPNdUSP2PsqSGThEs3OfSt3hYWWMqOSBZlrZ0RSUHkG049qK8uu6Vt8agitcc5S5sZ1N9mduq3KG/TeYymAA6H7NwS4c0hx8opikAGoMELgoHE01i10bVthHBryZOxwSdZKU0hRRHHH+QrKgXy5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtDjz0HMemhLFTn/TTL64u7270DuZdeGw4zb6qoJ5DI=;
 b=RBItEoLG7puhPy2KZG1bB3O+U3isKPRh/MKBY2xsIzh2BpguEvDdipx6fB0ASrampxGsEZbicltlrTBrD7hucylKHenMxVI0vNTRXLoBnSbGNGgc4fBi2Wo/KvL3ZoMIU74ZKon0wQ7ABzhLpHIQRO1irKTuXvMJOW2MP/zn8LI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 04:53:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 04:53:10 +0000
Subject: Re: dirty bitmap migration refactor
To: John Snow <jsnow@redhat.com>
References: <2e939379-b770-43f7-2cad-90f765141d70@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430075309597
Message-ID: <ab0a4672-b974-4992-6954-e198fae5eeff@virtuozzo.com>
Date: Thu, 30 Apr 2020 07:53:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <2e939379-b770-43f7-2cad-90f765141d70@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 04:53:10 +0000
X-Tagtoolbar-Keys: D20200430075309597
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb607b84-2513-4f93-7397-08d7ecc261fe
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448E373200A50D04706F1FCC1AA0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(346002)(376002)(136003)(396003)(36756003)(186003)(4326008)(3480700007)(478600001)(31686004)(52116002)(8936002)(6486002)(26005)(86362001)(54906003)(16576012)(316002)(31696002)(16526019)(2906002)(8676002)(956004)(6916009)(5660300002)(2616005)(66476007)(66556008)(66946007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRrqsTGMZW0JbCWG35DSXVxjx9Zj/3UObkkX8h+ODMGOxDIQbYDOprUsqCxf4SEU2fZPlBKH5G78G78QkbuwSU0Uus+KUwLALWrDlxsL5nVR3fb2MgnQSB5p+s69PHZJL+pN/vSus0X2dYTAT8AXFts97g4gKyGd9+zBT/qwk6MpJDfzSafK/TJMll2us5DSX7jWi5HZ0rwn8c17sqMHnveFLww179xaK9fQiiijW94UUy1LgCrkCd+urSfVrcbDRGBVcpQ6c0VR0kFYgVt8Mu/fscRVQvI+sR4YPGRaQzFuRT8bolZsVWmJ/6sNhX08QpTqlOvGC5maIX8vl243uVW9qsA8oMQSlOiMPZzzjCPXW6Jbmt/VPzr7S12kLV1XA2Evk/QcAxVZOfxuCTqJG/hz7CNjNtYzTOmJLOgkpaidrW+/7aLZQ75BsdgA8HjFkRNd210PjozOTT5ABs2/6W8IjmwPLA4W0d8BPlbH+9V6zOiPRepOYSt4riWk1THX
X-MS-Exchange-AntiSpam-MessageData: fPOkwOOgDKogb2+wcpnVbRbZj7sRdB4wePWEqt2WUREX7BPxcVzNL1oSUzmm86diNYYcjD5WzwzHtC9ifKMKM+Jv5qqfYPcj+ZC+vVtE+vpMIGLcjlVDoAY3FC6UAnhbkVn1tFzApBM3mBei7knhSTbj+Pd9oQgXxxkcgYkxznV6yNsgR+GBkDviOJTmt3W1b5PZprUWEvBBI8OGeVJw7fgcM/CwW0R0gWy3IioJadT9aJG00j12tHphw1z+wV4Hbi2MldMDKvl0hyJqDa0yu/xtWUtROZcqM8h+34MJnvTynIRBEi7WzWEaS8VYrgzDcu9mxUE+RVrGoKoKzk+Da0nnnM4wCJHiTF+lHlTb72aL4csGuVDMcu7WHzd8vH4EMDLRRaJaAEeRNxUdqe8EpoPQJvd3MJmxvFruwVttFBgMwYp9VHpdPbR0s8xFNokIOREuzGJdCQg6LtFq1XLyIYJXm4QsDAPXjhFKQCGvUQAQRXg17dU1sAN6Ty826uj5EL0sTedhXg7M/vxD7FWnt2b4BpC4S1qz2TLZt/wky2LA5i+ggiu8pAlL1Q9nHdwFb8zWceAD+WHwK3IjzsuQ1VX7vs4q+jNMGFEIA7NgP8fB4Ns6BKax7JkaQbOjNdpRVPAwauKQeotn165rWiSF47kGvjWDvEfUOs7r+19xWhw6WVF7TXafQe2lSurwGEoMACoSvyNB8EKikf7IkinxfgoJ0jcZZGj+KyRehIcyHXR+xMhXbIF+eP4G5hnRj/li6+fSIB/VhdPUVYeYY0XCRGU7UKDJ2gk9Rl2VkMWdclE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb607b84-2513-4f93-7397-08d7ecc261fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 04:53:10.9385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Y24DctoXjQsLCVS/87fIQaDp5rJIeG9FgBhdNDAhpo6vYZUUiugzxYPX3aSq6kphzRMbKWBCmBL3BCyYfuFQZb4rnRjwgfhTg5atERfejI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.3.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 00:53:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.3.132
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.04.2020 16:29, John Snow wrote:
> Hi all,
> 
> as you are probably aware I haven't been paying attention to dirty
> bitmap work very much for the past month.
> 
> Around KVM Forum, we had a giant thread dedicated to discussing the
> problems with dirty bitmap migration, which in a nutshell, are that it
> migrates using the node name with no option for re-routing or re-naming
> nodes.
> 
> IIRC, there was a patchset to fix this quickly sent by Virtuozzo, but
> the series stalled because it was quite close to a release and was
> deemed too risky.
> 
> What is the status of those patches, if any? Do we need to start from
> scratch to implement the functionality that libvirt wants here?
> 

Hi!

There are two series now in list:

"[PATCH v2 0/5] fix migration with bitmaps and mirror" - the series you are saying about

I made some changes to it downstream, to restrict migration by generated node names at all, as we had a bug. I can resend, if needed.

What the series does? It just tries to migrate by blk name even for filtered nodes. This fixes migration of bitmaps during mirror. But it doesn't apply to blockdev-era (doesn't hurt still). So can someone analyze, do we need this fix in current Qemu? Or is it for downstream only? Or should we take it just to make downstreaming cleaner?

===

The second is "[PATCH v2 00/22] Fix error handling during bitmap postcopy"

- it fixes, how postcopy bitmap migration behaves on errors, and we need it anyway.

===

What to do next? I have a plan to post series to implement new API, discussed on list, to make mapping from bitmaps on source to bitmaps on target by hand.

-- 
Best regards,
Vladimir

