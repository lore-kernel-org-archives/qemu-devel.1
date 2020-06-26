Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45439C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15813206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ceRfBSEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15813206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jork8-0004Qk-BV
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jorWX-0006ut-PZ; Fri, 26 Jun 2020 12:48:24 -0400
Received: from mail-db8eur05on2107.outbound.protection.outlook.com
 ([40.107.20.107]:62785 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jorWT-0008IO-Dv; Fri, 26 Jun 2020 12:48:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gncdUNpKhNEzTPz2aDSYNMDxmemH1xbaJ+cQ/2BVqN1DAMUopanqPDOcXFQzsxiLiHtdG2TwvZK79sPjHshJA5L9YOE7NEedtWoTtIeomLBzW+p4d2w2SHyDeoq4399uKN/bJvS/S5bkcS4UxrBugkAP71jt4I3aelAxvuCAcMC9/CofeF6FtSsgMGG7mkxl0SunH5emgCj7SQaMVakp1GZHbDepT6SDdRS65igNWHx0lcHrJ65jJmdZQCoENakSwD/SNcjRYZrHcxhAMs1zhT/lnyrfE69SL0jHtWYwFI2zb77+BjzEokxt7Z8queyUgpe4tnMr5Reci3c7K8B6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM2IRdQb6PMycS24puQHRaXEJDpRmouPQ+26rlksKRs=;
 b=ZI0ssamu0U44VvnZEMG50ZAlT8tp8ajmomfTmVK/CA1Kk2KIKygREN2DUeE3ZrLxOm4cFu2sXXx7ZGsAuxbjmT0/jOSQu4hActFzIx4DZhvvuByzIWKgIbxfgLVfb4i7OLxz043MyICJ8/tDbIJvcoWXpJmkiT0SMpyLJJ3DZ3oaHqXyKoTAUkhm+lQ2RzCCurV97zm1a7Bct/gvwIc7GoyHD9NUel9xhU92WPTyfCxO7A6gtGtSyfbiTfMZFwgGleag33UzU9MtkW02drf/jLnvS/T61UNoUYxbKNOm0EuJzH7J1VS5Vazt6uaWnjeY+tqkSOPOBpV71Jq4Tt5pSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM2IRdQb6PMycS24puQHRaXEJDpRmouPQ+26rlksKRs=;
 b=ceRfBSEs0S7rV7gwSRfRJ9AxT2z5pXlCCiGBX7KOvCPyQtsuLcHRuxcoHcIKLgo3t7/6fslrFaedOHUdX3iTZ6U/pWztL86hAQu9Zj3UGvu5JbN47zIdtDyVyQFo7tX27vgCUXDyhtcpJBxUK9Hm7PyGXwzBwJf3s3c/owbxCEg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4536.eurprd08.prod.outlook.com (2603:10a6:20b:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 16:48:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 16:48:13 +0000
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix add_bitmaps_to_list
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200626130658.76498-1-vsementsov@virtuozzo.com>
 <20eed09c-f667-ab71-9d1a-a08c0c9d6a65@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e062f4cc-c78f-da88-97e0-bcb71e3dfd9c@virtuozzo.com>
Date: Fri, 26 Jun 2020 19:48:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20eed09c-f667-ab71-9d1a-a08c0c9d6a65@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0101.eurprd04.prod.outlook.com
 (2603:10a6:208:be::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.7) by
 AM0PR04CA0101.eurprd04.prod.outlook.com (2603:10a6:208:be::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:48:12 +0000
X-Originating-IP: [185.215.60.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a49e70e3-2812-43f9-3854-08d819f0b782
X-MS-TrafficTypeDiagnostic: AM6PR08MB4536:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4536C211EB1B52BF4C8D3533C1930@AM6PR08MB4536.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8cPxXKt0JnEJ9hGoANrLkqJ5gGdiRyV5xL7BQ5OvPhdKwzOfBIC71UazGGHQDgQE/o5+QUit+K43J/8H0HAJ5XpH7YXBvuzmjOBC42PCwK3t+k+jkx3xUZ3I7NHDMMNNRvpQoTkeHwSe7h2P0BB/WE9QwWcBbPnsCwyG3coXIxXhSp2Eu4X+pcG7RaoYNdxWwo2WMZ1irMEMz8gRtj+p0cXolv9hXNtyvYQ2zYjRVjfObVOH+goRqqaDhEkhbb70E3VtSxeSpAsir5zwHLNU38St3lFRNOp5Cfx3plLPS6Xr5H38p6rxb1At03DH6ZQliFmQEp5x0aMm6EtIgYvtpwsGnYy0RmxVzdJCmg/CHeul3RWftwNxn9srH5hHFhssJYtk3w3dzjZ+3zI23pcgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(39840400004)(376002)(396003)(66556008)(52116002)(26005)(66946007)(83380400001)(53546011)(36756003)(2906002)(478600001)(4326008)(186003)(6486002)(16526019)(16576012)(956004)(316002)(2616005)(31686004)(66476007)(8676002)(5660300002)(86362001)(31696002)(8936002)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OaOz4VH1ixvuW3LkyxwNKuPldYQn+nq8NYV7uRkKe9rOwtGvA6+24uHpjfFA3jswp5PmR+96FiPr7KS2VMokZoYiYS7KEt7Pf1Ov7xeH+4hwvXPap63uUwlS97O95YDdbkuxsUysJf2zpPx9MCmfDKfkeFgsAyGLd3pUr65pBIbPGn/tqX2CeUicva5/Bf4p/vyGoZJSUzP+qHYiW8z/7lNNgn7ZUbySJYTEgi6eOqB9WCsouNP2FTxaq3NEDUvCWCQvf/cKkrj8Z6qo1lI3wzlGQa65P7ul2m/KQQbIH9wcNa01mr6gi05cHzIxS72bZ4V7xV4BDfVKV/65lzCwJ+0AVd3w69cKPxnh0+ApdMYfzcmv9z6I06Wxqs9yn05OLrwJL+TLQu2MIZcm4Jr6YckOPoMIRludASSb8d2NS0rNvsdCpg+WUcFTOk/Zz1NUdYEUC3pdN1DArGo899fHk6hN/X1Ym+qUI49pM/DZ0jg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49e70e3-2812-43f9-3854-08d819f0b782
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:48:13.5501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t64KRA0bGVUFF+MEf/z7awslZz3FdoKn7vfBGL3+tuCw0vmeA1y5yULbPvcNIg0L+CA5u8p4/M41PvAW028ghoYpbVt1Q7DeYmFs5VknKsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4536
Received-SPF: pass client-ip=40.107.20.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 12:48:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.06.2020 17:34, Eric Blake wrote:
> On 6/26/20 8:06 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We shouldn't fail, if found unnamed bitmap in a unnamed node or node
> 
> We shouldn't fail when finding an unnamed
> 
>> with auto-generated node name, as bitmap migration ignores such bitmaps
>> at all.
> 
> such bitmaps in the first place.
> 
>>
>> Fixes: 82640edb88faa
>> Fixes: 4ff5cc121b089
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   migration/block-dirty-bitmap.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Will queue through the bitmaps tree.
> 
> Is this easy enough to reproduce that it would be worth having iotest coverage?

I don't think it worth it. This all is so bad, I only hope for the future of
explicit mapping.

This patch just fixes wrong code. Actually, today I've committed to downstream
also a change, which when see auto-generated node-name a few lines above just
returns 0 instead of an error, otherwise, in some specific case, bitmaps which
were in backing files break migrations (and when skipped, they migrate through
storage, as our specific case is storage migration).. Don't know, how much it
applies to upstream.

I've already said about my idea of "lazy" disabled bitmap: we shouldn't load them
all on start, but on demand. Actually same thing may be said about bitmaps in
read-only nodes. And of course migrating bitmaps from r-o backing chain, when it is
shared-migration is nonsense.

> 
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 47bc0f650c..b0dbf9eeed 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -274,7 +274,11 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
>>       DirtyBitmapMigBitmapState *dbms;
>>       Error *local_err = NULL;
>> -    bitmap = bdrv_dirty_bitmap_first(bs);
>> +    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>> +        if (bdrv_dirty_bitmap_name(bitmap)) {
>> +            break;
>> +        }
>> +    }
>>       if (!bitmap) {
>>           return 0;
>>       }
>>
> 


Here is my today's downstream fix:

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index e8ce791278..66f5d6365a 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -312,10 +312,12 @@ static int add_bitmaps_to_list(DBMSaveState *s,
      }
  
      if (bs_name[0] == '#') {
-        error_report("Found bitmap '%s' in a node with auto-generated "
-                     "name: %s. It can't be migrated",
-                     bdrv_dirty_bitmap_name(bitmap), bs_name);
-        return -1;
+        /*
+         * Reporting error here breaks shared migration of dispatcher-created
+         * bitmaps. In u13 we just ignored them (ignored all bitmaps in backing
+         * files). So, just ignore the node.
+         */
+        return 0;
      }
  
      for ( ; bitmap; bitmap = bdrv_dirty_bitmap_next(bs, bitmap)) {


I can send a patch, if you think it worth it. For me it seems too hacky and too specific.
With this change, bitmaps in backing chain can be migrated though shared-storage when
dirty-bitmaps capability is enabled.

(for clarity: u13 didn't have patch
  592203e7cfbd1a "migration/dirty-bitmaps: change bitmap enumeration method",
  and in u14 we've backported it)

-- 
Best regards,
Vladimir

