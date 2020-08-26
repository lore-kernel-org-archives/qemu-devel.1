Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B7CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684DE20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684DE20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqBI-0004XN-Kk
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAqA2-0002LM-Ni; Wed, 26 Aug 2020 03:47:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2104 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAq9z-00028W-Uw; Wed, 26 Aug 2020 03:47:58 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 250DE44ED93AE378A15A;
 Wed, 26 Aug 2020 15:47:53 +0800 (CST)
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.252]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 15:47:44 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH V2 07/10] block/: fix some comment spelling errors
Thread-Topic: [PATCH V2 07/10] block/: fix some comment spelling errors
Thread-Index: AdZ7fE1rIxaMRRSdTo6XVvpZzb5RsA==
Date: Wed, 26 Aug 2020 07:47:45 +0000
Message-ID: <640CDEE67BE2784FAE298BB2517210E48AC401@dggemi522-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.227]
Content-Type: multipart/alternative;
 boundary="_000_640CDEE67BE2784FAE298BB2517210E48AC401dggemi522mbschina_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:47:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: zhaolichang <zhaolichang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_640CDEE67BE2784FAE298BB2517210E48AC401dggemi522mbschina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the block folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
block/block-copy.c | 2 +-
block/linux-aio.c  | 2 +-
block/mirror.c     | 2 +-
block/vhdx.c       | 2 +-
block/vhdx.h       | 4 ++--
5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index a30b9097ef..d648306ce5 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -321,7 +321,7 @@ static coroutine_fn int block_copy_task_run(AioTaskPool=
 *pool,
  * Do copy of cluster-aligned chunk. Requested region is allowed to exceed
  * s->len only to cover last cluster when s->len is not aligned to cluster=
s.
  *
- * No sync here: nor bitmap neighter intersecting requests handling, only =
copy.
+ * No sync here: neither bitmap nor intersecting requests handling, only c=
opy.
  *
  * Returns 0 on success.
  */
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 3c0527c2bf..772ff860ea 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -222,7 +222,7 @@ static void qemu_laio_process_completions(LinuxAioState=
 *s)

     /* If we are nested we have to notify the level above that we are done
      * by setting event_max to zero, upper level will then jump out of it'=
s
-     * own `for` loop.  If we are the last all counters droped to zero. */
+     * own `for` loop.  If we are the last all counters dropped to zero. *=
/
     s->event_max =3D 0;
     s->event_idx =3D 0;
}
diff --git a/block/mirror.c b/block/mirror.c
index e8e8844afc..22d574167e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -478,7 +478,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlo=
ckJob *s)

     job_pause_point(&s->common.job);

-    /* Find the number of consective dirty chunks following the first dirt=
y
+    /* Find the number of consecutive dirty chunks following the first dir=
ty
      * one, and wait for in flight requests in them. */
     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
     while (nb_chunks * s->granularity < s->buf_size) {
diff --git a/block/vhdx.c b/block/vhdx.c
index 791eb90263..84eedee83f 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1073,7 +1073,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
         goto fail;
     }

-    /* endian convert populated BAT field entires */
+    /* endian convert populated BAT field entries */
     for (i =3D 0; i < s->bat_entries; i++) {
         s->bat[i] =3D le64_to_cpu(s->bat[i]);
     }
diff --git a/block/vhdx.h b/block/vhdx.h
index 0b74924cee..e385e484b4 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -212,7 +212,7 @@ typedef struct QEMU_PACKED VHDXLogDataSector {
     uint32_t    sequence_high;          /* 4 MSB of 8 byte sequence_number=
 */
     uint8_t     data[4084];             /* raw data, bytes 8-4091 (inclusi=
ve).
                                            see the data descriptor field f=
or the
-                                           other mising bytes */
+                                           other missing bytes */
     uint32_t    sequence_low;           /* 4 LSB of 8 byte sequence_number=
 */
} VHDXLogDataSector;

@@ -257,7 +257,7 @@ typedef struct QEMU_PACKED VHDXMetadataTableHeader {

#define VHDX_META_FLAGS_IS_USER         0x01    /* max 1024 entries */
#define VHDX_META_FLAGS_IS_VIRTUAL_DISK 0x02    /* virtual disk metadata if=
 set,
-                                                   otherwise file metdata =
*/
+                                                   otherwise file metadata=
 */
#define VHDX_META_FLAGS_IS_REQUIRED     0x04    /* parse must understand th=
is
                                                    entry to open the file =
*/
typedef struct QEMU_PACKED VHDXMetadataTableEntry {
--
2.26.2.windows.1


--_000_640CDEE67BE2784FAE298BB2517210E48AC401dggemi522mbschina_
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
 errors in the block folder.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: zhaolichang &lt;=
zhaolichang@huawei.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">block/block-copy.c | 2 &#43;-<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">block/linux-aio.c&nbsp; | 2 &#4=
3;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">block/mirror.c&nbsp;&nbsp;&nbsp=
;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">block/vhdx.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">block/vhdx.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">5 files changed, 6 insertions(&=
#43;), 6 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/block/block-copy.c=
 b/block/block-copy.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index a30b9097ef..d648306ce5 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/block/block-copy.c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/block/block-c=
opy.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -321,7 &#43;321,7 @@ static =
coroutine_fn int block_copy_task_run(AioTaskPool *pool,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Do copy of cluster-ali=
gned chunk. Requested region is allowed to exceed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * s-&gt;len only to cove=
r last cluster when s-&gt;len is not aligned to clusters.<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * No sync here: nor bitmap ne=
ighter intersecting requests handling, only copy.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * No sync here: neither b=
itmap nor intersecting requests handling, only copy.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Returns 0 on success.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/block/linux-aio.c =
b/block/linux-aio.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 3c0527c2bf..772ff860ea 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/block/linux-aio.c<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/block/linux-a=
io.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -222,7 &#43;222,7 @@ static =
void qemu_laio_process_completions(LinuxAioState *s)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /* If =
we are nested we have to notify the level above that we are done<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* by setting event_max to zero, upper level will then jump out of it's<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * own=
 `for` loop.&nbsp; If we are the last all counters droped to zero. */<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 own `for` loop.&nbsp; If we are the last all counters dropped to zero. */<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;=
event_max =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;=
event_idx =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/block/mirror.c b/b=
lock/mirror.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index e8e8844afc..22d574167e 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/block/mirror.c<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/block/mirror.=
c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -478,7 &#43;478,7 @@ static =
uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; job_pa=
use_point(&amp;s-&gt;common.job);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; /* Find the=
 number of consective dirty chunks following the first dirty<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp; /* Find=
 the number of consecutive dirty chunks following the first dirty<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* one, and wait for in flight requests in them. */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; bdrv_d=
irty_bitmap_lock(s-&gt;dirty_bitmap);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; while =
(nb_chunks * s-&gt;granularity &lt; s-&gt;buf_size) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/block/vhdx.c b/blo=
ck/vhdx.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 791eb90263..84eedee83f 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/block/vhdx.c<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/block/vhdx.c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1073,7 &#43;1073,7 @@ stati=
c int vhdx_open(BlockDriverState *bs, QDict *options, int flags,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; goto fail;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; /* endian c=
onvert populated BAT field entires */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp; /* endi=
an convert populated BAT field entries */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; for (i=
 =3D 0; i &lt; s-&gt;bat_entries; i&#43;&#43;) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; s-&gt;bat[i] =3D le64_to_cpu(s-&gt;bat[i]);<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/block/vhdx.h b/blo=
ck/vhdx.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 0b74924cee..e385e484b4 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/block/vhdx.h<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/block/vhdx.h<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -212,7 &#43;212,7 @@ typedef=
 struct QEMU_PACKED VHDXLogDataSector {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; &nbsp;&nbsp;&nbsp;uint32=
_t&nbsp;&nbsp;&nbsp; sequence_high;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* 4 MSB of 8 byte sequence_number */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; uint8_=
t&nbsp;&nbsp;&nbsp;&nbsp; data[4084];&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* raw data, bytes 8-4091 (inclusive).<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; see the data descriptor field for the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ot=
her mising bytes */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; other missing bytes */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; uint32=
_t&nbsp;&nbsp;&nbsp; sequence_low;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* 4 LSB of 8 byte sequence_number */<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">} VHDXLogDataSector;<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -257,7 &#43;257,7 @@ typedef=
 struct QEMU_PACKED VHDXMetadataTableHeader {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define VHDX_META_FLAGS_IS_USER=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01&nbsp;&nbsp;&nbsp; /* =
max 1024 entries */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define VHDX_META_FLAGS_IS_VIRT=
UAL_DISK 0x02&nbsp;&nbsp;&nbsp; /* virtual disk metadata if set,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otherwise file metdata */<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otherwise file metadata *=
/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define VHDX_META_FLAGS_IS_REQU=
IRED&nbsp;&nbsp;&nbsp;&nbsp; 0x04&nbsp;&nbsp;&nbsp; /* parse must understan=
d this<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry to open the file *=
/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">typedef struct QEMU_PACKED VHDX=
MetadataTableEntry {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.26.2.windows.1<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_640CDEE67BE2784FAE298BB2517210E48AC401dggemi522mbschina_--

