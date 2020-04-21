Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B13FC54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0007F2064C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XWJLFOtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0007F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrBF-0007e9-4P
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 07:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQrAR-0006sF-Eo
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQrAP-00081e-6V
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:34:18 -0400
Received: from mail-am6eur05on2121.outbound.protection.outlook.com
 ([40.107.22.121]:19424 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQrAO-0007yC-DS; Tue, 21 Apr 2020 07:34:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDWM3QAEVarO1RQUo5p/ebbgFL48Wqezt4YytdwMDdDCFpd9rhyHrHJYY2+eEYyUa8fNbaPtI/xObe6i00ML15c4EKwHUmWFEsGcahsidsHZDG+RDoj55/4QWe9SchlxCwW+5NoVS3x//dsDz6mvkJQFItg7Q6SLn59fkzwVdGIIyUBrwWgR8/Mv7qZPeeRgdgn4ddfT844c4kvw5HJTjOQx4DNwA/i2faRuvwOBa//85F4A7lwTxp9ATSBoAR0pndIhYXwd01ba7h69f4WdRX0nzHWnAzRaAHnQpybaB6MF14Icv1UE9hDd/hLY851xWQ/gQitR4wvxhp2/z86f8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT5xjGJQSV4UFCS1ilpJyA1nuzx5TEUtF0GHkN1qjEk=;
 b=OAj99z/J5mlBXbK6lr8ylT5P7Yt0YRHHvnS8yCe7mnT7brXcp5vU3LbH3fjl+8C8e+Y4AVr8NIu5wDFrtHm2qIjWba9rA5cOC9XQ9gv7c14rDgdOn4NtHAkkxwe+B72EaOMrQhcRcGFMrxwuExQVCdr79ZfzBHcEhFnu4h9Zx7A7SAvCvfDFZ67U5oau2LUD9HKI4ZM6m2pNQdh6KJcX/Zu/AYEjxMxauSIvX0WH9pl7Yjvk1eUG4Nb55+IudPE+jK4QqWnO0rrfQ9kJQWxwKz4yDqNoa4sWX1rvir+emVXiw0sOXP6e9qj7jp0uT9CyMI1AQQP9eDXfEP66Zj3ReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT5xjGJQSV4UFCS1ilpJyA1nuzx5TEUtF0GHkN1qjEk=;
 b=XWJLFOtkjxsq1mtwJpRcNVtilHZJ3Dx+PcTqcVZ3CgfvZgwt2AHf0ZrH54ljaavpzoz3BP4q03FVTPK3C7GsTmDSnHP/GD5M1LeMH8j3Ci5qEEQRx2f5bfIBtT5LFL88lcjS8B205TWc1Nsd5NXulmGfD/7GPTXxiW4lwq7gqKM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5432.eurprd08.prod.outlook.com (2603:10a6:20b:10b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 11:34:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 11:34:11 +0000
Subject: Re: [PATCH v4 8/9] iotests: Filter testfiles out in img_info_log()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-9-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421143409683
Message-ID: <19cee1b2-6a00-2fad-cbf0-7fa08b7ce0a6@virtuozzo.com>
Date: Tue, 21 Apr 2020 14:34:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420133214.28921-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0116.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM0PR01CA0116.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Tue, 21 Apr 2020 11:34:10 +0000
X-Tagtoolbar-Keys: D20200421143409683
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b05a7e3-fa69-49b3-416e-08d7e5e7e949
X-MS-TrafficTypeDiagnostic: AM7PR08MB5432:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5432BEDE47959A0E94DE99A8C1D50@AM7PR08MB5432.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(39850400004)(376002)(26005)(86362001)(478600001)(36756003)(4326008)(8936002)(81156014)(31696002)(8676002)(2616005)(16526019)(186003)(16576012)(31686004)(316002)(52116002)(66556008)(6486002)(66476007)(956004)(66946007)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADpXFlRCrWcIIuS49GgtsAWCPs3vFsohaoDhcT3pnmlMGGFIjTflV7ePH3G56TR7Uzvgyu/a3chJcRiAeR8YrwTvxHtB6mHkIBoyfmqQmL1Jl7WLqLcyuanU3LOZ1nojdUO0s9mv5ob6VBe0JnuF0fdT/LmCdASe/zQ5nGyyo9XjVIgUTp9nAP4jYB0x6yCBa0T1rCz0scKVG3jLc/SQVbh0DVkZIS7Gi1tGgruvemFsm25yS/23FMWGFL+LLMPB5xMfj37xE3o9Li4j9nYOmldvN0az7v/NvIcHG9TvVx3cua4vaUBioPHLi4O6Qm8tYDSlY0zDNLBnsjLZSFNSLsMel3A9am/0OK3rs0NPcm+aHMsbwuSHsUQpg52s7u6OZ8amI8KkHCtBUkAYSl94Q4iOPSOZs4v3UpxjvFemAUf5aTqkqrNfEyL7uItbrVE3
X-MS-Exchange-AntiSpam-MessageData: DVHWA1HniAwUdCd6zzt+2sHmAbk1TbPZRDR6FXfOOZOLv/HvLriouKMgXb2JBr7txsOuoNObkVvVI7c5uvONfHpDw66oXiQ900lyQgUTz5VDHqnzBg4ErS+CJKdzvp8VqGPjWLXqL+Qpvzy8n9hJqg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b05a7e3-fa69-49b3-416e-08d7e5e7e949
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 11:34:11.2124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/zm4X4f14Xv99hWvmJhTCzJgthS9RaqGVdsl9mOITLHDvg07Gk8jdO6ehQgtxp4kzApZ7QzBT25/SCut0ove1NkkskcuDOO7m0drSG6Ywk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5432
Received-SPF: pass client-ip=40.107.22.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 07:34:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.121
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 16:32, Kevin Wolf wrote:
> This changes the output of some files where instead of filter_img_info()
> now filter_testfiles() takes precedence, so update the reference output.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py |  5 ++++-
>   tests/qemu-iotests/206.out    | 12 ++++++------
>   tests/qemu-iotests/242.out    | 12 ++++++------
>   3 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 7bc4934cd2..3eaf29411b 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -152,7 +152,10 @@ def img_info_log(filename, filter_path=None, imgopts=False, extra_args=[]):
>       output = qemu_img_pipe(*args)
>       if not filter_path:
>           filter_path = filename
> -    log(filter_img_info(output, filter_path))
> +
> +    output = filter_testfiles(output)
> +    output = filter_img_info(output, filter_path)
> +    log(output)

Looks weird for me, because filter_img_info is used only in img_info_log, and seems to be the function, which specifically prepare img_info output for printing. So, isn't it better to improve filter_img_info itself?

Hmm, qemu_io_log do the same thing, it uses filter_testfiles, and filter_qemu_io.. So, at least you are not the first.

Still, for applying several filters, seems better to use filters=[] argument of log, like in qemu_io_log.

>   
>   def qemu_io(*args):
>       '''Run qemu-io and return the stdout data'''
> diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
> index 61e7241e0b..adde82f9b8 100644
> --- a/tests/qemu-iotests/206.out
> +++ b/tests/qemu-iotests/206.out
> @@ -12,7 +12,7 @@
>   {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>   {"return": {}}
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-t.IMGFMT

Honestly, doesn't look as improvement.. But not a problem of course.

>   file format: IMGFMT
>   virtual size: 128 MiB (134217728 bytes)
>   cluster_size: 65536
> @@ -34,7 +34,7 @@ Format specific information:
>   {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>   {"return": {}}
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-t.IMGFMT
>   file format: IMGFMT
>   virtual size: 64 MiB (67108864 bytes)
>   cluster_size: 65536
> @@ -56,7 +56,7 @@ Format specific information:
>   {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>   {"return": {}}
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-t.IMGFMT
>   file format: IMGFMT
>   virtual size: 32 MiB (33554432 bytes)
>   cluster_size: 2097152
> @@ -78,11 +78,11 @@ Format specific information:
>   {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>   {"return": {}}
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-t.IMGFMT
>   file format: IMGFMT
>   virtual size: 32 MiB (33554432 bytes)
>   cluster_size: 512
> -backing file: TEST_IMG.base
> +backing file: TEST_DIR/PID-t.IMGFMT.base
>   backing file format: IMGFMT
>   Format specific information:
>       compat: 0.10
> @@ -95,7 +95,7 @@ Format specific information:
>   {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>   {"return": {}}
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-t.IMGFMT
>   file format: IMGFMT
>   virtual size: 32 MiB (33554432 bytes)
>   encrypted: yes
> diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
> index 7ac8404d11..0cc3a78bb2 100644
> --- a/tests/qemu-iotests/242.out
> +++ b/tests/qemu-iotests/242.out
> @@ -6,7 +6,7 @@ wrote 262144/262144 bytes at offset 0
>   
>   qemu-img info dump:
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-disk
>   file format: IMGFMT
>   virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
> @@ -26,7 +26,7 @@ wrote 262144/262144 bytes at offset 262144
>   
>   qemu-img info dump:
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-disk
>   file format: IMGFMT
>   virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
> @@ -58,7 +58,7 @@ wrote 262144/262144 bytes at offset 524288
>   
>   qemu-img info dump:
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-disk
>   file format: IMGFMT
>   virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
> @@ -98,7 +98,7 @@ Test 4
>   Checking "in-use" flag...
>   qemu-img info dump:
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-disk
>   file format: IMGFMT
>   virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
> @@ -143,11 +143,11 @@ Test 5
>   {"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 16384, "name": "bitmap-0", "node": "drive0", "persistent": true}}
>   {"return": {}}
>   Write an unknown bitmap flag '0x4' into a new QCOW2 image at offset 327695
> -qemu-img: Could not open 'TEST_IMG': Bitmap 'bitmap-0' doesn't satisfy the constraints
> +qemu-img: Could not open 'TEST_DIR/PID-disk': Bitmap 'bitmap-0' doesn't satisfy the constraints
>   
>   Unset the unknown bitmap flag '0x4' in the bitmap directory entry:
>   
> -image: TEST_IMG
> +image: TEST_DIR/PID-disk
>   file format: IMGFMT
>   virtual size: 1 MiB (1048576 bytes)
>   cluster_size: 65536
> 


-- 
Best regards,
Vladimir

