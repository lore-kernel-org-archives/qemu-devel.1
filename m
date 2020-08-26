Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E62FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448D120707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448D120707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqAc-0002y2-Fk
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAq8R-0007Ct-JJ; Wed, 26 Aug 2020 03:46:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2926 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAq8L-0001yi-Vl; Wed, 26 Aug 2020 03:46:19 -0400
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 7B379176D220AE100E99;
 Wed, 26 Aug 2020 15:46:03 +0800 (CST)
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.252]) by
 dggemi405-hub.china.huawei.com ([10.3.17.143]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 15:45:57 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH V2 02/10] migration/: fix some comment spelling errors
Thread-Topic: [PATCH V2 02/10] migration/: fix some comment spelling errors
Thread-Index: AdZ7e58eLH+Cj8odTD6kr5etL2R3OA==
Date: Wed, 26 Aug 2020 07:45:57 +0000
Message-ID: <640CDEE67BE2784FAE298BB2517210E48AC3A1@dggemi522-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.227]
Content-Type: multipart/alternative;
 boundary="_000_640CDEE67BE2784FAE298BB2517210E48AC3A1dggemi522mbschina_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:46:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhaolichang <zhaolichang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_640CDEE67BE2784FAE298BB2517210E48AC3A1dggemi522mbschina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the migration folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
migration/colo-failover.c |  2 +-
migration/colo.c          |  2 +-
migration/multifd.c       |  4 ++--
migration/postcopy-ram.c  |  4 ++--
migration/postcopy-ram.h  |  2 +-
migration/ram.c           | 10 +++++-----
migration/rdma.c          |  8 ++++----
migration/savevm.c        |  4 ++--
8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index e9ca0b4774..b717edc8e2 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -46,7 +46,7 @@ void failover_request_active(Error **errp)
{
    if (failover_set_state(FAILOVER_STATUS_NONE,
         FAILOVER_STATUS_REQUIRE) !=3D FAILOVER_STATUS_NONE) {
-        error_setg(errp, "COLO failover is already actived");
+        error_setg(errp, "COLO failover is already activated");
         return;
     }
     failover_bh =3D qemu_bh_new(colo_failover_bh, NULL);
diff --git a/migration/colo.c b/migration/colo.c
index ea7d1e9d4e..80788d46b5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -632,7 +632,7 @@ out:
     /*
      * It is safe to unregister notifier after failover finished.
      * Besides, colo_delay_timer and colo_checkpoint_sem can't be
-     * released befor unregister notifier, or there will be use-after-free
+     * released before unregister notifier, or there will be use-after-fre=
e
      * error.
      */
     colo_compare_unregister_notifier(&packets_compare_notifier);
diff --git a/migration/multifd.c b/migration/multifd.c
index d0441202aa..ac84a61797 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -731,7 +731,7 @@ static void multifd_new_send_channel_async(QIOTask *tas=
k, gpointer opaque)
         qemu_sem_post(&p->sem_sync);
         /*
          * Although multifd_send_thread is not created, but main migration
-         * thread neet to judge whether it is running, so we need to mark
+         * thread needs to judge whether it is running, so we need to mark
          * its status.
          */
         p->quit =3D true;
@@ -1042,7 +1042,7 @@ bool multifd_recv_all_channels_created(void)

/*
  * Try to receive all multifd channels to get ready for the migration.
- * - Return true and do not set @errp when correctly receving all channels=
;
+ * - Return true and do not set @errp when correctly receiving all channel=
s;
  * - Return false and do not set @errp when correctly receiving the curren=
t one;
  * - Return false and set @errp when failing to receive the current channe=
l.
  */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 1bb22f2b6c..baf094ba3a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -237,7 +237,7 @@ release_ufd:
  * request_ufd_features: this function should be called only once on a new=
ly
  * opened ufd, subsequent calls will lead to error.
  *
- * Returns: true on succes
+ * Returns: true on success
  *
  * @ufd: fd obtained from userfaultfd syscall
  * @features: bit mask see UFFD_API_FEATURES
@@ -807,7 +807,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)

     low_time_offset =3D get_low_time_offset(dc);
     /* lookup cpu, to clear it,
-     * that algorithm looks straighforward, but it's not
+     * that algorithm looks straightforward, but it's not
      * optimal, more optimal algorithm is keeping tree or hash
      * where key is address value is a list of  */
     for (i =3D 0; i < smp_cpus; i++) {
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 9941feb63a..6d2b3cf124 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -161,7 +161,7 @@ struct PostCopyFD {
  */
void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
-/* Call each of the shared 'waker's registerd telling them of
+/* Call each of the shared 'waker's registered telling them of
  * availability of a block.
  */
int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset);
diff --git a/migration/ram.c b/migration/ram.c
index 76d4fee5d5..c5f36aeae5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -256,7 +256,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
     /*
      * Always use little endian when sending the bitmap. This is
      * required that when source and destination VMs are not using the
-     * same endianess. (Note: big endian won't work.)
+     * same endianness. (Note: big endian won't work.)
      */
     bitmap_to_le(le_bitmap, block->receivedmap, nbits);

@@ -275,7 +275,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
     qemu_put_buffer(file, (const uint8_t *)le_bitmap, size);
     /*
      * Mark as an end, in case the middle part is screwed up due to
-     * some "misterious" reason.
+     * some "mysterious" reason.
      */
     qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
     qemu_fflush(file);
@@ -718,7 +718,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **cur=
rent_data,
     /*
      * Reaching here means the page has hit the xbzrle cache, no matter wh=
at
      * encoding result it is (normal encoding, overflow or skipping the pa=
ge),
-     * count the page as encoded. This is used to caculate the encoding ra=
te.
+     * count the page as encoded. This is used to calculate the encoding r=
ate.
      *
      * Example: 2 pages (8KB) being encoded, first page encoding generates=
 2KB,
      * 2nd page turns out to be skipped (i.e. no new bytes written to the
@@ -3705,7 +3705,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlo=
ck *block)

     /*
      * Note: see comments in ramblock_recv_bitmap_send() on why we
-     * need the endianess convertion, and the paddings.
+     * need the endianness conversion, and the paddings.
      */
     local_size =3D ROUND_UP(local_size, 8);

@@ -3743,7 +3743,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlo=
ck *block)
     }

     /*
-     * Endianess convertion. We are during postcopy (though paused).
+     * Endianness conversion. We are during postcopy (though paused).
      * The dirty bitmap won't change. We can directly modify it.
      */
     bitmap_from_le(block->bmap, le_bitmap, nbits);
diff --git a/migration/rdma.c b/migration/rdma.c
index bea6532813..c399c86785 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1510,7 +1510,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *r=
dma)
     } else {
         /* This is the source side, we're in a separate thread
          * or destination prior to migration_fd_process_incoming()
-         * after postcopy, the destination also in a seprate thread.
+         * after postcopy, the destination also in a separate thread.
          * we can't yield; so we have to poll the fd.
          * But we need to be able to handle 'cancel' or an error
          * without hanging forever.
@@ -2267,7 +2267,7 @@ static inline int qemu_rdma_buffer_mergable(RDMAConte=
xt *rdma,
  *    chunk, then start a new chunk and flush() the old chunk.
  * 3. To keep the hardware busy, we also group chunks into batches
  *    and only require that a batch gets acknowledged in the completion
- *    qeueue instead of each individual chunk.
+ *    queue instead of each individual chunk.
  */
static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
                            uint64_t block_offset, uint64_t offset,
@@ -3149,7 +3149,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *=
opaque,
     if (size > 0) {
         /*
          * Add this page to the current 'chunk'. If the chunk
-         * is full, or the page doen't belong to the current chunk,
+         * is full, or the page doesn't belong to the current chunk,
          * an actual RDMA write will occur and a new chunk will be formed.
          */
         ret =3D qemu_rdma_write(f, rdma, block_offset, offset, size);
@@ -4102,7 +4102,7 @@ void rdma_start_outgoing_migration(void *opaque,
         goto err;
     }

-    /* RDMA postcopy need a seprate queue pair for return path */
+    /* RDMA postcopy need a separate queue pair for return path */
     if (migrate_postcopy()) {
         rdma_return_path =3D qemu_rdma_data_init(host_port, errp);

diff --git a/migration/savevm.c b/migration/savevm.c
index a843d202b5..62a4f04762 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2795,7 +2795,7 @@ void qmp_xen_save_devices_state(const char *filename,=
 bool has_live, bool live,

     if (!has_live) {
         /* live default to true so old version of Xen tool stack can have =
a
-         * successfull live migration */
+         * successful live migration */
         live =3D true;
     }

@@ -2818,7 +2818,7 @@ void qmp_xen_save_devices_state(const char *filename,=
 bool has_live, bool live,
          * "xen-save-devices-state" and in case of migration failure, libx=
l
          * would call "cont".
          * So call bdrv_inactivate_all (release locks) here to let the oth=
er
-         * side of the migration take controle of the images.
+         * side of the migration take control of the images.
          */
         if (live && !saved_vm_running) {
             ret =3D bdrv_inactivate_all();
--
2.26.2.windows.1


--_000_640CDEE67BE2784FAE298BB2517210E48AC3A1dggemi522mbschina_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">I found that there are many spe=
lling errors in the comments of qemu,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">so I used the spellcheck tool t=
o check the spelling errors<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">and finally found some spelling=
 errors in the migration folder.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: zhaolichang &lt;=
zhaolichang@huawei.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reviewed-by: Peter Maydell &lt;=
peter.maydell@linaro.org&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">migration/colo-failover.c |&nbs=
p; 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">migration/colo.c&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;-<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">migration/multifd.c&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">migration/postcopy-ram.c&nbsp; =
|&nbsp; 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">migration/postcopy-ram.h&nbsp; =
|&nbsp; 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">migration/ram.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;| 10 &#43;&#43;&#43;&#43;&#43;=
-----<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">migration/rdma.c&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 &#43;&#43;&#43;&#43;----<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">migration/savevm.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">8 files changed, 18 insertions(=
&#43;), 18 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/migration/colo-fai=
lover.c b/migration/colo-failover.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index e9ca0b4774..b717edc8e2 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/migration/colo-failover.c=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/migration/col=
o-failover.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -46,7 &#43;46,7 @@ void fail=
over_request_active(Error **errp)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">{<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; if (failover=
_set_state(FAILOVER_STATUS_NONE,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; FAILOVER_STATUS_REQUIRE) !=3D FAILOVER_STATUS_NONE) {<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; error_setg(errp, &quot;COLO failover is already actived&quot;)=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; error_setg(errp, &quot;COLO failover is already activated&=
quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; failov=
er_bh =3D qemu_bh_new(colo_failover_bh, NULL);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/migration/colo.c b=
/migration/colo.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index ea7d1e9d4e..80788d46b5 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/migration/colo.c<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/migration/col=
o.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -632,7 &#43;632,7 @@ out:<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* It is safe to unregister notifier after failover finished.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* Besides, colo_delay_timer and colo_checkpoint_sem can't be<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * rel=
eased befor unregister notifier, or there will be use-after-free<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 released before unregister notifier, or there will be use-after-free<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* error.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; colo_c=
ompare_unregister_notifier(&amp;packets_compare_notifier);<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/migration/multifd.=
c b/migration/multifd.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index d0441202aa..ac84a61797 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/migration/multifd.c<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/migration/mul=
tifd.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -731,7 &#43;731,7 @@ static =
void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; qemu_sem_post(&amp;p-&gt;sem_sync);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * Although multifd_send_thread is not created, but =
main migration<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * thread neet to judge whether it is running, so we need=
 to mark<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * thread needs to judge whether it is running, so we=
 need to mark<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * its status.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; p-&gt;quit =3D true;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1042,7 &#43;1042,7 @@ bool =
multifd_recv_all_channels_created(void)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Try to receive all mul=
tifd channels to get ready for the migration.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * - Return true and do not se=
t @errp when correctly receving all channels;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * - Return true and do no=
t set @errp when correctly receiving all channels;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * - Return false and do =
not set @errp when correctly receiving the current one;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * - Return false and set=
 @errp when failing to receive the current channel.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/migration/postcopy=
-ram.c b/migration/postcopy-ram.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 1bb22f2b6c..baf094ba3a 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/migration/postcopy-ram.c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/migration/pos=
tcopy-ram.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -237,7 &#43;237,7 @@ release=
_ufd:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * request_ufd_features: =
this function should be called only once on a newly<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * opened ufd, subsequent=
 calls will lead to error.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * Returns: true on succes<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * Returns: true on succes=
s<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * @ufd: fd obtained from=
 userfaultfd syscall<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * @features: bit mask se=
e UFFD_API_FEATURES<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -807,7 &#43;807,7 @@ static =
void mark_postcopy_blocktime_end(uintptr_t addr)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; low_ti=
me_offset =3D get_low_time_offset(dc);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /* loo=
kup cpu, to clear it,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * tha=
t algorithm looks straighforward, but it's not<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 that algorithm looks straightforward, but it's not<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* optimal, more optimal algorithm is keeping tree or hash<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* where key is address value is a list of&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; for (i=
 =3D 0; i &lt; smp_cpus; i&#43;&#43;) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/migration/postcopy=
-ram.h b/migration/postcopy-ram.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 9941feb63a..6d2b3cf124 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/migration/postcopy-ram.h<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/migration/pos=
tcopy-ram.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -161,7 &#43;161,7 @@ struct =
PostCopyFD {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">void postcopy_register_shared_u=
fd(struct PostCopyFD *pcfd);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">void postcopy_unregister_shared=
_ufd(struct PostCopyFD *pcfd);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-/* Call each of the shared 'wa=
ker's registerd telling them of<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;/* Call each of the shared=
 'waker's registered telling them of<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * availability of a bloc=
k.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">int postcopy_notify_shared_wake=
(RAMBlock *rb, uint64_t offset);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/migration/ram.c b/=
migration/ram.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 76d4fee5d5..c5f36aeae5 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/migration/ram.c<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/migration/ram=
.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -256,7 &#43;256,7 @@ int64_t=
 ramblock_recv_bitmap_send(QEMUFile *file,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* Always use little endian when sending the bitmap. This is<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* required that when source and destination VMs are not using the<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * sam=
e endianess. (Note: big endian won't work.)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 same endianness. (Note: big endian won't work.)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; bitmap=
_to_le(le_bitmap, block-&gt;receivedmap, nbits);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -275,7 &#43;275,7 @@ int64_t=
 ramblock_recv_bitmap_send(QEMUFile *file,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; qemu_p=
ut_buffer(file, (const uint8_t *)le_bitmap, size);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* Mark as an end, in case the middle part is screwed up due to<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * som=
e &quot;misterious&quot; reason.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 some &quot;mysterious&quot; reason.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; qemu_p=
ut_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; qemu_f=
flush(file);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -718,7 &#43;718,7 @@ static =
int save_xbzrle_page(RAMState *rs, uint8_t **current_data,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* Reaching here means the page has hit the xbzrle cache, no matter what<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* encoding result it is (normal encoding, overflow or skipping the page),<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * cou=
nt the page as encoded. This is used to caculate the encoding rate.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 count the page as encoded. This is used to calculate the encoding rate.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* Example: 2 pages (8KB) being encoded, first page encoding generates 2KB,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* 2nd page turns out to be skipped (i.e. no new bytes written to the<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -3705,7 &#43;3705,7 @@ int r=
am_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* Note: see comments in ramblock_recv_bitmap_send() on why we<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * nee=
d the endianess convertion, and the paddings.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 need the endianness conversion, and the paddings.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; local_=
size =3D ROUND_UP(local_size, 8);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -3743,7 &#43;3743,7 @@ int r=
am_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * End=
ianess convertion. We are during postcopy (though paused).<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 Endianness conversion. We are during postcopy (though paused).<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* The dirty bitmap won't change. We can directly modify it.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; bitmap=
_from_le(block-&gt;bmap, le_bitmap, nbits);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/migration/rdma.c b=
/migration/rdma.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index bea6532813..c399c86785 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/migration/rdma.c<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/migration/rdm=
a.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1510,7 &#43;1510,7 @@ stati=
c int qemu_rdma_wait_comp_channel(RDMAContext *rdma)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; } else=
 {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* This is the source side, we're in a separate thread<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * or destination prior to migration_fd_process_inco=
ming()<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * after postcopy, the destination also in a seprate thre=
ad.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * after postcopy, the destination also in a separate=
 thread.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * we can't yield; so we have to poll the fd.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * But we need to be able to handle 'cancel' or an e=
rror<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * without hanging forever.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -2267,7 &#43;2267,7 @@ stati=
c inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *&nbsp;&nbsp;&nbsp; chun=
k, then start a new chunk and flush() the old chunk.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * 3. To keep the hardwar=
e busy, we also group chunks into batches<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *&nbsp;&nbsp;&nbsp; and =
only require that a batch gets acknowledged in the completion<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- *&nbsp;&nbsp;&nbsp; qeueue in=
stead of each individual chunk.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; *&nbsp;&nbsp;&nbsp; queue=
 instead of each individual chunk.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">static int qemu_rdma_write(QEMU=
File *f, RDMAContext *rdma,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t block_off=
set, uint64_t offset,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -3149,7 &#43;3149,7 @@ stati=
c size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; if (si=
ze &gt; 0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * Add this page to the current 'chunk'. If the chun=
k<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * is full, or the page doen't belong to the current chun=
k,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * is full, or the page doesn't belong to the current=
 chunk,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * an actual RDMA write will occur and a new chunk w=
ill be formed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D qemu_rdma_write(f, rdma, block_offset, offset, si=
ze);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -4102,7 &#43;4102,7 @@ void =
rdma_start_outgoing_migration(void *opaque,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; goto err;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; /* RDMA pos=
tcopy need a seprate queue pair for return path */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp; /* RDMA=
 postcopy need a separate queue pair for return path */<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; if (mi=
grate_postcopy()) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; rdma_return_path =3D qemu_rdma_data_init(host_port, errp)=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/migration/savevm.c=
 b/migration/savevm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index a843d202b5..62a4f04762 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/migration/savevm.c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/migration/sav=
evm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -2795,7 &#43;2795,7 @@ void =
qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; if (!h=
as_live) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* live default to true so old version of Xen tool stack =
can have a<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * successfull live migration */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * successful live migration */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; live =3D true;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -2818,7 &#43;2818,7 @@ void =
qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * &quot;xen-save-devices-state&quot; and in case of=
 migration failure, libxl<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * would call &quot;cont&quot;.<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * So call bdrv_inactivate_all (release locks) here =
to let the other<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * side of the migration take controle of the images.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * side of the migration take control of the images.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (live &amp;&amp; !saved_vm_running) {<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D bdrv_inactivate_all();<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.26.2.windows.1<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_640CDEE67BE2784FAE298BB2517210E48AC3A1dggemi522mbschina_--

