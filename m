Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DED2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB722078B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ptzDLjlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB722078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIEQ-0005sw-32
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJICx-0003pX-QT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJICt-0007r1-NH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:49:39 -0400
Received: from mail-am6eur05on2113.outbound.protection.outlook.com
 ([40.107.22.113]:33377 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJICi-0007kn-Rv; Tue, 31 Mar 2020 10:49:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwKIQv4QabZd7uGix9RYutML4biMaXVEvRbTEiujfsOLRbADTwx3ULaJvAaAoNgYi9oqoyjp07btilFbVlpP9wGHrxh4XVgMi/CyfLiYPWsRnwwCgTbGQAg00bQ3HPC+PRB6wWO5Vk05gjlEGufkScID9qE9etV0SoAB+TKGd+sym9zpTWl5r08VmTcZH8eZ/1ZpsoWIXnU/6qpom89cfCfi08QvPC/E9rPIiUc9sw4evEEWI9qzmuvwf0jb1xuW9Ld3xc40aAEW4NjCuA7MOVvVg3durHAPQ3dlflx0jDyznnWca+yXfBHOObzsUwOEfJ59dtKkvSV6NhopZkNGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdZksmEcgelntB6PKyX2mEHU+HWJKZYjz43xmKjQl1M=;
 b=lel1IZcMtea/QQqJvHgrS5piFsO8bVqjR/cMy0B9xY4M1bf7YxMqcQhFGVoxzrxhNrXzlvrz13zbYJdbH9Su2ySC0IFh2EHhPXVHn0Jy0nohKIDYWW4tLIZWGd5P/bYW8d6rzJ0ZXXoCyvovW04DSP8tgAqKiEq/+H4cLyN59A6ubB6AWEA3o6UDx7VLvOoBIlH9X3ziQo/imYkpGH6qYBLsTSxJMuspeWTO+NLPUvRWQGxpwM/iUuA5x2G7gKTHaZVVM9BuOvIInXxhuuFl4+w+VMZoZU3Dlmmw78A9AlexqfySstRH5Q4ZxrH2B+TsPsrIZMDSeTp9UP/HT4sdVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdZksmEcgelntB6PKyX2mEHU+HWJKZYjz43xmKjQl1M=;
 b=ptzDLjlQFLR7g1gkXqR1KCsvtzpLJOa/vZDfkRGCf7qJkKJfNyPVxnG0f0PO+l7iCPeiipNLObMK9rtNqcNIyYPzfaORUuSfm80QIAEeZFCm81Y07mgXY2IN60LFmM78qoqfwY70ow1EJLkmvX1+nLqOqG+RUDYb71mZ6BrLt4M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5414.eurprd08.prod.outlook.com (10.141.172.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Tue, 31 Mar 2020 14:49:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 14:49:22 +0000
Subject: Re: [PATCH v13 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200331131743.17448-1-dplotnikov@virtuozzo.com>
 <20200331131743.17448-4-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200331174920972
Message-ID: <c2bab0c3-a39e-7c4c-49cc-065f366906fc@virtuozzo.com>
Date: Tue, 31 Mar 2020 17:49:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200331131743.17448-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.2) by
 AM0PR01CA0008.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Tue, 31 Mar 2020 14:49:21 +0000
X-Tagtoolbar-Keys: D20200331174920972
X-Originating-IP: [185.215.60.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e310de60-5f23-4c33-ffeb-08d7d582b327
X-MS-TrafficTypeDiagnostic: AM7PR08MB5414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5414F0D7A8C0E01DC498DDD1C1C80@AM7PR08MB5414.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(39840400004)(396003)(366004)(136003)(346002)(2616005)(31696002)(16526019)(26005)(4326008)(186003)(52116002)(478600001)(66556008)(6486002)(8936002)(31686004)(66946007)(66476007)(81156014)(16576012)(81166006)(8676002)(86362001)(316002)(956004)(2906002)(36756003)(5660300002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChoLyPvboakvolv9CCRdRK5BAZpI3RCRJGSLFcMmNACZPKIc0c2EXnruxInfQnd0MbDaoN+YvkO2Iy81a35MbE4fVQy6xRh0HUTi/A/wWtB14IqeXMNjRkC9+4EBOy+30oF8EPIePPv8ZFvfBMFIpEonAGKLWV1bZid3pth8lIMR8Gz0TyBNMMTFv0TWUBseTif0FAb169gqP2k3Pj9EsIVIa2q5JMhHWGmB8RscKkptVXbxsqwpF6ocv0j2ni4NFsDg0x8fslT7meVsTpGT904XskALGbC6YNOiwfPZkXYDywQzPoMzsMGv2E1dKWsaHnzHHAMXYwAtVSH/aOAkbHabSP5X5K4cVvF85z5hlslfnHJtYVu2RhQTEeGrqT4zLfYpM02criZMAvuU9DGbIuGEO51RublveFFlnfmFjTQiTMv3kIpwQSH37w1lkzS/
X-MS-Exchange-AntiSpam-MessageData: UfjAxNHQzCYiXdHBFQ7Pe4WIBXdorFOHG778sRiXDqBboGdMXjKyi0mSXZXgoADUivR5fkj3AGdBSu4MbUOHde0tuIZLGfwekvUU5rnpYvyzzDMQF96hw69zxojNoG241VHLF9tiLGTVyNH+fdkauA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e310de60-5f23-4c33-ffeb-08d7d582b327
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 14:49:22.5945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhX/AUTevNOe+BZD8pyeDK9xzHm+YpDFBlyYZdR4Yx7iDS9OBVm2ok6ajdsLKytGKjckM3ydDi+uWytgA5meCkT94Yah1jh5o+FlXkybZVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5414
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.113
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.03.2020 16:17, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
> 
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
> 
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
> 
> compress cmd:
>    time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
>                    src.img [zlib|zstd]_compressed.img
> decompress cmd
>    time ./qemu-img convert -O qcow2
>                    [zlib|zstd]_compressed.img uncompressed.img
> 
>             compression               decompression
>           zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
> 
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---

Hi!

I have three suggestions:

1. return type of qcow2 compression functions is ssize_t, and return type of zstd is size_t. I think better is not to mix them.
2. safe check for ENOMEM in compression part - avoid overflow ( maximum of paranoia :)
3. slightly more tolerate sanity check in decompression part: allow zstd to make progress only on one of the buffers

Here is it, and if you like it, take it together with my
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 0b04f30bd8..208218c8f3 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -188,7 +188,7 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
  static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
                                     const void *src, size_t src_size)
  {
-    size_t ret;
+    ssize_t ret;
      ZSTD_outBuffer output = { dest, dest_size, 0 };
      ZSTD_inBuffer input = { src, src_size, 0 };
      ZSTD_CCtx *cctx;
@@ -214,13 +214,14 @@ static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
           * We want to use zstd streamed interface on decompression,
           * as we won't know the exact size of the compressed data.
           */
-        ret = ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);
-        if (ZSTD_isError(ret)) {
+        size_t zstd_ret = ZSTD_compressStream2(cctx, &output, &input,
+                                               ZSTD_e_end);
+        if (ZSTD_isError(zstd_ret)) {
              ret = -EIO;
              goto out;
          }
          /* Dest buffer isn't big enough to store compressed content */
-        if (output.pos + ret > output.size) {
+        if (zstd_ret > output.size - output.pos) {
              ret = -ENOMEM;
              goto out;
          }
@@ -248,7 +249,8 @@ out:
  static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
                                       const void *src, size_t src_size)
  {
-    size_t ret = 0;
+    ssize_t ret = 0;
+    size_t zstd_ret = 0;
      ZSTD_outBuffer output = { dest, dest_size, 0 };
      ZSTD_inBuffer input = { src, src_size, 0 };
      ZSTD_DCtx *dctx = ZSTD_createDCtx();
@@ -269,8 +271,9 @@ static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
       * ZSTD_decompressStream reads another ONE full frame.
       */
      while (output.pos < output.size) {
-        size_t last_input_pos = input.pos;
-        ret = ZSTD_decompressStream(dctx, &output, &input);
+        size_t last_progress = input.pos + output.pos;
+
+        zstd_ret = ZSTD_decompressStream(dctx, &output, &input);
          /*
           * zstd manual doesn't explicitly states what happens,
           * if the read the frame partially. But, based on the
@@ -278,7 +281,7 @@ static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
           * and have read all the frames from the input,
           * we end up with error here.
           */
-        if (ZSTD_isError(ret)) {
+        if (ZSTD_isError(zstd_ret)) {
              ret = -EIO;
              break;
          }
@@ -286,7 +289,7 @@ static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
          /*
           * Sanity check that each time we do some progress
           */
-        if (last_input_pos >= input.pos) {
+        if (last_progress >= input.pos + output.pos) {
              ret = -EIO;
              break;
          }
@@ -297,7 +300,7 @@ static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
       * if not, we somehow managed to get uncompressed cluster
       * greater then the cluster size.
       */
-    if (ret > 0) {
+    if (zstd_ret > 0) {
          ret = -EIO;
      }



-- 
Best regards,
Vladimir

