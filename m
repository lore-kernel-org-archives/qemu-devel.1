Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1345FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D640B2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="PTAF20GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D640B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8f9W-0002Y2-6f
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 03:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k8f8x-00027W-MM; Thu, 20 Aug 2020 03:37:51 -0400
Received: from mail-eopbgr40108.outbound.protection.outlook.com
 ([40.107.4.108]:57574 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k8f8v-0006Ws-2W; Thu, 20 Aug 2020 03:37:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh72hATGxDTh1cOgsPuTHxG283/YAf9P2sH4BFB7Ij7gSOgrcyfURZrCh2oJb8VnsbM5r5mNGHjmETAXD7KMisRPmhDUxh/ZgKMFsP3lYgB5ElNMHf8rM3CnR11ZY2gAcU6Cs/V9gZeBAGwti88rMtZrfV5pVIAagEWW+k/IvnKJStYQz3Afq9n69uQ26uzQZJrGohKKbobWMju7OXOhIfdQNJZ3IP+Ceb0hyy7FMY1qnVYTe2G6w9s8rMD3VwI3OuqBof54DEvZLjUn7D/efAXLK43roCehchcSvDsAv9AXbkaQgWnN0O0MQQsScJLqY5K6/P8FpHv8KqTWfiMRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebRu8+z5dUxsAzlhGwHKklFJVwo+lPhgaUHeDe+94uw=;
 b=bqG1Vq1R0N4y6t7sE3qEt7YU5bjTEHVhTZd6qsmUVQZewBA6y7U3LlnfmTQKofkb04xZwFRSnBHzlVTPsbAi5xef9UBOW6w5v02CzkMjFuxeM8TRqjI86hyFepogaZ986UedhNujzgLvjv8FBmPH2dP3Tv4dQnjYKgWCnnbrecX5pp2YAaNtP8CIsAjM08hg7i7HpfuplVjdncMFWxHflVuHOE6N8Le/hgYt7gwPxgHTwbAcgHVN0+slR+nF1yxoDcK80m6fMdd73xfgjiAAks1+Uqh8H9aLGBxku/kkSoq5lJK8y91F2nI2SsXzZNoPuC9ozlSHkoMI58BtaP2Jlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebRu8+z5dUxsAzlhGwHKklFJVwo+lPhgaUHeDe+94uw=;
 b=PTAF20GO9u7LHyqdKEyqOfP9xfTMaDFy78r7daLLBmTY0UjmTuHNVNnEPTFqoJXoiZbvv5RncQNyV06ddu1aBes64jb3mtQQVdNfmFg6HkvuZEsh4PWNombA3FUzonZg/JZSYPzclCzVd1DYemfn6zBTIrOxss3IF6AFA6tQ990=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3765.eurprd08.prod.outlook.com (2603:10a6:20b:8f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 07:37:44 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:37:44 +0000
Subject: Re: [PATCH v2 for 5.2 0/3] block: add logging facility for long
 standing IO requests
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200810101447.7380-1-den@openvz.org>
 <20200812140009.GB112330@stefanha-x1.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <1650481b-8beb-94b6-f307-c46bfc7a8512@openvz.org>
Date: Thu, 20 Aug 2020 10:37:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200812140009.GB112330@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0120.eurprd05.prod.outlook.com
 (2603:10a6:207:2::22) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 AM3PR05CA0120.eurprd05.prod.outlook.com (2603:10a6:207:2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:37:44 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7586671c-f0f9-4123-9109-08d844dbed85
X-MS-TrafficTypeDiagnostic: AM6PR08MB3765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3765F92FFEED4CEFD4FFD959B65A0@AM6PR08MB3765.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7iTTCPKbtwJWn5uWC/f9rz4uf1TRKbrOU1hcekOaiMEgs5Nz3El4+DkYWQKy7JJPifNPCyi+gMVeauZ7tDKeiHeSeIZGOOXBZDc/vjjGCKSYyRADbGyPnNiLUnIlUxHdzj8FCkRhpcGJz0TVnuUmXtbbu88Q61G8zKniSJ6/j4omWaLmYjbQGBmGI0SvmjYMYYlBDVvVFnrQdP8XRRP1qz5Gi6CPhld/QKo0SgUIiiU7/CMMgldtK8Le5IWk0mEKM/Nz6njxelbBe28qJwS2ZVXV0qoek9df3I5eB2SnZHR8zXgmadKM+zAteUparXPHgaSK5qW5plCw8W/EjJVeuNj1cCmkIOPtxdvakerEg/Uc+ZcJATYGJ+R3twX3fKZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39840400004)(31686004)(6486002)(83170400001)(36756003)(53546011)(26005)(5660300002)(31696002)(52116002)(2906002)(83380400001)(186003)(54906003)(8676002)(4326008)(8936002)(478600001)(66476007)(6916009)(16526019)(316002)(66556008)(66946007)(42882007)(2616005)(16576012)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VJZwYXjhaNq/Fc3xZh5MxxYqvb9C9eXyvtSMg1XKe1ZWrVi7dCNlWcqOARy1nK0Qc2R4vjgNOIw7mBvJA4e0nAQQ06qtZPGq1lp1cgYGx5/fFPVkJuoFnJQS+itxjtebwA3samHIXOntprd6ain9QiWIJEU8NqM4O3Hq0DVbx1wDT3q29kGlympZfKwh86bqb/A2UYMr80hVA7rm61E9oe+Rg5N5tYQ/p7BFke6A6jEo8jxT5QMJf4PJEV8rxwq0f6bwg3J7rRruUm3CGRodBMj/trmEh5+mPrnyc4hqejdEEpnus09lnBQ1OtHAr9WGwgX1WkNsIBftwviktlVL35d+ym1WreUV6OhQKYblCsUD6a8zvrUVvczMRfndJEdflhh+3JFaXUNw2fZxHRy2VEDCeCFrPNPacoIgolsUDOdwJPpkZ1o2hhtn/QBFEJJkPYqYJMzxbjtsswwidg4iM2Q6VJIpj5kNnBnsP35CMcO9v8P7eJyweAkTf4HrxUaAPQDGYyEjqtkirA3UUoGrX1rFuJ6nL2oDrkaUDIpFQvn5kkCBUhkhxbAi8sH+5xc2UWXKOL1PkUdFyKsJhcO9nv3K7H+8joTL+5vX84Z47pSyV4J3+SC73GB4EDtsVVt3GJ3StnM2ofUzkNMgIJ4X2g==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 7586671c-f0f9-4123-9109-08d844dbed85
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:37:44.7854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7sLb6Ldt5JJjTc/UwJ+/84jcR4yRTFlBtL46/hIkPtiJ6J489GR6aafHmDqOPP9ukIldHeVtlB3nAH7q03Esw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3765
Received-SPF: pass client-ip=40.107.4.108; envelope-from=den@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:37:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 5:00 PM, Stefan Hajnoczi wrote:
> On Mon, Aug 10, 2020 at 01:14:44PM +0300, Denis V. Lunev wrote:
>> There are severe delays with IO requests processing if QEMU is running in
>> virtual machine or over software defined storage. Such delays potentially
>> results in unpredictable guest behavior. For example, guests over IDE or
>> SATA drive could remount filesystem read-only if write is performed
>> longer than 10 seconds.
>>
>> Such reports are very complex to process. Some good starting point for this
>> seems quite reasonable. This patch provides one. It adds logging of such
>> potentially dangerous long IO operations.
>>
>> Changed from v2:
>> - removed accidentally added slirp subproject ID
>> - added comment describing timeout selection to patch 3
>>
>> Changes from v1:
>> - fixed conversions using macros suggested by Stefan
>> - fixed option declaration
>> - enabled by default with patch 3
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
ping

