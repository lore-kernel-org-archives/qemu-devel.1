Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E17C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFECE2312D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="bfPSCIg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFECE2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3JzG-00082u-Uy
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 10:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k3Jy5-0007Hy-Df; Wed, 05 Aug 2020 10:00:33 -0400
Received: from mail-db8eur05on2138.outbound.protection.outlook.com
 ([40.107.20.138]:44785 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k3Jy2-0006K8-GF; Wed, 05 Aug 2020 10:00:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJWUN9MbM48bW1Tqx/B3wwBhL8iqIea50WxBpCoIkdpuCjatprNPYBlGFrdBm4NU3ZlplR0xN90DlTHkLwEoezHRpVwxQWcM4Ebp/z2dJi1jebNKm7CvBNMmZO6Evf2cUWCndnQ8lHYfBXy8XqjVAkfddPJmTqZ3SgW7KY3ozni4+bll/njBkqgPnfYQg6liNlyFzzrq089YqLYZW40UPynoSfjoR9iKP1k/usXOtOT3jFWuodUbCQ8so2palQfKBLsQBMotL46ahMfymkEpnpo3ZbTuRqlcW+EY7ULlOYnEQCCjfBz4RJapitgMJvbEc4G8GdHC1jKdQgPNUfWYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVSrpNf1yUQiOqPf9pj4hd1LEyzYxdLCgcAT4cmhgMc=;
 b=XnDdlzWwlmQsUV3AzIcly6tytFqX2bYCR+LdKtYLKsbVhd3nHCvJO4Lbix0gTbr3kktSSNzZscecxIVwFbOQCr9G8ESrNhyOjgmfRE2TOY/5rgB+6Z8XzK/vJx59kX13oR7H6BDtMkXrL3DhsdU2m5gILnKBPTp0mGMPbQTMALq4YGpTcfzUTjtPzmcW0It3hT8UFsyfi0OV8ijcw3Ti/1H6ZFSv6e2WBZSJ9nUIKD9YxuHBHBDGdC5AiOV6fGsyFw8yolYYEjw6DPZXOvKwY/rGeyPAGPHRWPi0dresRLETAoeOVih9uLu08PLarfeOP36bP1Jhf+GEMfh1c9SfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVSrpNf1yUQiOqPf9pj4hd1LEyzYxdLCgcAT4cmhgMc=;
 b=bfPSCIg06JI0CcSx5kxfFwJpj7RpANr61cCgKbuvvwcbCqc3iMgNr0lOFafKDT2gy4DHau5v2SsFaM76eyhFb67XTOgM98fL75xI0X2KNnKF12FYLnsL+ELpXFz6Cpqg7aDyueR79bNhqsb4unhaRD1u+BaVWDVEkch3GZik5ZY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4406.eurprd08.prod.outlook.com (2603:10a6:20b:71::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 5 Aug
 2020 14:00:26 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 14:00:25 +0000
Subject: Re: [PATCH 2/3] block: add logging facility for long standing IO
 requests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200805100824.16817-1-den@openvz.org>
 <20200805100824.16817-3-den@openvz.org>
 <703a491d-2281-608d-b5e7-7b143c404111@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <37418a5b-100a-8802-e0a4-93ee06ca463c@openvz.org>
Date: Wed, 5 Aug 2020 17:00:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <703a491d-2281-608d-b5e7-7b143c404111@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1P189CA0015.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::28)
 To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1P189CA0015.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Wed, 5 Aug 2020 14:00:25 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 591423f3-d58d-4bd4-a48b-08d83947e71f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4406:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4406CDA40C5F36C0E74C46E6B64B0@AM6PR08MB4406.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3sCSyJewWjCRqPniZ44Qfa5RW5hiBoDgXsX44xQTcLOjx/a1zdza0zKL/XGEPofRnufFxSxzMKmFNEZy77FtHz7YJgh99T3HH6kRnfjOqQXPLxaIS0+vMOO5EbewqOmbRcO/pKqRs88U+ZOkAjkO++EgguWAOf/dM+iun0v4mrq++9u/dquHKKfXCQTlqsKXu86130LrcEU56CriNbMH/DI5Qq4cVCtvMPulRBhEKVdw0vDFuBdGFiVVmo+hIMPZ7t4PnStVuqQp5x2hUq0ZRehQOEa4Xc9G0NUJwRRxLhJlo2Xwlg4QB1wO3Eg8MF0EJo+T1yLnpjT9tKPwmoN49hlrcj8TJpfGuB524oQnGSQAxcnAuiCzxN9oYxjOLP3p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39840400004)(396003)(366004)(83380400001)(5660300002)(83170400001)(31686004)(4326008)(6486002)(8676002)(16526019)(186003)(66946007)(2906002)(42882007)(2616005)(956004)(52116002)(53546011)(6666004)(478600001)(16576012)(54906003)(26005)(31696002)(36756003)(8936002)(66476007)(66556008)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QkrIC5pvaGpKQz5A1D+dTEBRYuwzLuyI5lfHE6XeimA6YGvKtjmDHI3VghQBtVwbnYKeTQ5OP0HBha9QYHHIqn0hkcSIrp4XFmDq05JdUoS18rk3ttZieUdIQQsNuJ+8KLWW7XsC3ga1CQShEIpEp/d4e/lF6YCUBzISNwhoyQI+EdSJUrfqXKOBw5Wbs/Zt3tImxjG4LO9KWVOQHyTltN73Rl2humajqk7Dt3eUhvoLLrqMGU+9KYq+x+nIlWQ6KcgZxsULUG7R4jZwIrcvrgR0sB4dS/LCdgmw598xllFq7mumvIpuXJo5R32Xs/1cvgJC1ccdBh5ZaBo3pHtwUgYFSJjCUSBCQaI7qmr8xRK07eiVaXM2g2Bi+xw2KjqjBaI9WryTipKo1dso9+h+s6thcAqOnAjTkoiX7QSS0NpBJ3hSux35rf534UXhn7cezyXvoq+OL1u4ZK9ej8qg4Ld2pujwnG9i5NEWkN5TvIchoFCB8Fw1nr4mNDqtw+94lJmJRzrKWf6ghjF39vfCAuvnWPBqkmNS+JQUgNGEsIbf7zmkSAacA+YtESD3TRNYIB2Ha4b25hPh9ho7sPbLPLm4sTZBazxjtiM/QJqu5IQqNK+VOTZGeo4TkkX4ZNsh733P2w2P3KzKP1Y4aOA7Rg==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 591423f3-d58d-4bd4-a48b-08d83947e71f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 14:00:25.8085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZD96AH7vyRHjTndaCF/rl9nlo/XEOjzpkGkGZoi6qNhVZQeQ4NdnucPqCc/Ms/DLs4MqCuztiBLpLLmHt15QXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4406
Received-SPF: pass client-ip=40.107.20.138; envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 10:00:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 4:51 PM, Philippe Mathieu-Daudé wrote:
> On 8/5/20 12:08 PM, Denis V. Lunev wrote:
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
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/accounting.c         | 59 +++++++++++++++++++++++++++++++++++++-
>>  blockdev.c                 |  7 ++++-
>>  include/block/accounting.h |  5 +++-
>>  slirp                      |  2 +-
>>  4 files changed, 69 insertions(+), 4 deletions(-)
>>
> ...
>
>>  typedef struct BlockAcctCookie {
>> @@ -101,7 +104,7 @@ typedef struct BlockAcctCookie {
>>  
>>  void block_acct_init(BlockAcctStats *stats);
>>  void block_acct_setup(BlockAcctStats *stats, bool account_invalid,
>> -                     bool account_failed);
>> +                      bool account_failed, unsigned latency_log_threshold_ms);
>>  void block_acct_cleanup(BlockAcctStats *stats);
>>  void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
>>  BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
>> diff --git a/slirp b/slirp
>> index ce94eba204..2faae0f778 160000
>> --- a/slirp
>> +++ b/slirp
>> @@ -1 +1 @@
>> -Subproject commit ce94eba2042d52a0ba3d9e252ebce86715e94275
>> +Subproject commit 2faae0f778f818fadc873308f983289df697eb93
> SLiRP change unrelated I presume...
>
yes :(

subprojects comes into play.. I have not event changed this.
Just a result from pull :((((

