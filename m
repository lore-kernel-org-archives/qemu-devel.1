Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFE3C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C081921974
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rgPc433r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C081921974
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI7dj-0008QR-Id
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 05:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI7cp-0007pz-2I; Tue, 15 Sep 2020 05:51:47 -0400
Received: from mail-am6eur05on2107.outbound.protection.outlook.com
 ([40.107.22.107]:59635 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI7cl-00065u-0v; Tue, 15 Sep 2020 05:51:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI7STJQGmvoHavsmQgCUUzTJAqbKC0YtWemsfy6HZH1ytxpQzdCgmommNbV6NpQRfg42GQQLncIy8NSYJsjFUAsQ4q9fDGHaXrZs7VbV43fEMn4Cpb9wjEVAhEwdxw/1W8cZ+A7pL2sOWo+LbNsmJa9O5AQn9KOn9/Q53EnCalSe70CpEhSs/dQWOruT/5GQM/UALDW61f599G+ZGxpF5ZtNhLFHU7yS9EeiyLsvmUYx694DTF4Qsru2EKCAP3IR7M13u9df8mg8yWP+4juA+ayYCtx03xX1AebmrHvGhd8fasbaGpdNyug+Cjt5m8UOnuXhbWONjjCkh+S7H9P7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMPKaNbmfLlaVzd1Tru+NTQ5mlYbxOyqf7RT0qX2jGQ=;
 b=jcOEoFHjwaP2s+Ad3mgBGQjNeC58BTynGeNTINgHiYMZHAVshRsrpa0qPL0bK0vqJ4GBIFU1ddviop3PiAoNvaEaZ8UjLBfp8ahF+BXAu4YuSfOpnI2ZrpMYFrwBYNyK1e+IB54iwq/xcleG+r3zaPSpdLufbuHXdNCs/qtUyM37NIlIxE89Ydk+KBUbxkcNAqqDRmhy4i4HNIppkJXdLJIYuJqAIL7OUn4zvMwoIKqBx6rd+2LUoiucaaOewb4asIrnUfbFH1Yvjn2R0JO4K/YJJkq1M2lqgeJ4E0D4ppjLA7kWWGdIBBOiGNiZcxrq4RAf9w5cTFKGYnZuryyCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMPKaNbmfLlaVzd1Tru+NTQ5mlYbxOyqf7RT0qX2jGQ=;
 b=rgPc433rUyKPXRIR34lXgcfDWtWUwqDCnwNKTseRpTTCTllMIrnJ02axgZWcMbitwD52o2hYs9Eyx6tV795jr2faVTNA56o/RwIHu9icW5SrSAEkjrj1wiCSYUnOJvz0ngKh8iDlpko/hIL+mRDjOh19rP2DGOsCEkAr77hkrxA=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3029.eurprd08.prod.outlook.com (2603:10a6:209:48::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 09:51:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 09:51:38 +0000
Subject: Re: [PATCH 04/15] spapr: Simplify error handling in callers of
 ppc_set_compat()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-5-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7c733c6e-e75f-b98a-8be2-616e240a4847@virtuozzo.com>
Date: Tue, 15 Sep 2020 12:51:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-5-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0129.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR10CA0129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 09:51:31 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc07bd21-e1d0-4586-0305-08d8595cecfd
X-MS-TrafficTypeDiagnostic: AM6PR08MB3029:
X-Microsoft-Antispam-PRVS: <AM6PR08MB302983FDEDF9359CF783C55DC1200@AM6PR08MB3029.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4vxUrdDLNv7lLo8opygCstaLmphUzqweLYjjR35/mz6ULQcrAuu1Z8ozgQkfS+UqlDMOCIdnkjO6Q+85dAuRzQJYEUrU8sEXOLgLZ5eHOdPl4esaLVRsyi9Qpc+lkU2S+JIKO+PWmtuYfiydjsiQhrNRjAiZH+rc75Cva3QZl67DCirVEsw50eSgciy4ymE6nzBz5rcaItgoLht0BB1NjRhovaY7d5cpLFTf/b5wUXBmHKUPujg3wSHEbS/GrvJTeGT2H55oCvzIJyPJ1zdLrEk5KaZz2yrf8GcY2nJ0fFE81CVokQ9kmHGXzY7XeCLqqSRA0xP2FV+GcooaFrIloxNAuRVokrVWYdi8hxeVjn/Q8itrUvRxrltf6x3Z+vg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39840400004)(376002)(478600001)(6486002)(186003)(31686004)(54906003)(8676002)(16576012)(5660300002)(16526019)(36756003)(66476007)(66946007)(66556008)(316002)(2906002)(52116002)(2616005)(956004)(558084003)(86362001)(8936002)(26005)(4326008)(83380400001)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mb3hQZ9Tk5SkshSIijqxz6ulu/6430FJrMEo77bvevd1rVJkg37kUWOYJRbMFFnBntUJMlJmS5xdgjb5/UjbEVbZmQOvJrnaEK66XEYopGzD2/7zIn2198RPFN/Y190ZPQ5BP2Y7UenlV40CiiWzOqQ6xYLsEe2BRe0fwE2+KwgtJMGPEnY0nwProu8b/WCVdkVktfG0bBQaJx7qzmAkrDX5RUgM+Gp/BA1OfOL7WkdOQtZnohlYH66cn/Lx4pnTTSE8vRCXG56rhVfyCjdGZkFqQFKWWYrTV6iIv+Kv+CSVPOmzZ3ENE9Q8NM+aTcBuqMY4sYKoZTAb0TvNrezuIkeIn5ePmXwcWdphaYIysIDPIF4OmeifoY1CKE3pi0JwAaLZt/6adCd/tkJjrPREwJc0SWd78DXj7f2aDTuLzqQx1X3rI2UMcwbk3acgv6Z5gByc13nov0CQSUI3dkcJQNfItfbMgm8L9u2dQHcJyJBOc65ctOpaGSDIbwkEWLISPocyFU8GcSmSAaIo9NSAHKJ0Nyrgm4MBSgkYvs5nJGd/KYo4lRBmPH0OXzwj/88JmuPoD4TqRteikJr4yqBTT/YyD3WtOoodaXSTSO6Jp3VHxEXYUz0+LN62VnTzsB+Y+FJ+zMU0ZbxNpERH0Ivqwg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc07bd21-e1d0-4586-0305-08d8595cecfd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 09:51:32.1927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l86IVuWqhQPMGn594X+egtlRuFF0CzjRRNCMahUqZ+wsK36s2yIrOY1F++BLSBnq590/Jcyf3KYP+3trB5sMeL1j1NLRBzDaFBNe87lAjAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3029
Received-SPF: pass client-ip=40.107.22.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 05:51:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

14.09.2020 15:34, Greg Kurz wrote:
> Now that ppc_set_compat() indicates success/failure with a return
> value, use it and reduce error propagation overhead.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

