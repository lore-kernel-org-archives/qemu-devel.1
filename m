Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B1C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 09:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2591C20850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 09:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2591C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33365 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEsr9-0006Ox-Cr
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 05:52:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hEsqF-00060Z-89
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hEsqE-0003tY-25
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:51:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2264 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
	id 1hEsq8-0003nt-Jt; Fri, 12 Apr 2019 05:51:21 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 95ADE80E7B2DFA8E635F;
	Fri, 12 Apr 2019 17:51:14 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS410-HUB.china.huawei.com
	(10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
	17:51:05 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
	<bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
	<87bm1fiuo8.fsf@dusky.pond.sub.org>
	<20190409082852.GB6610@localhost.localdomain>
	<c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com>
	<20190411122246.GB5694@linux.fritz.box>
	<0c6c32b7-46f8-cf80-b7a6-1b48995b84e4@huawei.com>
Message-ID: <355cd139-2084-e282-9a60-3574fe0746bd@huawei.com>
Date: Fri, 12 Apr 2019 17:50:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
	Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <0c6c32b7-46f8-cf80-b7a6-1b48995b84e4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: Re: [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of
 flash device to save memory
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com,
	Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412095009.Daz9-rE_bY98OolT2HriEqg96uBO76S0O4eewCb21v4@z>


On 2019/4/12 9:52, Xiang Zheng wrote:
> On 2019/4/11 20:22, Kevin Wolf wrote:
>> Okay, so your problem is that blk_pread() writes to the whole buffer,
>> writing explicit zeroes for unallocated parts of the image, while you
>> would like to leave those parts of the buffer untouched so that we don't
>> actually allocate the memory, but can just use the shared zero page.
>>
>> If you just want to read the non-zero parts of the image, that can be
>> done by using a loop that calls bdrv_block_status() and only reads from
>> the image if the BDRV_BLOCK_ZERO bit is clear.
>>
>> Would this solve your problem?
> 
> Sounds good! What if guest tried to read/write the zero parts?
> 

I wrote the below patch (refer to bdrv_make_zero()) for test, it seems
that everything is OK and the memory is also exactly allocated on demand.

This requires pflash devices to use sparse files backend. Thus I have to
create images like:

   dd of="QEMU_EFI-pflash.raw" if="/dev/zero" bs=1M seek=64 count=0
   dd of="QEMU_EFI-pflash.raw" if="QEMU_EFI.fd" conv=notrunc

   dd of="empty_VARS.fd" if="/dev/zero" bs=1M seek=64 count=0


---8>---

diff --git a/block/block-backend.c b/block/block-backend.c
index f78e82a..ed8ca87 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1379,6 +1379,12 @@ BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                         flags | BDRV_REQ_ZERO_WRITE, cb, opaque);
 }

+int blk_pread_nonzeroes(BlockBackend *blk, void *buf)
+{
+    int ret = bdrv_pread_nonzeroes(blk->root, buf);
+    return ret;
+}
+
 int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int count)
 {
     int ret = blk_prw(blk, offset, buf, count, blk_read_entry, 0);
diff --git a/block/io.c b/block/io.c
index dfc153b..83e5ea7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -882,6 +882,38 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                         BDRV_REQ_ZERO_WRITE | flags);
 }

+int bdrv_pread_nonzeroes(BdrvChild *child, void *buf)
+{
+    int ret;
+    int64_t target_size, bytes, offset = 0;
+    BlockDriverState *bs = child->bs;
+
+    target_size = bdrv_getlength(bs);
+    if (target_size < 0) {
+        return target_size;
+    }
+
+    for (;;) {
+        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
+        if (bytes <= 0) {
+            return 0;
+        }
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+        if (ret & BDRV_BLOCK_ZERO) {
+            offset += bytes;
+            continue;
+        }
+        ret = bdrv_pread(child, offset, buf, bytes);
+        if (ret < 0) {
+            return ret;
+        }
+        offset += bytes;
+    }
+}
+
 /*
  * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
  * The operation is sped up by checking the block status and only writing
diff --git a/hw/block/block.c b/hw/block/block.c
index bf56c76..e3c67f8 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -53,7 +53,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
      * block device and read only on demand.
      */
     assert(size <= BDRV_REQUEST_MAX_BYTES);
-    ret = blk_pread(blk, 0, buf, size);
+    ret = blk_pread_nonzeroes(blk, buf);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "can't read block backend");
         return false;
diff --git a/include/block/block.h b/include/block/block.h
index c7a2619..d0e06cf 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -322,6 +322,7 @@ int bdrv_write(BdrvChild *child, int64_t sector_num,
                const uint8_t *buf, int nb_sectors);
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags);
+int bdrv_pread_nonzeroes(BdrvChild *child, void *buf);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes);
 int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 3be05c2..5d349d2 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -129,6 +129,7 @@ int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                                   int bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque);
+int blk_pread_nonzeroes(BlockBackend *blk, void *buf);
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
 int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int bytes);
 int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int bytes,
-- 
1.8.3.1



-- 

Thanks,
Xiang



