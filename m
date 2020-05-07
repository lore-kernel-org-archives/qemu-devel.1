Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7B7C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C53C2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XoxHw4Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C53C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcEP-0003kb-IO
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDC-0001wW-C3; Thu, 07 May 2020 04:48:58 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:2308 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDB-0006ET-FB; Thu, 07 May 2020 04:48:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXMAxRhHVSPe8GaY0ug2ibaeqMlyBeWTKzVlHiw2Qo4dqevkUQgslW27hnH51kh8HpcnQ0UEE9klOtsx+CYm5xonCBmfM6j3Qw2HAjOLUMF1qNwi5TTMwp8k30KqIOIcCfESIT3jnCA/Dned/hbkbjU9g+Xzli3anWob513cF0WaRSJO37zGvENSP+jEVHodALLtQqlyUF3691WavFaU/yodXiBkvZsAQy68EoGvv26ETezHQTiG9WKwLG2kxvkFZIzccj/SG6uGOwJNECoUklwa/fkjOlILBIANWzAtdWd2c7QIYoHHFuP9gQN4NVU+CTeRtlMYWCtqJ9xqQxITSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcbgjCYYvhfsWp15T1RdkWOxF9JlG4jbjmNvT/in/0s=;
 b=cOZdpyR2FjPiv1kzfWZD7ZG4WU7INPbRulr287T58/scoyJDO1kXeEURNE4FMDskz6EGftbJj/EVyRhpCqk9WOWtHzjGhyALLZK+0SoT7KDqQ2V3iy8ffwaZSPUM/C6q7O2UDPyp73KZLfb+bxkjbmawkQSTv7+ymVkUwhoI2d25hImCz8pPuCMH3cPfbW3qhT5R4quPINOF4CNUjQP9kfvIxZQYEtz90fBXG/A2sE3dW1zvSIpBuCMeyvnmgo7UAduLZTWc+QSohxirjeEwh8k63w7LLYEYJrqYUQz9dY4pgP6D8LQTRIZnd9r6XgG0jh3u1R5wKW/3DQYNvL0Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcbgjCYYvhfsWp15T1RdkWOxF9JlG4jbjmNvT/in/0s=;
 b=XoxHw4EpTK0YPvahnebBgrdqnX0ReQDs7Ccfi1IwMHshqvQ9+iDzucx3yVQX/k74KO5jL3EUHjpHKIPKPZ4P2h+Ym2mTX7xyabNQnmL4Ak3Ntla5ZKD0kZdOQ/VqAd5Jyccuvz0Ti6vpn18AmAR0EFLpDj0mOKixONsuah9IyyU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/9] block/vdi: return ZERO block-status when appropriate
Date: Thu,  7 May 2020 11:47:54 +0300
Message-Id: <20200507084800.20596-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200507084800.20596-1-vsementsov@virtuozzo.com>
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:37 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38e8a38e-f5a8-4918-5f57-08d7f2636f32
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549549247C30838F93848292C1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dmncv1BX6QvOdhpQ5FKAkLfywAv8+Pyt/rhcGiodmc/ZG0xPIQfMcX5hzU4n6HjHVaVqe8zBZSzCtXTYuyuxfYNLXdM2CY+o/M+uG8Qx8VzjKYdPH6CFaBe2BC7hdbA1rI3sGc/vzNC9YT2w15gybJLniTjX5RzjxrCe2YYD34Vz1buy9cS6F7V6NPASyOPUJYo/9R7icqiszYuYlbH+aOlSFP+Uxllp9RDocrMHfq1Sn5CHPxk5RJbGT1vM1B0e3boQWloTK6rEHNmCDKoSDHRzeLNShUTu3YYe7cmwFBCzn77+56fSg27s/TnH15vF3ZN4e5qpKDAc+cLZt7rPacVJjcnWm6QmRgyM07ryOQoad3biHNec2UpEy5DMoj+/0URPA71awsIwf54yER7rS+0OPJ1I2GBdoU0wkdpmi99bRwB12Rp9RqBg8UIXdgTPWJ1yec4qLOH9gosVGzdi/qcgfslNDYl+1ahsSCJjlie+v2APvG4KWnSln6axrS7AeoraXUXblDKoqVaXBF41QcVjIe/fhVL0sf6TlXs4agkVQeonxQwzGEdSukxZ+Z6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(107886003)(66476007)(66946007)(66556008)(5660300002)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JyxStYvnbb0oViBzGWvJGFF0VeNYtbgKW7Q0DEGljD2Z2dJR7WQzINJXt3SfncMPOuxkWi759gtFiNqjQjEXCtbctDe2oftlcj6d7V/rDQxssaeU8HjZEWp+oy7ahAsMibpub1fH1ozNNIxF7U1ZkgWnbn56k3qQneyi0zcBlYysImocFJH3d4gsrMIOomko8Yn9s97R5JT+q2ekrlOCG041XxyfbuuhyRqoTa3ce+HGqowIxjEfxcWXrAPtd7mDaT3YxeWN7F9WWB33Ii7Pqm9L8L8Upck9iZO8NpbIiPb5QiS9eU3BqSl5eWk5ygcKpMFb+wsgoC8aTi8XeozQyH8XYarNngU9lDxJ5lPVl9ofdfmCSGL1WXEDZvB7YHcomWe5qY5ykGP7nOIW6IHjbLYwKfeg5HOzsJXUE0x0l8MW1LkWR5FIBICsMKhkuDaZhdITxKIMv0GW2T2wi0QVkv0zRHtlidVLRbRhkPTZu1GIRRRIxXHq84xuTeuDbddZvFwt3CGPz5NiezzvvwlQgMXuSyvkhdnulXUkOQ3GVKK6BLHL4Qb2ZVIwJ6Pdj65dfJs13NoBqjN1711EI9BAuMnLZMEVWZ4VhavQsyBygrpCDeUC85m+WpQR5BTgDIc1yiBneU82BeRwLUa+5XzbW6ST/ZegkSjSjk6h3d+aiuE/2raNzrLnVDkguljyBHRJQuNXLh2ev6869mhQsU2VEjYyK8IiOfsvmD9TtkoEEvqKNYpmrs6Jxcc0LJS9Jp/sG+rOzi/hG82H7DYyE0TQAz+jocwM+gNonlPHNXYQGDo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e8a38e-f5a8-4918-5f57-08d7f2636f32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:38.0188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBlkmBzS49Bmv9xFrdfv1c4O3pMHCVMb1D0EP36U6aD0AYpMNvVQ5KHtvpH182ATweqt6JVC/hfMqttKi6j+EoIY+HhzDIPoq7BoLrm11Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.4.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case of !VDI_IS_ALLOCATED[], we do zero out the corresponding chunk
of qiov. So, this should be reported as ZERO.

Note that this changes visible output of "qemu-img map --output=json"
and "qemu-io -c map" commands. For qemu-img map, the change is obvious:
we just mark as zero what is really zero. For qemu-io it's less
obvious: what was unallocated now is allocated.

There is an inconsistency in understanding of unallocated regions in
Qemu: backing-supporting format-drivers return 0 block-status to report
go-to-backing logic for this area. Some protocol-drivers (iscsi) return
0 to report fs-unallocated-non-zero status (i.e., don't occupy space on
disk, read result is undefined).

BDRV_BLOCK_ALLOCATED is defined as something more close to
go-to-backing logic. Still it is calculated as ZERO | DATA, so 0 from
iscsi is treated as unallocated. It doesn't influence backing-chain
behavior, as iscsi can't have backing file. But it does influence
"qemu-io -c map".

We should solve this inconsistency at some future point. Now, let's
just make backing-not-supporting format drivers (vdi at this patch and
vpc with the following) to behave more like backing-supporting drivers
and not report 0 block-status. More over, returning ZERO status is
absolutely valid thing, and again, corresponds to how the other
format-drivers (backing-supporting) work.

After block-status update, it never reports 0, so setting
unallocated_blocks_are_zero doesn't make sense (as the only user of it
is bdrv_co_block_status and it checks unallocated_blocks_are_zero only
for unallocated areas). Drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/vdi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 0c7835ae70..83471528d2 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -334,7 +334,6 @@ static int vdi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     logout("\n");
     bdi->cluster_size = s->block_size;
     bdi->vm_state_offset = 0;
-    bdi->unallocated_blocks_are_zero = true;
     return 0;
 }
 
@@ -536,7 +535,7 @@ static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
     *pnum = MIN(s->block_size - index_in_block, bytes);
     result = VDI_IS_ALLOCATED(bmap_entry);
     if (!result) {
-        return 0;
+        return BDRV_BLOCK_ZERO;
     }
 
     *map = s->header.offset_data + (uint64_t)bmap_entry * s->block_size +
-- 
2.21.0


