Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D4FC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D08922201
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZcRpt231"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D08922201
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShm7-00039L-1f
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kShlS-0002cc-HW; Wed, 14 Oct 2020 10:28:26 -0400
Received: from mail-eopbgr00139.outbound.protection.outlook.com
 ([40.107.0.139]:57535 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kShlP-0005Ge-Dx; Wed, 14 Oct 2020 10:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTMKQ0290ZjO/X4SAskAsosi6dgJpBfC6H6wdsWCaLtNwTwAiYCZsGEUkkVkQwoLNW9G6YH//SItBn4+D043uOBPjcPxMpJJKjpgJMYRu5AOd5GvI42qhL20aA1YAGeihLU8O3w+Y0Sjv4+vvGy2BLSlEpzUOfpB0nkW1i6Wq6jTwL7AgC5BLIq6Y6xnh/DdLpVCyrE+i530oMo1YOA995yUJxXoqOo7Pt32dUQR+AIBEaTk1g0dWB7SIS1yOnl8UURcmxJv1C28iUtPN6v4f1XAns/4zTVVOjYIrF89AgNfoOBRbJmnwTgdC2WTLJaTHN4nE9a0JGD2KHwLj961NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyKYx+erT5eKovQq/1msetWzmKb9UH/esRDZ/7awZSk=;
 b=beDqxGYU7gDo+rKxyWS38zlL6ScFYrMvcrYOPU8x6KB2KTip/XcjXQL32quGhrVZRmEoeDfKVcEmyZrJjISadTSqGTy+PXuhQf1elHuxaj88OTqfgu+x04NcgF3nQz15QIgkLf5V5UD08HBPD/t6NgoRuHKbs4ODIqJQ2CXu2yFdFIUFx7lyFs2KjxOmwLbd7/2suW4NN4qrtP4NqGSfuw6vr/7ucl8sSqNL3b/9DRN0gi1/6MVOpz06FwRD0KSlsqavWJG4jgWDQIrzHNfAYhej+xkwcMqKHZ+8dD5yaoJwVwM4fmz6XIME5/Ebky4LhyhK9UIJFxc5rCs7jVbXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyKYx+erT5eKovQq/1msetWzmKb9UH/esRDZ/7awZSk=;
 b=ZcRpt231AgjN06P0GRimlBG4Zr3ImN2b/6myE+Girolbq/W1TGPib2E2En2DOUNTRNJ6AnqGjZOQpVMSlQnhz/jEERKlw2YFM3b0Yg8hHuvvFkWO4cd8itIfFuHGdxXGHqbfT+cHO9XLBlLPdYK6x2Xgny9N7BxIqnSRovP798U=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1644.eurprd08.prod.outlook.com (2603:10a6:3:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Wed, 14 Oct
 2020 14:28:18 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 14:28:17 +0000
Subject: Re: [PATCH v11 02/13] copy-on-read: add filter append/drop functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <39aec06d-6dbd-a0e4-c3b8-d0f243864121@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <e88ba6fb-17ae-1539-1174-395bfee890de@virtuozzo.com>
Date: Wed, 14 Oct 2020 17:28:14 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <39aec06d-6dbd-a0e4-c3b8-d0f243864121@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM4PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:205:1::42) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM4PR07CA0029.eurprd07.prod.outlook.com (2603:10a6:205:1::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 14:28:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd2d46f-ba1d-4a13-d5a9-08d8704d6459
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1644BCC24BA298B55658C1D2F4050@HE1PR0801MB1644.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NugbwZNQwJbvQbtmPAWe8RdAA5SfsEj7qw8uepn6A0IfQFWJW02pL+HyAOVvnOlJwzYF8MTZ12FJ//iGlKf45m101DalhvNRILj1Jm2aptOOJgQz7rlSAD8sHEBvhI6yiS1mBxWVs5eKv1KqHXpg64r8XQFDA8dvHXTxn+c/sNVTwz+uwupr38VvR4NIy/4AOqN9O5BA+d2HpcHiw1996te/gFGeSK87hxLFmh0eerOGLTcfe6a7q6WHYNFhm8ZnpH3AjqeQxP6lxEQ87tnH4C7g7nPbc2bQqFf7kWdR4PYslJUZPAwMS/1khJDRpDzfG2IWt2IQAIwj8vSyX31eCsct666Y/K9qqGAFca+oElsRXWTcPcz7+QOWSBEpvXit
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(346002)(366004)(396003)(376002)(136003)(36756003)(2906002)(31696002)(66946007)(6486002)(66476007)(83380400001)(66556008)(53546011)(5660300002)(26005)(6506007)(478600001)(316002)(8676002)(16526019)(8936002)(52116002)(956004)(6512007)(44832011)(107886003)(4326008)(2616005)(31686004)(86362001)(7416002)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: b8Qi88JNZVvnjdoKSmtd41BokL2u0hGeBlDCb24PiPtLmVukjeaMuma8ceewdriyMiCUCe7i5zJI2zAtoyvyRkRokzSjpFNlhbOXAEDdiBn42Yvs/9Klo967+ZLY4rAdYjfv1TRhmzTitz9GUJu1cpgEaZT7eqX6qnzFtjLjJNs4fnnMtNuDSl7zRTuwEKOPD2dkNs82OCxjHZJKJw2ke5m+U/w6f0YgDj4x1dmb0meCkrVjzdM23I9TOldnbl6lfTMmSCB5fA0iiKmzankzqP1/LqQHwdDtpbFVivxzPMFxgnjqmWNvnuXU+ucnnIjhooLm8ZZJuO2q7DREZOJzSjQFODyog+AlEaSkg+WtzUeTbUW2p9ow+ex+ubPNt8XCrgwnGCGAzEtWXjnNyfQNoaeQFzJRSWcurN39ANkjNdaxot7fcliwfJUqNmmGDB9+OU9MMw5oyGTIAuMFTSpCrKyqM2da9QEXCzZPLDAuciexJaAmw2HW84pMvw2ZZIHzEWLI7aKWuksw+bQC1Fs8mOgrcYt5pzK+muMK6rBtfuvREzgeR7wJcUHCOVje960saNlhzj8el2GW8m0KLyItID5wi22p8eUTfApTA6ZI3OO60tKaoFm4RpqE53qtp3qiv63efhJBdpVYnyyJwXprIA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd2d46f-ba1d-4a13-d5a9-08d8704d6459
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 14:28:17.3306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85zpRKTP4wb7I6berRCftwIwF6LDQWQTTE/VKFwdW1k0pOM+YzKFVqdDQ3br30llpByhCUWripJlxltFD5kWjZwhtVBxAu2Ye3Xmkew8MvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1644
Received-SPF: pass client-ip=40.107.0.139;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 10:28:19
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

On 14.10.2020 13:44, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> Provide API for the COR-filter insertion/removal.
>> Also, drop the filter child permissions for an inactive state when the
>> filter node is being removed.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   block/copy-on-read.h | 35 +++++++++++++++++++++
>>   2 files changed, 123 insertions(+)
>>   create mode 100644 block/copy-on-read.h
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index cb03e0f..bcccf0f 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
> 
> [...]
> 
>> @@ -159,4 +188,63 @@ static void bdrv_copy_on_read_init(void)
>>       bdrv_register(&bdrv_copy_on_read);
>>   }
>>   
>> +
>> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
>> +                                         QDict *node_options,
>> +                                         int flags, Error **errp)
> 
> I had hoped you could make this a generic block layer function. :(
> 
> (Because it really is rather generic)
> 
> *shrug*

Actually, I did (and still can do) that for the 'append node' function 
only but not for the 'drop node' one so far...

diff --git a/block.c b/block.c
index 11ab55f..f41e876 100644
--- a/block.c
+++ b/block.c
@@ -4669,6 +4669,55 @@ static void bdrv_delete(BlockDriverState *bs)
      g_free(bs);
  }

+BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict 
*node_options,
+                                   int flags, Error **errp)
+{
+    BlockDriverState *new_node_bs;
+    Error *local_err = NULL;
+
+    new_node_bs =  bdrv_open(NULL, NULL, node_options, flags, errp);
+    if (new_node_bs == NULL) {
+        error_prepend(errp, "Could not create node: ");
+        return NULL;
+    }
+
+    bdrv_drained_begin(bs);
+    bdrv_replace_node(bs, new_node_bs, &local_err);
+    bdrv_drained_end(bs);
+
+    if (local_err) {
+        bdrv_unref(new_node_bs);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return new_node_bs;
+}
+
+void bdrv_remove_node(BlockDriverState *bs)
+{
+    BdrvChild *child;
+    BlockDriverState *inferior_bs;
+
+    child = bdrv_filter_or_cow_child(bs);
+    if (!child) {
+        return;
+    }
+    inferior_bs = child->bs;
+
+    /* Retain the BDS until we complete the graph change. */
+    bdrv_ref(inferior_bs);
+    /* Hold a guest back from writing while permissions are being reset. */
+    bdrv_drained_begin(inferior_bs);
+    /* Refresh permissions before the graph change. */
+    bdrv_child_refresh_perms(bs, child, &error_abort);
+    bdrv_replace_node(bs, inferior_bs, &error_abort);
+
+    bdrv_drained_end(inferior_bs);
+    bdrv_unref(inferior_bs);
+    bdrv_unref(bs);
+}

So, it is an intermediate solution in this patch of the series. I am 
going to make both functions generic once Vladimir overhauls the QEMU 
permission update system. Otherwise, the COR-filter node cannot be 
removed from the backing chain gracefully.

Thank you for your r-b. If the next version comes, I can move the 
'append node' function only to the generic layer.

Andrey

> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
>> +{
>> +    BlockDriverState *cor_filter_bs;
>> +    Error *local_err = NULL;
>> +
>> +    cor_filter_bs = bdrv_open(NULL, NULL, node_options, flags, errp);
>> +    if (cor_filter_bs == NULL) {
>> +        error_prepend(errp, "Could not create COR-filter node: ");
>> +        return NULL;
>> +    }
>> +
>> +    if (!qdict_get_try_str(node_options, "node-name")) {
>> +        cor_filter_bs->implicit = true;
>> +    }
>> +
>> +    bdrv_drained_begin(bs);
>> +    bdrv_replace_node(bs, cor_filter_bs, &local_err);
>> +    bdrv_drained_end(bs);
>> +
>> +    if (local_err) {
>> +        bdrv_unref(cor_filter_bs);
>> +        error_propagate(errp, local_err);
>> +        return NULL;
>> +    }
>> +
>> +    return cor_filter_bs;
>> +}
> 

