Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44636C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83062078A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xis++8Io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83062078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLp8s-0006xy-3j
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLp83-00061r-SH
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLp82-0004o6-DS
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:23:03 -0400
Received: from mail-eopbgr140100.outbound.protection.outlook.com
 ([40.107.14.100]:50053 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLp81-0004nJ-Pa; Tue, 07 Apr 2020 10:23:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH+hsYGVloslwrWp5//wWc85GBrHcTvShoTriCc0nuMXSHJf4VVvQ0SINfVZQS0ULN8jjRV9RQcLVCeB3nSWg6l+8yndTws5hEu5Ta00yUp7HjtU0YWUgwIx9eKbM54mqsUS2diIqtj+Ak0dHMyLgVJ8XRG3e+rK3HAYExSL+k9ThXjTNbvI5WgxhbMhJdnT4k/n+2cDcNBnLwehMDwcJYTlgRWnNEfeRsjEgE+VHLV9z/k1buEcjIcmhmJB+SFze0mMjcsy9M8T/WayaLx5LVnQxF1EnP+ilY1Ety5AdTK9focuNXgCTu6jaN3u+BVeS8Ql0U2uCMfS70jhYgBW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSTPNg2hn68GRVYUt2JqGaH/dNcdy3fIIQy6xoRKEbE=;
 b=iT5TF17GCz1Eo2U29vCFBeO1bxWlNfX+7kv/3AqEnqQnTrdjYWeqBVSVR0oVQDc0STteSiuIfttNXFq5i97Ub9iooZ+pmpVC6uKXdyDs2yS7mWFY/+iqWxciMBw/0jZd7ThQGOVwXuKuo3PObGam5sJDDOFkHo2/MZkDXBVD3jwUO1jIV90rhD2786kFjVSWHqZ1+2DZaMc5SPToGCMGzKgv5N6z040fjOpKo7XB3bWlWoxjBDGPfgsOvAT7wRpTyye81xnU2FHuIBoI5/H9I6ZM/E+LCulXeF39PdZ4O/WvazqjGEF6vXh1rAbPiVxyNtrEc9kD03pNnTHS52Q21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSTPNg2hn68GRVYUt2JqGaH/dNcdy3fIIQy6xoRKEbE=;
 b=Xis++8IoWqpAZY8785plbfplg//ZPoFBc5j82OcsR0jk3e0hksFyjQbe+1E2OSsrhxqj5jAXOxFJWzOBo9UMR2S5zosN3AG1ZcTAiZguvyHSxefhHDQMi6oZ8sHB49U003kdmonKSKSg5UFgvBIKzorvCNZmq6EHRcpqCPg+kIg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5302.eurprd08.prod.outlook.com (10.141.171.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Tue, 7 Apr 2020 14:22:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 14:22:59 +0000
Subject: Re: [PATCH for-5.0 v3 2/3] block: Increase BB.in_flight for coroutine
 and sync interfaces
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200407121259.21350-1-kwolf@redhat.com>
 <20200407121259.21350-3-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407172256987
Message-ID: <2a1985c1-5d36-6537-86f5-e95baaca7416@virtuozzo.com>
Date: Tue, 7 Apr 2020 17:22:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200407121259.21350-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19 via Frontend Transport; Tue, 7 Apr 2020 14:22:59 +0000
X-Tagtoolbar-Keys: D20200407172256987
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64e49721-c548-4055-78ec-08d7daff2c9b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5302:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53027FBE640048DEA22AFAE1C1C30@AM7PR08MB5302.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(346002)(396003)(366004)(39840400004)(376002)(66946007)(36756003)(478600001)(2906002)(86362001)(31696002)(6486002)(4326008)(956004)(31686004)(26005)(186003)(16526019)(2616005)(66476007)(66556008)(4744005)(5660300002)(8936002)(16576012)(52116002)(316002)(8676002)(81156014)(81166006);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gf0u1s+Jh/Vod9FoGklBq9fBA7JrTmL+klEbv4jfoI6p3BCIAgVwDh0tVQpL7dT/TH0i5o2V1Ly0b6bxFBzgKrf8Gy3AMow3Ywpit7O0A6Guf1wkDaqydhYuXMzwwMm9EM1mjuCmO30dtC8pXg3MPVF0VJeKT5Xy0det1hTlsZ2ydmEkrJ/3IpMrFnY5ckGBZDWBdCbuxhyBpyUC7QIm4Chf1lLQoQifp7tofthTK6/wR7GINGCSJZ4/qR7prHGRjNewaV+YrBCEgbrBQduXqfYVh2Aqr6hwUC7c/5Jh3w9+cUYDhHD8/eryJ47SpKhd9x3EKYB4+0EqCD3yi/lL1bH2PZb7MzFhpzk2o68AOGFGZcunejB4yse6g3J7aUjMNBjE7Y/LBAWq88w0SzSFbzuNUcmOK+X2QOPsja0JkKXDeGRYGBvAqJDFFlHnn/Ba
X-MS-Exchange-AntiSpam-MessageData: APd1iD+a/b6VHfiEFl0UW+WDusXTWqIrRlk6L5VEkQqN/z9kZJEHJh11vV3cEOO1/444FqOkgj4ENhLE+Ayzrybk1GmWM+esS346La77GWeGfOmcR6JO3NTTWrxmAnm0ixekFmUXmHqW5X82XoWMtQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e49721-c548-4055-78ec-08d7daff2c9b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 14:22:59.8416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcyHCvF+NTyJMQ33PgJeZBlw1ShYJyzDyfGGD1LYjesUC+kczyEBuxI13iE+tACx1TJWXHh0AEXL+LOPic+288lApVMqfn4xTwVuUnO68Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.100
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
Cc: s.reiter@proxmox.com, qemu-devel@nongnu.org, dietmar@proxmox.com,
 stefanha@redhat.com, mreitz@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.04.2020 15:12, Kevin Wolf wrote:
> External callers of blk_co_*() and of the synchronous blk_*() functions
> don't currently increase the BlockBackend.in_flight counter, but calls
> from blk_aio_*() do, so there is an inconsistency whether the counter
> has been increased or not.
> 
> This patch moves the actual operations to static functions that can
> later know they will always be called with in_flight increased exactly
> once, even for external callers using the blk_co_*() coroutine
> interfaces.
> 
> If the public blk_co_*() interface is unused, remove it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

side question:

Should we inc/dec in blk_make_zero, blk_truncate?



-- 
Best regards,
Vladimir

