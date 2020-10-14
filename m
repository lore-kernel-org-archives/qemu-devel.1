Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2289AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFF721582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LoPiRx6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFF721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiRQ-0007xR-1k
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kShz0-00022r-UR; Wed, 14 Oct 2020 10:42:31 -0400
Received: from mail-am6eur05on2116.outbound.protection.outlook.com
 ([40.107.22.116]:52449 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kShyw-000775-1x; Wed, 14 Oct 2020 10:42:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucpr0Q/1vX99W4ikgI8uTUctO6AzCZs17Xk5er2tYJKSnUiYI+iHhFptZAUOzD6Wz26pCQXgNVq+2pk0+TJYLvBBdf3yNrIObbBX+GP6xYYSrXsZfYxGFRIlEdTa67J1MIlgDaxOyzqP42WNJvH6/2j08TebdQ+Ene9qu/S7JfHX8g7VwMRlFWoXe/sE9REZ6oLxaNbn1XYvyVSV2FaEVPQ1uXFRb5ooUgb8cmTaU0T7NW4NBCxOvIzTB/s7U3GVz5idW7/2uWE+3LdvSFtrLtTTkVkj7aThbnVN8tdpIzv1EeJ0zHIsrXzhQCHyuJzHC/frYv/oZ58CpnMRZJxD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYBz2dkYSM/S1N4LtfcBI/Xdy35ILp313hUZvAyfgNc=;
 b=JbnX09y6OEPz0/zwKXe9FMilaioC52OP7jpkbHtKlX5ET1vD/r8ONW/H2YN+K9DBOWNPHjIUHRfxNMwEXbZS1v7GLkgFK/fqGOBMgCiE2JD44r3Fh2RfbMPw9m2brz+cQszpaL5yByCJqfuBEp+L/8a4aO42Z+alK7C2uKzhYT8Mj2Kzttm/meuFRKzlap8o+PhkpYsIX2YYMwdAJfbAa1QIWGOY1xIjpr7Th7K2xFvKs0tbhv/Oohgums6eO5NSkZ1VKQebNXj3za0GVHsozjBYbzZNQDJK8ColPPqcpPWu0aspHL0ZDorW7wQbwqGcEGSNHX1Bhue8u+4ZK2Mu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYBz2dkYSM/S1N4LtfcBI/Xdy35ILp313hUZvAyfgNc=;
 b=LoPiRx6izgHDTfDN3zQj1k/A9dQJU1rOasPOpx8t1htqz4PHPnd4nqDvbnn3o58Uma1Vt6HgfjKhoIn+86rbs5xMbDQoyRX1+6ARhiki3+OB5Or6jArNupLzwL1SaNKaw3k/tKRJ1VlaM6EqgTNxe/pnejxMnE8sWkZJsShL1Ok=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2097.eurprd08.prod.outlook.com (2603:10a6:203:4c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 14:42:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 14:42:16 +0000
Subject: Re: [PATCH v4 7/7] nbd: Allow export of multiple bitmaps for one
 device
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, rjones@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-8-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ce14bdf9-0d40-58bc-c530-a529edf3740e@virtuozzo.com>
Date: Wed, 14 Oct 2020 17:42:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <20201009215533.1194742-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM4PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:205::14)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM4PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:205::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 14:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1f9f8a0-8e97-487b-da9d-08d8704f5884
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2097:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB209701E4A2197B98A61492CFC1050@AM5PR0801MB2097.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:53;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyPoriyTVlzaVRygz0TgY+ifD9ycoImMMB00eIv6B7gZGXXsr3N3mkuxjN71ZndKnzWl10oSbTa195huiTjNfqZ4Hhr8LaZqinC0eLglQexq4PggCUqEnzXKv/uO+qEiNEoFRkqsyY9usQmz7mId5nBQY8G3RM5Pv8+btlemWN1YL0jRoZq6rJXydPyb17iteX2/sMfA4LoFUVa6mp33uDrmkO/YmTN/K0Vy83C6b/uXpTIesVHfrzwFNx42QVSObDYA7+ZFaVpb1uTN0t0UcUk964EOvSIrNYIuc3rrkqSQ2hQW6JxyssZ4bvUvyHOknp+0ka+oSy4CK37t3m7cj1LBulwIjgIlab2A7k2ZCGtsr2xzl69eqofmBIKzkx1h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39840400004)(366004)(2616005)(66476007)(66556008)(956004)(36756003)(5660300002)(66946007)(83380400001)(6486002)(478600001)(2906002)(4326008)(31686004)(52116002)(26005)(86362001)(8676002)(316002)(16526019)(8936002)(186003)(16576012)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YvKDHLWBmcSzGDH9bbFXIGJJQ9dt040Q4PiMTh4H1WOm+lznf09oq6pWWTE37W0O+UqbmXpxsjyLXC8ePq/XNw2ZLTefCe7TAcK/xAZ2WCJVAWlXOe13On9XrmMNEtNkceoUGrsFEzVAdI60VmRJiTOdKRCCTzbJwLQbo07AHAXQQZ/TlYrsQnjMU3Pe/X19olWFM4Sh0ky85LyuP2eAoisox+MHsSepVvebyKWa2jXCMH90hDH+w4/GZnX6hs/LoT7AfK5y9U2gXhBIioISahNq6LR4rnlabUZVPNrhmX55jNu0EB4PfF70IvjUYXyNviBaVFuxNQk8XBWN30bKuGN3EFwFxpgoi1QJGEzzaCCbEYyK8ojhLUI/8kf2KtqDrfwZM7coiMPE1VRqxvlANH4Z+zSE3Mj6Lj4rcIqmEdF5xdemyn0V5jd/D5TsyaqFuVmdBg46FP7KzFblm62Sr48BnUOTILBlcRTO2J4SgKB4hLtpq7iOPiMHCMgVKdeoJep4j5/itucIvupScVk2nGKkQOVMNLCvxaXW8IH1CSDi/X4yE4KoATH85NgmNNs9k3Y38TrjAHMQIofYK8iO3/u2H7QRd1Yyn2baN/3YevZ/8rujUGhZ7rDKMMTbRy0A9O+wyKt+vNCDW9iHWfpC6Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f9f8a0-8e97-487b-da9d-08d8704f5884
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 14:42:16.4556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja6ZFliTcs2zg+FmNZsSTu2DcI+iz3cHVEV89VxJJclWSHKPD/H1Cf0ERfIxBGlGzJDiWspA54IWC3SjnMO45XpWbljxt1KvEHI8b60Xjkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2097
Received-SPF: pass client-ip=40.107.22.116;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 09:06:36
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

10.10.2020 00:55, Eric Blake wrote:
> With this, 'qemu-nbd -B b0 -B b1 -f qcow2 img.qcow2' can let you sniff
> out multiple bitmaps from one server.  qemu-img as client can still
> only read one bitmap per client connection, but other NBD clients
> (hello libnbd) can now read multiple bitmaps in a single pass.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


You didn't update nbd_export_create failure patch, I suggest:

@@ -1533,6 +1537,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
      bool shared = !exp_args->writable;
      strList *bitmaps;
      int ret;
+    size_t i;
  
      assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
  
@@ -1632,11 +1637,15 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
              goto fail;
          }
  
-        bdrv_dirty_bitmap_set_busy(bm, true);
          exp->export_bitmaps[exp->nr_export_bitmaps++] = bm;
          assert(strlen(bitmap) <= BDRV_BITMAP_MAX_NAME_SIZE);
      }
  
+    /* Mark bitmaps busy in a separate loop, to not bother with roll-back */
+    for (i = 0; i < exp->nr_export_bitmaps; i++) {
+        bdrv_dirty_bitmap_set_busy(bm, true);
+    }
+
      exp->allocation_depth = arg->allocation_depth;
  
      blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);
@@ -1646,6 +1655,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
      return 0;
  
  fail:
+    g_free(exp->export_bitmaps);
      g_free(exp->name);
      g_free(exp->description);
      return ret;

and with it:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


Also, would be good to add a comment:

@@ -29,6 +29,10 @@
  #define NBD_META_ID_BASE_ALLOCATION 0
  #define NBD_META_ID_ALLOCATION_DEPTH 1
  #define NBD_META_ID_DIRTY_BITMAP 2
+/*
+ * NBD_META_ID_DIRTY_BITMAP+i are reserved for dirty bitmaps, so keep
+ * NBD_META_ID_DIRTY_BITMAP the last one.
+ */
  
  /*
   * NBD_MAX_BLOCK_STATUS_EXTENTS: 1 MiB of extents data. An empirical



-- 
Best regards,
Vladimir

