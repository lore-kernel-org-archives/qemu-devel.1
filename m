Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE603C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AE32080C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v1JnJo4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AE32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIHAc-0008JJ-3f
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 16:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIH9y-0007mO-Af; Tue, 15 Sep 2020 16:02:38 -0400
Received: from mail-eopbgr60100.outbound.protection.outlook.com
 ([40.107.6.100]:28318 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIH9u-00006m-Om; Tue, 15 Sep 2020 16:02:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J18TE0XRskwqfRh3XirEHAZ+gclAXHN1YX/rsnLFoEz1F9dY0piz0cJRw6zKFkyvBUmu5r1iAoL2hgbWsI1ADIghcs2p01xpyoy9c/imngMzMJcBf38z2LU0zJsAcIOcVorq+4k2UY01BScMBFAjazD6AmFbouL2caP5Fe3zikAX1FMImS77UjuJJm5HdEZX7lSGemHTBZKf3vVFdbcvYACzyeIboTakLyf1twZVv+rQ12YxLwDSh2SwbNTQi+PpisptuA9boGS52ScXtQ/Xn+8NRR6yVTCFdAvmhmYhGkS9IbOW3nJQSqeICv5ltFh2qk2j30+Zv+xaNHOvXz0ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1MUIdGgiwPed4iihqyAzoI6xvI7896Ug3e1wU0y718=;
 b=P04aD1QhtMq653tKLdKlMSGxUPEFcGEy/R7NgZ1TDRyXzyEZE1B86LcNlyRfp9jJePsjNy9md60BlHZfuy8W5OgtVxLBi7HxB7zHVENX2H1/gvkBkfowhHxeJg12L+LPmCdFGKrKusBARTiQSBeLR27HdwkqivE9xktM4gDTTGoNoXv1Ux2ujkdA2RfmVXAtV99EP0JmR4m9hhVp1kRSCId16lX0zH2KnLqxZmCXC/AEBw0A1mDvdCLtDosaGESZN8icKaM8EtFf9KUWqa/yNkWr4sHjMq03CJDgqVEcEIjxCyjLdzv2343v3YAyBS5H9ZeVgQDJjNy3Yr6yW9L4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1MUIdGgiwPed4iihqyAzoI6xvI7896Ug3e1wU0y718=;
 b=v1JnJo4orKBVMvWMkuBcUSHCXqa+i1CtmJST060cv52ijOr9HwNG6oux0nUsTmlEeFyfoXRB22zzXPIrcsWVjIy6rljuuVoQoBwZRdCJM56xBVhHO43dBiV5KYCJiTtd5AiVjURZ1UzMHFxYlMh3i5hQe0NIZqug4RCgJcDtlmY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4341.eurprd08.prod.outlook.com (2603:10a6:20b:b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 20:02:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 20:02:30 +0000
Subject: Re: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-5-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <be6408ba-a430-0294-96e8-a38af7f94c1b@virtuozzo.com>
Date: Tue, 15 Sep 2020 23:02:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200915164411.20590-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR01CA0120.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Tue, 15 Sep 2020 20:02:29 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 362a86fe-6bfd-4722-c290-08d859b246c1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4341B13F62BFDAC990F45A43C1200@AM6PR08MB4341.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wJTgN+og/tRUJgnpmtmY68ypicNo8+ptbBk1crI4Tj4nCdUL+cqcNBtFsyXKmPwyNfICjxcrBl2ncKaGSjmZtrTCrqKKu2jI/mPhOxTWCGGykkSBXYmjgeYVDeA0oijry+s58CkFLCFgUxXxJldV0s9il1lbgsFL7YcXCEkGYvycZNNHDptE8fNkyLSsZJhnF7vZyV/hfDOKjhXziAPQRJTeAo3PuKB9mSt7VXNMUTcm5mkbBUIwjx09f/yINNYaF24XQAp8j2DNMZ6Sk+H7InQ0oa9R7PoiN4aVV3QeZDhZ6J4F4ccFGUfHb0KG7Ax8SdbAr7Stxm1TBbdLmdHJ7Myh7G0ExFQoThbgpAhcYI0tECduEb2D5Urq7JuBKNY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(396003)(346002)(366004)(376002)(8676002)(31686004)(478600001)(83380400001)(2906002)(6916009)(316002)(26005)(5660300002)(86362001)(16526019)(16576012)(186003)(31696002)(956004)(4326008)(52116002)(66556008)(66476007)(66946007)(36756003)(6486002)(2616005)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hxB+4DGVxkR0zZ8H6BUXxvFKsTmWPnSmbqcPVCK/xY9IpHlTOkTN//xtaYvbej/Hb+XfNEuU1h5HYxEfYjrzc/TGypFaU3ziYIHj4Qv8C/Hv1NLeFtRi96/tBa/gCsyMKZlZ0UpvYpnMlqwOCIczMvkUBUs7LsN9OLd14bW+T+QXAPfbmgSNFdyOeSamvinf1Sa4lY6mqFj79CLapyUwwX9qG+V3UahjoDSoefg2NMftX+CIB8Tk89ZhSw7S2KP1OBpEfzXNo6pwXHmV8Eguefj7xQFSBLFVhl5/SV3yvK7P8kx2Uz2W58u+ELxbQNR2r/2n6iNFfu/kOny46WwJ904ScKLdCFgiARI3OgBun0PLtmS0Sr4WIeVMLHcCV+cqIoiv98giNFJM/zqpUHu4Lu5595X2rw9B861gJlXIUUdl2cfoakDdY9o873oW87CX9e3IqzyUupcjWr8ofGBdgwuk2kxTEp1He+0Yl+jQM+rPqiF2E4CPwTQX7HDg+/qJHaddiABO+834QB5x23bqIMWsehN/8QShjgDNDSKWlUhQrpEqApnkK7EsQwjK8o/IxlK1Nx2zb4sGusy7g8EmJT5/kiyC/yfaGTZUbdFzYv4qqGVjV6/qLVPl3uHHcNh4A8x5fEm0K3DRDEsZ8+qzLA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362a86fe-6bfd-4722-c290-08d859b246c1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 20:02:30.0931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqqI9wx2Bh9NyohXslbunNoujT1drpys6lXt22QTh2x2L6w142JkHDyYIAUfwc8SHrtAqxiZbRb7hrRhAZqucjBSjK9gJt5Bc2fPqGrHro8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4341
Received-SPF: pass client-ip=40.107.6.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 16:02:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

15.09.2020 19:44, Vladimir Sementsov-Ogievskiy wrote:
> We have a very frequent pattern of creating coroutine from function
> with several arguments:
> 
>    - create structure to pack parameters
>    - create _entry function to call original function taking parameters
>      from struct
>    - do different magic to handle completion: set ret to NOT_DONE or
>      EINPROGRESS or use separate bool field
>    - fill the struct and create coroutine from _entry function and this
>      struct as a parameter
>    - do coroutine enter and BDRV_POLL_WHILE loop
> 
> Let's reduce code duplication by generating coroutine wrappers.
> 
> This patch adds scripts/block-coroutine-wrapper.py together with some
> friends, which will generate functions with declared prototypes marked
> by 'generated_co_wrapper' specifier.
> 
> The usage of new code generation is as follows:
> 
>      1. define somewhere
> 
>          int coroutine_fn bdrv_co_NAME(...) {...}
> 
>         function
> 
>      2. declare in some header file
> 
>          int generated_co_wrapper bdrv_NAME(...);
> 
>         function with same list of parameters. (you'll need to include
>         "block/generated-co-wrapper.h" to get the specifier)
> 
>      3. both declarations should be available through block/coroutines.h
>         header.
> 
>      4. add header with generated_co_wrapper declaration into
>         COROUTINE_HEADERS list in Makefile
> 
> Still, no function is now marked, this work is for the following
> commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> ---
>   docs/devel/block-coroutine-wrapper.rst |  54 +++++++
>   block/block-gen.h                      |  49 +++++++
>   include/block/block.h                  |  10 ++
>   block/meson.build                      |   8 ++
>   scripts/block-coroutine-wrapper.py     | 187 +++++++++++++++++++++++++
>   5 files changed, 308 insertions(+)
>   create mode 100644 docs/devel/block-coroutine-wrapper.rst
>   create mode 100644 block/block-gen.h
>   create mode 100755 scripts/block-coroutine-wrapper.py


Also needed:

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 04773ce076..cb0abe1e69 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -31,3 +31,4 @@ Contents:
     reset
     s390-dasd-ipl
     clocks
+   block-coroutine-wrapper

-- 
Best regards,
Vladimir

